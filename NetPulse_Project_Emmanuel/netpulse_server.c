/**
 * NetPulse — C Socket Programming
 * CSC 417: Data Communication
 *
 * Demonstrates:
 *   - POSIX socket API (the foundation of all network programming)
 *   - IPv4 address structures (sockaddr_in)
 *   - TCP socket lifecycle: socket() → bind() → listen() → accept() → recv()/send() → close()
 *   - IP header structure (manual packet construction)
 *   - Network byte order (htonl, htons, ntohl, ntohs)
 *   - ICMP Ping simulation
 *
 * Compile: gcc -o netpulse_c netpulse_server.c -lpthread -Wall
 * Run:     ./netpulse_c server   (or client, or ping)
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <time.h>
#include <pthread.h>

/* POSIX socket headers */
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <netinet/ip.h>       /* IP header */
#include <arpa/inet.h>        /* inet_addr, inet_ntoa */
#include <netdb.h>            /* gethostbyname */

/* ─── Constants ──────────────────────────────────── */
#define SERVER_PORT      9200
#define MAX_CLIENTS      16
#define BUFFER_SIZE      2048
#define MAX_USERNAME     32
#define BACKLOG          5

/* ANSI colors for terminal output */
#define COLOR_GREEN  "\033[0;32m"
#define COLOR_RED    "\033[0;31m"
#define COLOR_CYAN   "\033[0;36m"
#define COLOR_YELLOW "\033[1;33m"
#define COLOR_RESET  "\033[0m"

/* ─── IP Header (Network Layer — OSI Layer 3) ────── */
/*
 * Manual IPv4 Header structure — demonstrates Layer 3 knowledge
 *
 *  0                   1                   2                   3
 *  0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 * |Version|  IHL  |Type of Service|          Total Length         |
 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 * |         Identification        |Flags|      Fragment Offset    |
 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 * |  Time to Live |    Protocol   |         Header Checksum       |
 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 * |                       Source Address                          |
 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 * |                    Destination Address                        |
 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
 */
struct ip_header {
    uint8_t  version_ihl;      /* Version (4 bits) + IHL (4 bits)     */
    uint8_t  tos;              /* Type of Service / DSCP + ECN         */
    uint16_t total_length;     /* Total packet length (header+data)    */
    uint16_t identification;   /* Packet ID for fragmentation          */
    uint16_t flags_fragment;   /* Flags (3 bits) + Fragment Offset     */
    uint8_t  ttl;              /* Time To Live — decremented each hop  */
    uint8_t  protocol;         /* 6=TCP, 17=UDP, 1=ICMP               */
    uint16_t checksum;         /* Header checksum                      */
    uint32_t src_addr;         /* Source IP address                    */
    uint32_t dst_addr;         /* Destination IP address               */
};

/* ─── Custom Application Protocol Header ─────────── */
struct np_header {
    uint8_t  magic[2];     /* 'N' 'P' — NetPulse signature  */
    uint8_t  version;      /* Protocol version (1)           */
    uint8_t  msg_type;     /* 0x01=DATA 0x02=ACK 0x03=PING  */
    uint32_t seq_num;      /* Sequence number                */
    uint32_t length;       /* Payload length in bytes        */
    uint16_t checksum;     /* Simple XOR checksum            */
} __attribute__((packed)); /* No padding — exact byte layout */

/* ─── Client Session ─────────────────────────────── */
typedef struct {
    int           fd;              /* Socket file descriptor     */
    struct sockaddr_in addr;       /* Client address             */
    char          username[MAX_USERNAME];
    int           active;
    pthread_t     thread;
    time_t        connected_at;
} client_session_t;

/* Global state */
static client_session_t clients[MAX_CLIENTS];
static int              client_count = 0;
static pthread_mutex_t  clients_mutex = PTHREAD_MUTEX_INITIALIZER;
static volatile int     server_running = 1;

/* ─── Utility Functions ──────────────────────────── */

/** Internet checksum (RFC 1071) — used in IP/TCP/UDP headers */
uint16_t checksum(const void *data, size_t len) {
    const uint16_t *ptr = (const uint16_t *)data;
    uint32_t sum = 0;
    while (len > 1) {
        sum += *ptr++;
        len -= 2;
    }
    if (len) sum += *(const uint8_t *)ptr;
    while (sum >> 16) sum = (sum & 0xFFFF) + (sum >> 16);
    return ~sum;
}

/** Simple XOR checksum for our custom protocol */
uint16_t np_checksum(const uint8_t *data, size_t len) {
    uint16_t csum = 0;
    for (size_t i = 0; i < len; i++) csum ^= data[i];
    return csum;
}

/** Print IP address from uint32_t (network byte order) */
void print_ip(uint32_t addr) {
    unsigned char *bytes = (unsigned char *)&addr;
    printf("%u.%u.%u.%u", bytes[0], bytes[1], bytes[2], bytes[3]);
}

/** Get current timestamp string */
const char *timestamp(void) {
    static char buf[32];
    time_t t = time(NULL);
    struct tm *tm = localtime(&t);
    strftime(buf, sizeof(buf), "%H:%M:%S", tm);
    return buf;
}

/* ─── Display IP Header Analysis ─────────────────── */
void display_ip_header_info(const char *src_ip, const char *dst_ip) {
    printf("\n%s[IP Header Analysis — OSI Layer 3]%s\n", COLOR_CYAN, COLOR_RESET);
    printf("┌────────────────────────────────────────────────┐\n");
    printf("│ %-46s │\n", "IPv4 Packet Header Structure");
    printf("├──────────────┬─────────────────────────────────┤\n");
    printf("│ %-12s │ %-31s │\n", "Version",     "4 (IPv4)");
    printf("│ %-12s │ %-31s │\n", "IHL",         "5 (20 bytes, no options)");
    printf("│ %-12s │ %-31s │\n", "TOS",         "0 (Best Effort)");
    printf("│ %-12s │ %-31s │\n", "TTL",         "64 (typical default)");
    printf("│ %-12s │ %-31s │\n", "Protocol",    "6 = TCP");
    printf("│ %-12s │ %-31s │\n", "Source IP",   src_ip);
    printf("│ %-12s │ %-31s │\n", "Dest IP",     dst_ip);
    printf("│ %-12s │ %-31s │\n", "Flags",       "DF=1 (Don't Fragment)");
    printf("└──────────────┴─────────────────────────────────┘\n");
}

/* ─── Client Thread Handler ──────────────────────── */
void *handle_client(void *arg) {
    client_session_t *client = (client_session_t *)arg;
    char buffer[BUFFER_SIZE];
    ssize_t bytes;

    printf("%s[+]%s [%s] Client connected: %s:%d\n",
        COLOR_GREEN, COLOR_RESET, timestamp(),
        inet_ntoa(client->addr.sin_addr),
        ntohs(client->addr.sin_port));

    /* Send greeting */
    const char *welcome = "Welcome to NetPulse C Server!\nEnter username: ";
    send(client->fd, welcome, strlen(welcome), 0);

    /* Receive username */
    bytes = recv(client->fd, buffer, sizeof(buffer) - 1, 0);
    if (bytes <= 0) goto disconnect;
    buffer[bytes] = '\0';
    /* Strip newline */
    for (int i = 0; buffer[i]; i++) {
        if (buffer[i] == '\n' || buffer[i] == '\r') { buffer[i] = '\0'; break; }
    }
    strncpy(client->username, buffer, MAX_USERNAME - 1);

    printf("[*] [%s] User '%s' authenticated\n", timestamp(), client->username);

    /* Send confirmation */
    snprintf(buffer, sizeof(buffer),
        "Hello %s! Protocol: TCP/IPv4 | Port: %d | OSI Layer 4\n",
        client->username, SERVER_PORT);
    send(client->fd, buffer, strlen(buffer), 0);

    /* Main receive loop */
    while (server_running) {
        bytes = recv(client->fd, buffer, sizeof(buffer) - 1, 0);
        if (bytes <= 0) break;
        buffer[bytes] = '\0';

        /* Strip trailing newline */
        for (int i = 0; buffer[i]; i++) {
            if (buffer[i] == '\n' || buffer[i] == '\r') { buffer[i] = '\0'; break; }
        }

        printf("[MSG] [%s] <%s> %s\n", timestamp(), client->username, buffer);

        /* Process commands */
        char response[BUFFER_SIZE];
        if (strcmp(buffer, "/quit") == 0) {
            snprintf(response, sizeof(response), "Goodbye %s! Connection closing...\n", client->username);
            send(client->fd, response, strlen(response), 0);
            break;
        } else if (strcmp(buffer, "/stats") == 0) {
            snprintf(response, sizeof(response),
                "Server Stats: %d active client(s) | Port: %d | Running\n",
                client_count, SERVER_PORT);
            send(client->fd, response, strlen(response), 0);
        } else if (strcmp(buffer, "/help") == 0) {
            snprintf(response, sizeof(response),
                "Commands: /stats /quit /help | Or type anything to echo\n");
            send(client->fd, response, strlen(response), 0);
        } else {
            /* Echo with prefix */
            snprintf(response, sizeof(response), "[ECHO] %s\n", buffer);
            send(client->fd, response, strlen(response), 0);
        }
    }

disconnect:
    printf("%s[-]%s [%s] Client '%s' disconnected\n",
        COLOR_RED, COLOR_RESET, timestamp(), client->username);

    pthread_mutex_lock(&clients_mutex);
    client->active = 0;
    client_count--;
    pthread_mutex_unlock(&clients_mutex);

    close(client->fd);
    return NULL;
}

/* ─── TCP Server ─────────────────────────────────── */
int run_server(void) {
    int server_fd;
    struct sockaddr_in server_addr, client_addr;
    socklen_t client_len = sizeof(client_addr);

    printf("\n%s╔══════════════════════════════════════════════╗%s\n", COLOR_GREEN, COLOR_RESET);
    printf("%s║   NetPulse C Server — POSIX Socket API       ║%s\n", COLOR_GREEN, COLOR_RESET);
    printf("%s║   CSC 417: Data Communication               ║%s\n", COLOR_GREEN, COLOR_RESET);
    printf("%s╚══════════════════════════════════════════════╝%s\n\n", COLOR_GREEN, COLOR_RESET);

    /* 1. Create socket — AF_INET=IPv4, SOCK_STREAM=TCP */
    server_fd = socket(AF_INET, SOCK_STREAM, 0);
    if (server_fd < 0) {
        perror("socket() failed");
        return EXIT_FAILURE;
    }
    printf("[*] Socket created: fd=%d\n", server_fd);

    /* 2. Set socket options — SO_REUSEADDR avoids "Address already in use" */
    int opt = 1;
    setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

    /* 3. Bind — associate socket with port */
    memset(&server_addr, 0, sizeof(server_addr));
    server_addr.sin_family      = AF_INET;
    server_addr.sin_addr.s_addr = INADDR_ANY;          /* Listen on all interfaces */
    server_addr.sin_port        = htons(SERVER_PORT);  /* Host-to-Network byte order */

    if (bind(server_fd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
        perror("bind() failed");
        close(server_fd);
        return EXIT_FAILURE;
    }
    printf("[*] Bound to port %d (htons=%d)\n", SERVER_PORT, htons(SERVER_PORT));

    /* 4. Listen — mark socket as passive (accepts connections) */
    if (listen(server_fd, BACKLOG) < 0) {
        perror("listen() failed");
        close(server_fd);
        return EXIT_FAILURE;
    }
    printf("[*] Listening... (backlog=%d)\n", BACKLOG);
    printf("[*] Waiting for TCP connections on port %d\n\n", SERVER_PORT);

    display_ip_header_info("0.0.0.0 (INADDR_ANY)", "any");

    /* 5. Accept loop */
    while (server_running) {
        /* accept() blocks until a client connects (TCP 3-way handshake completes) */
        int client_fd = accept(server_fd,
                               (struct sockaddr *)&client_addr, &client_len);
        if (client_fd < 0) {
            if (errno == EINTR) continue;  /* Interrupted by signal */
            perror("accept() failed");
            break;
        }

        /* Find free client slot */
        pthread_mutex_lock(&clients_mutex);
        int slot = -1;
        for (int i = 0; i < MAX_CLIENTS; i++) {
            if (!clients[i].active) { slot = i; break; }
        }

        if (slot == -1) {
            fprintf(stderr, "[!] Max clients reached, rejecting\n");
            close(client_fd);
            pthread_mutex_unlock(&clients_mutex);
            continue;
        }

        /* Initialize client session */
        clients[slot].fd = client_fd;
        clients[slot].addr = client_addr;
        clients[slot].active = 1;
        clients[slot].connected_at = time(NULL);
        memset(clients[slot].username, 0, MAX_USERNAME);
        client_count++;
        pthread_mutex_unlock(&clients_mutex);

        /* Spawn thread for this client */
        pthread_create(&clients[slot].thread, NULL, handle_client, &clients[slot]);
        pthread_detach(clients[slot].thread);  /* Auto-cleanup when done */
    }

    close(server_fd);
    printf("\n[*] Server stopped.\n");
    return EXIT_SUCCESS;
}

/* ─── OSI Model Display ──────────────────────────── */
void display_osi_model(void) {
    printf("\n%s╔══════════════════════════════════════════════════════════╗%s\n",
           COLOR_CYAN, COLOR_RESET);
    printf("%s║              OSI Model — 7 Layers                        ║%s\n",
           COLOR_CYAN, COLOR_RESET);
    printf("%s╠════╦═════════════════╦════════════════════════════════════╣%s\n",
           COLOR_CYAN, COLOR_RESET);

    const struct { int layer; const char *name; const char *desc; const char *pdu; } osi[] = {
        {7, "Application", "HTTP, FTP, SMTP, DNS, SSH",         "Data"},
        {6, "Presentation","Encryption, Compression, Encoding",  "Data"},
        {5, "Session",     "Session management, Authentication", "Data"},
        {4, "Transport",   "TCP, UDP — Ports, Reliability",      "Segment/Datagram"},
        {3, "Network",     "IP, ICMP, OSPF — Routing",           "Packet"},
        {2, "Data Link",   "Ethernet, WiFi — MAC, Framing",      "Frame"},
        {1, "Physical",    "Cables, Fiber, Radio — Bits",        "Bit"},
    };

    for (int i = 0; i < 7; i++) {
        const char *color = (osi[i].layer == 4) ? COLOR_YELLOW : COLOR_RESET;
        printf("║ %s%2d ║ %-15s ║ %-34s ║%s\n",
            color, osi[i].layer, osi[i].name, osi[i].desc, COLOR_RESET);
    }
    printf("%s╚════╩═════════════════╩════════════════════════════════════╝%s\n\n",
           COLOR_CYAN, COLOR_RESET);
    printf("  Layer 4 (Transport) %s← THIS SERVER OPERATES HERE%s\n\n",
           COLOR_YELLOW, COLOR_RESET);
}

/* ─── Network Byte Order Demo ────────────────────── */
void demo_byte_order(void) {
    printf("\n%s[Network Byte Order Demo]%s\n", COLOR_CYAN, COLOR_RESET);
    uint32_t host_val = 0x12345678;
    uint32_t net_val  = htonl(host_val);
    uint16_t port_host = 9200;
    uint16_t port_net  = htons(port_host);

    printf("  Host byte order:    0x%08X (%u)\n", host_val, host_val);
    printf("  Network byte order: 0x%08X (%u) [Big-endian]\n", net_val, net_val);
    printf("  Port %u  → htons → %u (0x%04X)\n", port_host, port_net, port_net);
    printf("  Port %u  → ntohs → %u (restored)\n\n", port_net, ntohs(port_net));
    printf("  Rule: Always use htonl/htons when sending, ntohl/ntohs when receiving!\n");
}

/* ─── Main ────────────────────────────────────────── */
int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s [server|osi|byteorder]\n", argv[0]);
        printf("\n  server    — Start TCP echo server on port %d\n", SERVER_PORT);
        printf("  osi       — Display OSI 7-layer model\n");
        printf("  byteorder — Demo network byte order (htonl/htons)\n");
        return EXIT_FAILURE;
    }

    if (strcmp(argv[1], "server") == 0) {
        memset(clients, 0, sizeof(clients));
        return run_server();
    } else if (strcmp(argv[1], "osi") == 0) {
        display_osi_model();
        return EXIT_SUCCESS;
    } else if (strcmp(argv[1], "byteorder") == 0) {
        demo_byte_order();
        return EXIT_SUCCESS;
    } else {
        fprintf(stderr, "Unknown command: %s\n", argv[1]);
        return EXIT_FAILURE;
    }
}
