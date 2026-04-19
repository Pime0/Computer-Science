-- ============================================================
-- NetPulse — Network Communication Logs Database
-- CSC 417: Data Communication
-- Author: [Your Name] | 400-Level CS | SIWES Project
-- Database: MySQL 8.0 / PostgreSQL 15
-- ============================================================

CREATE DATABASE IF NOT EXISTS netpulse_db;
USE netpulse_db;

-- ============================================================
-- TABLE 1: NETWORK NODES
-- Stores all network devices (servers, clients, routers)
-- ============================================================
CREATE TABLE network_nodes (
    node_id         INT            PRIMARY KEY AUTO_INCREMENT,
    hostname        VARCHAR(100)   NOT NULL,
    ip_address      VARCHAR(45)    NOT NULL,   -- Supports IPv6 (max 45 chars)
    mac_address     VARCHAR(17),               -- Format: AA:BB:CC:DD:EE:FF
    node_type       ENUM('SERVER', 'CLIENT', 'ROUTER', 'SWITCH', 'GATEWAY') NOT NULL,
    os_type         VARCHAR(50),               -- Windows, Linux, macOS
    location        VARCHAR(100),
    is_active       BOOLEAN        DEFAULT TRUE,
    first_seen      TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    last_seen       TIMESTAMP      DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    UNIQUE INDEX idx_ip (ip_address),
    INDEX idx_node_type (node_type),
    INDEX idx_active (is_active)
);

-- ============================================================
-- TABLE 2: CONNECTIONS
-- Records all TCP/UDP connection events
-- ============================================================
CREATE TABLE connections (
    conn_id         BIGINT         PRIMARY KEY AUTO_INCREMENT,
    src_node_id     INT            NOT NULL,
    dst_node_id     INT            NOT NULL,
    protocol        ENUM('TCP', 'UDP', 'ICMP', 'HTTP', 'HTTPS', 'FTP', 'DNS', 'OTHER') NOT NULL,
    src_port        SMALLINT UNSIGNED NOT NULL,   -- 0–65535
    dst_port        SMALLINT UNSIGNED NOT NULL,
    state           ENUM('ESTABLISHED', 'SYN_SENT', 'SYN_RECEIVED', 'FIN_WAIT',
                          'TIME_WAIT', 'CLOSED', 'LISTEN', 'FAILED') DEFAULT 'ESTABLISHED',
    start_time      TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    end_time        TIMESTAMP      NULL,
    duration_ms     INT UNSIGNED,              -- Connection duration in milliseconds
    bytes_sent      BIGINT UNSIGNED DEFAULT 0,
    bytes_received  BIGINT UNSIGNED DEFAULT 0,
    packets_sent    INT UNSIGNED   DEFAULT 0,
    packets_received INT UNSIGNED  DEFAULT 0,
    rtt_ms          DECIMAL(10,3),             -- Round-trip time in milliseconds
    retransmissions INT UNSIGNED   DEFAULT 0,  -- TCP retransmission count

    FOREIGN KEY (src_node_id) REFERENCES network_nodes(node_id),
    FOREIGN KEY (dst_node_id) REFERENCES network_nodes(node_id),
    INDEX idx_protocol (protocol),
    INDEX idx_state (state),
    INDEX idx_start_time (start_time)
);

-- ============================================================
-- TABLE 3: PACKETS
-- Individual packet capture records (like Wireshark data)
-- ============================================================
CREATE TABLE packets (
    packet_id       BIGINT         PRIMARY KEY AUTO_INCREMENT,
    conn_id         BIGINT,                    -- NULL for broadcast/multicast
    capture_time    TIMESTAMP(6)   NOT NULL,   -- Microsecond precision
    direction       ENUM('INBOUND', 'OUTBOUND', 'INTERNAL') NOT NULL,
    src_ip          VARCHAR(45)    NOT NULL,
    dst_ip          VARCHAR(45)    NOT NULL,
    src_port        SMALLINT UNSIGNED,
    dst_port        SMALLINT UNSIGNED,
    protocol        VARCHAR(20)    NOT NULL,
    ip_version      TINYINT        DEFAULT 4,  -- 4 = IPv4, 6 = IPv6
    ttl             TINYINT UNSIGNED,          -- IP Time-to-Live
    packet_size     SMALLINT UNSIGNED NOT NULL, -- Total packet size in bytes
    header_size     TINYINT UNSIGNED,           -- IP + Transport header bytes
    payload_size    SMALLINT UNSIGNED,          -- Data bytes
    tcp_flags       SET('SYN','ACK','FIN','RST','PSH','URG'),  -- TCP flags
    tcp_seq         BIGINT UNSIGNED,           -- TCP sequence number
    tcp_ack         BIGINT UNSIGNED,           -- TCP acknowledgment number
    checksum_valid  BOOLEAN        DEFAULT TRUE,
    is_fragment     BOOLEAN        DEFAULT FALSE,
    payload_preview VARCHAR(256),              -- First 256 bytes of payload (hex/text)

    FOREIGN KEY (conn_id) REFERENCES connections(conn_id),
    INDEX idx_capture_time (capture_time),
    INDEX idx_protocol (protocol),
    INDEX idx_src_ip (src_ip),
    INDEX idx_dst_ip (dst_ip),
    INDEX idx_direction (direction)
);

-- ============================================================
-- TABLE 4: DNS QUERIES
-- Records DNS lookups (Application Layer over UDP port 53)
-- ============================================================
CREATE TABLE dns_queries (
    query_id        INT            PRIMARY KEY AUTO_INCREMENT,
    client_node_id  INT,
    transaction_id  SMALLINT UNSIGNED NOT NULL,  -- DNS message ID
    query_type      ENUM('A', 'AAAA', 'CNAME', 'MX', 'NS', 'PTR', 'TXT', 'SOA') NOT NULL,
    domain_name     VARCHAR(253)   NOT NULL,      -- Max domain length = 253 chars
    query_time      TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    response_time_ms DECIMAL(10,3),
    resolved_ip     VARCHAR(45),                  -- NULL if NXDOMAIN
    dns_server      VARCHAR(45)    DEFAULT '8.8.8.8',
    response_code   TINYINT,                      -- 0=NOERROR, 3=NXDOMAIN, etc.
    cached          BOOLEAN        DEFAULT FALSE,
    ttl_seconds     INT UNSIGNED,

    FOREIGN KEY (client_node_id) REFERENCES network_nodes(node_id),
    INDEX idx_domain (domain_name),
    INDEX idx_query_time (query_time)
);

-- ============================================================
-- TABLE 5: SECURITY EVENTS
-- Network security alerts and anomaly detection
-- ============================================================
CREATE TABLE security_events (
    event_id        INT            PRIMARY KEY AUTO_INCREMENT,
    node_id         INT,
    event_type      ENUM('PORT_SCAN', 'DOS_ATTACK', 'BRUTE_FORCE', 'PACKET_FLOOD',
                          'ARP_SPOOFING', 'MITM', 'MALFORMED_PACKET', 'POLICY_VIOLATION',
                          'BANDWIDTH_EXCEED', 'UNAUTHORIZED_ACCESS') NOT NULL,
    severity        ENUM('LOW', 'MEDIUM', 'HIGH', 'CRITICAL') NOT NULL,
    src_ip          VARCHAR(45),
    dst_ip          VARCHAR(45),
    detected_at     TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    description     TEXT,
    packets_count   INT UNSIGNED,
    action_taken    ENUM('LOGGED', 'BLOCKED', 'RATE_LIMITED', 'ALERTED', 'QUARANTINED'),
    resolved        BOOLEAN        DEFAULT FALSE,
    resolved_at     TIMESTAMP      NULL,

    FOREIGN KEY (node_id) REFERENCES network_nodes(node_id),
    INDEX idx_severity (severity),
    INDEX idx_event_type (event_type),
    INDEX idx_detected_at (detected_at),
    INDEX idx_resolved (resolved)
);

-- ============================================================
-- TABLE 6: NETWORK INTERFACES
-- Physical/virtual network interface cards
-- ============================================================
CREATE TABLE network_interfaces (
    iface_id        INT            PRIMARY KEY AUTO_INCREMENT,
    node_id         INT            NOT NULL,
    iface_name      VARCHAR(20)    NOT NULL,  -- eth0, wlan0, lo, etc.
    ip_address      VARCHAR(45),
    subnet_mask     VARCHAR(45),
    mac_address     VARCHAR(17),
    speed_mbps      INT UNSIGNED,             -- Interface speed
    duplex          ENUM('HALF', 'FULL', 'AUTO'),
    is_up           BOOLEAN        DEFAULT TRUE,
    mtu             SMALLINT UNSIGNED DEFAULT 1500,  -- Maximum Transmission Unit
    bytes_in        BIGINT UNSIGNED DEFAULT 0,
    bytes_out       BIGINT UNSIGNED DEFAULT 0,
    errors_in       INT UNSIGNED   DEFAULT 0,
    errors_out      INT UNSIGNED   DEFAULT 0,

    FOREIGN KEY (node_id) REFERENCES network_nodes(node_id),
    UNIQUE INDEX idx_node_iface (node_id, iface_name)
);

-- ============================================================
-- VIEWS — Analytical Queries
-- ============================================================

-- View 1: Active connections with full node details
CREATE VIEW active_connections_view AS
SELECT
    c.conn_id,
    src.hostname     AS source_host,
    src.ip_address   AS source_ip,
    c.src_port,
    dst.hostname     AS dest_host,
    dst.ip_address   AS dest_ip,
    c.dst_port,
    c.protocol,
    c.state,
    c.bytes_sent,
    c.bytes_received,
    c.rtt_ms,
    TIMESTAMPDIFF(SECOND, c.start_time, NOW()) AS duration_sec
FROM connections c
JOIN network_nodes src ON c.src_node_id = src.node_id
JOIN network_nodes dst ON c.dst_node_id = dst.node_id
WHERE c.state = 'ESTABLISHED';

-- View 2: Protocol usage summary
CREATE VIEW protocol_stats_view AS
SELECT
    protocol,
    COUNT(*)                               AS total_connections,
    SUM(bytes_sent + bytes_received)       AS total_bytes,
    AVG(rtt_ms)                            AS avg_rtt_ms,
    AVG(retransmissions)                   AS avg_retransmissions,
    SUM(CASE WHEN state='ESTABLISHED' THEN 1 ELSE 0 END) AS active
FROM connections
GROUP BY protocol
ORDER BY total_connections DESC;

-- View 3: DNS performance analysis
CREATE VIEW dns_performance_view AS
SELECT
    domain_name,
    COUNT(*)                        AS total_queries,
    AVG(response_time_ms)           AS avg_response_ms,
    MIN(response_time_ms)           AS min_response_ms,
    MAX(response_time_ms)           AS max_response_ms,
    SUM(cached)                     AS cache_hits,
    ROUND(SUM(cached)/COUNT(*)*100) AS cache_hit_rate_pct,
    COUNT(DISTINCT resolved_ip)     AS unique_ips
FROM dns_queries
WHERE response_code = 0  -- NOERROR only
GROUP BY domain_name
ORDER BY total_queries DESC;

-- View 4: Security threat dashboard
CREATE VIEW threat_dashboard_view AS
SELECT
    event_type,
    severity,
    COUNT(*)                         AS occurrences,
    COUNT(DISTINCT src_ip)           AS unique_sources,
    MAX(detected_at)                 AS last_seen,
    SUM(CASE WHEN resolved THEN 1 ELSE 0 END) AS resolved_count
FROM security_events
WHERE detected_at >= DATE_SUB(NOW(), INTERVAL 24 HOUR)
GROUP BY event_type, severity
ORDER BY FIELD(severity,'CRITICAL','HIGH','MEDIUM','LOW'), occurrences DESC;

-- ============================================================
-- STORED PROCEDURES
-- ============================================================

DELIMITER //

-- Procedure 1: Log a new connection
CREATE PROCEDURE log_connection(
    IN p_src_ip      VARCHAR(45),
    IN p_dst_ip      VARCHAR(45),
    IN p_protocol    VARCHAR(20),
    IN p_src_port    INT,
    IN p_dst_port    INT
)
BEGIN
    DECLARE v_src_id INT;
    DECLARE v_dst_id INT;

    -- Upsert source node
    INSERT INTO network_nodes (hostname, ip_address, node_type)
    VALUES (p_src_ip, p_src_ip, 'CLIENT')
    ON DUPLICATE KEY UPDATE last_seen = NOW();
    SELECT node_id INTO v_src_id FROM network_nodes WHERE ip_address = p_src_ip;

    -- Upsert destination node
    INSERT INTO network_nodes (hostname, ip_address, node_type)
    VALUES (p_dst_ip, p_dst_ip, 'SERVER')
    ON DUPLICATE KEY UPDATE last_seen = NOW();
    SELECT node_id INTO v_dst_id FROM network_nodes WHERE ip_address = p_dst_ip;

    -- Insert connection record
    INSERT INTO connections (src_node_id, dst_node_id, protocol, src_port, dst_port)
    VALUES (v_src_id, v_dst_id, p_protocol, p_src_port, p_dst_port);

    SELECT LAST_INSERT_ID() AS conn_id;
END //

-- Procedure 2: Network bandwidth report
CREATE PROCEDURE bandwidth_report(IN p_hours INT)
BEGIN
    SELECT
        HOUR(start_time)              AS hour_of_day,
        protocol,
        COUNT(*)                      AS connections,
        SUM(bytes_sent)               AS bytes_uploaded,
        SUM(bytes_received)           AS bytes_downloaded,
        SUM(bytes_sent + bytes_received) AS total_bytes,
        AVG(rtt_ms)                   AS avg_latency_ms
    FROM connections
    WHERE start_time >= DATE_SUB(NOW(), INTERVAL p_hours HOUR)
    GROUP BY HOUR(start_time), protocol
    ORDER BY hour_of_day, total_bytes DESC;
END //

DELIMITER ;

-- ============================================================
-- SAMPLE DATA INSERTS
-- ============================================================

INSERT INTO network_nodes (hostname, ip_address, mac_address, node_type, os_type) VALUES
('netpulse-server',  '192.168.1.1',  'AA:BB:CC:DD:EE:01', 'SERVER',  'Linux Ubuntu 24.04'),
('student-pc-1',     '192.168.1.10', 'AA:BB:CC:DD:EE:02', 'CLIENT',  'Windows 11'),
('student-pc-2',     '192.168.1.11', 'AA:BB:CC:DD:EE:03', 'CLIENT',  'macOS Sonoma'),
('gateway-router',   '192.168.1.254','AA:BB:CC:DD:EE:FF', 'GATEWAY', 'Cisco IOS'),
('dns-server',       '8.8.8.8',      NULL,                 'SERVER',  'Google DNS');

INSERT INTO connections (src_node_id, dst_node_id, protocol, src_port, dst_port, state, bytes_sent, bytes_received, rtt_ms) VALUES
(2, 1, 'TCP',   54321, 9000, 'ESTABLISHED', 2048, 4096, 1.23),
(3, 1, 'TCP',   54322, 9000, 'ESTABLISHED', 1024, 2048, 2.55),
(2, 5, 'UDP',   55000,   53, 'CLOSED',       512,  128, 15.30),
(3, 1, 'HTTP',  54400,   80, 'ESTABLISHED', 8192, 65536, 45.20),
(2, 1, 'HTTPS', 54401,  443, 'ESTABLISHED', 4096, 32768, 12.80);

INSERT INTO dns_queries (client_node_id, transaction_id, query_type, domain_name, response_time_ms, resolved_ip, ttl_seconds) VALUES
(2, 0x1234, 'A', 'google.com',    15.2, '142.250.80.46',   300),
(2, 0x1235, 'A', 'github.com',    22.1, '140.82.121.4',    60),
(3, 0x2345, 'A', 'anthropic.com', 18.5, '34.160.179.253',  120),
(2, 0x1236, 'A', 'google.com',    0.5,  '142.250.80.46',   299);  -- Cache hit

-- ============================================================
-- ANALYTICAL QUERIES — CSC 417 Study Examples
-- ============================================================

-- Q1: Top 5 protocols by data volume
SELECT protocol,
       COUNT(*) AS connections,
       ROUND(SUM(bytes_sent + bytes_received)/1024/1024, 2) AS total_MB,
       ROUND(AVG(rtt_ms), 2) AS avg_rtt_ms
FROM connections
GROUP BY protocol
ORDER BY total_MB DESC
LIMIT 5;

-- Q2: Find all active TCP connections with RTT > 10ms (high latency)
SELECT c.conn_id, src.ip_address AS src, dst.ip_address AS dst,
       c.dst_port, c.rtt_ms, c.bytes_sent, c.bytes_received
FROM connections c
JOIN network_nodes src ON c.src_node_id = src.node_id
JOIN network_nodes dst ON c.dst_node_id = dst.node_id
WHERE c.protocol = 'TCP'
  AND c.state = 'ESTABLISHED'
  AND c.rtt_ms > 10.0
ORDER BY c.rtt_ms DESC;

-- Q3: DNS cache efficiency by domain
SELECT domain_name,
       COUNT(*) AS total_queries,
       SUM(cached) AS cache_hits,
       CONCAT(ROUND(SUM(cached)/COUNT(*)*100,1), '%') AS hit_rate,
       AVG(response_time_ms) AS avg_ms
FROM dns_queries
GROUP BY domain_name
HAVING total_queries > 1
ORDER BY hit_rate DESC;

-- Q4: Bandwidth usage per client node (top consumers)
SELECT n.hostname, n.ip_address,
       COUNT(c.conn_id) AS connections,
       ROUND(SUM(c.bytes_sent)/1024/1024, 2) AS MB_uploaded,
       ROUND(SUM(c.bytes_received)/1024/1024, 2) AS MB_downloaded
FROM network_nodes n
JOIN connections c ON n.node_id = c.src_node_id
WHERE n.node_type = 'CLIENT'
GROUP BY n.node_id
ORDER BY MB_downloaded DESC;
