/**
 * ArchForge — SOLID Principles & C++ Templates
 * CSC 419: Software Design and Architecture
 *
 * Demonstrates all 5 SOLID principles with real examples:
 *   S — Single Responsibility Principle
 *   O — Open/Closed Principle
 *   L — Liskov Substitution Principle
 *   I — Interface Segregation Principle
 *   D — Dependency Inversion Principle
 *
 * Also demonstrates:
 *   - C++ Templates (generic programming)
 *   - Smart pointers (RAII — Resource Acquisition Is Initialization)
 *   - Pure virtual interfaces
 *   - Template Method Pattern
 *   - Strategy Pattern with templates
 *
 * Compile: g++ -std=c++17 -o archforge_cpp cpp/solid_principles.cpp && ./archforge_cpp
 */

#include <iostream>
#include <string>
#include <vector>
#include <memory>
#include <functional>
#include <unordered_map>
#include <algorithm>
#include <sstream>
#include <chrono>
#include <stdexcept>
#include <typeinfo>

using namespace std;

// ─── ANSI Colors ──────────────────────────────────────────────
#define RESET  "\033[0m"
#define GREEN  "\033[0;32m"
#define CYAN   "\033[0;36m"
#define YELLOW "\033[1;33m"
#define RED    "\033[0;31m"
#define BOLD   "\033[1m"

// ═══════════════════════════════════════════════════════════════
// S — SINGLE RESPONSIBILITY PRINCIPLE
// "A class should have only one reason to change."
// ═══════════════════════════════════════════════════════════════

// ❌ BAD: This class has MULTIPLE responsibilities
class BadReport {
public:
    string title;
    vector<string> data;

    void load_from_db()  { /* loads data — responsibility 1 */ }
    void calculate_totals() { /* business logic — responsibility 2 */ }
    void print_to_console() { /* presentation — responsibility 3 */ }
    void save_to_file()  { /* persistence — responsibility 4 */ }
    // Too many reasons to change — violates SRP
};

// ✅ GOOD: Each class has ONE responsibility
struct ReportData {
    string title;
    vector<pair<string, double>> rows;
    double total = 0.0;
};

class ReportRepository {
    // Responsibility: Load/Save data only
public:
    ReportData load(const string& report_id) {
        // Simulate DB fetch
        return ReportData{"Q3 Sales Report", {{"Jan", 125000}, {"Feb", 148000}, {"Mar", 162000}}};
    }
    void save(const ReportData& data) {
        cout << "  [Saved] Report: " << data.title << "\n";
    }
};

class ReportCalculator {
    // Responsibility: Business calculations only
public:
    void calculate(ReportData& data) {
        data.total = 0;
        for (auto& [label, value] : data.rows) {
            data.total += value;
        }
    }
    double average(const ReportData& data) {
        return data.rows.empty() ? 0 : data.total / data.rows.size();
    }
};

class ReportRenderer {
    // Responsibility: Rendering/display only
public:
    void render_console(const ReportData& data) {
        cout << "  ┌─────────────────────────────────┐\n";
        cout << "  │ " << data.title << "\n";
        cout << "  ├─────────────────────────────────┤\n";
        for (auto& [label, val] : data.rows) {
            cout << "  │ " << label << ": ₦" << val << "\n";
        }
        cout << "  │ Total: ₦" << data.total << "\n";
        cout << "  └─────────────────────────────────┘\n";
    }
};

// ═══════════════════════════════════════════════════════════════
// O — OPEN/CLOSED PRINCIPLE
// "Open for extension, closed for modification."
// ═══════════════════════════════════════════════════════════════

// ❌ BAD: Adding a new shape requires modifying existing code
class BadAreaCalculator {
public:
    double calculate(const string& shape, double a, double b = 0) {
        if (shape == "rectangle") return a * b;
        if (shape == "circle")    return 3.14159 * a * a;
        // Adding triangle requires MODIFYING this class — violates OCP!
        return 0;
    }
};

// ✅ GOOD: Extend by adding new classes, never modify existing
class Shape {
public:
    virtual ~Shape() = default;
    virtual double area() const = 0;
    virtual string name() const = 0;
};

class Rectangle : public Shape {
    double width_, height_;
public:
    Rectangle(double w, double h) : width_(w), height_(h) {}
    double area()   const override { return width_ * height_; }
    string name()   const override { return "Rectangle"; }
};

class Circle : public Shape {
    double radius_;
public:
    Circle(double r) : radius_(r) {}
    double area()   const override { return 3.14159265 * radius_ * radius_; }
    string name()   const override { return "Circle"; }
};

class Triangle : public Shape {
    double base_, height_;
public:
    Triangle(double b, double h) : base_(b), height_(h) {}
    double area()   const override { return 0.5 * base_ * height_; }
    string name()   const override { return "Triangle"; }
};

// This calculator NEVER needs to change when new shapes are added!
class AreaCalculator {
public:
    double total_area(const vector<unique_ptr<Shape>>& shapes) const {
        double total = 0;
        for (const auto& s : shapes) total += s->area();
        return total;
    }
};

// ═══════════════════════════════════════════════════════════════
// L — LISKOV SUBSTITUTION PRINCIPLE
// "Subclasses must be substitutable for their base classes."
// ═══════════════════════════════════════════════════════════════

// ❌ BAD: Classic violation — Square IS-A Rectangle is wrong!
class BadRectangle {
protected:
    double width_, height_;
public:
    BadRectangle(double w, double h) : width_(w), height_(h) {}
    virtual void set_width(double w)  { width_ = w; }
    virtual void set_height(double h) { height_ = h; }
    double area() const { return width_ * height_; }
};

class BadSquare : public BadRectangle {
public:
    BadSquare(double s) : BadRectangle(s, s) {}
    void set_width(double w)  override { width_ = height_ = w; }  // Breaks LSP!
    void set_height(double h) override { width_ = height_ = h; }  // Breaks LSP!
};

// ✅ GOOD: Both Rectangle and Square extend an abstract Quadrilateral
class Quadrilateral {
public:
    virtual ~Quadrilateral() = default;
    virtual double area() const = 0;
    virtual string describe() const = 0;
};

class GoodRectangle : public Quadrilateral {
    double width_, height_;
public:
    GoodRectangle(double w, double h) : width_(w), height_(h) {}
    double area()    const override { return width_ * height_; }
    string describe() const override {
        return "Rectangle(" + to_string((int)width_) + "×" + to_string((int)height_) + ")";
    }
};

class GoodSquare : public Quadrilateral {
    double side_;
public:
    GoodSquare(double s) : side_(s) {}
    double area()    const override { return side_ * side_; }
    string describe() const override {
        return "Square(" + to_string((int)side_) + "²)";
    }
};

// This function works correctly with ANY Quadrilateral — LSP satisfied!
void print_area(const Quadrilateral& q) {
    cout << "  " << q.describe() << " → Area = " << q.area() << " sq units\n";
}

// ═══════════════════════════════════════════════════════════════
// I — INTERFACE SEGREGATION PRINCIPLE
// "Clients should not depend on interfaces they don't use."
// ═══════════════════════════════════════════════════════════════

// ❌ BAD: Fat interface — forces all implementors to implement all methods
class BadWorker {
public:
    virtual void work()       = 0;
    virtual void eat()        = 0;  // Robots can't eat!
    virtual void sleep()      = 0;  // Robots can't sleep!
    virtual void take_break() = 0;  // Robots don't break!
};

// ✅ GOOD: Segregated interfaces — each is small and focused
class IWorkable {
public: virtual void work() = 0;
};

class IBreakable {
public: virtual void take_break() = 0;
};

class IRestable {
public:
    virtual void eat()  = 0;
    virtual void sleep() = 0;
};

class HumanWorker : public IWorkable, public IBreakable, public IRestable {
    string name_;
public:
    HumanWorker(const string& name) : name_(name) {}
    void work()        override { cout << "  " << name_ << " is working (human)\n"; }
    void take_break()  override { cout << "  " << name_ << " taking a break\n"; }
    void eat()         override { cout << "  " << name_ << " eating lunch\n"; }
    void sleep()       override { cout << "  " << name_ << " sleeping\n"; }
};

class RobotWorker : public IWorkable {
    // Robots only implement IWorkable — not forced to implement eat/sleep!
    string model_;
public:
    RobotWorker(const string& model) : model_(model) {}
    void work() override { cout << "  Robot " << model_ << " is processing tasks 24/7\n"; }
};

// ═══════════════════════════════════════════════════════════════
// D — DEPENDENCY INVERSION PRINCIPLE
// "High-level modules depend on abstractions, not concretions."
// ═══════════════════════════════════════════════════════════════

// ❌ BAD: High-level code depends directly on low-level MySQL
class BadOrderService {
    // MySQLDatabase mysql_db;  // Tightly coupled to MySQL!
public:
    void place_order(const string& item) {
        // mysql_db.save("orders", item);  // Cannot swap for PostgreSQL/MongoDB!
        cout << "  [BAD] Directly using MySQL — cannot swap\n";
    }
};

// ✅ GOOD: Both high-level and low-level depend on IDatabase abstraction
class IDatabase {
public:
    virtual ~IDatabase() = default;
    virtual bool save(const string& collection, const string& data)   = 0;
    virtual string find(const string& collection, const string& id)   = 0;
    virtual string type() const = 0;
};

class PostgreSQLDatabase : public IDatabase {
public:
    bool save(const string& col, const string& data) override {
        cout << "  [PostgreSQL] INSERT INTO " << col << " VALUES('" << data << "')\n";
        return true;
    }
    string find(const string& col, const string& id) override {
        return "PostgreSQL::" + col + "::" + id;
    }
    string type() const override { return "PostgreSQL"; }
};

class MongoDBDatabase : public IDatabase {
public:
    bool save(const string& col, const string& data) override {
        cout << "  [MongoDB] db." << col << ".insertOne({data: '" << data << "'})\n";
        return true;
    }
    string find(const string& col, const string& id) override {
        return "MongoDB::" + col + "::" + id;
    }
    string type() const override { return "MongoDB"; }
};

class OrderService {
    // Depends on IDatabase abstraction — not any concrete DB!
    shared_ptr<IDatabase> db_;
public:
    explicit OrderService(shared_ptr<IDatabase> db) : db_(move(db)) {}

    void place_order(const string& item) {
        db_->save("orders", item);
        cout << "  Order placed via " << db_->type() << "\n";
    }

    // Swap database at runtime! (also Strategy Pattern)
    void set_database(shared_ptr<IDatabase> db) { db_ = move(db); }
};

// ═══════════════════════════════════════════════════════════════
// TEMPLATES — Generic Programming
// ═══════════════════════════════════════════════════════════════

/**
 * Generic Stack — works for ANY type T.
 * Demonstrates C++ templates (compile-time polymorphism).
 */
template<typename T>
class Stack {
    vector<T> data_;
    size_t max_size_;
public:
    explicit Stack(size_t max_size = 100) : max_size_(max_size) {}

    void push(const T& item) {
        if (data_.size() >= max_size_)
            throw overflow_error("Stack overflow: max size reached");
        data_.push_back(item);
    }

    T pop() {
        if (data_.empty()) throw underflow_error("Stack underflow: empty");
        T top = data_.back();
        data_.pop_back();
        return top;
    }

    const T& peek() const {
        if (data_.empty()) throw underflow_error("Stack is empty");
        return data_.back();
    }

    bool empty() const { return data_.empty(); }
    size_t size() const { return data_.size(); }
};

/**
 * Generic Cache — key-value store with TTL eviction.
 */
template<typename K, typename V>
class Cache {
    struct Entry { V value; chrono::steady_clock::time_point expires; };
    unordered_map<K, Entry> store_;
    chrono::seconds default_ttl_;
public:
    explicit Cache(int ttl_seconds = 300)
        : default_ttl_(chrono::seconds(ttl_seconds)) {}

    void put(const K& key, const V& value) {
        store_[key] = {value, chrono::steady_clock::now() + default_ttl_};
    }

    optional<V> get(const K& key) {
        auto it = store_.find(key);
        if (it == store_.end()) return nullopt;
        if (chrono::steady_clock::now() > it->second.expires) {
            store_.erase(it);
            return nullopt;
        }
        return it->second.value;
    }

    size_t size() const { return store_.size(); }
};

// ─── MAIN ──────────────────────────────────────────────────────
int main() {
    cout << BOLD << CYAN;
    cout << "╔══════════════════════════════════════════════════════╗\n";
    cout << "║  ArchForge — SOLID Principles + C++ Templates       ║\n";
    cout << "║  CSC 419: Software Design and Architecture          ║\n";
    cout << "╚══════════════════════════════════════════════════════╝\n" << RESET;

    // S — SRP
    cout << YELLOW << "\n[S] Single Responsibility Principle\n" << RESET;
    ReportRepository repo;
    ReportCalculator calc;
    ReportRenderer renderer;
    auto report = repo.load("Q3");
    calc.calculate(report);
    renderer.render_console(report);
    cout << "  Average: ₦" << calc.average(report) << "\n";

    // O — OCP
    cout << YELLOW << "\n[O] Open/Closed Principle\n" << RESET;
    vector<unique_ptr<Shape>> shapes;
    shapes.push_back(make_unique<Rectangle>(10, 5));
    shapes.push_back(make_unique<Circle>(7));
    shapes.push_back(make_unique<Triangle>(8, 6));
    AreaCalculator aCalc;
    for (const auto& s : shapes) {
        cout << "  " << s->name() << " area: " << s->area() << " sq units\n";
    }
    cout << "  Total area: " << aCalc.total_area(shapes) << " sq units\n";

    // L — LSP
    cout << YELLOW << "\n[L] Liskov Substitution Principle\n" << RESET;
    GoodRectangle rect(8, 4);
    GoodSquare    sq(5);
    print_area(rect);  // Works correctly
    print_area(sq);    // Also works correctly — LSP satisfied!

    // I — ISP
    cout << YELLOW << "\n[I] Interface Segregation Principle\n" << RESET;
    HumanWorker human("Alice");
    RobotWorker robot("R2D2");
    human.work(); robot.work();
    human.eat();  // Robot doesn't need to implement eat!
    cout << "  Robot doesn't implement eat/sleep — correct!\n";

    // D — DIP
    cout << YELLOW << "\n[D] Dependency Inversion Principle\n" << RESET;
    auto pg_db    = make_shared<PostgreSQLDatabase>();
    auto mongo_db = make_shared<MongoDBDatabase>();
    OrderService orderSvc(pg_db);
    orderSvc.place_order("MacBook Pro x1");
    orderSvc.set_database(mongo_db);  // Swap DB at runtime!
    orderSvc.place_order("iPhone 15 x2");

    // Templates
    cout << YELLOW << "\n[T] Generic Templates\n" << RESET;
    Stack<string> callStack;
    callStack.push("main()");
    callStack.push("processOrder()");
    callStack.push("validatePayment()");
    cout << "  Call stack (LIFO):\n";
    while (!callStack.empty()) cout << "    ↩ " << callStack.pop() << "\n";

    Cache<string, string> userCache(60);
    userCache.put("user:123", "{name:'Alice',role:'admin'}");
    auto cached = userCache.get("user:123");
    cout << "  Cache hit: " << (cached ? *cached : "MISS") << "\n";

    cout << GREEN << "\n✅ All SOLID principles demonstrated in C++!\n" << RESET;
    cout << "\nSOLID Summary:\n";
    cout << "  S → " << CYAN << "One class, one job" << RESET << " — ReportRepository/Calculator/Renderer\n";
    cout << "  O → " << CYAN << "Add shapes without modifying AreaCalculator" << RESET << "\n";
    cout << "  L → " << CYAN << "Quadrilateral base — Square/Rectangle both work" << RESET << "\n";
    cout << "  I → " << CYAN << "IWorkable/IRestable separate — Robot only implements IWorkable" << RESET << "\n";
    cout << "  D → " << CYAN << "OrderService depends on IDatabase, not MySQL/MongoDB" << RESET << "\n";

    return 0;
}
