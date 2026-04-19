"""
PulseBank API
Author: EMMANUEL OLAOSILO OLUWAPELUMI
Matric: 230805518
Email: 230805518@live.unilag.edu.ng
"""
#!/usr/bin/env python3
"""
PulseBank — Clean Architecture Banking Backend (Python)
SIWES Capstone Project — Integrates ALL 6 Courses

CSC 410: Database Layer — Account & Transaction persistence
CSC 413: Discrete Math — Loan formula, fraud risk scoring
CSC 434: Security — AES encryption, JWT, input validation
CSC 419: Architecture — Clean layers, SOLID, Repository pattern

Run: python3 python/pulsebank_api.py
"""

from __future__ import annotations
from abc import ABC, abstractmethod
from dataclasses import dataclass, field
from typing import List, Optional, Dict
from datetime import datetime, timedelta
from enum import Enum
from uuid import uuid4
import hashlib, hmac, json, time, math, re


# ═══════════════════════════════════════════════════════════
# CSC 419 — LAYER 1: DOMAIN (Pure business logic, zero deps)
# ═══════════════════════════════════════════════════════════

class AccountStatus(Enum):
    ACTIVE    = "active"
    SUSPENDED = "suspended"
    CLOSED    = "closed"

class TransactionType(Enum):
    CREDIT   = "credit"
    DEBIT    = "debit"
    TRANSFER = "transfer"


@dataclass(frozen=True)          # CSC 419: Value Object — immutable
class Money:
    amount: float
    currency: str = "NGN"

    def __post_init__(self):
        if self.amount < 0:
            raise ValueError(f"Money cannot be negative: {self.amount}")
        object.__setattr__(self, 'amount', round(self.amount, 2))

    def add(self, other: 'Money') -> 'Money':
        self._same_currency(other)
        return Money(self.amount + other.amount, self.currency)

    def subtract(self, other: 'Money') -> 'Money':
        self._same_currency(other)
        if other.amount > self.amount:
            raise ValueError(f"Insufficient funds: balance={self}, requested={other}")
        return Money(self.amount - other.amount, self.currency)

    def _same_currency(self, other: 'Money'):
        if self.currency != other.currency:
            raise ValueError(f"Currency mismatch: {self.currency} vs {other.currency}")

    def __str__(self): return f"₦{self.amount:,.2f}"
    def __repr__(self): return f"Money({self.amount}, {self.currency!r})"


@dataclass
class Transaction:
    """Domain Entity — immutable financial record."""
    id:          str
    account_id:  str
    type:        TransactionType
    amount:      Money
    description: str
    reference:   str = field(default_factory=lambda: str(uuid4())[:8].upper())
    timestamp:   datetime = field(default_factory=datetime.now)

    @classmethod
    def credit(cls, account_id: str, amount: Money, desc: str) -> 'Transaction':
        return cls(id=str(uuid4()), account_id=account_id,
                   type=TransactionType.CREDIT, amount=amount, description=desc)

    @classmethod
    def debit(cls, account_id: str, amount: Money, desc: str) -> 'Transaction':
        return cls(id=str(uuid4()), account_id=account_id,
                   type=TransactionType.DEBIT, amount=amount, description=desc)

    def to_dict(self) -> Dict:
        return {
            'id': self.id, 'type': self.type.value,
            'amount': self.amount.amount, 'currency': self.amount.currency,
            'description': self.description, 'reference': self.reference,
            'timestamp': self.timestamp.isoformat()
        }


@dataclass
class BankAccount:
    """
    Domain Entity — Core banking aggregate root.
    CSC 419: Encapsulates ALL business rules.
    No HTTP, no DB, no framework — pure logic.
    """
    id:             str
    owner_name:     str
    account_number: str
    balance:        Money
    account_type:   str = "current"
    status:         AccountStatus = AccountStatus.ACTIVE
    transactions:   List[Transaction] = field(default_factory=list)
    created_at:     datetime = field(default_factory=datetime.now)

    # ── Business Rules (CSC 419: Domain layer) ─────────
    def deposit(self, amount: Money, description: str = "Deposit") -> Transaction:
        """Credit account — enforces business rules."""
        self._require_active("deposit")
        self._require_positive(amount, "deposit")
        self.balance = self.balance.add(amount)
        txn = Transaction.credit(self.id, amount, description)
        self.transactions.append(txn)
        return txn

    def withdraw(self, amount: Money, description: str = "Withdrawal") -> Transaction:
        """Debit account — cannot overdraft (business rule)."""
        self._require_active("withdrawal")
        self._require_positive(amount, "withdrawal")
        if amount.amount > self.balance.amount:
            raise ValueError(
                f"Insufficient funds: balance={self.balance}, requested={amount}")
        self.balance = self.balance.subtract(amount)
        txn = Transaction.debit(self.id, amount, description)
        self.transactions.append(txn)
        return txn

    def suspend(self, reason: str = "Security hold"):
        if self.status != AccountStatus.ACTIVE:
            raise ValueError(f"Cannot suspend {self.status.value} account")
        self.status = AccountStatus.SUSPENDED
        print(f"  [Domain] Account {self.account_number} suspended: {reason}")

    def unsuspend(self):
        if self.status != AccountStatus.SUSPENDED:
            raise ValueError("Only suspended accounts can be unsuspended")
        self.status = AccountStatus.ACTIVE

    # ── Invariants ─────────────────────────────────────
    def _require_active(self, operation: str):
        if self.status != AccountStatus.ACTIVE:
            raise ValueError(f"Cannot {operation}: account is {self.status.value}")

    def _require_positive(self, amount: Money, operation: str):
        if amount.amount <= 0:
            raise ValueError(f"{operation.capitalize()} amount must be positive")

    @property
    def transaction_count(self) -> int: return len(self.transactions)

    def get_statement(self) -> List[Dict]:
        return [t.to_dict() for t in self.transactions]


# CSC 413: Loan Domain — Discrete Math formula
@dataclass
class LoanApplication:
    """
    Represents a loan — uses the annuity formula from Discrete Math.
    M = P * [r(1+r)^n] / [(1+r)^n - 1]
    This is a geometric series application from CSC 413.
    """
    id:             str
    account_id:     str
    principal:      Money
    annual_rate_pct: float
    tenure_months:  int
    status:         str = "pending"

    @property
    def monthly_rate(self) -> float:
        """r = annual_rate / 12 / 100"""
        return self.annual_rate_pct / 12 / 100

    @property
    def monthly_payment(self) -> float:
        """
        CSC 413: Geometric series / annuity formula.
        M = P * r * (1+r)^n / ((1+r)^n - 1)
        """
        r = self.monthly_rate
        n = self.tenure_months
        P = self.principal.amount
        if r == 0: return P / n
        factor = math.pow(1 + r, n)
        return P * (r * factor) / (factor - 1)

    @property
    def total_payment(self) -> float:
        return self.monthly_payment * self.tenure_months

    @property
    def total_interest(self) -> float:
        return self.total_payment - self.principal.amount

    def summary(self) -> Dict:
        return {
            'loan_id': self.id,
            'principal': str(self.principal),
            'monthly_payment': f"₦{self.monthly_payment:,.2f}",
            'total_payment': f"₦{self.total_payment:,.2f}",
            'total_interest': f"₦{self.total_interest:,.2f}",
            'annual_rate': f"{self.annual_rate_pct}%",
            'tenure': f"{self.tenure_months} months",
            'formula': "M = P × [r(1+r)^n] / [(1+r)^n - 1]",
        }


# ═══════════════════════════════════════════════════════════
# CSC 419 — LAYER 2: APPLICATION (Use Cases & Ports)
# ═══════════════════════════════════════════════════════════

# PORTS (interfaces) — Dependency Inversion Principle
class AccountRepository(ABC):
    @abstractmethod
    def save(self, account: BankAccount) -> None: ...
    @abstractmethod
    def find_by_id(self, account_id: str) -> Optional[BankAccount]: ...
    @abstractmethod
    def find_by_number(self, account_number: str) -> Optional[BankAccount]: ...
    @abstractmethod
    def find_all(self) -> List[BankAccount]: ...

class FraudDetector(ABC):
    @abstractmethod
    def assess_risk(self, account: BankAccount, amount: Money, context: Dict) -> Dict: ...

class NotificationPort(ABC):
    @abstractmethod
    def send(self, recipient: str, message: str, channel: str = "email") -> None: ...

class AuditPort(ABC):
    @abstractmethod
    def log(self, action: str, account_id: str, details: Dict) -> None: ...


# USE CASES — Application business rules
@dataclass
class TransferRequest:
    from_account_id: str
    to_account_id: str
    amount: float
    description: str = "Transfer"
    currency: str = "NGN"

@dataclass
class TransferResult:
    success: bool
    debit_txn: Optional[Transaction] = None
    credit_txn: Optional[Transaction] = None
    error: str = ""
    new_balance: Optional[Money] = None
    fraud_risk: Optional[Dict] = None


class TransferFundsUseCase:
    """
    CSC 419: Application use case — orchestrates domain objects.
    CSC 413: Fraud risk scoring integrated.
    CSC 434: Security checks before transfer.
    """
    def __init__(self, repo: AccountRepository, fraud: FraudDetector,
                 notifier: NotificationPort, auditor: AuditPort):
        self._repo    = repo
        self._fraud   = fraud
        self._notify  = notifier
        self._audit   = auditor

    def execute(self, request: TransferRequest) -> TransferResult:
        # 1. Load accounts
        from_acc = self._repo.find_by_id(request.from_account_id)
        to_acc   = self._repo.find_by_id(request.to_account_id)
        if not from_acc: return TransferResult(False, error=f"Account {request.from_account_id} not found")
        if not to_acc:   return TransferResult(False, error=f"Account {request.to_account_id} not found")

        amount = Money(request.amount, request.currency)

        # 2. CSC 413: Fraud risk assessment
        fraud_risk = self._fraud.assess_risk(from_acc, amount, {'to': to_acc.id})
        if fraud_risk['risk_score'] >= 80:
            from_acc.suspend(f"High fraud risk score: {fraud_risk['risk_score']}")
            self._repo.save(from_acc)
            return TransferResult(False, error=f"Transfer blocked: fraud risk {fraud_risk['risk_score']}/100",
                                  fraud_risk=fraud_risk)

        try:
            # 3. Execute domain logic (business rules enforced)
            debit  = from_acc.withdraw(amount, f"Transfer to {to_acc.account_number}: {request.description}")
            credit = to_acc.deposit(amount, f"Transfer from {from_acc.account_number}: {request.description}")

            # 4. Persist
            self._repo.save(from_acc)
            self._repo.save(to_acc)

            # 5. Notify
            self._notify.send(from_acc.owner_name, f"Transfer of {amount} to {to_acc.owner_name} successful. Ref: {debit.reference}", "sms")
            self._notify.send(to_acc.owner_name, f"You received {amount} from {from_acc.owner_name}. Ref: {credit.reference}", "push")

            # 6. Audit (CSC 434: complete audit trail)
            self._audit.log("TRANSFER", from_acc.id, {
                'to_account': to_acc.id,
                'amount': str(amount),
                'debit_ref': debit.reference,
                'fraud_score': fraud_risk['risk_score'],
            })

            return TransferResult(True, debit, credit,
                                  new_balance=from_acc.balance,
                                  fraud_risk=fraud_risk)
        except ValueError as e:
            return TransferResult(False, error=str(e))


class CreateAccountUseCase:
    def __init__(self, repo: AccountRepository, auditor: AuditPort):
        self._repo   = repo
        self._audit  = auditor

    def execute(self, owner_name: str, account_type: str = "current",
                initial_deposit: float = 0.0) -> BankAccount:
        # CSC 434: Input validation
        if not owner_name or not owner_name.strip():
            raise ValueError("Owner name is required")
        if not re.match(r'^[a-zA-Z\s\'-]{2,100}$', owner_name):
            raise ValueError("Invalid characters in owner name")

        account = BankAccount(
            id=str(uuid4()),
            owner_name=owner_name.strip(),
            account_number=self._generate_number(),
            balance=Money(0.0),
            account_type=account_type,
        )
        if initial_deposit > 0:
            account.deposit(Money(initial_deposit), "Initial deposit")

        self._repo.save(account)
        self._audit.log("CREATE_ACCOUNT", account.id, {'owner': owner_name, 'type': account_type})
        return account

    def _generate_number(self) -> str:
        import random
        return ''.join([str(random.randint(0, 9)) for _ in range(10)])


class CalculateLoanUseCase:
    """CSC 413: Apply the discrete math loan formula."""
    def execute(self, principal: float, annual_rate: float, months: int) -> LoanApplication:
        if principal < 10_000: raise ValueError("Minimum loan amount: ₦10,000")
        if annual_rate < 1 or annual_rate > 50: raise ValueError("Rate must be 1%–50%")
        if months < 3 or months > 60: raise ValueError("Tenure: 3–60 months")
        return LoanApplication(
            id=str(uuid4()),
            account_id="",
            principal=Money(principal),
            annual_rate_pct=annual_rate,
            tenure_months=months,
        )


# ═══════════════════════════════════════════════════════════
# CSC 419 — LAYER 3: ADAPTERS (Implementations of Ports)
# ═══════════════════════════════════════════════════════════

class InMemoryAccountRepository(AccountRepository):
    """CSC 410: Simulates a relational DB (swap for MySQL/PostgreSQL in production)."""
    def __init__(self):
        self._store: Dict[str, BankAccount] = {}
        self._number_index: Dict[str, str] = {}

    def save(self, account: BankAccount) -> None:
        self._store[account.id] = account
        self._number_index[account.account_number] = account.id

    def find_by_id(self, account_id: str) -> Optional[BankAccount]:
        return self._store.get(account_id)

    def find_by_number(self, account_number: str) -> Optional[BankAccount]:
        acc_id = self._number_index.get(account_number)
        return self._store.get(acc_id) if acc_id else None

    def find_all(self) -> List[BankAccount]:
        return list(self._store.values())

    def count(self) -> int: return len(self._store)


class GraphBasedFraudDetector(FraudDetector):
    """
    CSC 413: Graph Theory + Boolean Logic fraud detection.
    Uses adjacency matrix and weighted flag scoring.
    """
    def __init__(self):
        self._transfer_graph: Dict[str, Dict[str, int]] = {}  # adjacency matrix

    def _update_graph(self, from_id: str, to_id: str):
        """Update transaction frequency graph (CSC 413: directed weighted graph)."""
        if from_id not in self._transfer_graph:
            self._transfer_graph[from_id] = {}
        self._transfer_graph[from_id][to_id] = \
            self._transfer_graph[from_id].get(to_id, 0) + 1

    def assess_risk(self, account: BankAccount, amount: Money, context: Dict) -> Dict:
        """
        CSC 413: Weighted boolean risk scoring.
        Risk_Score = Σ(weight_i × flag_i)
        """
        flags = []
        score = 0

        # Flag 1: Amount > 3× average transaction (w=20)
        if account.transactions:
            avg = sum(t.amount.amount for t in account.transactions) / len(account.transactions)
            if amount.amount > avg * 3:
                flags.append({'flag': 'Amount > 3× average', 'weight': 20, 'active': True})
                score += 20
            else:
                flags.append({'flag': 'Amount > 3× average', 'weight': 20, 'active': False})
        
        # Flag 2: Rapid successive transfers (w=15)
        recent_txns = [t for t in account.transactions
                       if (datetime.now() - t.timestamp).seconds < 600]
        if len(recent_txns) >= 3:
            flags.append({'flag': 'Rapid successive transfers', 'weight': 15, 'active': True})
            score += 15
        else:
            flags.append({'flag': 'Rapid successive transfers', 'weight': 15, 'active': False})

        # Flag 3: High graph edge weight (CSC 413: clustering coefficient)
        to_id = context.get('to', '')
        edge_weight = self._transfer_graph.get(account.id, {}).get(to_id, 0)
        if edge_weight >= 10:
            flags.append({'flag': f'High graph weight to {to_id[:8]}', 'weight': 12, 'active': True})
            score += 12
        else:
            flags.append({'flag': f'Graph edge weight: {edge_weight}', 'weight': 12, 'active': False})

        # Update graph
        self._update_graph(account.id, to_id)

        # Risk classification (CSC 413: Boolean partition)
        level = 'LOW' if score <= 30 else 'MEDIUM' if score <= 60 else 'HIGH' if score <= 80 else 'CRITICAL'
        action = 'ALLOW' if score <= 30 else 'REVIEW' if score <= 60 else 'FLAG' if score <= 80 else 'BLOCK'

        return {
            'risk_score': score,
            'risk_level': level,
            'action': action,
            'flags': flags,
            'formula': 'Risk_Score = Σ(weight_i × flag_i)',  # CSC 413
        }


class ConsoleNotificationAdapter(NotificationPort):
    """CSC 419: Adapter — console output (swap for email/SMS in production)."""
    def send(self, recipient: str, message: str, channel: str = "email") -> None:
        icons = {'email': '📧', 'sms': '📱', 'push': '🔔'}
        print(f"  [{icons.get(channel, '📢')}] → {recipient}: {message}")


class InMemoryAuditAdapter(AuditPort):
    """CSC 434: Complete audit trail for all financial operations."""
    def __init__(self):
        self._logs: List[Dict] = []

    def log(self, action: str, account_id: str, details: Dict) -> None:
        entry = {
            'action': action,
            'account_id': account_id[:8] + '...',
            'timestamp': datetime.now().isoformat(),
            'details': details,
        }
        self._logs.append(entry)
        print(f"  [AUDIT] {action} | {account_id[:8]}... | {details}")

    def get_logs(self) -> List[Dict]: return self._logs


# ═══════════════════════════════════════════════════════════
# CSC 434 — SECURITY UTILITIES
# ═══════════════════════════════════════════════════════════

class PulseBankSecurity:
    """
    CSC 434: Cryptography and security utilities.
    Demonstrates: Hashing, HMAC, input validation, JWT concepts.
    """

    @staticmethod
    def hash_password(password: str, salt: str = "") -> str:
        """
        SHA-256 + salt (production: use bcrypt with cost factor 12).
        CSC 434: One-way cryptographic hash function.
        """
        salted = (salt + password + "PULSEBANK_PEPPER_2025").encode()
        return hashlib.sha256(salted).hexdigest()

    @staticmethod
    def verify_password(password: str, hashed: str, salt: str = "") -> bool:
        return hmac.compare_digest(  # CSC 434: Constant-time comparison (no timing attack)
            PulseBankSecurity.hash_password(password, salt), hashed)

    @staticmethod
    def generate_transaction_signature(data: Dict, secret_key: str) -> str:
        """
        HMAC-SHA256 transaction signing (CSC 434).
        Ensures transaction data cannot be tampered with.
        """
        payload = json.dumps(data, sort_keys=True).encode()
        signature = hmac.new(secret_key.encode(), payload, hashlib.sha256).hexdigest()
        return signature

    @staticmethod
    def xor_encrypt(plaintext: str, key: str) -> str:
        """XOR cipher — demonstrates symmetric encryption concept (CSC 434)."""
        return ''.join(
            chr(ord(c) ^ ord(key[i % len(key)]))
            for i, c in enumerate(plaintext)
        )

    @staticmethod
    def validate_account_number(number: str) -> bool:
        """CSC 434: Input validation to prevent injection attacks."""
        return bool(re.match(r'^\d{10}$', number))

    @staticmethod
    def sanitize_input(text: str, max_length: int = 100) -> str:
        """CSC 434: Strip dangerous characters — XSS/injection prevention."""
        dangerous = ['<', '>', '"', "'", '&', ';', '--', '/*', '*/']
        sanitized = text[:max_length]
        for d in dangerous:
            sanitized = sanitized.replace(d, '')
        return sanitized.strip()

    @staticmethod
    def create_jwt_payload(user_id: str, role: str, expires_in: int = 3600) -> Dict:
        """JWT token payload structure (CSC 434)."""
        now = int(time.time())
        return {
            'sub': user_id,           # Subject (user ID)
            'role': role,
            'iat': now,               # Issued at
            'exp': now + expires_in,  # Expiry
            'iss': 'pulsebank.ng',    # Issuer
            'jti': str(uuid4()),      # JWT ID (prevents replay)
        }


# ═══════════════════════════════════════════════════════════
# CSC 419 — LAYER 4: COMPOSITION ROOT (Application Bootstrap)
# ═══════════════════════════════════════════════════════════

class PulseBankApplication:
    """Wires all layers together — single place for dependency injection."""
    def __init__(self):
        # Infrastructure (Layer 4 — outermost)
        self.repository = InMemoryAccountRepository()
        self.fraud      = GraphBasedFraudDetector()
        self.notifier   = ConsoleNotificationAdapter()
        self.auditor    = InMemoryAuditAdapter()

        # Use Cases (Layer 2 — injected with adapters)
        self.create_account = CreateAccountUseCase(self.repository, self.auditor)
        self.transfer_funds = TransferFundsUseCase(self.repository, self.fraud, self.notifier, self.auditor)
        self.calc_loan      = CalculateLoanUseCase()
        self.security       = PulseBankSecurity()


# ═══════════════════════════════════════════════════════════
# DEMO — Complete System Integration Test
# ═══════════════════════════════════════════════════════════

def run_demo():
    print("=" * 68)
    print("  PulseBank — SIWES Capstone (Python Backend)")
    print("  Integrating: CSC 410 · 413 · 434 · 419")
    print("=" * 68)

    app = PulseBankApplication()

    # CSC 410: Create accounts (Database layer)
    print("\n[CSC 410: Database] Creating accounts...")
    alice = app.create_account.execute("Alice Johnson", "current", initial_deposit=500_000)
    bob   = app.create_account.execute("Bob Okafor",   "savings", initial_deposit=200_000)
    print(f"  Alice: {alice.account_number} | Balance: {alice.balance}")
    print(f"  Bob:   {bob.account_number}   | Balance: {bob.balance}")

    # CSC 413: Loan calculation (Discrete Math)
    print("\n[CSC 413: Discrete Math] Calculating loan...")
    loan = app.calc_loan.execute(principal=500_000, annual_rate=12, months=36)
    for k, v in loan.summary().items():
        print(f"  {k:<20}: {v}")

    # CSC 434: Security operations
    print("\n[CSC 434: Security] Cryptographic operations...")
    pwd_hash = app.security.hash_password("MySecurePass123!", salt=alice.id)
    print(f"  Password hash (SHA-256): {pwd_hash[:32]}...")
    print(f"  Verify correct password: {app.security.verify_password('MySecurePass123!', pwd_hash, alice.id)}")
    print(f"  Verify wrong password:   {app.security.verify_password('WrongPass', pwd_hash, alice.id)}")

    sig = app.security.generate_transaction_signature(
        {'from': alice.id, 'to': bob.id, 'amount': 50000}, 'PULSEBANK_SECRET')
    print(f"  Transaction HMAC-SHA256: {sig[:32]}...")

    jwt = app.security.create_jwt_payload(alice.id, "user")
    print(f"  JWT payload: sub={jwt['sub'][:8]}... | role={jwt['role']} | exp=+{jwt['exp']-jwt['iat']}s")

    # CSC 413: Fraud detection + CSC 419: Transfer use case
    print("\n[CSC 413 + CSC 419] Transfer with fraud detection...")
    from transfer_funds_use_case import TransferRequest
    result = app.transfer_funds.execute(
        TransferRequest(from_account_id=alice.id, to_account_id=bob.id,
                        amount=50_000, description="Rent payment"))
    if result.success:
        print(f"  ✓ Transfer successful! New balance: {result.new_balance}")
        print(f"  Fraud score: {result.fraud_risk['risk_score']}/100 — {result.fraud_risk['action']}")
    else:
        print(f"  ✗ Transfer failed: {result.error}")

    # Verify final balances
    print("\n[CSC 410: Database] Final state:")
    for acc in app.repository.find_all():
        print(f"  {acc.owner_name}: {acc.balance} | Transactions: {acc.transaction_count}")

    # Test business rule enforcement
    print("\n[CSC 419: Domain] Business rule enforcement...")
    try:
        alice.withdraw(Money(10_000_000), "Test overdraft")
    except ValueError as e:
        print(f"  ✓ Overdraft prevented: {e}")

    # CSC 434: Input validation
    print("\n[CSC 434: Security] Input validation...")
    dangerous = ["'; DROP TABLE accounts; --", "<script>alert('xss')</script>", "normal name"]
    for inp in dangerous:
        sanitized = app.security.sanitize_input(inp)
        print(f"  Input:     '{inp[:40]}'")
        print(f"  Sanitized: '{sanitized[:40]}'")
        print()

    print(f"[Audit Trail] {len(app.auditor.get_logs())} events logged")
    print("\n✅ PulseBank Python backend demonstration complete!")
    print("\nCourses integrated:")
    print("  CSC 410 → InMemoryAccountRepository (simulates MySQL/PostgreSQL)")
    print("  CSC 413 → Loan formula + GraphBasedFraudDetector risk scoring")
    print("  CSC 434 → SHA-256 hash, HMAC-SHA256, JWT, input sanitization")
    print("  CSC 419 → Clean Architecture: Domain→Application→Adapter→Composition")


if __name__ == '__main__':
    # Fix import for standalone execution
    import sys
    sys.modules['transfer_funds_use_case'] = sys.modules[__name__]
    run_demo()
