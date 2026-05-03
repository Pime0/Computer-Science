#!/usr/bin/env python3
"""
NetPulse — TCP Echo Server (Multi-threaded)
CSC 417: Data Communication
Project: NetPulse Network Protocols Lab

Demonstrates:
  - TCP socket programming
  - Multi-threaded client handling
  - OSI Layer 4 (Transport Layer) concepts
  - Three-way handshake simulation
  - Connection logging
"""

import socket
import threading
import logging
import json
import time
from datetime import datetime

# ─── Configuration ─────────────────────────────────────
HOST = '127.0.0.1'
PORT = 9000
MAX_CLIENTS = 10
BUFFER_SIZE = 4096
LOG_FILE = 'netpulse_server.log'

# ─── Logging Setup ────────────────────────────────────
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s [%(levelname)s] %(message)s',
    handlers=[
        logging.FileHandler(LOG_FILE),
        logging.StreamHandler()
    ]
)
log = logging.getLogger('NetPulse-TCP-Server')

# ─── Connection Registry ──────────────────────────────
active_connections = {}
connections_lock = threading.Lock()
stats = {
    'total_connections': 0,
    'bytes_received': 0,
    'bytes_sent': 0,
    'messages_handled': 0,
    'start_time': time.time()
}


class ClientHandler(threading.Thread):
    """
    Handles each TCP client connection in a dedicated thread.
    Demonstrates Thread-per-Connection server model.
    """

    def __init__(self, client_socket: socket.socket, address: tuple):
        super().__init__(daemon=True)
        self.socket = client_socket
        self.address = address
        self.client_id = f"{address[0]}:{address[1]}"
        self.connected_at = datetime.now()

    def run(self):
        """Main client handler loop — receives, processes, echoes."""
        log.info(f"[+] New connection: {self.client_id}  [Thread: {threading.current_thread().name}]")

        with connections_lock:
            active_connections[self.client_id] = {
                'address': self.address,
                'connected_at': self.connected_at.isoformat(),
                'messages': 0
            }
            stats['total_connections'] += 1

        try:
            # Send welcome banner (simulates TCP handshake completion message)
            banner = json.dumps({
                'type': 'WELCOME',
                'server': 'NetPulse TCP Server v1.0',
                'protocol': 'TCP/IP',
                'layer': 'Transport (OSI Layer 4)',
                'client_id': self.client_id,
                'timestamp': self.connected_at.isoformat()
            })
            self._send(banner)

            while True:
                data = self.socket.recv(BUFFER_SIZE)
                if not data:
                    break   # Client disconnected (FIN packet received)

                message = data.decode('utf-8').strip()
                stats['bytes_received'] += len(data)

                log.info(f"[{self.client_id}] RX ({len(data)} bytes): {message[:80]}")

                # Process message
                response = self._process(message)
                self._send(response)

                with connections_lock:
                    active_connections[self.client_id]['messages'] += 1
                    stats['messages_handled'] += 1

        except (ConnectionResetError, BrokenPipeError):
            log.warning(f"[!] Connection reset: {self.client_id}")
        except Exception as e:
            log.error(f"[!] Error handling {self.client_id}: {e}")
        finally:
            self._cleanup()

    def _send(self, message: str):
        """Send data to client with length prefix (framing)."""
        data = message.encode('utf-8')
        # Length-prefix framing to handle TCP segment boundary issues
        frame = len(data).to_bytes(4, 'big') + data
        self.socket.sendall(frame)
        stats['bytes_sent'] += len(frame)
        log.info(f"[{self.client_id}] TX ({len(data)} bytes)")

    def _process(self, message: str) -> str:
        """
        Process incoming message — demonstrates application layer protocol.
        Commands: ECHO, TIME, STATS, PING, QUIT
        """
        try:
            payload = json.loads(message)
            cmd = payload.get('command', 'ECHO').upper()
        except json.JSONDecodeError:
            cmd = 'ECHO'
            payload = {'data': message}

        if cmd == 'ECHO':
            return json.dumps({'type': 'ECHO', 'data': payload.get('data', message), 'server_time': time.time()})

        elif cmd == 'TIME':
            return json.dumps({'type': 'TIME', 'server_time': datetime.now().isoformat(), 'unix': time.time()})

        elif cmd == 'STATS':
            uptime = time.time() - stats['start_time']
            return json.dumps({
                'type': 'STATS',
                'total_connections': stats['total_connections'],
                'active_connections': len(active_connections),
                'bytes_received': stats['bytes_received'],
                'bytes_sent': stats['bytes_sent'],
                'messages_handled': stats['messages_handled'],
                'uptime_seconds': round(uptime, 2)
            })

        elif cmd == 'PING':
            return json.dumps({'type': 'PONG', 'latency_ms': 0, 'server': HOST})

        elif cmd == 'QUIT':
            return json.dumps({'type': 'BYE', 'message': 'Connection closing — TCP FIN sent'})

        else:
            return json.dumps({'type': 'ERROR', 'message': f'Unknown command: {cmd}'})

    def _cleanup(self):
        """Close socket and remove from active connections registry."""
        with connections_lock:
            active_connections.pop(self.client_id, None)
        self.socket.close()
        duration = (datetime.now() - self.connected_at).total_seconds()
        log.info(f"[-] Disconnected: {self.client_id}  [Duration: {duration:.2f}s]")


class NetPulseTCPServer:
    """
    Multi-threaded TCP Server implementing:
    - AF_INET socket (IPv4)
    - SOCK_STREAM (TCP — reliable, ordered, connection-oriented)
    - SO_REUSEADDR (allow port reuse on restart)
    - Thread-per-connection concurrency model
    """

    def __init__(self, host: str = HOST, port: int = PORT):
        self.host = host
        self.port = port
        self.server_socket = None
        self.running = False

    def start(self):
        """Initialize socket, bind, listen, and accept connections."""
        # Create TCP socket (AF_INET = IPv4, SOCK_STREAM = TCP)
        self.server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

        # Allow immediate port reuse (avoids TIME_WAIT state issues)
        self.server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

        # Bind to address and port
        self.server_socket.bind((self.host, self.port))

        # Listen — backlog queue of MAX_CLIENTS pending connections
        self.server_socket.listen(MAX_CLIENTS)

        self.running = True
        log.info(f"[*] NetPulse TCP Server listening on {self.host}:{self.port}")
        log.info(f"[*] Protocol: TCP/IP  |  OSI Layer 4 (Transport)")
        log.info(f"[*] Max clients: {MAX_CLIENTS}  |  Buffer: {BUFFER_SIZE} bytes")
        log.info("[*] Waiting for connections... (Press Ctrl+C to stop)")

        try:
            while self.running:
                # Block until a client connects (TCP 3-way handshake completes)
                client_sock, client_addr = self.server_socket.accept()

                # Check max connections
                if len(active_connections) >= MAX_CLIENTS:
                    log.warning(f"[!] Max clients reached. Rejecting: {client_addr}")
                    client_sock.close()
                    continue

                # Spawn new thread for this client
                handler = ClientHandler(client_sock, client_addr)
                handler.start()

        except KeyboardInterrupt:
            log.info("\n[*] Server shutting down...")
        finally:
            self.stop()

    def stop(self):
        """Gracefully shut down server — close all connections."""
        self.running = False
        with connections_lock:
            for cid in list(active_connections.keys()):
                log.info(f"  Closing: {cid}")
        if self.server_socket:
            self.server_socket.close()
        log.info("[*] Server stopped. Final stats:")
        log.info(f"    Total connections: {stats['total_connections']}")
        log.info(f"    Bytes TX: {stats['bytes_sent']}  RX: {stats['bytes_received']}")
        log.info(f"    Messages handled: {stats['messages_handled']}")


# ─── TCP Client (for testing) ─────────────────────────
class NetPulseTCPClient:
    """Test client that demonstrates the TCP three-way handshake."""

    def __init__(self, host: str = HOST, port: int = PORT):
        self.host = host
        self.port = port

    def demo(self):
        """Send test messages to the server."""
        print("\n[NetPulse TCP Client Demo]")
        print(f"Connecting to {self.host}:{self.port} via TCP...")

        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            # TCP 3-way handshake: SYN → SYN-ACK → ACK (happens here)
            s.connect((self.host, self.port))
            print("✓ TCP Handshake complete (SYN → SYN-ACK → ACK)")

            # Commands to test
            commands = [
                json.dumps({'command': 'PING'}),
                json.dumps({'command': 'TIME'}),
                json.dumps({'command': 'ECHO', 'data': 'Hello from NetPulse!'}),
                json.dumps({'command': 'STATS'}),
                json.dumps({'command': 'QUIT'}),
            ]

            for cmd in commands:
                s.sendall(cmd.encode())
                # Read length prefix
                raw_len = s.recv(4)
                if not raw_len:
                    break
                msg_len = int.from_bytes(raw_len, 'big')
                data = s.recv(msg_len)
                response = json.loads(data.decode())
                print(f"  → CMD: {json.loads(cmd).get('command')}")
                print(f"  ← RSP: {response}")
                time.sleep(0.1)


if __name__ == '__main__':
    import sys
    if len(sys.argv) > 1 and sys.argv[1] == 'client':
        NetPulseTCPClient().demo()
    else:
        server = NetPulseTCPServer()
        server.start()
