-- ============================================================
-- PALLADIUM BANK RETAIL ANALYTICS - DIMENSIONAL DATA MODEL
-- Star Schema with SCD Type 1 & Type 2, Date Dimension
-- Author: Data Analytics Team
-- Date: April 2026
-- Description: Full star schema for 18-month retail banking
--              transaction analytics platform
-- ============================================================


-- ============================================================
-- SECTION 1: DROP EXISTING TABLES (Safe re-run)
-- ============================================================
DROP TABLE IF EXISTS fact_transactions;
DROP TABLE IF EXISTS dim_customer;
DROP TABLE IF EXISTS dim_product;
DROP TABLE IF EXISTS dim_branch;
DROP TABLE IF EXISTS dim_channel;
DROP TABLE IF EXISTS dim_transaction_type;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS agg_monthly_branch_summary;


-- ============================================================
-- SECTION 2: DIMENSION TABLES
-- ============================================================

-- ------------------------------------------------------------
-- dim_date: Date Dimension
-- Grain: One row per calendar day
-- Purpose: Enables time-based analysis — MoM, QoQ, YoY
-- Hierarchy: Year → Quarter → Month → Week → Day
-- ------------------------------------------------------------
CREATE TABLE dim_date (
    date_key        INT             NOT NULL,   -- Surrogate key: YYYYMMDD format (e.g., 20240108)
    full_date       DATE            NOT NULL,   -- Actual calendar date
    day_of_week     TINYINT         NOT NULL,   -- 1=Monday ... 7=Sunday
    day_name        VARCHAR(10)     NOT NULL,   -- e.g., 'Monday'
    day_of_month    TINYINT         NOT NULL,   -- 1–31
    day_of_year     SMALLINT        NOT NULL,   -- 1–366
    week_number     TINYINT         NOT NULL,   -- ISO week number 1–53
    month_number    TINYINT         NOT NULL,   -- 1–12
    month_name      VARCHAR(10)     NOT NULL,   -- e.g., 'January'
    month_short     CHAR(3)         NOT NULL,   -- e.g., 'Jan'
    quarter_number  TINYINT         NOT NULL,   -- 1–4
    quarter_label   CHAR(2)         NOT NULL,   -- 'Q1','Q2','Q3','Q4'
    year_number     SMALLINT        NOT NULL,   -- e.g., 2024
    year_quarter    VARCHAR(7)      NOT NULL,   -- e.g., '2024-Q1'
    year_month      VARCHAR(7)      NOT NULL,   -- e.g., '2024-01'
    is_weekend      BOOLEAN         NOT NULL DEFAULT FALSE,
    is_public_holiday BOOLEAN       NOT NULL DEFAULT FALSE,
    fiscal_year     SMALLINT        NOT NULL,   -- Bank fiscal year
    fiscal_quarter  TINYINT         NOT NULL,   -- Bank fiscal quarter

    CONSTRAINT pk_dim_date PRIMARY KEY (date_key)
);

COMMENT ON TABLE dim_date IS
  'Conformed date dimension. Populated once for the full analytics date range.
   Hierarchy: Year → Quarter → Month → Week → Day.';


-- ------------------------------------------------------------
-- dim_customer: Customer Dimension (SCD Type 2)
-- Grain: One row per customer version (tracks tier changes)
-- Purpose: Customer segmentation by tier, tenure, branch
-- SCD Type 2: Tier may change over time — full history kept
-- ------------------------------------------------------------
CREATE TABLE dim_customer (
    customer_sk         BIGINT          NOT NULL GENERATED ALWAYS AS IDENTITY,  -- Surrogate key
    customer_id         VARCHAR(10)     NOT NULL,   -- Natural/business key (e.g., 'C0001')
    customer_name       VARCHAR(100)    NOT NULL,   -- Full name of customer
    tier                VARCHAR(20)     NOT NULL,   -- 'Platinum','Gold','Silver','Standard'
    tier_start_date     DATE            NOT NULL,   -- When this tier version became active
    tier_end_date       DATE,                       -- NULL = currently active record
    is_current          BOOLEAN         NOT NULL DEFAULT TRUE,  -- Flag for current record
    home_branch_id      VARCHAR(10),                -- Customer's primary branch (denormalized)
    home_state          VARCHAR(50),                -- Customer's state (denormalized)
    account_open_date   DATE,                       -- When customer first joined the bank
    customer_tenure_months INT,                     -- Months since account_open_date (computed)
    created_at          TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at          TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_dim_customer PRIMARY KEY (customer_sk)
);

CREATE INDEX idx_dim_customer_id ON dim_customer (customer_id);
CREATE INDEX idx_dim_customer_current ON dim_customer (customer_id, is_current);
CREATE INDEX idx_dim_customer_tier ON dim_customer (tier, is_current);

COMMENT ON TABLE dim_customer IS
  'SCD Type 2 customer dimension. A new row is inserted when a customer tier
   changes. tier_end_date = NULL means the record is the current active version.
   is_current = TRUE flags the latest record for easy filtering.
   Hierarchy: Tier → Customer.';

COMMENT ON COLUMN dim_customer.customer_sk IS
  'Surrogate key — always use this in fact table joins, never customer_id directly.';

COMMENT ON COLUMN dim_customer.tier IS
  'Customer value segment: Platinum > Gold > Silver > Standard.
   Key dimension for fee income analysis.';


-- ------------------------------------------------------------
-- dim_product: Product Dimension (SCD Type 1)
-- Grain: One row per banking product
-- Purpose: Analyse volume/value by product, type, and category
-- SCD Type 1: Product names/types rarely change; overwrite is acceptable
-- ------------------------------------------------------------
CREATE TABLE dim_product (
    product_sk      INT             NOT NULL GENERATED ALWAYS AS IDENTITY,  -- Surrogate key
    product_id      VARCHAR(10)     NOT NULL,   -- Natural key (e.g., 'P001')
    product_name    VARCHAR(100)    NOT NULL,   -- e.g., 'Current Account'
    product_type    VARCHAR(50)     NOT NULL,   -- 'Account','Card','Loan','Savings','Digital'
    is_deposit_product   BOOLEAN    NOT NULL DEFAULT FALSE,  -- TRUE if product drives deposits
    is_withdrawal_product BOOLEAN   NOT NULL DEFAULT FALSE,  -- TRUE if product drives withdrawals
    is_digital_product   BOOLEAN    NOT NULL DEFAULT FALSE,  -- TRUE for digital/mobile products
    is_active       BOOLEAN         NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_dim_product PRIMARY KEY (product_sk)
);

CREATE INDEX idx_dim_product_id ON dim_product (product_id);
CREATE INDEX idx_dim_product_type ON dim_product (product_type);

COMMENT ON TABLE dim_product IS
  'SCD Type 1 product dimension. Product attributes are overwritten in-place.
   Type 1 chosen because product definitions rarely change in retail banking
   and historical tracking of product name changes is not a business requirement.
   Hierarchy: Product_Type → Product_Name.';


-- ------------------------------------------------------------
-- dim_branch: Branch Dimension (SCD Type 1)
-- Grain: One row per branch
-- Purpose: Branch-level reporting and geographic analysis
-- SCD Type 1: Branch attributes (name, state) rarely change
-- Hierarchy: State → Branch
-- ------------------------------------------------------------
CREATE TABLE dim_branch (
    branch_sk       INT             NOT NULL GENERATED ALWAYS AS IDENTITY,  -- Surrogate key
    branch_id       VARCHAR(10)     NOT NULL,   -- Natural key (e.g., 'B01')
    branch_name     VARCHAR(100)    NOT NULL,   -- e.g., 'Lagos Island'
    state           VARCHAR(50)     NOT NULL,   -- e.g., 'Lagos', 'Abuja', 'Kano', 'Rivers'
    city            VARCHAR(100),               -- City (may differ from branch name)
    region          VARCHAR(50),                -- Geographic region grouping
    is_active       BOOLEAN         NOT NULL DEFAULT TRUE,
    opened_date     DATE,                       -- When branch was opened
    created_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_dim_branch PRIMARY KEY (branch_sk)
);

CREATE INDEX idx_dim_branch_id ON dim_branch (branch_id);
CREATE INDEX idx_dim_branch_state ON dim_branch (state);

COMMENT ON TABLE dim_branch IS
  'SCD Type 1 branch dimension. Overwrites in-place when branch details change.
   Hierarchy: State → Branch_Name. Used for geographic drill-down analysis.';


-- ------------------------------------------------------------
-- dim_channel: Transaction Channel Dimension
-- Grain: One row per transaction channel
-- Purpose: Analyse channel preferences and behaviours
-- No SCD needed: Channel definitions are static
-- ------------------------------------------------------------
CREATE TABLE dim_channel (
    channel_sk      INT             NOT NULL GENERATED ALWAYS AS IDENTITY,  -- Surrogate key
    channel_name    VARCHAR(50)     NOT NULL,   -- e.g., 'POS','ATM','Branch','USSD','Mobile App','Internet Banking'
    channel_type    VARCHAR(30)     NOT NULL,   -- 'Physical','Digital','Self-Service'
    is_digital      BOOLEAN         NOT NULL DEFAULT FALSE,
    is_self_service BOOLEAN         NOT NULL DEFAULT FALSE,

    CONSTRAINT pk_dim_channel PRIMARY KEY (channel_sk),
    CONSTRAINT uq_dim_channel_name UNIQUE (channel_name)
);

COMMENT ON TABLE dim_channel IS
  'Static channel dimension. No SCD required — channel definitions are stable.
   Enables segmentation of digital vs physical vs self-service transaction behaviour.';


-- ------------------------------------------------------------
-- dim_transaction_type: Transaction Type Dimension
-- Grain: One row per transaction type
-- Purpose: Classify transactions for income/activity analysis
-- Degenerate dimension alternative: stored here to avoid bloating fact
-- ------------------------------------------------------------
CREATE TABLE dim_transaction_type (
    txn_type_sk     INT             NOT NULL GENERATED ALWAYS AS IDENTITY,  -- Surrogate key
    txn_type_name   VARCHAR(50)     NOT NULL,   -- e.g., 'Deposit','Withdrawal','Transfer','POS Purchase'
    txn_direction   VARCHAR(10)     NOT NULL,   -- 'Inflow' or 'Outflow' or 'Neutral'
    generates_fee   BOOLEAN         NOT NULL DEFAULT FALSE,   -- Does this type generate fee income?
    fee_category    VARCHAR(50),                -- e.g., 'Transfer Fee','Card Fee','Loan Fee'

    CONSTRAINT pk_dim_txn_type PRIMARY KEY (txn_type_sk),
    CONSTRAINT uq_dim_txn_type UNIQUE (txn_type_name)
);

COMMENT ON TABLE dim_transaction_type IS
  'Transaction type dimension. Distinguishes inflows vs outflows and fee-generating
   transactions — critical for answering which customer segments generate most fee income.';


-- ============================================================
-- SECTION 3: FACT TABLE
-- ============================================================

-- ------------------------------------------------------------
-- fact_transactions: Core Transaction Fact Table
-- Grain: ONE ROW PER INDIVIDUAL TRANSACTION
-- Justification: The business wants to analyse individual
--   transaction behaviour (frequency, recency, value) and
--   track churn signals — per-transaction grain is required.
--   A daily or monthly summary would lose the recency and
--   frequency signals needed for churn analysis.
-- Degenerate Dimensions: txn_id is stored here as a
--   degenerate dimension — it has no additional attributes
--   beyond the transaction itself, so no separate table needed.
-- ------------------------------------------------------------
CREATE TABLE fact_transactions (
    txn_fact_sk         BIGINT          NOT NULL GENERATED ALWAYS AS IDENTITY,  -- Surrogate key

    -- Degenerate Dimension: Transaction ID (no separate dim table needed)
    txn_id              VARCHAR(20)     NOT NULL,   -- e.g., 'TXN-10041' — stored for traceability

    -- Foreign Keys to Dimensions
    date_key            INT             NOT NULL,   -- FK → dim_date.date_key
    customer_sk         BIGINT          NOT NULL,   -- FK → dim_customer.customer_sk (current version)
    product_sk          INT             NOT NULL,   -- FK → dim_product.product_sk
    branch_sk           INT             NOT NULL,   -- FK → dim_branch.branch_sk
    channel_sk          INT             NOT NULL,   -- FK → dim_channel.channel_sk
    txn_type_sk         INT             NOT NULL,   -- FK → dim_transaction_type.txn_type_sk

    -- Measures (Facts)
    txn_amount          NUMERIC(18, 2)  NOT NULL,   -- Transaction amount in NGN
    balance_after       NUMERIC(18, 2),             -- Account balance after transaction
    fee_amount          NUMERIC(10, 2)  NOT NULL DEFAULT 0.00,  -- Fee charged for this transaction
    txn_hour            TINYINT         NOT NULL,   -- Hour of day (0–23) for time-of-day analysis

    -- Timestamps (stored for audit and recency calculation)
    txn_timestamp       TIMESTAMP       NOT NULL,   -- Full datetime of transaction
    load_timestamp      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- ETL load time

    CONSTRAINT pk_fact_transactions PRIMARY KEY (txn_fact_sk),
    CONSTRAINT fk_fact_date         FOREIGN KEY (date_key)    REFERENCES dim_date (date_key),
    CONSTRAINT fk_fact_customer     FOREIGN KEY (customer_sk) REFERENCES dim_customer (customer_sk),
    CONSTRAINT fk_fact_product      FOREIGN KEY (product_sk)  REFERENCES dim_product (product_sk),
    CONSTRAINT fk_fact_branch       FOREIGN KEY (branch_sk)   REFERENCES dim_branch (branch_sk),
    CONSTRAINT fk_fact_channel      FOREIGN KEY (channel_sk)  REFERENCES dim_channel (channel_sk),
    CONSTRAINT fk_fact_txn_type     FOREIGN KEY (txn_type_sk) REFERENCES dim_transaction_type (txn_type_sk)
);

COMMENT ON TABLE fact_transactions IS
  'Core transaction fact table. Grain = one row per banking transaction.
   Supports: customer behaviour analysis, product & channel performance,
   branch-level reporting, churn signals (recency/frequency), and time-based analysis.
   txn_id is a degenerate dimension — kept for traceability without a separate table.';

COMMENT ON COLUMN fact_transactions.txn_id IS
  'Degenerate dimension. The source transaction identifier stored in the fact row
   for lineage/debugging. No attributes beyond those captured in other dimensions.';

-- Indexes for performance
CREATE INDEX idx_fact_date_key       ON fact_transactions (date_key);
CREATE INDEX idx_fact_customer_sk    ON fact_transactions (customer_sk);
CREATE INDEX idx_fact_product_sk     ON fact_transactions (product_sk);
CREATE INDEX idx_fact_branch_sk      ON fact_transactions (branch_sk);
CREATE INDEX idx_fact_channel_sk     ON fact_transactions (channel_sk);
CREATE INDEX idx_fact_txn_type_sk    ON fact_transactions (txn_type_sk);
CREATE INDEX idx_fact_txn_timestamp  ON fact_transactions (txn_timestamp);
CREATE INDEX idx_fact_amount         ON fact_transactions (txn_amount);

-- Partitioning: partition by year-month for incremental load efficiency
-- (Syntax varies by RDBMS — shown here for PostgreSQL)
-- For production PostgreSQL, use declarative partitioning:
-- PARTITION BY RANGE (txn_timestamp)


-- ============================================================
-- SECTION 4: SLOWLY CHANGING DIMENSIONS (SCD) PROCEDURES
-- ============================================================

-- ------------------------------------------------------------
-- SCD Type 2 MERGE for dim_customer (handles tier changes)
-- Strategy: Insert new row, close old row with end date
-- ------------------------------------------------------------
-- Pseudocode / representative logic (ANSI SQL compatible):
/*
  WHEN a customer's tier changes:
    1. UPDATE dim_customer SET tier_end_date = CURRENT_DATE - 1,
                               is_current = FALSE
       WHERE customer_id = :customer_id AND is_current = TRUE;
    2. INSERT INTO dim_customer (customer_id, customer_name, tier,
                                  tier_start_date, tier_end_date, is_current, ...)
       VALUES (:customer_id, :customer_name, :new_tier,
               CURRENT_DATE, NULL, TRUE, ...);
*/

-- SCD Type 1 UPDATE for dim_product (overwrite in-place)
/*
  WHEN product details change:
    UPDATE dim_product
    SET product_name = :new_name,
        product_type = :new_type,
        updated_at = CURRENT_TIMESTAMP
    WHERE product_id = :product_id;
*/


-- ============================================================
-- SECTION 5: ETL POPULATION ORDER & DATA QUALITY CHECKS
-- ============================================================

-- Correct order for initial load:
-- 1. dim_date        (no dependencies)
-- 2. dim_channel     (no dependencies)
-- 3. dim_transaction_type (no dependencies)
-- 4. dim_product     (no dependencies)
-- 5. dim_branch      (no dependencies)
-- 6. dim_customer    (may reference branch for home_branch_id)
-- 7. fact_transactions (depends on all dimensions above)

-- DATA QUALITY CHECK 1: Referential Integrity — no orphan facts
-- Detection: COUNT(*) from fact_transactions where customer_sk NOT IN dim_customer
-- Action: Reject and quarantine records; alert ETL team
-- Example:
/*
SELECT COUNT(*) AS orphan_facts
FROM fact_transactions f
LEFT JOIN dim_customer c ON f.customer_sk = c.customer_sk
WHERE c.customer_sk IS NULL;
*/

-- DATA QUALITY CHECK 2: Amount range validation — no zero or negative amounts
-- Detection: SELECT COUNT(*) FROM fact_transactions WHERE txn_amount <= 0
-- Action: Flag records in a DQ error log table; exclude from aggregations
/*
SELECT txn_id, txn_amount FROM fact_transactions WHERE txn_amount <= 0;
*/

-- DATA QUALITY CHECK 3: Duplicate transaction detection
-- Detection: Check txn_id appears only once in fact table
-- Action: Deduplicate using ROW_NUMBER() OVER (PARTITION BY txn_id ORDER BY load_timestamp)
/*
SELECT txn_id, COUNT(*) AS cnt
FROM fact_transactions
GROUP BY txn_id
HAVING COUNT(*) > 1;
*/

-- DATA QUALITY CHECK 4: Date key validity — all date keys must exist in dim_date
-- Detection: JOIN fact to dim_date; flag missing date_keys
-- Action: Populate missing date keys in dim_date before loading facts
/*
SELECT DISTINCT f.date_key
FROM fact_transactions f
LEFT JOIN dim_date d ON f.date_key = d.date_key
WHERE d.date_key IS NULL;
*/

-- DATA QUALITY CHECK 5: Balance consistency — balance should not be negative for savings accounts
-- Detection: Join to dim_product; check balance_after < 0 for savings/account products
-- Action: Flag and route to exception report for manual review
/*
SELECT f.txn_id, f.balance_after, p.product_type
FROM fact_transactions f
JOIN dim_product p ON f.product_sk = p.product_sk
WHERE f.balance_after < 0 AND p.product_type IN ('Account','Savings');
*/


-- ============================================================
-- SECTION 6: AGGREGATION TABLE (Performance Optimization)
-- ============================================================

-- ------------------------------------------------------------
-- agg_monthly_branch_summary: Pre-aggregated monthly summary
-- Purpose: Accelerate branch-level monthly reporting queries
-- Partitioning strategy: By year_month to speed monthly loads
-- ------------------------------------------------------------
CREATE TABLE agg_monthly_branch_summary (
    summary_sk          BIGINT          NOT NULL GENERATED ALWAYS AS IDENTITY,
    year_month          CHAR(7)         NOT NULL,   -- e.g., '2024-01'
    year_number         SMALLINT        NOT NULL,
    month_number        TINYINT         NOT NULL,
    quarter_label       CHAR(2)         NOT NULL,
    branch_sk           INT             NOT NULL,
    branch_name         VARCHAR(100)    NOT NULL,
    state               VARCHAR(50)     NOT NULL,

    -- Volume metrics
    total_transactions  INT             NOT NULL DEFAULT 0,
    unique_customers    INT             NOT NULL DEFAULT 0,
    active_customers    INT             NOT NULL DEFAULT 0,  -- Txn in last 30 days

    -- Value metrics
    total_txn_amount    NUMERIC(20, 2)  NOT NULL DEFAULT 0,
    total_fee_income    NUMERIC(18, 2)  NOT NULL DEFAULT 0,
    avg_txn_amount      NUMERIC(14, 2),
    total_deposits      NUMERIC(20, 2)  NOT NULL DEFAULT 0,
    total_withdrawals   NUMERIC(20, 2)  NOT NULL DEFAULT 0,

    -- Channel breakdown
    digital_txn_count   INT             NOT NULL DEFAULT 0,
    branch_txn_count    INT             NOT NULL DEFAULT 0,

    aggregated_at       TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_agg_monthly_branch PRIMARY KEY (summary_sk),
    CONSTRAINT uq_agg_monthly_branch UNIQUE (year_month, branch_sk),
    CONSTRAINT fk_agg_branch FOREIGN KEY (branch_sk) REFERENCES dim_branch (branch_sk)
);

CREATE INDEX idx_agg_year_month   ON agg_monthly_branch_summary (year_month);
CREATE INDEX idx_agg_branch_state ON agg_monthly_branch_summary (state, year_month);

COMMENT ON TABLE agg_monthly_branch_summary IS
  'Pre-aggregated monthly branch summary for BI dashboard acceleration.
   Refreshed incrementally at month-end. Reduces fact table scan on dashboards
   from millions of rows to hundreds. Supports MoM and QoQ branch comparisons.';


-- ============================================================
-- SECTION 7: SAMPLE LOOKUP DATA (Reference values)
-- ============================================================

-- Populate dim_channel with known values
INSERT INTO dim_channel (channel_name, channel_type, is_digital, is_self_service) VALUES
  ('Branch',            'Physical',     FALSE, FALSE),
  ('ATM',               'Self-Service', FALSE, TRUE),
  ('POS',               'Self-Service', FALSE, TRUE),
  ('Mobile App',        'Digital',      TRUE,  TRUE),
  ('Internet Banking',  'Digital',      TRUE,  TRUE),
  ('USSD',              'Digital',      TRUE,  TRUE);

-- Populate dim_transaction_type with known values
INSERT INTO dim_transaction_type (txn_type_name, txn_direction, generates_fee, fee_category) VALUES
  ('Deposit',         'Inflow',   FALSE, NULL),
  ('Withdrawal',      'Outflow',  FALSE, NULL),
  ('Transfer',        'Outflow',  TRUE,  'Transfer Fee'),
  ('POS Purchase',    'Outflow',  TRUE,  'Card Fee'),
  ('ATM Withdrawal',  'Outflow',  TRUE,  'ATM Fee'),
  ('Bill Payment',    'Outflow',  TRUE,  'Bill Payment Fee'),
  ('Loan Repayment',  'Outflow',  FALSE, NULL);

-- Populate dim_product with known values
INSERT INTO dim_product (product_id, product_name, product_type, is_deposit_product, is_withdrawal_product, is_digital_product) VALUES
  ('P001', 'Current Account',   'Account', TRUE,  TRUE,  FALSE),
  ('P002', 'Savings Account',   'Account', TRUE,  TRUE,  FALSE),
  ('P003', 'Fixed Deposit',     'Savings', TRUE,  FALSE, FALSE),
  ('P004', 'Personal Loan',     'Loan',    FALSE, FALSE, FALSE),
  ('P007', 'Debit Card',        'Card',    FALSE, TRUE,  FALSE),
  ('P008', 'Credit Card',       'Card',    FALSE, TRUE,  FALSE),
  ('P009', 'Mobile Banking',    'Digital', FALSE, FALSE, TRUE),
  ('P010', 'Internet Banking',  'Digital', FALSE, FALSE, TRUE);

-- Populate dim_branch with known values
INSERT INTO dim_branch (branch_id, branch_name, state, city) VALUES
  ('B01', 'Lagos Island',   'Lagos', 'Lagos Island'),
  ('B02', 'Ikeja',          'Lagos', 'Ikeja'),
  ('B03', 'Victoria Island','Lagos', 'Victoria Island'),
  ('B04', 'Abuja Central',  'Abuja', 'Abuja'),
  ('B06', 'Kano Central',   'Kano',  'Kano'),
  ('B07', 'Port Harcourt',  'Rivers','Port Harcourt');


-- ============================================================
-- END OF SCHEMA
-- ============================================================
