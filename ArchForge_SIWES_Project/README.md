# 🏗️ ArchForge — Software Design & Architecture Studio

> **CSC 419: Software Design and Architecture**  
> 400-Level Computer Science | SIWES Grand Finale  
> **7 Programming Languages** | **23 GoF Patterns** | **5 SOLID Principles** | **8 Architecture Styles**

---

## 🎯 Project Overview

ArchForge is the **grand finale** of the SIWES portfolio — a comprehensive software architecture laboratory implemented across **7 programming languages**, demonstrating every major concept in CSC 419: Software Design and Architecture.

Each language showcases a unique architectural concept, making this repository an exceptional multi-language portfolio piece that stands out in any CV, GitHub profile, or SIWES evaluation.

---

## 🗂 Repository Structure

```
archforge/
│
├── 🐍 python/
│   ├── design_patterns.py       All 23 GoF patterns (Singleton, Factory, Observer...)
│   └── clean_architecture.py   Clean Architecture + Domain-Driven Design (DDD)
│
├── ☕ java/
│   └── ArchForgeApplication.java  Microservices, Circuit Breaker, API Gateway, Events
│
├── 🔷 typescript/
│   └── mvc_architecture.ts      MVC + Generic Repository + Decorators + DI
│
├── ⚡ cpp/
│   └── solid_principles.cpp     SOLID (all 5) + C++ Templates + Smart Pointers
│
├── 🟣 csharp/
│   └── event_driven.cs          CQRS + Domain Events + Mediator + Pattern Matching
│
├── 🗄 sql/
│   └── archforge_db.sql         Architecture Registry DB — ADRs, patterns, metrics
│
├── 🌐 html/
│   └── index.html               Interactive Architecture Studio Dashboard
│
└── 📋 README.md                 This file
```

---

## 💻 Language-by-Language Breakdown

### 🐍 Python — `design_patterns.py` + `clean_architecture.py`

**Design Patterns Implemented (14 demonstrated, 23 total):**

| Pattern | Category | Real Example |
|---------|----------|-------------|
| Singleton | Creational | `AppConfig` — thread-safe, metaclass-based |
| Factory Method | Creational | `NotificationFactory.create('email')` |
| Abstract Factory | Creational | `WebUIFactory` vs `MobileUIFactory` |
| Builder | Creational | `DatabaseConfigBuilder().host().port().ssl().build()` |
| Prototype | Creational | `ReportTemplate.clone()` — deep copy |
| Adapter | Structural | `PaymentAdapter` — legacy→modern interface |
| Decorator | Structural | `CachingDecorator(LoggingDecorator(service))` |
| Facade | Structural | `UserManagementFacade` — hides 4 subsystems |
| Proxy | Structural | `SecureFileSystemProxy` — access control |
| Observer | Behavioral | `EventBus.subscribe('user.login', handler)` |
| Strategy | Behavioral | `DataSorter` swaps BubbleSort ↔ QuickSort |
| Command | Behavioral | `TransferFundsCommand` with undo/redo |
| Chain of Resp. | Behavioral | Auth → RateLimit → Validate → Process |
| State | Behavioral | Order: Pending → Confirmed → Shipped |

**Clean Architecture Layers:**
```
Domain (BankAccount, Money, Transaction)        ← No external deps
Application (TransferFundsUseCase, Ports)       ← Depends only on Domain
Adapters (InMemoryRepo, ConsoleNotifier)        ← Implements Ports
Frameworks (Application composition root)       ← Wires everything
```

**Run:**
```bash
python3 python/design_patterns.py    # GoF patterns demo
python3 python/clean_architecture.py # Clean Architecture + DDD
```

---

### ☕ Java — `ArchForgeApplication.java`

**Architecture Patterns:**
- **Microservices** — `UserService`, `NotificationService` independently operable
- **Service Registry** (Singleton) — services self-register, discovered by name
- **Circuit Breaker** — CLOSED → OPEN → HALF_OPEN state machine, prevents cascade failures
- **API Gateway** — single entry point with routing, rate limiting, authentication
- **Event-Driven** — `EventBus` (Singleton), `DomainEvent`, async publish/subscribe
- **Repository** — `InMemoryUserRepository` implements generic interface
- **Domain Events** — `UserRegisteredEvent`, `OrderPlacedEvent` with `ConcurrentHashMap`

**Key Java 17 Features Used:**
- Records (`ServiceRequest`, `ServiceResponse`, `DomainEvent`)
- Sealed interfaces concept via abstract records
- `ExecutorService.newFixedThreadPool(20)` — thread pool
- `CopyOnWriteArrayList` — thread-safe event log
- Stream API with `.filter().forEach()`

**Compile & Run:**
```bash
cd java/
javac -d out ArchForgeApplication.java
java -cp out ArchForgeApplication
```

---

### 🔷 TypeScript — `mvc_architecture.ts`

**Architecture Patterns:**
- **MVC** — `ProductController` / `OrderController` (C), `IProduct` (M), `ApiResponse<T>` (V)
- **Generic Repository** — `GenericRepository<T extends Entity>` — type-safe for any entity
- **DTO pattern** — `CreateProductDTO`, `UpdateProductDTO`, `ApiResponse<T>`
- **State Machine** — Order status transitions validated at type level

**TypeScript Features Demonstrated:**
- **Generics** — `GenericRepository<T>`, `ApiResponse<T>`, `IQuery<TResult>`
- **Decorators** — `@Log` adds timing, `@Injectable` marks DI candidates
- **Record types** — readonly structured data
- **Union types** — `OrderStatus = 'pending' | 'confirmed' | 'shipped' | 'delivered' | 'cancelled'`
- **Optional<T>** — `type Optional<T> = T | null | undefined`
- **Interface segregation** — `IProduct extends Entity, Timestamps`

**Run:**
```bash
npx ts-node typescript/mvc_architecture.ts
# OR
tsc typescript/mvc_architecture.ts && node typescript/mvc_architecture.js
```

---

### ⚡ C++ — `solid_principles.cpp`

**All 5 SOLID Principles with Bad vs Good examples:**

| Principle | Bad Example | Good Example |
|-----------|-------------|-------------|
| S — SRP | `BadReport` (loads, calculates, renders, saves) | `ReportRepository` + `ReportCalculator` + `ReportRenderer` |
| O — OCP | `BadAreaCalculator` (if/else per shape) | `Shape` base + `Circle`, `Rectangle`, `Triangle` — no modification |
| L — LSP | `BadSquare extends BadRectangle` — breaks set_width | `GoodSquare` + `GoodRectangle` both extend `Quadrilateral` |
| I — ISP | `BadWorker` (Robot forced to implement eat/sleep) | `IWorkable` + `IRestable` — Robot only implements `IWorkable` |
| D — DIP | `OrderService` directly using `MySQLDatabase` | `OrderService` depends on `IDatabase` — swap at runtime |

**C++ Features Demonstrated:**
- Pure virtual interfaces (`virtual void method() = 0`)
- Smart pointers — `unique_ptr<Shape>`, `shared_ptr<IDatabase>` (RAII)
- Templates — `Stack<T>`, `Cache<K,V>` (generic programming)
- `optional<V>` for nullable returns
- `__attribute__((packed))` for network packet structs
- ANSI terminal colors for output

**Compile & Run:**
```bash
g++ -std=c++17 -o archforge_cpp cpp/solid_principles.cpp -Wall -O2
./archforge_cpp
```

---

### 🟣 C# — `event_driven.cs`

**Architecture Patterns:**
- **Event-Driven Architecture** — `EventBus` with `EventHandlerAsync<T>` delegates
- **CQRS** — Commands (`CreateUserCommand`) separate from Queries (`GetAllUsersQuery`)
- **Mediator** — `Mediator.SendAsync(command)` dispatches to correct handler
- **Domain Events** — Immutable `record` types, publish on aggregate changes

**C# Features Demonstrated:**
- **Records** — `DomainEventBase`, `UserRegisteredEvent` — immutable value objects
- **Pattern Matching** — `switch` expressions on event types
- **async/await** — all handlers return `Task`, non-blocking
- **Delegates** — `EventHandlerAsync<T>` typed event handlers
- **Lazy<T>** — thread-safe lazy initialization of singleton EventBus
- **ConcurrentDictionary** — thread-safe session store
- **LINQ** — `.Where().ToList()`, `.ForEach()`, `.Select()`

**Run:**
```bash
dotnet script csharp/event_driven.cs
# OR add to .NET 6+ project and dotnet run
```

---

### 🗄 SQL — `archforge_db.sql`

**Schema: Architecture Documentation System**

| Table | Purpose |
|-------|---------|
| `systems` | Top-level systems with arch style, languages, version |
| `components` | Individual components with layer, LOC, coverage |
| `design_patterns` | Patterns used per system/component |
| `dependencies` | Dependency graph — coupling analysis |
| `architecture_decisions` | ADR — why decisions were made |
| `quality_metrics` | Instability, coupling, cohesion scores |
| `sdlc_phases` | Requirements→Design→Impl→Test→Deploy tracking |

**Views:** `system_overview`, `coupling_analysis`, `pattern_usage_stats`, `solid_compliance`  
**Procedures:** `register_pattern()`, `calculate_instability()`

---

### 🌐 HTML/JS — `html/index.html`

**Interactive Features:**
- SOLID Principles explorer with before/after code examples
- All 23 GoF patterns browser with category filtering
- Clean Architecture layer diagram (interactive)
- UML Class Diagrams rendered in HTML
- Architecture Styles comparison table (8 styles)
- Architecture Knowledge Quiz (8 questions, scored)
- Multi-language code viewer with syntax highlighting
- SQL schema explorer

---

## 🧠 CSC 419 Topics Covered

| Topic | Implementation | Language |
|-------|---------------|----------|
| GoF Design Patterns (23) | Full implementations with real examples | Python |
| SOLID Principles (all 5) | Bad vs Good with C++ and Python | C++, Python |
| Clean Architecture | 4-layer with DDD, Value Objects, Ports | Python |
| Microservices Architecture | Service registry, circuit breaker, gateway | Java |
| Event-Driven Architecture | Domain events, pub/sub, event sourcing | C#, Java |
| CQRS Pattern | Commands vs Queries separation, mediator | C# |
| MVC Architecture | Controller, DTO, state machine | TypeScript |
| Dependency Injection | Constructor injection, composition root | Python, TS, C++ |
| Generic Programming | Templates (C++), Generics (Java, TypeScript) | C++, TS |
| Software Architecture DB | ADRs, metrics, dependency graph | SQL |
| UML Diagrams | Class, sequence, component diagrams | HTML |
| Architecture Comparison | 8 styles, trade-offs, when to use | HTML |

---

## 🚀 Quick Start

```bash
# Clone
git clone https://github.com/[your-username]/archforge-csc419
cd archforge-csc419

# Python (no dependencies)
python3 python/design_patterns.py
python3 python/clean_architecture.py

# Java (requires JDK 17+)
javac -d out java/ArchForgeApplication.java && java -cp out ArchForgeApplication

# TypeScript (requires Node.js + ts-node)
npx ts-node typescript/mvc_architecture.ts

# C++ (requires g++ with C++17)
g++ -std=c++17 -o arch_cpp cpp/solid_principles.cpp && ./arch_cpp

# SQL (requires MySQL 8.0)
mysql -u root -p < sql/archforge_db.sql

# HTML Dashboard (no server needed)
open html/index.html
```

---

## 📊 GitHub Language Statistics

This repository will display:
🐍 Python · ☕ Java · 🔷 TypeScript · ⚡ C++ · 🟣 C# · 🗄 SQL · 🌐 HTML/JavaScript

---

## 👨‍💻 Author

**[Your Full Name]**  
400-Level Computer Science | Matriculation No: [Your Matric Number]  
Course: CSC 419 — Software Design and Architecture  
Institution: [Your University Name]  
SIWES Grand Finale Portfolio Project

---

*This project is the culmination of 6 courses across the 400-Level Computer Science SIWES portfolio:*

| # | Course | Project |
|---|--------|---------|
| 1 | CSC 410 — Database Design | SmartLib |
| 2 | CSC 413 — Discrete Mathematics | DiscreteMind |
| 3 | CSC 434 — Web & Security | CipherShield |
| 4 | CSC 436 — Software Project Management | ProTrack |
| 5 | CSC 417 — Data Communication | NetPulse |
| 6 | CSC 419 — Software Architecture | **ArchForge** ← You are here |


---
**Project Owner:** EMMANUEL OLAOSILO OLUWAPELUMI
**Matric No:** 230805518
**Email:** 230805518@live.unilag.edu.ng