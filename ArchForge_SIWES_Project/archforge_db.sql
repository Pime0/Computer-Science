-- ============================================================
-- ArchForge — Software Architecture Registry Database
-- CSC 419: Software Design and Architecture
-- Author: [Your Name] | 400-Level CS | SIWES Project
-- 
-- Models a software architecture documentation system:
--   - Systems and their architectural styles
--   - Components and their layers
--   - Design patterns used per system
--   - Dependency relationships
--   - Architecture decision records (ADRs)
--   - Quality metrics (maintainability, coupling, cohesion)
-- ============================================================

CREATE DATABASE IF NOT EXISTS archforge_db;
USE archforge_db;

-- ============================================================
-- TABLE 1: SYSTEMS — Top-level software systems
-- ============================================================
CREATE TABLE systems (
    system_id       INT            PRIMARY KEY AUTO_INCREMENT,
    system_name     VARCHAR(100)   NOT NULL UNIQUE,
    description     TEXT,
    arch_style      ENUM(
                        'Monolithic', 'Microservices', 'Layered',
                        'Event-Driven', 'Hexagonal', 'CQRS',
                        'Serverless', 'Service-Oriented', 'Clean'
                    ) NOT NULL,
    programming_languages VARCHAR(200),   -- comma-separated: 'Python,Java,TypeScript'
    team_size       TINYINT UNSIGNED,
    version         VARCHAR(20)    DEFAULT '1.0.0',
    status          ENUM('Active','Deprecated','Legacy','Planned') DEFAULT 'Active',
    repo_url        VARCHAR(255),
    created_by      VARCHAR(100),
    created_at      TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP      DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_arch_style (arch_style),
    INDEX idx_status (status)
);

-- ============================================================
-- TABLE 2: COMPONENTS — Individual components within systems
-- ============================================================
CREATE TABLE components (
    component_id    INT            PRIMARY KEY AUTO_INCREMENT,
    system_id       INT            NOT NULL,
    component_name  VARCHAR(100)   NOT NULL,
    layer           ENUM(
                        'Domain', 'Application', 'Infrastructure',
                        'Presentation', 'Service', 'Repository',
                        'Controller', 'Gateway', 'Adapter'
                    ) NOT NULL,
    language        VARCHAR(50),
    responsibility  TEXT,
    loc             INT UNSIGNED,   -- Lines of code
    complexity      TINYINT CHECK (complexity BETWEEN 1 AND 10),
    test_coverage   DECIMAL(5,2),   -- 0.00 - 100.00%
    is_public       BOOLEAN        DEFAULT TRUE,  -- Public or internal API

    FOREIGN KEY (system_id) REFERENCES systems(system_id) ON DELETE CASCADE,
    INDEX idx_system (system_id),
    INDEX idx_layer (layer)
);

-- ============================================================
-- TABLE 3: DESIGN PATTERNS — Patterns used per system
-- ============================================================
CREATE TABLE design_patterns (
    pattern_id      INT            PRIMARY KEY AUTO_INCREMENT,
    system_id       INT,
    component_id    INT,           -- NULL if system-wide
    pattern_name    VARCHAR(100)   NOT NULL,
    category        ENUM('Creational','Structural','Behavioral','Architectural','Concurrency') NOT NULL,
    language        VARCHAR(50),
    description     TEXT,
    file_path       VARCHAR(255),  -- Where to find it in the codebase
    implemented_at  TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (system_id)   REFERENCES systems(system_id),
    FOREIGN KEY (component_id) REFERENCES components(component_id),
    INDEX idx_category (category),
    INDEX idx_pattern_name (pattern_name)
);

-- ============================================================
-- TABLE 4: DEPENDENCIES — Component dependency graph
-- Maps out "who depends on whom" — for coupling analysis
-- ============================================================
CREATE TABLE dependencies (
    dep_id          INT            PRIMARY KEY AUTO_INCREMENT,
    from_component  INT            NOT NULL,
    to_component    INT            NOT NULL,
    dep_type        ENUM('Uses','Extends','Implements','Imports','Calls','EventSubscribes') NOT NULL,
    is_interface    BOOLEAN        DEFAULT FALSE,  -- Depends on interface (good!) or concrete (bad)?
    coupling_level  ENUM('Loose','Medium','Tight') DEFAULT 'Medium',
    description     VARCHAR(255),

    FOREIGN KEY (from_component) REFERENCES components(component_id),
    FOREIGN KEY (to_component)   REFERENCES components(component_id),
    CHECK (from_component != to_component),

    INDEX idx_from (from_component),
    INDEX idx_to (to_component)
);

-- ============================================================
-- TABLE 5: ADR — Architecture Decision Records
-- Documents WHY architectural decisions were made
-- ============================================================
CREATE TABLE architecture_decisions (
    adr_id          INT            PRIMARY KEY AUTO_INCREMENT,
    system_id       INT            NOT NULL,
    adr_number      INT            NOT NULL,  -- ADR-001, ADR-002 ...
    title           VARCHAR(200)   NOT NULL,
    status          ENUM('Proposed','Accepted','Deprecated','Superseded') DEFAULT 'Proposed',
    context         TEXT           NOT NULL,  -- What is the issue?
    decision        TEXT           NOT NULL,  -- What was decided?
    consequences    TEXT,                     -- Good + bad consequences
    alternatives    TEXT,                     -- What else was considered?
    decided_by      VARCHAR(100),
    decided_at      TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    superseded_by   INT,           -- Points to newer ADR if deprecated

    FOREIGN KEY (system_id)    REFERENCES systems(system_id),
    FOREIGN KEY (superseded_by) REFERENCES architecture_decisions(adr_id),
    UNIQUE INDEX idx_system_adr (system_id, adr_number)
);

-- ============================================================
-- TABLE 6: QUALITY METRICS — Architectural quality measurements
-- ============================================================
CREATE TABLE quality_metrics (
    metric_id       INT            PRIMARY KEY AUTO_INCREMENT,
    system_id       INT            NOT NULL,
    component_id    INT,
    measured_at     TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,

    -- Coupling & Cohesion (lower coupling = better, higher cohesion = better)
    afferent_coupling    INT UNSIGNED,  -- Ca: # of components that depend ON this
    efferent_coupling    INT UNSIGNED,  -- Ce: # of components this depends ON
    instability          DECIMAL(4,3),  -- Ce / (Ca + Ce) — 0=stable, 1=unstable
    abstractness         DECIMAL(4,3),  -- # abstract classes / total classes

    -- Code metrics
    cyclomatic_complexity INT UNSIGNED, -- McCabe complexity
    lines_of_code        INT UNSIGNED,
    test_coverage_pct    DECIMAL(5,2),
    comment_ratio_pct    DECIMAL(5,2),

    -- Maintainability Index (0-100, higher = better)
    maintainability_index DECIMAL(5,2),

    notes TEXT,

    FOREIGN KEY (system_id)   REFERENCES systems(system_id),
    FOREIGN KEY (component_id) REFERENCES components(component_id),
    INDEX idx_measured (measured_at)
);

-- ============================================================
-- TABLE 7: SDLC PHASES — Track implementation phases
-- ============================================================
CREATE TABLE sdlc_phases (
    phase_id        INT            PRIMARY KEY AUTO_INCREMENT,
    system_id       INT            NOT NULL,
    phase_name      ENUM('Requirements','Design','Implementation','Testing',
                         'Deployment','Maintenance') NOT NULL,
    start_date      DATE,
    end_date        DATE,
    status          ENUM('Not Started','In Progress','Complete','Skipped') DEFAULT 'Not Started',
    artifacts       TEXT,          -- Docs, diagrams, code produced
    lead_architect  VARCHAR(100),
    notes           TEXT,

    FOREIGN KEY (system_id) REFERENCES systems(system_id),
    INDEX idx_phase (phase_name)
);

-- ============================================================
-- VIEWS
-- ============================================================

-- View 1: System architecture overview with pattern counts
CREATE VIEW system_overview AS
SELECT
    s.system_id,
    s.system_name,
    s.arch_style,
    s.programming_languages,
    COUNT(DISTINCT c.component_id)  AS component_count,
    COUNT(DISTINCT dp.pattern_id)   AS pattern_count,
    COUNT(DISTINCT adr.adr_id)      AS decision_count,
    AVG(qm.maintainability_index)   AS avg_maintainability,
    s.status,
    s.version
FROM systems s
LEFT JOIN components c            ON s.system_id = c.system_id
LEFT JOIN design_patterns dp      ON s.system_id = dp.system_id
LEFT JOIN architecture_decisions adr ON s.system_id = adr.system_id
LEFT JOIN quality_metrics qm      ON s.system_id = qm.system_id
GROUP BY s.system_id, s.system_name, s.arch_style, s.programming_languages, s.status, s.version;

-- View 2: Dependency analysis — find tightly coupled components
CREATE VIEW coupling_analysis AS
SELECT
    c1.component_name                AS from_component,
    c2.component_name                AS to_component,
    d.dep_type,
    d.coupling_level,
    d.is_interface,
    CASE
        WHEN d.is_interface = TRUE THEN '✅ Good — depends on abstraction'
        WHEN d.coupling_level = 'Tight' THEN '❌ Tight coupling — refactor!'
        ELSE '⚠️ Review'
    END AS recommendation
FROM dependencies d
JOIN components c1 ON d.from_component = c1.component_id
JOIN components c2 ON d.to_component   = c2.component_id;

-- View 3: Pattern usage statistics
CREATE VIEW pattern_usage_stats AS
SELECT
    pattern_name,
    category,
    COUNT(*) AS usage_count,
    GROUP_CONCAT(DISTINCT language ORDER BY language SEPARATOR ', ') AS languages,
    GROUP_CONCAT(DISTINCT s.system_name ORDER BY s.system_name SEPARATOR ', ') AS used_in
FROM design_patterns dp
JOIN systems s ON dp.system_id = s.system_id
GROUP BY pattern_name, category
ORDER BY usage_count DESC, category;

-- View 4: SOLID principle compliance dashboard
CREATE VIEW solid_compliance AS
SELECT
    s.system_name,
    SUM(CASE WHEN dp.description LIKE '%Single Responsibility%' THEN 1 ELSE 0 END) AS srp_count,
    SUM(CASE WHEN dp.description LIKE '%Open/Closed%'           THEN 1 ELSE 0 END) AS ocp_count,
    SUM(CASE WHEN dp.description LIKE '%Liskov%'                THEN 1 ELSE 0 END) AS lsp_count,
    SUM(CASE WHEN dp.description LIKE '%Interface Segregation%' THEN 1 ELSE 0 END) AS isp_count,
    SUM(CASE WHEN dp.description LIKE '%Dependency Inversion%'  THEN 1 ELSE 0 END) AS dip_count,
    COUNT(DISTINCT d.dep_id) FILTER (WHERE d.is_interface = TRUE)  AS abstract_deps,
    COUNT(DISTINCT d.dep_id) FILTER (WHERE d.coupling_level = 'Tight') AS tight_couplings
FROM systems s
LEFT JOIN design_patterns dp ON s.system_id = dp.system_id
LEFT JOIN components c       ON s.system_id = c.system_id
LEFT JOIN dependencies d     ON c.component_id = d.from_component
GROUP BY s.system_name;

-- ============================================================
-- STORED PROCEDURES
-- ============================================================
DELIMITER //

-- Register a new architectural pattern
CREATE PROCEDURE register_pattern(
    IN p_system_id   INT,
    IN p_component_id INT,
    IN p_pattern_name VARCHAR(100),
    IN p_category    VARCHAR(20),
    IN p_language    VARCHAR(50),
    IN p_description TEXT
)
BEGIN
    INSERT INTO design_patterns (system_id, component_id, pattern_name, category, language, description)
    VALUES (p_system_id, p_component_id, p_pattern_name, p_category, p_language, p_description);
    SELECT LAST_INSERT_ID() AS pattern_id, 'Pattern registered' AS message;
END //

-- Calculate instability metric for a component
CREATE PROCEDURE calculate_instability(IN p_component_id INT)
BEGIN
    DECLARE v_ca INT DEFAULT 0;  -- Afferent (incoming) coupling
    DECLARE v_ce INT DEFAULT 0;  -- Efferent (outgoing) coupling
    DECLARE v_instability DECIMAL(4,3);

    SELECT COUNT(*) INTO v_ca FROM dependencies WHERE to_component   = p_component_id;
    SELECT COUNT(*) INTO v_ce FROM dependencies WHERE from_component = p_component_id;

    IF (v_ca + v_ce) = 0 THEN
        SET v_instability = 0.0;
    ELSE
        SET v_instability = v_ce / (v_ca + v_ce);
    END IF;

    INSERT INTO quality_metrics (component_id, afferent_coupling, efferent_coupling, instability)
    VALUES (p_component_id, v_ca, v_ce, v_instability);

    SELECT
        v_ca AS afferent_coupling,
        v_ce AS efferent_coupling,
        v_instability AS instability_score,
        CASE
            WHEN v_instability < 0.3 THEN 'STABLE — rarely changes'
            WHEN v_instability < 0.7 THEN 'BALANCED — moderate stability'
            ELSE 'UNSTABLE — changes frequently'
        END AS assessment;
END //

DELIMITER ;

-- ============================================================
-- SAMPLE DATA — ArchForge System Registration
-- ============================================================
INSERT INTO systems (system_name, description, arch_style, programming_languages, team_size, version, created_by) VALUES
('ArchForge Studio',  'Software Design & Architecture Lab',        'Clean',         'Python,TypeScript,C#',  2, '1.0.0', '[Your Name]'),
('PulseBank FinTech', 'Full-stack banking platform',               'Microservices', 'Python,Java,TypeScript,SQL', 4, '1.0.0', '[Your Name]'),
('NetPulse Comms',    'Network Protocols Lab (CSC 417)',           'Layered',       'Python,Java,C,SQL,Bash', 1, '1.0.0', '[Your Name]'),
('SmartLib Portal',   'Library Database Management (CSC 410)',     'Monolithic',    'HTML,JavaScript,SQL',   1, '1.0.0', '[Your Name]'),
('CipherShield',      'Web Security & Crypto Lab (CSC 434)',       'Layered',       'HTML,JavaScript',       1, '1.0.0', '[Your Name]');

INSERT INTO components (system_id, component_name, layer, language, responsibility, loc, complexity, test_coverage) VALUES
(1, 'DesignPatternsCatalogue', 'Domain',         'Python',     'All 23 GoF patterns implemented',    850, 7, 88.0),
(1, 'CleanArchitectureDemo',   'Application',    'Python',     'Layered clean architecture with DDD', 420, 6, 92.0),
(1, 'MicroservicesDemo',       'Service',        'Java',       'Service registry, circuit breaker',   680, 8, 85.0),
(1, 'MVCArchitecture',         'Controller',     'TypeScript', 'MVC with generics, decorators, DI',  490, 7, 80.0),
(1, 'SOLIDPrinciples',         'Domain',         'C++',        'All 5 SOLID principles + templates',  520, 8, 75.0),
(1, 'EventDrivenCQRS',         'Application',    'C#',         'CQRS, mediator, domain events',       580, 9, 82.0),
(1, 'ArchitectureRegistry',    'Repository',     'SQL',        'Stores patterns, ADRs, metrics',      240, 4, 95.0);

INSERT INTO design_patterns (system_id, component_id, pattern_name, category, language, description) VALUES
(1, 1, 'Singleton',      'Creational',   'Python', 'Thread-safe singleton metaclass — AppConfig'),
(1, 1, 'Factory Method', 'Creational',   'Python', 'NotificationFactory — creates by channel string'),
(1, 1, 'Builder',        'Creational',   'Python', 'DatabaseConfigBuilder with fluent interface'),
(1, 1, 'Observer',       'Behavioral',   'Python', 'EventBus with subscribe/publish pattern'),
(1, 1, 'Strategy',       'Behavioral',   'Python', 'DataSorter with swappable SortStrategy'),
(1, 1, 'Command',        'Behavioral',   'Python', 'TransferFundsCommand with undo/redo history'),
(1, 1, 'Chain of Resp.', 'Behavioral',   'Python', 'Middleware pipeline for request handling'),
(1, 1, 'State',          'Behavioral',   'Python', 'Order state machine: Pending→Confirmed→Shipped'),
(1, 1, 'Decorator',      'Structural',   'Python', 'CachingDecorator + LoggingDecorator on DataService'),
(1, 1, 'Facade',         'Structural',   'Python', 'UserManagementFacade hiding 4 subsystems'),
(1, 1, 'Adapter',        'Structural',   'Python', 'PaymentAdapter — legacy→modern interface'),
(1, 1, 'Proxy',          'Structural',   'Python', 'SecureFileSystemProxy — access control wrapper'),
(1, 3, 'Microservices',  'Architectural','Java',   'UserService, NotificationService independently'),
(1, 3, 'Service Registry','Architectural','Java',  'Singleton registry for service discovery'),
(1, 3, 'Circuit Breaker','Architectural','Java',   'State machine: CLOSED→OPEN→HALF_OPEN'),
(1, 3, 'API Gateway',    'Architectural','Java',   'Single entry point with routing + rate limiting'),
(1, 4, 'MVC',            'Architectural','TypeScript','ProductController/OrderController pattern'),
(1, 6, 'CQRS',           'Architectural','C#',     'Commands change state, Queries read state'),
(1, 6, 'Mediator',       'Behavioral',   'C#',     'Central dispatch for commands and queries'),
(1, 6, 'Domain Events',  'Architectural','C#',     'UserRegisteredEvent, OrderPlacedEvent etc.');

-- ADRs
INSERT INTO architecture_decisions (system_id, adr_number, title, status, context, decision, consequences) VALUES
(1, 1, 'Use Clean Architecture over MVC',
 'Accepted',
 'Need architecture that is testable, maintainable, and independent of frameworks.',
 'Adopt Clean Architecture with Domain, Application, Adapter, and Framework layers.',
 'Good: highly testable, framework-independent. Bad: more initial boilerplate.'),
(1, 2, 'Use Python for Design Pattern implementations',
 'Accepted',
 'Need to demonstrate all 23 GoF patterns in a readable, executable way.',
 'Python chosen for readability, ABC module, dataclasses, and dynamic typing flexibility.',
 'Good: readable, concise. Bad: no compile-time type checking (mitigated with type hints).'),
(1, 3, 'Implement Circuit Breaker in Java Microservices',
 'Accepted',
 'Microservices must be resilient to cascading failures when dependent services fail.',
 'Custom CircuitBreaker class with CLOSED/OPEN/HALF_OPEN states and configurable thresholds.',
 'Good: prevents cascade failures. Could use Resilience4j in production.');

-- ============================================================
-- ANALYTICAL QUERIES — CSC 419 Study Examples
-- ============================================================

-- Q1: Architecture style distribution
SELECT arch_style, COUNT(*) AS systems_using,
       GROUP_CONCAT(system_name SEPARATOR ', ') AS system_names
FROM systems GROUP BY arch_style ORDER BY systems_using DESC;

-- Q2: Most used design patterns across all systems
SELECT pattern_name, category, COUNT(*) AS usage_count,
       GROUP_CONCAT(DISTINCT language SEPARATOR ', ') AS languages
FROM design_patterns
GROUP BY pattern_name, category
ORDER BY usage_count DESC LIMIT 10;

-- Q3: Components with high complexity (need refactoring attention)
SELECT c.component_name, c.layer, c.language,
       c.complexity, c.test_coverage, c.loc
FROM components c
WHERE c.complexity >= 7
ORDER BY c.complexity DESC, c.test_coverage ASC;

-- Q4: ADR timeline per system
SELECT s.system_name, adr.adr_number,
       CONCAT('ADR-', LPAD(adr.adr_number, 3, '0')) AS adr_ref,
       adr.title, adr.status, adr.decided_at
FROM architecture_decisions adr
JOIN systems s ON adr.system_id = s.system_id
ORDER BY s.system_name, adr.adr_number;

-- Q5: Full system architecture report
SELECT * FROM system_overview;

-- Q6: Component dependency health
SELECT * FROM coupling_analysis WHERE coupling_level = 'Tight';
