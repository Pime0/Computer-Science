#!/usr/bin/env python3
"""
NetPulse — UDP Server & Packet Analyzer
CSC 417: Data Communication

Demonstrates:
  - UDP (SOCK_DGRAM) — connectionless, no handshake
  - Difference between TCP and UDP
  - Packet loss simulation
  - DNS query structure (application layer over UDP)
  - Custom packet framing
  - Checksum computation (CRC16)
"""

import socket
import struct
import random
import time
import json
import hashlib
from dataclasses import dataclass, field
from typing import Optional


# ─── Custom Packet Structure ──────────────────────────
@dataclass
class NetPacket:
    """
    Custom UDP payload packet — demonstrates packet structure concepts.

    Packet Header (12 bytes):
    ┌────────────┬──────────┬──────────┬────────────┬──────────┐
    │  Magic (2) │ Type (1) │ Seq  (2) │ Length (4) │  CRC (2) │
    └────────────┴──────────┴──────────┴────────────┴──────────┘
    Followed by payload (variable length)
    """
    MAGIC = 0x4E50        # Signature bytes (NetPulse)
    MAGIC_BYTES = b'NP' # 2 bytes

    TYPE_DATA  = 0x01
    TYPE_ACK   = 0x02
    TYPE_PING  = 0x03
    TYPE_PONG  = 0x04
    TYPE_ERROR = 0xFF

    ptype:   int   = TYPE_DATA
    seq:     int   = 0
    payload: bytes = b''
    crc:     int   = 0

    HEADER_FORMAT = '!2sBHI'   # Big-endian: 2s=magic, B=type, H=seq(ushort), I=length(uint)
    HEADER_SIZE   = struct.calcsize(HEADER_FORMAT)  # = 9 bytes

    def to_bytes(self) -> bytes:
        """Serialize packet to bytes for transmission."""
        payload_len = len(self.payload)
        # CRC16 of payload for error detection
        crc = self._crc16(self.payload)
        header = struct.pack(
            self.HEADER_FORMAT,
            self.MAGIC_BYTES,
            self.ptype,
            self.seq,
            payload_len
        )
        return header + struct.pack('!H', crc) + self.payload

    @classmethod
    def from_bytes(cls, data: bytes) -> Optional['NetPacket']:
        """Deserialize bytes back into a NetPacket."""
        if len(data) < cls.HEADER_SIZE + 2:
            return None
        magic, ptype, seq, length = struct.unpack(cls.HEADER_FORMAT, data[:cls.HEADER_SIZE])
        if magic != b'NP':
            return None  # Invalid magic — drop packet
        crc_received = struct.unpack('!H', data[cls.HEADER_SIZE:cls.HEADER_SIZE+2])[0]
        payload = data[cls.HEADER_SIZE+2:cls.HEADER_SIZE+2+length]
        crc_computed = cls._crc16_static(payload)
        if crc_received != crc_computed:
            print(f"  ⚠️  CRC mismatch! Expected {crc_computed:#06x}, got {crc_received:#06x}")
        packet = cls(ptype=ptype, seq=seq, payload=payload, crc=crc_received)
        return packet

    def _crc16(self, data: bytes) -> int:
        return self._crc16_static(data)

    @staticmethod
    def _crc16_static(data: bytes) -> int:
        """CRC-16/CCITT checksum for error detection."""
        crc = 0xFFFF
        for byte in data:
            crc ^= byte << 8
            for _ in range(8):
                if crc & 0x8000:
                    crc = (crc << 1) ^ 0x1021
                else:
                    crc <<= 1
            crc &= 0xFFFF
        return crc


# ─── UDP Server ───────────────────────────────────────
class NetPulseUDPServer:
    """
    UDP Server — connectionless, no handshake.

    Key UDP characteristics demonstrated:
    - No connection establishment (no handshake)
    - No guaranteed delivery (packets can be lost)
    - No ordering guarantee (packets can arrive out of order)
    - Low overhead — faster than TCP
    - Best for: streaming, DNS, gaming, VoIP
    """

    def __init__(self, host: str = '127.0.0.1', port: int = 9001):
        self.host = host
        self.port = port
        self.packet_count = 0
        self.bytes_received = 0

    def start(self):
        """Start UDP server — notice no listen() or accept() needed!"""
        # SOCK_DGRAM = UDP (Datagram)
        with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
            s.bind((self.host, self.port))
            print(f"[UDP Server] Listening on {self.host}:{self.port}")
            print(f"[UDP Server] Protocol: UDP  |  OSI Layer 4 (Transport)")
            print(f"[UDP Server] Connectionless — no handshake required\n")

            while True:
                # recvfrom returns (data, (addr, port)) — each datagram is independent
                data, addr = s.recvfrom(65535)  # Max UDP datagram = 65,535 bytes
                self.packet_count += 1
                self.bytes_received += len(data)

                print(f"[+] Datagram #{self.packet_count} from {addr[0]}:{addr[1]} ({len(data)} bytes)")

                packet = NetPacket.from_bytes(data)
                if packet:
                    self._handle_packet(s, addr, packet)
                else:
                    # Try JSON fallback
                    try:
                        msg = json.loads(data.decode())
                        response = json.dumps({'type': 'ACK', 'seq': 0, 'echo': msg})
                        s.sendto(response.encode(), addr)
                    except Exception:
                        pass

    def _handle_packet(self, sock, addr, packet: NetPacket):
        """Process and respond to incoming packets."""
        payload = packet.payload.decode('utf-8', errors='replace')
        print(f"    Type: {['DATA','ACK','PING','PONG'][packet.ptype-1] if 1<=packet.ptype<=4 else 'ERROR'}")
        print(f"    Seq:  {packet.seq}")
        print(f"    Data: {payload[:60]}")

        if packet.ptype == NetPacket.TYPE_PING:
            # Send PONG response
            pong = NetPacket(ptype=NetPacket.TYPE_PONG, seq=packet.seq, payload=b'PONG')
            sock.sendto(pong.to_bytes(), addr)

        elif packet.ptype == NetPacket.TYPE_DATA:
            # Echo back with ACK
            ack = NetPacket(ptype=NetPacket.TYPE_ACK, seq=packet.seq, payload=packet.payload)
            sock.sendto(ack.to_bytes(), addr)


# ─── Stop-and-Wait Protocol Simulation ───────────────
class StopAndWait:
    """
    Simulates the Stop-and-Wait ARQ (Automatic Repeat reQuest) protocol.
    Demonstrates reliable data transfer over unreliable UDP.

    Protocol:
      1. Sender sends packet, starts timeout timer
      2. Waits for ACK
      3. If ACK arrives: send next packet
      4. If timeout: retransmit (simulate packet loss)
    """

    def __init__(self, loss_probability: float = 0.2):
        self.loss_prob = loss_probability
        self.total_sent = 0
        self.retransmissions = 0
        self.acked = 0

    def send_all(self, messages: list, timeout: float = 1.0):
        """
        Simulate sending a list of messages using Stop-and-Wait.
        Uses simulated packet loss to demonstrate retransmission.
        """
        print(f"\n[Stop-and-Wait ARQ Protocol]")
        print(f"Packet loss probability: {self.loss_prob*100:.0f}%")
        print(f"Timeout: {timeout}s\n")

        for seq, msg in enumerate(messages):
            seq_bit = seq % 2   # Alternating bit: 0 or 1
            acked = False

            while not acked:
                self.total_sent += 1
                print(f"  → TX  Frame {seq+1} [seq={seq_bit}]: '{msg}'", end="")

                # Simulate packet loss
                if random.random() < self.loss_prob:
                    print(f"  ✗ LOST (simulated)")
                    time.sleep(timeout)
                    self.retransmissions += 1
                    print(f"  ↺ ReTX Frame {seq+1} [seq={seq_bit}]: '{msg}'", end="")

                # Simulate ACK
                if random.random() >= self.loss_prob:
                    print(f"  ← ACK [ack={seq_bit}] ✓")
                    acked = True
                    self.acked += 1
                else:
                    print(f"  ✗ ACK LOST")
                    time.sleep(timeout)
                    self.retransmissions += 1

        efficiency = (len(messages) / self.total_sent) * 100
        print(f"\n[Stop-and-Wait Results]")
        print(f"  Frames sent (total):  {self.total_sent}")
        print(f"  Retransmissions:      {self.retransmissions}")
        print(f"  ACKs received:        {self.acked}")
        print(f"  Efficiency:           {efficiency:.1f}%")


# ─── DNS Query Parser ─────────────────────────────────
def parse_dns_query(domain: str) -> bytes:
    """
    Build a raw DNS query packet — demonstrates Application Layer over UDP.

    DNS Query Structure (RFC 1035):
    ┌─────────────────────────────────────┐
    │ Header (12 bytes)                   │
    │   ID (2) | Flags (2) | Counts (8)  │
    ├─────────────────────────────────────┤
    │ Question Section                    │
    │   QNAME | QTYPE | QCLASS           │
    └─────────────────────────────────────┘
    """
    # Header: ID=0x1234, Flags=Standard Query (RD=1), 1 question
    header = struct.pack(
        '!HHHHHH',
        0x1234,  # ID
        0x0100,  # Flags: Recursion Desired
        1,       # QDCOUNT: 1 question
        0,       # ANCOUNT: 0 answers
        0,       # NSCOUNT
        0        # ARCOUNT
    )

    # Encode domain name: split by '.', prefix each part with length
    qname = b''
    for label in domain.split('.'):
        qname += bytes([len(label)]) + label.encode()
    qname += b'\x00'  # Null terminator

    # QTYPE=A (1 = IPv4 address), QCLASS=IN (1 = Internet)
    question = qname + struct.pack('!HH', 1, 1)

    return header + question


def demo_dns_query():
    """Send a real DNS query to Google's DNS server (8.8.8.8) over UDP."""
    print("\n[DNS Query Demo — UDP Port 53]")
    domains = ['google.com', 'github.com', 'anthropic.com']

    for domain in domains:
        try:
            query = parse_dns_query(domain)
            with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
                s.settimeout(3.0)
                print(f"  Querying: {domain}")
                print(f"    → UDP Datagram sent to 8.8.8.8:53 ({len(query)} bytes)")
                s.sendto(query, ('8.8.8.8', 53))
                response, _ = s.recvfrom(512)
                # Extract answer IPs from response (simplified)
                print(f"    ← DNS Response received ({len(response)} bytes) ✓")
                # Parse transaction ID from response
                resp_id = struct.unpack('!H', response[:2])[0]
                print(f"    Transaction ID: {resp_id:#06x}")
        except socket.timeout:
            print(f"    ✗ DNS query timed out (no network?)")
        except Exception as e:
            print(f"    ✗ Error: {e}")
        print()


# ─── Packet Statistics Analyzer ──────────────────────
def analyze_protocols():
    """
    Compare TCP vs UDP protocol characteristics.
    Demonstrates understanding of Transport Layer protocols.
    """
    print("\n" + "═"*60)
    print("  TCP vs UDP — Protocol Analysis")
    print("═"*60)

    comparison = [
        ("Connection",    "3-way handshake",    "No connection (connectionless)"),
        ("Reliability",   "Guaranteed delivery", "Best-effort (no guarantee)"),
        ("Ordering",      "In-order delivery",   "No ordering guarantee"),
        ("Error Check",   "Yes (checksum+ACK)",  "Checksum only"),
        ("Flow Control",  "Yes (sliding window)", "No"),
        ("Congestion Ctl","Yes",                 "No"),
        ("Header Size",   "20–60 bytes",         "8 bytes"),
        ("Speed",         "Slower (overhead)",   "Faster (minimal overhead)"),
        ("Use Cases",     "HTTP, FTP, SSH, Email","DNS, VoIP, Video, Gaming"),
        ("OSI Layer",     "Transport (Layer 4)", "Transport (Layer 4)"),
    ]

    print(f"\n{'Feature':<20} {'TCP':^25} {'UDP':^25}")
    print("─"*70)
    for feature, tcp, udp in comparison:
        print(f"{feature:<20} {tcp:^25} {udp:^25}")

    print("\n[Bandwidth Efficiency Calculation]")
    payload = 1000  # bytes
    tcp_overhead = 40   # bytes (min)
    udp_overhead = 8    # bytes
    tcp_eff = payload / (payload + tcp_overhead) * 100
    udp_eff = payload / (payload + udp_overhead) * 100
    print(f"  Payload: {payload} bytes")
    print(f"  TCP efficiency: {tcp_eff:.1f}%  (header: {tcp_overhead} bytes)")
    print(f"  UDP efficiency: {udp_eff:.1f}%  (header: {udp_overhead} bytes)")


if __name__ == '__main__':
    import sys
    cmd = sys.argv[1] if len(sys.argv) > 1 else 'demo'

    if cmd == 'server':
        NetPulseUDPServer().start()
    elif cmd == 'stop-wait':
        saw = StopAndWait(loss_probability=0.25)
        messages = ['Hello', 'CSC 417', 'Data Communication', 'NetPulse', 'Project']
        saw.send_all(messages)
    elif cmd == 'dns':
        demo_dns_query()
    elif cmd == 'compare':
        analyze_protocols()
    else:
        print("[NetPulse UDP Demo]")
        analyze_protocols()
        StopAndWait(loss_probability=0.2).send_all(['Frame A', 'Frame B', 'Frame C', 'Frame D'])
