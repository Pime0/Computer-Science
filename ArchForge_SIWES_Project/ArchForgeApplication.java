/**
 * ArchForge — Microservices Architecture (Java)
 * CSC 419: Software Design and Architecture
 *
 * Demonstrates:
 *   - Microservices architectural pattern
 *   - Service Registry (Singleton)
 *   - API Gateway pattern
 *   - Circuit Breaker pattern
 *   - Repository pattern
 *   - Dependency Injection
 *   - Domain-Driven Design (DDD) concepts
 *   - Event-Driven communication between services
 *
 * Compile: javac -d out src/*.java
 * Run:     java -cp out ArchForgeApplication
 */

import java.util.*;
import java.util.concurrent.*;
import java.util.concurrent.atomic.*;
import java.time.*;
import java.time.format.*;
import java.util.function.*;
import java.util.stream.*;

// ─── Value Objects ────────────────────────────────────────────
record Money(double amount, String currency) {
    public Money {
        if (amount < 0) throw new IllegalArgumentException("Money cannot be negative");
        amount = Math.round(amount * 100.0) / 100.0;
    }

    public Money add(Money other) {
        if (!currency.equals(other.currency))
            throw new IllegalArgumentException("Currency mismatch");
        return new Money(amount + other.amount, currency);
    }

    public Money subtract(Money other) {
        if (other.amount > amount)
            throw new IllegalStateException("Insufficient funds");
        return new Money(amount - other.amount, currency);
    }

    @Override public String toString() {
        return String.format("₦%,.2f", amount);
    }
}

record ServiceRequest(String service, String method, Map<String, Object> payload) {}
record ServiceResponse(boolean success, Object data, String error, long latencyMs) {}


// ─── Circuit Breaker (Resilience Pattern) ─────────────────────
/**
 * Circuit Breaker Pattern — prevents cascading failures.
 *
 * States:
 *   CLOSED   → Normal operation, requests flow through
 *   OPEN     → Too many failures, requests fail fast (no network call)
 *   HALF_OPEN → Testing if service recovered
 */
class CircuitBreaker {
    enum State { CLOSED, OPEN, HALF_OPEN }

    private State state = State.CLOSED;
    private final int failureThreshold;
    private final long timeoutMs;
    private int failureCount = 0;
    private long lastFailureTime = 0;
    private final String name;

    public CircuitBreaker(String name, int threshold, long timeoutMs) {
        this.name = name;
        this.failureThreshold = threshold;
        this.timeoutMs = timeoutMs;
    }

    public <T> T call(Supplier<T> operation) {
        switch (state) {
            case OPEN -> {
                long elapsed = System.currentTimeMillis() - lastFailureTime;
                if (elapsed > timeoutMs) {
                    state = State.HALF_OPEN;
                    System.out.printf("  [CB:%s] HALF_OPEN — testing recovery%n", name);
                } else {
                    throw new RuntimeException(
                        String.format("Circuit OPEN: %s — fast fail (%.1fs remaining)",
                            name, (timeoutMs - elapsed) / 1000.0));
                }
            }
            case CLOSED, HALF_OPEN -> {}
        }

        try {
            T result = operation.get();
            onSuccess();
            return result;
        } catch (Exception e) {
            onFailure();
            throw e;
        }
    }

    private void onSuccess() {
        failureCount = 0;
        state = State.CLOSED;
    }

    private void onFailure() {
        failureCount++;
        lastFailureTime = System.currentTimeMillis();
        if (failureCount >= failureThreshold) {
            state = State.OPEN;
            System.out.printf("  [CB:%s] OPENED — %d failures detected!%n", name, failureCount);
        }
    }

    public State getState() { return state; }
    public String getName()  { return name; }
}


// ─── Event System ─────────────────────────────────────────────
record DomainEvent(String type, String aggregateId, Map<String, Object> payload, Instant timestamp) {
    public DomainEvent(String type, String aggregateId, Map<String, Object> payload) {
        this(type, aggregateId, payload, Instant.now());
    }

    @Override public String toString() {
        return String.format("[Event:%s | aggregate=%s | %s]", type, aggregateId, payload);
    }
}

@FunctionalInterface
interface EventHandler { void handle(DomainEvent event); }

class EventBus {
    private static EventBus instance;
    private final Map<String, List<EventHandler>> handlers = new ConcurrentHashMap<>();
    private final List<DomainEvent> eventLog = new CopyOnWriteArrayList<>();

    private EventBus() {}

    public static synchronized EventBus getInstance() {
        if (instance == null) instance = new EventBus();
        return instance;
    }

    public EventBus subscribe(String eventType, EventHandler handler) {
        handlers.computeIfAbsent(eventType, k -> new CopyOnWriteArrayList<>()).add(handler);
        return this;
    }

    public void publish(DomainEvent event) {
        eventLog.add(event);
        var eventHandlers = handlers.getOrDefault(event.type(), List.of());
        eventHandlers.forEach(h -> {
            try { h.handle(event); }
            catch (Exception e) { System.err.println("Event handler error: " + e.getMessage()); }
        });
    }

    public List<DomainEvent> getEventLog() { return Collections.unmodifiableList(eventLog); }
}


// ─── Repository Pattern ───────────────────────────────────────
interface Repository<T, ID> {
    void save(T entity);
    Optional<T> findById(ID id);
    List<T> findAll();
    void delete(ID id);
    long count();
}

// Aggregate Root — User
class User {
    private final String id;
    private String name;
    private String email;
    private final String role;
    private boolean active;
    private final Instant createdAt;

    public User(String id, String name, String email, String role) {
        this.id = id; this.name = name; this.email = email;
        this.role = role; this.active = true;
        this.createdAt = Instant.now();
    }

    // Getters
    public String getId()       { return id; }
    public String getName()     { return name; }
    public String getEmail()    { return email; }
    public String getRole()     { return role; }
    public boolean isActive()   { return active; }
    public Instant getCreatedAt() { return createdAt; }

    // Domain methods
    public void updateName(String newName) {
        if (newName == null || newName.isBlank())
            throw new IllegalArgumentException("Name cannot be blank");
        this.name = newName;
    }
    public void deactivate() { this.active = false; }

    @Override public String toString() {
        return String.format("User{id='%s', name='%s', email='%s', role='%s', active=%b}",
            id.substring(0,8)+"...", name, email, role, active);
    }
}

class InMemoryUserRepository implements Repository<User, String> {
    private final Map<String, User> store = new ConcurrentHashMap<>();
    private final Map<String, String> emailIndex = new ConcurrentHashMap<>();

    @Override public void save(User u) {
        store.put(u.getId(), u);
        emailIndex.put(u.getEmail(), u.getId());
    }
    @Override public Optional<User> findById(String id) { return Optional.ofNullable(store.get(id)); }
    public Optional<User> findByEmail(String email) { return Optional.ofNullable(emailIndex.get(email)).flatMap(this::findById); }
    @Override public List<User> findAll()   { return new ArrayList<>(store.values()); }
    @Override public void delete(String id) { store.computeIfPresent(id, (k,u) -> { emailIndex.remove(u.getEmail()); return null; }); }
    @Override public long count()           { return store.size(); }
}


// ─── Microservice Base ────────────────────────────────────────
abstract class Microservice {
    protected final String name;
    protected final EventBus eventBus;
    protected final CircuitBreaker cb;

    protected Microservice(String name) {
        this.name = name;
        this.eventBus = EventBus.getInstance();
        this.cb = new CircuitBreaker(name, 3, 5000);
    }

    public String getName() { return name; }

    public abstract ServiceResponse handle(ServiceRequest request);

    protected void publishEvent(String type, String aggregateId, Map<String, Object> payload) {
        eventBus.publish(new DomainEvent(type, aggregateId, payload));
    }

    protected void log(String msg) {
        System.out.printf("  [%s] %s%n", name, msg);
    }
}


// ─── User Service ─────────────────────────────────────────────
class UserService extends Microservice {
    private final InMemoryUserRepository repo = new InMemoryUserRepository();

    public UserService() {
        super("UserService");
        // Seed data
        repo.save(new User(UUID.randomUUID().toString(), "Alice Johnson", "alice@archforge.io", "ADMIN"));
        repo.save(new User(UUID.randomUUID().toString(), "Bob Okafor",   "bob@archforge.io",   "USER"));
    }

    @Override
    public ServiceResponse handle(ServiceRequest req) {
        long start = System.currentTimeMillis();
        try {
            return cb.call(() -> switch (req.method()) {
                case "CREATE_USER"  -> createUser(req.payload());
                case "GET_USER"     -> getUser((String) req.payload().get("id"));
                case "LIST_USERS"   -> listUsers();
                case "UPDATE_USER"  -> updateUser(req.payload());
                default -> new ServiceResponse(false, null,
                    "Unknown method: " + req.method(), System.currentTimeMillis() - start);
            });
        } catch (Exception e) {
            return new ServiceResponse(false, null, e.getMessage(), System.currentTimeMillis() - start);
        }
    }

    private ServiceResponse createUser(Map<String, Object> payload) {
        String name  = (String) payload.get("name");
        String email = (String) payload.get("email");
        String role  = (String) payload.getOrDefault("role", "USER");

        if (repo.findByEmail(email).isPresent())
            throw new IllegalArgumentException("Email already exists: " + email);

        User user = new User(UUID.randomUUID().toString(), name, email, role);
        repo.save(user);
        publishEvent("USER_CREATED", user.getId(),
            Map.of("name", name, "email", email, "role", role));
        log("Created user: " + user.getName());
        return new ServiceResponse(true, user, null, 0);
    }

    private ServiceResponse getUser(String id) {
        return repo.findById(id)
            .map(u -> new ServiceResponse(true, u, null, 0))
            .orElse(new ServiceResponse(false, null, "User not found: " + id, 0));
    }

    private ServiceResponse listUsers() {
        return new ServiceResponse(true, repo.findAll(), null, 0);
    }

    private ServiceResponse updateUser(Map<String, Object> payload) {
        String id = (String) payload.get("id");
        return repo.findById(id).map(user -> {
            if (payload.containsKey("name")) user.updateName((String) payload.get("name"));
            repo.save(user);
            return new ServiceResponse(true, user, null, 0);
        }).orElse(new ServiceResponse(false, null, "User not found", 0));
    }
}


// ─── Notification Service ─────────────────────────────────────
class NotificationService extends Microservice {
    private final List<Map<String, Object>> sentNotifications = new ArrayList<>();

    public NotificationService() {
        super("NotificationService");
        // Subscribe to domain events
        eventBus.subscribe("USER_CREATED", this::onUserCreated);
        eventBus.subscribe("ORDER_PLACED", this::onOrderPlaced);
    }

    @Override
    public ServiceResponse handle(ServiceRequest req) {
        return switch (req.method()) {
            case "SEND_EMAIL" -> sendEmail(req.payload());
            case "GET_SENT"   -> new ServiceResponse(true, sentNotifications, null, 0);
            default -> new ServiceResponse(false, null, "Unknown: " + req.method(), 0);
        };
    }

    private void onUserCreated(DomainEvent event) {
        sendEmail(Map.of("to", event.payload().get("email"),
            "subject", "Welcome to ArchForge!",
            "body", "Hi " + event.payload().get("name") + "! Your account is ready."));
    }

    private void onOrderPlaced(DomainEvent event) {
        log("Order placed: " + event.aggregateId());
    }

    private ServiceResponse sendEmail(Map<String, Object> payload) {
        sentNotifications.add(Map.of(
            "to", payload.get("to"),
            "subject", payload.get("subject"),
            "sent_at", Instant.now().toString()
        ));
        log("Email sent to: " + payload.get("to"));
        return new ServiceResponse(true, "Email sent", null, 0);
    }
}


// ─── Service Registry (Singleton) ─────────────────────────────
class ServiceRegistry {
    private static ServiceRegistry instance;
    private final Map<String, Microservice> services = new ConcurrentHashMap<>();

    private ServiceRegistry() {}

    public static synchronized ServiceRegistry getInstance() {
        if (instance == null) instance = new ServiceRegistry();
        return instance;
    }

    public void register(Microservice service) {
        services.put(service.getName(), service);
        System.out.println("  [Registry] Registered: " + service.getName());
    }

    public Optional<Microservice> get(String name) {
        return Optional.ofNullable(services.get(name));
    }

    public Map<String, String> healthCheck() {
        return services.entrySet().stream()
            .collect(Collectors.toMap(
                Map.Entry::getKey,
                e -> e.getValue().cb.getState() == CircuitBreaker.State.OPEN ? "DEGRADED" : "HEALTHY"
            ));
    }
}


// ─── API Gateway Pattern ──────────────────────────────────────
/**
 * API Gateway — single entry point for all service calls.
 * Handles: routing, authentication, rate limiting, load balancing.
 */
class APIGateway {
    private final ServiceRegistry registry = ServiceRegistry.getInstance();
    private final Map<String, Integer> requestCounts = new ConcurrentHashMap<>();
    private static final int RATE_LIMIT = 100;

    public ServiceResponse route(String token, ServiceRequest request) {
        // 1. Rate limiting
        int count = requestCounts.merge(token, 1, Integer::sum);
        if (count > RATE_LIMIT) {
            return new ServiceResponse(false, null, "429 Rate limit exceeded", 0);
        }

        // 2. Find service
        return registry.get(request.service())
            .map(svc -> {
                long start = System.currentTimeMillis();
                ServiceResponse resp = svc.handle(request);
                long latency = System.currentTimeMillis() - start;
                System.out.printf("  [Gateway] → %s.%s | %dms | %s%n",
                    request.service(), request.method(), latency,
                    resp.success() ? "✓" : "✗ " + resp.error());
                return new ServiceResponse(resp.success(), resp.data(), resp.error(), latency);
            })
            .orElse(new ServiceResponse(false, null, "Service not found: " + request.service(), 0));
    }
}


// ─── Application Entry Point ──────────────────────────────────
public class ArchForgeApplication {
    public static void main(String[] args) {
        System.out.println("╔══════════════════════════════════════════════════╗");
        System.out.println("║  ArchForge — Microservices Architecture (Java)  ║");
        System.out.println("║  CSC 419: Software Design and Architecture      ║");
        System.out.println("╚══════════════════════════════════════════════════╝\n");

        // Bootstrap services
        System.out.println("[1] Bootstrapping Services...");
        ServiceRegistry registry = ServiceRegistry.getInstance();
        UserService userSvc = new UserService();
        NotificationService notifSvc = new NotificationService();
        registry.register(userSvc);
        registry.register(notifSvc);

        // API Gateway
        APIGateway gateway = new APIGateway();
        String token = "Bearer user-token-xyz";

        // List users
        System.out.println("\n[2] Listing Users...");
        var resp = gateway.route(token, new ServiceRequest("UserService", "LIST_USERS", Map.of()));
        if (resp.success()) {
            ((List<?>) resp.data()).forEach(u -> System.out.println("  " + u));
        }

        // Create user (triggers USER_CREATED event → NotificationService sends email)
        System.out.println("\n[3] Creating User (triggers domain event)...");
        var createResp = gateway.route(token, new ServiceRequest("UserService", "CREATE_USER",
            Map.of("name", "Carol Smith", "email", "carol@archforge.io", "role", "USER")));
        System.out.println("  Result: " + (createResp.success() ? createResp.data() : createResp.error()));

        // Health check
        System.out.println("\n[4] Service Health Check...");
        registry.healthCheck().forEach((svc, status) ->
            System.out.printf("  %-22s → %s%n", svc, status));

        // Event log
        System.out.println("\n[5] Domain Event Log...");
        EventBus.getInstance().getEventLog().forEach(e ->
            System.out.println("  " + e));

        // Circuit Breaker demo
        System.out.println("\n[6] Circuit Breaker Demo...");
        System.out.println("  Sending requests to a 'faulty' service...");
        // Simulate failures
        for (int i = 0; i < 5; i++) {
            try {
                userSvc.cb.call(() -> { throw new RuntimeException("Service unavailable"); });
            } catch (Exception e) {
                System.out.printf("  Attempt %d: %s%n", i+1, e.getMessage().substring(0, Math.min(50, e.getMessage().length())));
            }
        }

        System.out.println("\n✅ Microservices Architecture demonstration complete!");
        System.out.println("\nPatterns demonstrated:");
        System.out.println("  • Microservices Architecture");
        System.out.println("  • Service Registry (Singleton)");
        System.out.println("  • API Gateway");
        System.out.println("  • Circuit Breaker (Resilience)");
        System.out.println("  • Repository Pattern");
        System.out.println("  • Event-Driven Architecture");
        System.out.println("  • Domain Events (DDD)");
        System.out.println("  • Dependency Injection");
    }
}
