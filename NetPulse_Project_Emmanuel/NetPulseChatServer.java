/**
 * NetPulse — Multi-Client Chat Server (Java)
 * CSC 417: Data Communication
 *
 * Demonstrates:
 *   - Java ServerSocket / Socket API (TCP)
 *   - Multi-threaded server with ExecutorService thread pool
 *   - Application-layer protocol design (custom chat protocol)
 *   - Broadcast messaging (one-to-many communication)
 *   - OSI Application Layer (Layer 7) concepts
 *
 * Compile: javac -d out src/NetPulse*.java
 * Run Server: java -cp out NetPulseChatServer
 * Run Client: java -cp out NetPulseChatClient
 */

import java.io.*;
import java.net.*;
import java.util.*;
import java.util.concurrent.*;
import java.time.*;
import java.time.format.*;

// ─── Message Protocol ────────────────────────────────────
class ChatMessage implements Serializable {
    public enum Type { JOIN, LEAVE, CHAT, WHISPER, SERVER_INFO, ERROR, LIST_USERS }

    public final Type type;
    public final String sender;
    public final String recipient;  // null = broadcast
    public final String content;
    public final String timestamp;

    public ChatMessage(Type type, String sender, String content) {
        this(type, sender, null, content);
    }

    public ChatMessage(Type type, String sender, String recipient, String content) {
        this.type = type;
        this.sender = sender;
        this.recipient = recipient;
        this.content = content;
        this.timestamp = LocalDateTime.now().format(
            DateTimeFormatter.ofPattern("HH:mm:ss")
        );
    }

    @Override
    public String toString() {
        return String.format("[%s] <%s> %s", timestamp, sender, content);
    }

    public String toWire() {
        // Simple text protocol: TYPE|SENDER|RECIPIENT|CONTENT
        return String.join("|",
            type.name(),
            sender != null ? sender : "",
            recipient != null ? recipient : "",
            content != null ? content : ""
        );
    }

    public static ChatMessage fromWire(String wire) {
        String[] parts = wire.split("\\|", 4);
        if (parts.length < 4) return null;
        Type t = Type.valueOf(parts[0]);
        String sender = parts[1].isEmpty() ? null : parts[1];
        String recipient = parts[2].isEmpty() ? null : parts[2];
        String content = parts[3];
        return new ChatMessage(t, sender, recipient, content);
    }
}


// ─── Server: Client Session Handler ─────────────────────
class ClientSession implements Runnable {
    private final Socket socket;
    private final NetPulseChatServer server;
    private PrintWriter out;
    private BufferedReader in;
    private String username;
    private final String sessionId;

    public ClientSession(Socket socket, NetPulseChatServer server) {
        this.socket = socket;
        this.server = server;
        this.sessionId = socket.getRemoteSocketAddress().toString();
    }

    public String getUsername() { return username; }

    public void send(ChatMessage message) {
        if (out != null && !socket.isClosed()) {
            out.println(message.toWire());
        }
    }

    @Override
    public void run() {
        System.out.printf("[+] New connection: %s%n", sessionId);
        try {
            in  = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            out = new PrintWriter(new OutputStreamWriter(socket.getOutputStream()), true);

            // Step 1: Authentication — receive username
            send(new ChatMessage(ChatMessage.Type.SERVER_INFO, "SERVER", "Enter your username:"));
            String wire = in.readLine();
            if (wire == null) return;

            ChatMessage joinMsg = ChatMessage.fromWire(wire);
            if (joinMsg == null || joinMsg.type != ChatMessage.Type.JOIN) {
                username = "Guest_" + (int)(Math.random() * 1000);
            } else {
                username = joinMsg.sender;
            }

            // Register with server
            if (!server.registerUser(this)) {
                send(new ChatMessage(ChatMessage.Type.ERROR, "SERVER", "Username taken!"));
                return;
            }

            System.out.printf("[+] User '%s' joined from %s%n", username, sessionId);

            // Broadcast join notification
            server.broadcast(new ChatMessage(ChatMessage.Type.JOIN, "SERVER",
                String.format(">> %s has joined the channel", username)), this);

            // Send welcome message
            send(new ChatMessage(ChatMessage.Type.SERVER_INFO, "SERVER",
                String.format("Welcome %s! %d user(s) online. Commands: /list /whisper /quit", 
                    username, server.getUserCount())));

            // Step 2: Main message loop
            while ((wire = in.readLine()) != null) {
                ChatMessage msg = ChatMessage.fromWire(wire);
                if (msg == null) continue;

                switch (msg.type) {
                    case CHAT -> handleChat(msg);
                    case WHISPER -> handleWhisper(msg);
                    case LIST_USERS -> handleListUsers();
                    case LEAVE -> { handleLeave(); return; }
                    default -> send(new ChatMessage(ChatMessage.Type.ERROR, "SERVER", "Unknown command"));
                }
            }

        } catch (IOException e) {
            System.out.printf("[!] Session error for %s: %s%n", username, e.getMessage());
        } finally {
            handleLeave();
        }
    }

    private void handleChat(ChatMessage msg) {
        System.out.printf("[MSG] %s: %s%n", username, msg.content);
        // Broadcast to all users (including self for echo)
        server.broadcast(new ChatMessage(ChatMessage.Type.CHAT, username, msg.content), null);
    }

    private void handleWhisper(ChatMessage msg) {
        // Direct message to specific user
        ClientSession target = server.getUser(msg.recipient);
        if (target != null) {
            target.send(new ChatMessage(ChatMessage.Type.WHISPER, username, 
                msg.recipient, "[Whisper] " + msg.content));
            send(new ChatMessage(ChatMessage.Type.WHISPER, "SERVER",
                "[→ " + msg.recipient + "] " + msg.content));
        } else {
            send(new ChatMessage(ChatMessage.Type.ERROR, "SERVER", 
                "User not found: " + msg.recipient));
        }
    }

    private void handleListUsers() {
        String users = String.join(", ", server.getOnlineUsers());
        send(new ChatMessage(ChatMessage.Type.LIST_USERS, "SERVER", 
            "Online: [" + users + "] — " + server.getUserCount() + " user(s)"));
    }

    private void handleLeave() {
        if (username != null) {
            server.unregisterUser(this);
            server.broadcast(new ChatMessage(ChatMessage.Type.LEAVE, "SERVER",
                "<< " + username + " has left the channel"), this);
            System.out.printf("[-] User '%s' disconnected%n", username);
            username = null;
        }
        try { socket.close(); } catch (IOException ignored) {}
    }
}


// ─── TCP Chat Server ─────────────────────────────────────
public class NetPulseChatServer {
    private static final int PORT = 9100;
    private static final int THREAD_POOL_SIZE = 20;

    // Thread-safe map of username → session
    private final ConcurrentHashMap<String, ClientSession> sessions = new ConcurrentHashMap<>();
    private final ExecutorService threadPool = Executors.newFixedThreadPool(THREAD_POOL_SIZE);

    // ── User Registry ─────────────────────────────────
    public boolean registerUser(ClientSession session) {
        return sessions.putIfAbsent(session.getUsername(), session) == null;
    }

    public void unregisterUser(ClientSession session) {
        if (session.getUsername() != null) {
            sessions.remove(session.getUsername());
        }
    }

    public ClientSession getUser(String username) {
        return sessions.get(username);
    }

    public int getUserCount() { return sessions.size(); }

    public List<String> getOnlineUsers() {
        return new ArrayList<>(sessions.keySet());
    }

    // ── Broadcast ─────────────────────────────────────
    public void broadcast(ChatMessage msg, ClientSession exclude) {
        sessions.values().stream()
            .filter(s -> s != exclude)
            .forEach(s -> s.send(msg));
    }

    // ── Server Entry Point ─────────────────────────────
    public void start() throws IOException {
        try (ServerSocket serverSocket = new ServerSocket(PORT)) {
            serverSocket.setReuseAddress(true);

            System.out.println("╔══════════════════════════════════════════╗");
            System.out.println("║   NetPulse Chat Server — Java TCP/IP     ║");
            System.out.println("║   CSC 417: Data Communication            ║");
            System.out.println("╠══════════════════════════════════════════╣");
            System.out.printf("║  Port:     %-30d║%n", PORT);
            System.out.printf("║  Threads:  %-30d║%n", THREAD_POOL_SIZE);
            System.out.printf("║  Protocol: %-30s║%n", "TCP (SOCK_STREAM)");
            System.out.printf("║  Layer:    %-30s║%n", "Transport + Application");
            System.out.println("╚══════════════════════════════════════════╝");
            System.out.println("\nWaiting for connections...\n");

            while (!serverSocket.isClosed()) {
                Socket client = serverSocket.accept();
                client.setKeepAlive(true);
                client.setTcpNoDelay(true);  // Disable Nagle's algorithm for chat
                ClientSession session = new ClientSession(client, this);
                threadPool.execute(session);
            }
        }
    }

    public static void main(String[] args) throws IOException {
        new NetPulseChatServer().start();
    }
}


// ─── TCP Chat Client ──────────────────────────────────────
class NetPulseChatClient {
    private static final String HOST = "127.0.0.1";
    private static final int PORT = 9100;

    private Socket socket;
    private PrintWriter out;
    private BufferedReader in;
    private volatile boolean running = true;

    public void connect(String username) throws IOException {
        socket = new Socket(HOST, PORT);
        socket.setTcpNoDelay(true);
        out = new PrintWriter(new OutputStreamWriter(socket.getOutputStream()), true);
        in  = new BufferedReader(new InputStreamReader(socket.getInputStream()));

        System.out.printf("Connected to NetPulse Chat Server at %s:%d%n", HOST, PORT);

        // Read server prompt
        System.out.println(in.readLine());

        // Send JOIN message
        out.println(new ChatMessage(ChatMessage.Type.JOIN, username, "Joining...").toWire());

        // Start listener thread
        Thread listener = new Thread(this::receiveLoop, "MessageListener");
        listener.setDaemon(true);
        listener.start();

        // Read from console
        Scanner scanner = new Scanner(System.in);
        while (running && scanner.hasNextLine()) {
            String input = scanner.nextLine().trim();
            if (input.isEmpty()) continue;

            if (input.startsWith("/quit")) {
                out.println(new ChatMessage(ChatMessage.Type.LEAVE, username, "Goodbye").toWire());
                running = false;
            } else if (input.startsWith("/list")) {
                out.println(new ChatMessage(ChatMessage.Type.LIST_USERS, username, "").toWire());
            } else if (input.startsWith("/whisper ")) {
                String[] parts = input.substring(9).split(" ", 2);
                if (parts.length == 2) {
                    out.println(new ChatMessage(ChatMessage.Type.WHISPER, username, parts[0], parts[1]).toWire());
                }
            } else {
                out.println(new ChatMessage(ChatMessage.Type.CHAT, username, input).toWire());
            }
        }
        socket.close();
    }

    private void receiveLoop() {
        try {
            String wire;
            while (running && (wire = in.readLine()) != null) {
                ChatMessage msg = ChatMessage.fromWire(wire);
                if (msg != null) {
                    System.out.println(msg);
                }
            }
        } catch (IOException e) {
            if (running) System.out.println("[Disconnected from server]");
        }
    }

    public static void main(String[] args) throws IOException {
        String username = args.length > 0 ? args[0] : "Student_" + (int)(Math.random()*100);
        new NetPulseChatClient().connect(username);
    }
}
