#!/usr/bin/env bash
# ============================================================
# NetPulse — Network Diagnostic Suite
# CSC 417: Data Communication
# Author: [Your Name] | 400-Level CS | SIWES Project
#
# This script demonstrates:
#   - Network diagnostic tools (ping, traceroute, netstat, ss)
#   - Bandwidth monitoring
#   - TCP connection state analysis
#   - DNS lookup tools
#   - Port scanning with netcat
#   - Network interface analysis
#
# Usage: chmod +x netpulse_diag.sh && ./netpulse_diag.sh [command]
# ============================================================

set -euo pipefail

# ─── Colors ────────────────────────────────────────────────
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; BLUE='\033[0;34m'; BOLD='\033[1m'; NC='\033[0m'

# ─── Logging ───────────────────────────────────────────────
LOG_DIR="./logs"
mkdir -p "$LOG_DIR"
LOG_FILE="${LOG_DIR}/netpulse_$(date +%Y%m%d_%H%M%S).log"

log()  { echo -e "${CYAN}[$(date +%H:%M:%S)]${NC} $*" | tee -a "$LOG_FILE"; }
info() { echo -e "${GREEN}[INFO]${NC} $*" | tee -a "$LOG_FILE"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $*" | tee -a "$LOG_FILE"; }
err()  { echo -e "${RED}[ERROR]${NC} $*" | tee -a "$LOG_FILE" >&2; }
hdr()  { echo -e "\n${BOLD}${BLUE}══════════════════════════════════════${NC}"; echo -e "${BOLD}  $*${NC}"; echo -e "${BLUE}══════════════════════════════════════${NC}"; }

# ─── Check if command exists ───────────────────────────────
has_cmd() { command -v "$1" &>/dev/null; }

# ─── Ping Analysis ─────────────────────────────────────────
ping_analysis() {
    local target="${1:-8.8.8.8}"
    local count="${2:-10}"

    hdr "🔴 PING Analysis — ICMP (OSI Layer 3)"
    log "Target: $target | Packets: $count"
    log "Protocol: ICMP | Type 8 (Echo Request) → Type 0 (Echo Reply)"
    echo ""

    if has_cmd ping; then
        # Run ping and capture output
        ping_out=$(ping -c "$count" -W 2 "$target" 2>&1 || true)
        echo "$ping_out" | tee -a "$LOG_FILE"

        # Extract RTT stats
        if echo "$ping_out" | grep -q "min/avg/max"; then
            rtt_line=$(echo "$ping_out" | grep "min/avg/max")
            echo ""
            info "RTT Statistics: $rtt_line"

            # Parse loss percentage
            loss=$(echo "$ping_out" | grep -oP '\d+(?=% packet loss)' || echo "0")
            if [[ "$loss" -eq 0 ]]; then
                info "✓ Zero packet loss — excellent connectivity"
            elif [[ "$loss" -lt 5 ]]; then
                warn "⚠ ${loss}% packet loss — acceptable but monitor"
            else
                err "✗ ${loss}% packet loss — connection degraded"
            fi
        fi
    else
        warn "ping not available on this system"
    fi
}

# ─── Traceroute / Path Analysis ────────────────────────────
trace_route() {
    local target="${1:-8.8.8.8}"

    hdr "🗺  Traceroute — Hop-by-Hop Path Analysis (OSI Layer 3)"
    log "Target: $target"
    log "Shows: IP routing path, TTL decrements, each router hop"
    echo ""
    echo "  HOP  LATENCY    IP ADDRESS         HOSTNAME"
    echo "  ─────────────────────────────────────────────"

    if has_cmd traceroute; then
        traceroute -m 15 -w 2 "$target" 2>/dev/null | \
            awk 'NR>1 {printf "  %-4s %-10s %-18s %s\n", $1, $3, $4, $5}' | \
            tee -a "$LOG_FILE" || true
    elif has_cmd tracepath; then
        tracepath -n "$target" 2>/dev/null | head -20 | tee -a "$LOG_FILE" || true
    else
        warn "traceroute/tracepath not available"
        # Simulate output for demo
        echo "  1    0.5ms      192.168.1.254      gateway.local"
        echo "  2    5.2ms      10.0.0.1           isp-router.net"
        echo "  3    12.8ms     72.14.215.138      google-core.net"
        echo "  4    15.3ms     8.8.8.8            dns.google"
    fi
    echo ""
    info "Each hop = one router that forwards your IP packet"
    info "TTL decrements by 1 at each hop — prevents infinite routing loops"
}

# ─── TCP Connection State Analysis ─────────────────────────
tcp_connections() {
    hdr "🔗 TCP Connection States — OSI Layer 4"
    log "Displaying all TCP connection states"
    echo ""

    # TCP State definitions
    declare -A tcp_states=(
        ["LISTEN"]="Server waiting for incoming connections (SYN packets)"
        ["SYN_SENT"]="Client sent SYN, waiting for SYN-ACK"
        ["SYN_RECEIVED"]="Server received SYN, sent SYN-ACK, waiting for ACK"
        ["ESTABLISHED"]="Three-way handshake complete — data transfer active"
        ["FIN_WAIT_1"]="Active close: sent FIN, waiting for ACK"
        ["FIN_WAIT_2"]="Received ACK of FIN, waiting for remote FIN"
        ["TIME_WAIT"]="Waiting to ensure remote received final ACK (2×MSL)"
        ["CLOSE_WAIT"]="Remote sent FIN; waiting for local application to close"
        ["CLOSED"]="No connection"
    )

    echo -e "${BOLD}  TCP State Machine:${NC}"
    echo "  ─────────────────────────────────────────────────"
    for state in LISTEN SYN_SENT ESTABLISHED FIN_WAIT_1 FIN_WAIT_2 TIME_WAIT CLOSE_WAIT; do
        printf "  ${GREEN}%-18s${NC} %s\n" "$state" "${tcp_states[$state]}"
    done
    echo ""

    # Live connections
    echo -e "${BOLD}  Live TCP Connections:${NC}"
    echo "  ─────────────────────────────────────────────────"
    if has_cmd ss; then
        ss -tnp 2>/dev/null | head -20 | tee -a "$LOG_FILE" || \
            echo "  (requires elevated privileges)"
    elif has_cmd netstat; then
        netstat -tn 2>/dev/null | head -20 | tee -a "$LOG_FILE" || \
            echo "  (requires elevated privileges)"
    else
        # Demo output
        printf "  %-14s %-22s %-22s\n" "State" "Local Address" "Remote Address"
        printf "  %-14s %-22s %-22s\n" "LISTEN"       "0.0.0.0:9000"  "0.0.0.0:*"
        printf "  %-14s %-22s %-22s\n" "ESTABLISHED"  "127.0.0.1:9000" "127.0.0.1:52341"
        printf "  %-14s %-22s %-22s\n" "TIME_WAIT"    "127.0.0.1:9000" "127.0.0.1:52300"
    fi
}

# ─── DNS Lookup Analysis ────────────────────────────────────
dns_lookup() {
    local domains=("google.com" "github.com" "anthropic.com")

    hdr "🌐 DNS Lookup — Application Layer (UDP Port 53)"
    log "DNS: Domain Name System — Resolves human names to IP addresses"
    echo ""
    printf "  ${BOLD}%-25s %-18s %-8s %s${NC}\n" "Domain" "IP Address" "RTT(ms)" "Type"
    echo "  ─────────────────────────────────────────────────────────"

    for domain in "${domains[@]}"; do
        start_ns=$(date +%s%N)

        if has_cmd dig; then
            ip=$(dig +short "$domain" A 2>/dev/null | head -1 || echo "N/A")
        elif has_cmd nslookup; then
            ip=$(nslookup "$domain" 2>/dev/null | awk '/^Address: /{print $2}' | head -1 || echo "N/A")
        elif has_cmd host; then
            ip=$(host "$domain" 2>/dev/null | awk '/has address/{print $4}' | head -1 || echo "N/A")
        else
            ip="N/A (no DNS tools)"
        fi

        end_ns=$(date +%s%N)
        rtt_ms=$(( (end_ns - start_ns) / 1000000 ))

        printf "  %-25s ${GREEN}%-18s${NC} %-8s %s\n" \
            "$domain" "${ip:-NXDOMAIN}" "${rtt_ms}ms" "A (IPv4)"
    done

    echo ""
    info "DNS Query Process: Browser → /etc/resolv.conf → DNS Server → Root → TLD → Auth"
    info "DNS uses UDP port 53 for queries (< 512 bytes), TCP for zone transfers"
}

# ─── Network Interface Analysis ────────────────────────────
interface_analysis() {
    hdr "🖧  Network Interfaces — OSI Layer 1 & 2"
    log "Listing all network interfaces and their statistics"
    echo ""

    if has_cmd ip; then
        echo -e "${BOLD}  Interface Configuration:${NC}"
        ip addr 2>/dev/null | grep -E "(^[0-9]+:|inet |ether )" | \
            awk '{print "  " $0}' | head -30 | tee -a "$LOG_FILE" || true

        echo ""
        echo -e "${BOLD}  Routing Table:${NC}"
        ip route 2>/dev/null | awk '{print "  " $0}' | head -15 | tee -a "$LOG_FILE" || true
    elif has_cmd ifconfig; then
        ifconfig 2>/dev/null | head -40 | awk '{print "  " $0}' | tee -a "$LOG_FILE" || true
    else
        warn "No interface tool found — showing demo data"
        echo "  eth0: 192.168.1.10/24  MAC: AA:BB:CC:DD:EE:02  MTU: 1500  UP"
        echo "  lo:   127.0.0.1/8                              MTU: 65536 LOOPBACK"
        echo ""
        echo "  Default route: 0.0.0.0/0 via 192.168.1.254 dev eth0"
    fi

    echo ""
    info "MTU (Maximum Transmission Unit): Max frame size at Layer 2"
    info "Standard Ethernet MTU: 1500 bytes"
    info "Loopback (lo): 127.0.0.1 — virtual interface for local communication"
}

# ─── Bandwidth Monitor ─────────────────────────────────────
bandwidth_monitor() {
    local interface="${1:-eth0}"
    local interval=2
    local iterations=5

    hdr "📊 Bandwidth Monitor — Real-time Traffic Analysis"
    log "Interface: $interface | Sample interval: ${interval}s"
    echo ""

    # Try to read /proc/net/dev (Linux)
    if [[ -r /proc/net/dev ]]; then
        echo -e "${BOLD}  Time       TX (bytes/s)    RX (bytes/s)    TX Pkts/s   RX Pkts/s${NC}"
        echo "  ──────────────────────────────────────────────────────────────"

        prev_tx=0; prev_rx=0
        for (( i=0; i<iterations; i++ )); do
            line=$(grep "$interface:" /proc/net/dev 2>/dev/null || echo "")
            if [[ -n "$line" ]]; then
                rx_bytes=$(echo "$line" | awk '{print $2}')
                tx_bytes=$(echo "$line" | awk '{print $10}')

                if [[ $prev_tx -gt 0 ]]; then
                    tx_rate=$(( (tx_bytes - prev_tx) / interval ))
                    rx_rate=$(( (rx_bytes - prev_rx) / interval ))
                    printf "  %-10s %-15s %-15s\n" \
                        "$(date +%H:%M:%S)" \
                        "$(numfmt --to=iec "$tx_rate" 2>/dev/null || echo "${tx_rate}B")/s" \
                        "$(numfmt --to=iec "$rx_rate" 2>/dev/null || echo "${rx_rate}B")/s"
                fi
                prev_tx=$tx_bytes; prev_rx=$rx_bytes
            fi
            sleep "$interval"
        done
    else
        warn "/proc/net/dev not available — showing simulated data"
        echo -e "${BOLD}  Time       TX Rate         RX Rate         Latency${NC}"
        echo "  ─────────────────────────────────────────────────"
        for (( i=0; i<iterations; i++ )); do
            tx=$(( RANDOM % 1024 + 100 ))
            rx=$(( RANDOM % 4096 + 500 ))
            lat=$(( RANDOM % 20 + 1 ))
            printf "  %-10s %-15s %-15s %sms\n" \
                "$(date +%H:%M:%S)" "${tx}KB/s" "${rx}KB/s" "$lat"
            sleep "$interval" &
            wait
        done
    fi
    echo ""
    info "RX = Received (inbound traffic) | TX = Transmitted (outbound traffic)"
}

# ─── Port Scanner (Educational) ───────────────────────────
port_scan() {
    local target="${1:-127.0.0.1}"
    local ports=(21 22 23 25 53 80 443 3306 5432 6379 8080 9000 9001 9100 9200)

    hdr "🔍 Port Scanner — TCP Connect Scan (Educational)"
    warn "Only scan systems you own or have permission to scan!"
    log "Target: $target | Method: TCP SYN connect"
    echo ""
    printf "  ${BOLD}%-8s %-12s %-10s %s${NC}\n" "Port" "State" "Protocol" "Service"
    echo "  ─────────────────────────────────────────────"

    declare -A services=(
        [21]="FTP" [22]="SSH" [23]="Telnet" [25]="SMTP"
        [53]="DNS" [80]="HTTP" [443]="HTTPS" [3306]="MySQL"
        [5432]="PostgreSQL" [6379]="Redis" [8080]="HTTP-Alt"
        [9000]="NetPulse-TCP" [9001]="NetPulse-UDP"
        [9100]="NetPulse-Java" [9200]="NetPulse-C"
    )

    for port in "${ports[@]}"; do
        if has_cmd nc; then
            if nc -z -w 1 "$target" "$port" 2>/dev/null; then
                state="${GREEN}OPEN${NC}"; tcp="TCP"
            else
                state="${RED}CLOSED${NC}"; tcp="TCP"
            fi
        else
            # Fallback: try /dev/tcp
            if (echo >/dev/tcp/"$target"/"$port") 2>/dev/null; then
                state="${GREEN}OPEN${NC}"; tcp="TCP"
            else
                state="${RED}CLOSED${NC}"; tcp="TCP"
            fi
        fi

        service="${services[$port]:-Unknown}"
        printf "  %-8s %-20s %-10s %s\n" "$port" "$(echo -e $state)" "$tcp" "$service"
    done
    echo ""
    info "OPEN = TCP SYN received ACK (port accepting connections)"
    info "CLOSED = TCP RST received (port not listening)"
    info "FILTERED = No response (firewall blocking)"
}

# ─── OSI Layer Summary ─────────────────────────────────────
osi_summary() {
    hdr "📚 OSI 7-Layer Model — Quick Reference"
    echo ""
    printf "  ${BOLD}%-5s %-14s %-22s %-25s %s${NC}\n" \
        "Layer" "Name" "Key Protocols" "PDU" "Device"
    echo "  ────────────────────────────────────────────────────────────────────────"

    layers=(
        "7|Application|HTTP HTTPS FTP SMTP DNS|Data|Browser/App"
        "6|Presentation|SSL/TLS JPEG MPEG ASCII|Data|Gateway"
        "5|Session|NetBIOS RPC SQL PPTP|Data|Gateway"
        "4|Transport|TCP UDP SCTP|Segment/Datagram|Firewall"
        "3|Network|IPv4 IPv6 ICMP OSPF BGP|Packet|Router"
        "2|Data Link|Ethernet WiFi PPP ARP|Frame|Switch"
        "1|Physical|RJ45 Fiber Radio Coax|Bit|Hub/NIC"
    )

    for entry in "${layers[@]}"; do
        IFS='|' read -r num name protos pdu device <<< "$entry"
        if [[ "$num" -eq 4 ]]; then
            echo -e "  ${YELLOW}${BOLD}$num${NC}   ${YELLOW}${BOLD}${name}${NC}       ${YELLOW}$protos${NC}       ${YELLOW}$pdu${NC}    ${YELLOW}$device ← Our servers${NC}"
        else
            echo -e "  $num   ${BOLD}$name${NC}       $protos       $pdu    $device"
        fi
    done

    echo ""
    info "Mnemonic (top→down): All People Seem To Need Data Processing"
    info "NetPulse operates at: Layer 4 (TCP/UDP) + Layer 7 (application protocol)"
}

# ─── Full System Report ────────────────────────────────────
full_report() {
    hdr "📋 NetPulse — Full Network Diagnostic Report"
    echo -e "  Generated: $(date) | Host: $(hostname) | OS: $(uname -s) $(uname -r)"
    echo ""

    osi_summary
    dns_lookup
    interface_analysis
    tcp_connections
    ping_analysis "8.8.8.8" 4
    port_scan "127.0.0.1"

    echo ""
    hdr "✅ Report Complete"
    info "Log saved to: $LOG_FILE"
}

# ─── Main Entry Point ──────────────────────────────────────
main() {
    echo -e "${BOLD}${GREEN}"
    echo "  ╔══════════════════════════════════════════════╗"
    echo "  ║   NetPulse Network Diagnostic Suite          ║"
    echo "  ║   CSC 417: Data Communication | Bash v1.0   ║"
    echo "  ╚══════════════════════════════════════════════╝"
    echo -e "${NC}"

    local cmd="${1:-help}"

    case "$cmd" in
        ping)       ping_analysis "${2:-8.8.8.8}" "${3:-10}" ;;
        trace)      trace_route "${2:-8.8.8.8}" ;;
        tcp)        tcp_connections ;;
        dns)        dns_lookup ;;
        interfaces) interface_analysis ;;
        bandwidth)  bandwidth_monitor "${2:-eth0}" ;;
        portscan)   port_scan "${2:-127.0.0.1}" ;;
        osi)        osi_summary ;;
        report)     full_report ;;
        help|*)
            echo "  Usage: $0 [command] [options]"
            echo ""
            echo "  Commands:"
            printf "    %-14s %s\n" "ping [host]"     "ICMP ping analysis with statistics"
            printf "    %-14s %s\n" "trace [host]"    "Traceroute hop-by-hop path analysis"
            printf "    %-14s %s\n" "tcp"             "Show TCP connection states"
            printf "    %-14s %s\n" "dns"             "DNS resolution with timing"
            printf "    %-14s %s\n" "interfaces"      "Network interface configuration"
            printf "    %-14s %s\n" "bandwidth [if]"  "Real-time bandwidth monitor"
            printf "    %-14s %s\n" "portscan [host]" "TCP port scanner (own systems only)"
            printf "    %-14s %s\n" "osi"             "OSI 7-layer model reference"
            printf "    %-14s %s\n" "report"          "Full diagnostic report"
            echo ""
            echo "  CSC 417 — Data Communication | SIWES Portfolio"
            ;;
    esac
}

main "$@"
