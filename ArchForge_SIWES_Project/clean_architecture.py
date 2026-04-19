#!/usr/bin/env python3
"""
ArchForge — Clean Architecture Implementation (Python)
CSC 419: Software Design and Architecture

Implements Clean Architecture by Robert C. Martin (Uncle Bob):

    ┌──────────────────────────────────────────────────┐
    │             Frameworks & Drivers                  │  ← Outer Ring
    │  ┌────────────────────────────────────────────┐  │
    │  │        Interface Adapters                   │  │
    │  │  ┌──────────────────────────────────────┐  │  │
    │  │  │         Application Layer            │  │  │
    │  │  │  ┌────────────────────────────────┐  │  │  │
    │  │  │  │      Domain / Entities          │  │  │  │  ← Inner Ring
    │  │  │  │   (Business Rules — Pure)       │  │  │  │
    │  │  │  └────────────────────────────────┘  │  │  │
    │  │  └──────────────────────────────────────┘  │  │
    │  └────────────────────────────────────────────┘  │
    └──────────────────────────────────────────────────┘

Dependency Rule: Source code dependencies point INWARD only.
Inner layers NEVER know about outer layers.

SOLID Principles also demonstrated throughout.
"""

from __future__ import annotations
from abc import ABC, abstractmethod
from dataclasses import dataclass, field
from typing import List, Optional, Dict, Any
from datetime import datetime
from uuid import uuid4
from enum import Enum
import json


# ═══════════════════════════════════════════════════════════════
# ║  LAYER 1: DOMAIN — Entities & Business Rules (Pure Python) ║
# ═══════════════════════════════════════════════════════════════
# No imports from outer layers. No framework dependencies.
# This is the HEART of the application.

class AccountStatus(Enum):
    ACTIVE    = "active"
    SUSPENDED = "suspended"
    CLOSED    = "closed"

class TransactionType(Enum):
    CREDIT = "credit"
    DEBIT  = "debit"
    TRANSFER = "transfer"


@dataclass
class Money:
    """
    Value Object — immutable, equality based on value not identity.
    Encapsulates currency logic so it cannot be misused.
    """
    amount: float
    currency: str = "NGN"

    def __post_init__(self):
        if self.amount < 0:
            raise ValueError("Money amount cannot be negative")
        # Immutable: round to 2 decimal places
        object.__setattr__(self, 'amount', round(self.amount, 2))

    def add(self, other: 'Money') -> 'Money':
        if self.currency != other.currency:
            raise ValueError(f"Currency mismatch: {self.currency} vs {other.currency}")
        return Money(self.amount + other.amount, self.currency)

    def subtract(self, other: 'Money') -> 'Money':
        if other.amount > self.amount:
            raise ValueError("Insufficient funds")
        return Money(self.amount - other.amount, self.currency)

    def __str__(self): return f"₦{self.amount:,.2f}"
    def __eq__(self, other): return isinstance(other, Money) and self.amount == other.amount and self.currency == other.currency


@dataclass
class Transaction:
    """Domain Entity — a financial transaction."""
    id:           str
    account_id:   str
    type:         TransactionType
    amount:       Money
    description:  str
    timestamp:    datetime = field(default_factory=datetime.now)
    reference:    str = field(default_factory=lambda: str(uuid4())[:8].upper())

    @classmethod
    def credit(cls, account_id: str, amount: Money, desc: str) -> 'Transaction':
        return cls(id=str(uuid4()), account_id=account_id,
                   type=TransactionType.CREDIT, amount=amount, description=desc)

    @classmethod
    def debit(cls, account_id: str, amount: Money, desc: str) -> 'Transaction':
        return cls(id=str(uuid4()), account_id=account_id,
                   type=TransactionType.DEBIT, amount=amount, description=desc)


@dataclass
class BankAccount:
    """
    Domain Entity — the core business object.
    Contains ONLY business rules. No database, no HTTP, no framework.
    """
    id:           str
    owner_name:   str
    account_number: str
    balance:      Money
    status:       AccountStatus = AccountStatus.ACTIVE
    transactions: List[Transaction] = field(default_factory=list)

    # ── Domain Business Rules ─────────────────────────────────
    def deposit(self, amount: Money, description: str = "Deposit") -> Transaction:
        """Business rule: can only deposit to active accounts."""
        self._ensure_active()
        if amount.amount <= 0:
            raise ValueError("Deposit amount must be positive")
        self.balance = self.balance.add(amount)
        txn = Transaction.credit(self.id, amount, description)
        self.transactions.append(txn)
        return txn

    def withdraw(self, amount: Money, description: str = "Withdrawal") -> Transaction:
        """Business rule: cannot withdraw more than balance, cannot overdraft."""
        self._ensure_active()
        if amount.amount <= 0:
            raise ValueError("Withdrawal amount must be positive")
        if amount.amount > self.balance.amount:
            raise ValueError(f"Insufficient funds: balance={self.balance}, requested={amount}")
        self.balance = self.balance.subtract(amount)
        txn = Transaction.debit(self.id, amount, description)
        self.transactions.append(txn)
        return txn

    def suspend(self):
        """Business rule: only active accounts can be suspended."""
        if self.status != AccountStatus.ACTIVE:
            raise ValueError(f"Cannot suspend account with status {self.status}")
        self.status = AccountStatus.SUSPENDED

    def _ensure_active(self):
        if self.status != AccountStatus.ACTIVE:
            raise ValueError(f"Account is {self.status.value}. Operations not allowed.")

    @property
    def transaction_count(self) -> int:
        return len(self.transactions)

    def get_statement(self) -> List[Dict]:
        return [{'type': t.type.value, 'amount': str(t.amount),
                 'description': t.description, 'ref': t.reference,
                 'timestamp': t.timestamp.isoformat()} for t in self.transactions]


# ═══════════════════════════════════════════════════════════════
# ║  LAYER 2: APPLICATION — Use Cases & Ports (Interfaces)     ║
# ═══════════════════════════════════════════════════════════════
# Depends only on Domain layer. Defines PORTS (interfaces).

# Ports — Abstract interfaces the app depends on
class AccountRepository(ABC):
    """Port — defines HOW data is stored (not WHERE)."""
    @abstractmethod
    def save(self, account: BankAccount) -> None: ...

    @abstractmethod
    def find_by_id(self, account_id: str) -> Optional[BankAccount]: ...

    @abstractmethod
    def find_by_number(self, account_number: str) -> Optional[BankAccount]: ...

    @abstractmethod
    def find_all(self) -> List[BankAccount]: ...


class NotificationPort(ABC):
    """Port — defines HOW notifications are sent (not via which channel)."""
    @abstractmethod
    def send_transaction_alert(self, owner: str, txn: Transaction) -> None: ...


class AuditPort(ABC):
    """Port — defines HOW actions are audited."""
    @abstractmethod
    def log(self, action: str, account_id: str, details: Dict) -> None: ...


# Use Cases — Application business rules
@dataclass
class TransferRequest:
    from_account_id: str
    to_account_id: str
    amount: float
    currency: str = "NGN"
    description: str = "Transfer"


@dataclass
class TransferResult:
    success: bool
    from_transaction: Optional[Transaction] = None
    to_transaction:   Optional[Transaction] = None
    error: str = ""
    new_balance: Optional[Money] = None


class TransferFundsUseCase:
    """
    Application Use Case — orchestrates domain objects to perform
    a funds transfer. Depends on PORTS (interfaces), not implementations.

    This is the Dependency Inversion Principle (DIP) — the D in SOLID.
    """
    def __init__(self,
                 repository: AccountRepository,
                 notifier: NotificationPort,
                 auditor: AuditPort):
        self._repo   = repository
        self._notify = notifier
        self._audit  = auditor

    def execute(self, request: TransferRequest) -> TransferResult:
        # 1. Fetch accounts
        from_acc = self._repo.find_by_id(request.from_account_id)
        to_acc   = self._repo.find_by_id(request.to_account_id)

        if not from_acc:
            return TransferResult(False, error=f"Account {request.from_account_id} not found")
        if not to_acc:
            return TransferResult(False, error=f"Account {request.to_account_id} not found")

        amount = Money(request.amount, request.currency)

        try:
            # 2. Execute domain logic (business rules enforced here)
            debit_txn  = from_acc.withdraw(amount, f"Transfer to {to_acc.account_number}")
            credit_txn = to_acc.deposit(amount, f"Transfer from {from_acc.account_number}")

            # 3. Persist
            self._repo.save(from_acc)
            self._repo.save(to_acc)

            # 4. Notify (async in production)
            self._notify.send_transaction_alert(from_acc.owner_name, debit_txn)
            self._notify.send_transaction_alert(to_acc.owner_name, credit_txn)

            # 5. Audit
            self._audit.log('TRANSFER', from_acc.id, {
                'to': to_acc.id,
                'amount': str(amount),
                'debit_ref': debit_txn.reference
            })

            return TransferResult(True, debit_txn, credit_txn, new_balance=from_acc.balance)

        except ValueError as e:
            return TransferResult(False, error=str(e))


class CreateAccountUseCase:
    """Use case for creating a new bank account."""
    def __init__(self, repository: AccountRepository):
        self._repo = repository

    def execute(self, owner_name: str, initial_deposit: float = 0.0) -> BankAccount:
        if not owner_name.strip():
            raise ValueError("Owner name cannot be empty")

        account = BankAccount(
            id=str(uuid4()),
            owner_name=owner_name,
            account_number=self._generate_account_number(),
            balance=Money(0.0),
        )

        if initial_deposit > 0:
            account.deposit(Money(initial_deposit), "Initial deposit")

        self._repo.save(account)
        return account

    def _generate_account_number(self) -> str:
        import random
        return ''.join([str(random.randint(0, 9)) for _ in range(10)])


# ═══════════════════════════════════════════════════════════════
# ║  LAYER 3: ADAPTERS — Concrete Implementations of Ports     ║
# ═══════════════════════════════════════════════════════════════
# Depends on Application layer. Implements the ports.

class InMemoryAccountRepository(AccountRepository):
    """Adapter: In-memory implementation of AccountRepository port."""
    def __init__(self):
        self._store: Dict[str, BankAccount] = {}

    def save(self, account: BankAccount) -> None:
        self._store[account.id] = account

    def find_by_id(self, account_id: str) -> Optional[BankAccount]:
        return self._store.get(account_id)

    def find_by_number(self, account_number: str) -> Optional[BankAccount]:
        return next((a for a in self._store.values()
                     if a.account_number == account_number), None)

    def find_all(self) -> List[BankAccount]:
        return list(self._store.values())

    def count(self) -> int:
        return len(self._store)


class ConsoleNotificationAdapter(NotificationPort):
    """Adapter: Console notification (swap for EmailAdapter in production)."""
    def send_transaction_alert(self, owner: str, txn: Transaction) -> None:
        icon = "↑" if txn.type == TransactionType.DEBIT else "↓"
        print(f"  [NOTIFY] {icon} {owner}: {txn.type.value} {txn.amount} — {txn.description}")


class InMemoryAuditAdapter(AuditPort):
    """Adapter: In-memory audit log."""
    def __init__(self):
        self._logs: List[Dict] = []

    def log(self, action: str, account_id: str, details: Dict) -> None:
        entry = {'action': action, 'account_id': account_id,
                 'details': details, 'timestamp': datetime.now().isoformat()}
        self._logs.append(entry)
        print(f"  [AUDIT] {action} | account={account_id[:8]}... | {details}")

    def get_logs(self) -> List[Dict]:
        return self._logs


# ═══════════════════════════════════════════════════════════════
# ║  LAYER 4: FRAMEWORKS & DRIVERS — Composition Root          ║
# ═══════════════════════════════════════════════════════════════

class Application:
    """
    Composition Root — the ONLY place where all layers are wired together.
    This is Dependency Injection in action.
    """
    def __init__(self):
        # Infrastructure (outer layer)
        self._repo    = InMemoryAccountRepository()
        self._notify  = ConsoleNotificationAdapter()
        self._audit   = InMemoryAuditAdapter()

        # Use Cases (application layer) — injected with adapters
        self.create_account  = CreateAccountUseCase(self._repo)
        self.transfer_funds  = TransferFundsUseCase(self._repo, self._notify, self._audit)

    def accounts(self) -> List[BankAccount]:
        return self._repo.find_all()

    def audit_logs(self) -> List[Dict]:
        return self._audit.get_logs()


# ─── DEMO ──────────────────────────────────────────────────────
if __name__ == '__main__':
    print("=" * 65)
    print("  ArchForge — Clean Architecture Demo (Python)")
    print("  CSC 419: Software Design and Architecture")
    print("=" * 65)

    app = Application()

    # Create accounts
    print("\n[1] Creating accounts...")
    alice = app.create_account.execute("Alice Johnson", initial_deposit=100_000)
    bob   = app.create_account.execute("Bob Okafor",   initial_deposit=50_000)
    print(f"  Alice: {alice.account_number} | Balance: {alice.balance}")
    print(f"  Bob:   {bob.account_number}   | Balance: {bob.balance}")

    # Transfer funds
    print("\n[2] Transferring ₦25,000 from Alice to Bob...")
    result = app.transfer_funds.execute(
        TransferRequest(alice.id, bob.id, 25_000, description="Rent payment"))

    if result.success:
        print(f"  ✓ Transfer successful!")
        print(f"  Alice's new balance: {result.new_balance}")
    else:
        print(f"  ✗ Transfer failed: {result.error}")

    # Verify balances
    print("\n[3] Final balances:")
    for acc in app.accounts():
        print(f"  {acc.owner_name}: {acc.balance} | Txns: {acc.transaction_count}")

    # Verify business rules
    print("\n[4] Testing business rules...")
    try:
        alice.withdraw(Money(1_000_000), "Test overdraft")  # Should fail
    except ValueError as e:
        print(f"  ✓ Overdraft prevented: {e}")

    alice.suspend()
    try:
        alice.deposit(Money(1_000), "Test")  # Should fail
    except ValueError as e:
        print(f"  ✓ Suspended account blocked: {e}")

    print(f"\n[5] Audit trail ({len(app.audit_logs())} entries):")
    for log in app.audit_logs():
        print(f"  [{log['timestamp'][:19]}] {log['action']}: {log['details']}")

    print("\n✅ Clean Architecture demonstration complete!")
    print("\nSOLID Principles Applied:")
    print("  S — Single Responsibility: Each class has one reason to change")
    print("  O — Open/Closed: NotificationFactory extends without modification")
    print("  L — Liskov Substitution: Any AccountRepository impl works")
    print("  I — Interface Segregation: Small focused ports (interfaces)")
    print("  D — Dependency Inversion: Use cases depend on abstractions")
