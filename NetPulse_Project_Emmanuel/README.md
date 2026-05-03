# 📡 NetPulse — Data Communication & Network Protocols Lab

> **CSC 417: Data Communication**  
> 400-Level Computer Science | SIWES Industrial Project  
> **6 Programming Languages** | **7 OSI Layers** | **4 Server Implementations**

---

## 🎯 Project Overview

NetPulse is a **multi-language network programming laboratory** that demonstrates Data Communication concepts through real, runnable code. Each programming language showcases a different aspect of network communication, from low-level C socket programming to high-level Python abstractions.

---

## 🗂 Repository Structure

```
netpulse/
├── 🐍 python/
│   ├── tcp_server.py          Multi-threaded TCP echo server with JSON protocol
│   └── udp_protocols.py       UDP datagram server, Stop-and-Wait ARQ, DNS queries
│
├── ☕ java/
│   └── NetPulseChatServer.java Multi-client chat server with thread pool + custom protocol
│
├── 🔵 c/
│   └── netpulse_server.c      POSIX socket API — raw TCP server, OSI demo, byte order
│
├── 🗄 sql/
│   └── netpulse_db.sql        MySQL schema for network logs, packets, DNS, security events
│
├── 🖥 bash/
│   └── netpulse_diag.sh       Network diagnostic suite — ping, traceroute, TCP states
│
├── 🌐 html/
│   └── index.html             Interactive dashboard — OSI model, protocol simulator, calc
│
└── 📋 README.md               This file
```

---

## 💻 Language Showcase

### 🐍 Python 3 — `python/`
**Concepts demonstrated:**
- `socket.socket(AF_INET, SOCK_STREAM)` — TCP socket creation
- `socket.socket(AF_INET, SOCK_DGRAM)` — UDP datagram socket
- `threading.Thread` — concurrent client handling
- Custom binary packet framing (length-prefix protocol)
- CRC-16/CCITT checksum implementation
- Stop-and-Wait ARQ protocol simulation
- Raw DNS query packet construction (RFC 1035)
- TCP vs UDP protocol analysis

**Run:**
```bash
cd python/
python3 tcp_server.py              # Start TCP server on port 9000
python3 tcp_server.py client       # Start test client
python3 udp_protocols.py stop-wait # Simulate Stop-and-Wait ARQ
python3 udp_protocols.py dns       # Send real DNS query to 8.8.8.8
python3 udp_protocols.py compare   # TCP vs UDP comparison
```

---

### ☕ Java 17 — `java/`
**Concepts demonstrated:**
- `ServerSocket` / `Socket` Java TCP API
- `ExecutorService.newFixedThreadPool(20)` — thread pool pattern
- `ConcurrentHashMap` — thread-safe session management
- Custom text-based wire protocol (`TYPE|SENDER|RECIPIENT|CONTENT`)
- Broadcast messaging (one-to-many)
- `setTcpNoDelay(true)` — disabling Nagle's algorithm for chat
- `setKeepAlive(true)` — detecting dead connections

**Compile & Run:**
```bash
cd java/
javac -d out NetPulseChatServer.java
java -cp out NetPulseChatServer        # Start server on port 9100
java -cp out NetPulseChatClient Alice  # Connect client (another terminal)
java -cp out NetPulseChatClient Bob    # Second client — they can chat!
```

---

### 🔵 C (POSIX) — `c/`
**Concepts demonstrated:**
- POSIX socket API: `socket()`, `bind()`, `listen()`, `accept()`, `recv()`, `send()`
- `struct sockaddr_in` — IPv4 address structure
- Network byte order: `htonl()`, `htons()`, `ntohl()`, `ntohs()`
- `struct ip_header` — manual IPv4 header with `__attribute__((packed))`
- Internet checksum algorithm (RFC 1071)
- `pthread_create()` / `pthread_detach()` — POSIX threads
- `SO_REUSEADDR` socket option
- OSI model visualization in terminal

**Compile & Run:**
```bash
cd c/
gcc -o netpulse_c netpulse_server.c -lpthread -Wall -O2
./netpulse_c server    # Start TCP server on port 9200
./netpulse_c osi       # Display OSI 7-layer model
./netpulse_c byteorder # Demo network byte order
```

---

### 🗄 SQL (MySQL) — `sql/`
**Concepts demonstrated:**
- Relational schema for network logging (6 tables, 5 views, 2 procedures)
- `SMALLINT UNSIGNED` for ports (0–65535)
- `TIMESTAMP(6)` for microsecond packet capture precision
- `ENUM` for protocol types, connection states, severity levels
- `SET` for TCP flags (`SYN`, `ACK`, `FIN`, `RST`, `PSH`, `URG`)
- `ON DUPLICATE KEY UPDATE` for node upserts
- Window functions and complex analytical queries
- Stored procedures: `log_connection()`, `bandwidth_report()`
- Views: `active_connections_view`, `dns_performance_view`, `threat_dashboard_view`

**Setup:**
```bash
mysql -u root -p < sql/netpulse_db.sql
mysql -u root -p netpulse_db

# Test queries:
mysql> SELECT * FROM active_connections_view;
mysql> CALL bandwidth_report(24);
mysql> SELECT * FROM dns_performance_view;
```

---

### 🖥 Bash — `bash/`
**Concepts demonstrated:**
- `ping` — ICMP echo request/reply analysis
- `traceroute` / `tracepath` — hop-by-hop routing path
- `ss` / `netstat` — TCP connection state analysis
- `dig` / `nslookup` — DNS resolution with timing
- `/proc/net/dev` — real-time interface statistics
- `nc` (netcat) — TCP port scanning
- Signal handling (`SIGINT`)
- Structured logging with timestamps

**Run:**
```bash
chmod +x bash/netpulse_diag.sh
./bash/netpulse_diag.sh report           # Full diagnostic report
./bash/netpulse_diag.sh ping 8.8.8.8 10  # Ping with 10 packets
./bash/netpulse_diag.sh dns              # DNS timing analysis
./bash/netpulse_diag.sh osi              # OSI model reference
```

---

### 🌐 HTML/CSS/JavaScript — `html/`
**Concepts demonstrated:**
- Interactive OSI 7-layer model with protocol details
- TCP three-way handshake animation
- Four-way TCP termination animation
- Stop-and-Wait ARQ simulator with configurable packet loss
- TCP vs UDP comparison table
- Protocol step-by-step simulator
- IPv4 Subnet calculator (CIDR notation)
- Bandwidth and propagation delay calculator
- IP packet encapsulation visualization

**Run:** Open `html/index.html` in any modern browser (no server needed).

---

## 🧠 CSC 417 Topics Covered

| Topic | Implementation |
|-------|---------------|
| OSI 7-Layer Model | HTML dashboard + C terminal display |
| TCP (Layer 4 — reliable) | Python multi-threaded server + Java chat |
| UDP (Layer 4 — fast) | Python datagram server + Stop-and-Wait |
| Socket Programming | Python + Java + C (3 different APIs) |
| IP Addressing & Subnets | HTML calculator + SQL schema |
| Packet Structure | C (raw struct) + Python (binary packing) |
| Network Byte Order | C (`htonl`/`htons`) + Python (`struct`) |
| Error Detection | CRC-16 (Python) + Internet Checksum (C) |
| Stop-and-Wait ARQ | Python simulation + HTML animator |
| DNS (App Layer/UDP) | Python raw packet + Bash `dig` |
| Routing & Traceroute | Bash `traceroute` diagnostic |
| Bandwidth & Latency | HTML bandwidth calculator |
| Network Logging | SQL database schema + analytical views |
| Security Monitoring | SQL `security_events` table |
| Thread-per-Connection | Python + Java + C (pthread) |

---

## 🚀 Quick Start

```bash
# Clone repository
git clone https://github.com/[your-username]/netpulse-csc417
cd netpulse-csc417

# Python — Start TCP server
python3 python/tcp_server.py

# Python — UDP demo
python3 python/udp_protocols.py compare

# Java — Chat server
javac -d out java/NetPulseChatServer.java && java -cp out NetPulseChatServer

# C — OSI model
gcc -o netpulse c/netpulse_server.c -lpthread && ./netpulse osi

# Bash — Network diagnostics
bash bash/netpulse_diag.sh report

# HTML — Open dashboard
open html/index.html  # or double-click the file
```

---

## 📊 GitHub Language Statistics

This project will display as:
- 🐍 Python — `tcp_server.py` (TCP) + `udp_protocols.py` (UDP)
- ☕ Java — `NetPulseChatServer.java` (multi-client chat)
- 🔵 C — `netpulse_server.c` (POSIX sockets)
- 🗄 SQL — `netpulse_db.sql` (MySQL schema)
- 🖥 Shell — `netpulse_diag.sh` (Bash diagnostics)
- 🌐 HTML — `index.html` (interactive dashboard)

---

## 👨‍💻 Author

**[Your Full Name]**  
400-Level Computer Science  
Matriculation No: [Your Matric Number]  
Course: CSC 417 — Data Communication  
Institution: [Your University Name]

---

*Built as part of a 400-Level Computer Science SIWES portfolio — demonstrating multi-language programming proficiency across network communication domains.*
