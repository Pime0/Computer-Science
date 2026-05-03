-- ============================================================
-- TRADEZONE DATABASE — PART A: DATA CLEANING & PREPARATION
-- HNG Internship Stage 2 | Analyst: TradeZone Data Team
-- ============================================================

-- ─────────────────────────────────────────────────────────────
-- SECTION 1: MISSING VALUES
-- Handle NULL or blank entries in critical columns
-- ─────────────────────────────────────────────────────────────

-- 1a. Customers: 16 records have NULL email addresses.
--     Decision: Retain these customers — email is not required for
--     purchase or signup analysis. Flagging them for CRM team.
SELECT customer_id, first_name, last_name, email
FROM customers
WHERE email IS NULL;

-- 1b. Orders: Check for NULL order_date, delivery_date, or total_amount
SELECT order_id, order_date, delivery_date, total_amount, order_status
FROM orders
WHERE order_date IS NULL OR total_amount IS NULL;

-- 1c. Reviews: Check for NULL ratings
SELECT review_id, product_id, customer_id, rating
FROM reviews
WHERE rating IS NULL;


-- ─────────────────────────────────────────────────────────────
-- SECTION 2: DUPLICATE RECORDS
-- Check and remove duplicates in customers, sellers, orders
-- ─────────────────────────────────────────────────────────────

-- 2a. No duplicate customer_ids found (primary key constraint)
SELECT customer_id, COUNT(*) AS cnt
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- 2b. No duplicate seller_ids found
SELECT seller_id, COUNT(*) AS cnt
FROM sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;

-- 2c. No duplicate order_ids found
SELECT order_id, COUNT(*) AS cnt
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- 2d. Check for logical duplicates in customers (same name + email)
SELECT first_name, last_name, email, COUNT(*) AS cnt
FROM customers
GROUP BY first_name, last_name, email
HAVING COUNT(*) > 1;


-- ─────────────────────────────────────────────────────────────
-- SECTION 3: INCONSISTENT FORMATTING — CITY NAMES
-- Standardise all city name variants to canonical form
-- ─────────────────────────────────────────────────────────────

-- City standardisation mapping:
-- 'LAGOS', 'lagos', 'Lagos ', ' Lagos', 'Lago s'   → 'Lagos'
-- 'ABUJA', 'abuja', 'Abuja ', ' ABUJA'              → 'Abuja'
-- 'KANO',  'kano',  'Kano '                         → 'Kano'
-- 'IBADAN','ibadan','Ibadan ', 'IBADAN'              → 'Ibadan'
-- 'PORT HARCOURT','Port-Harcourt','PortHarcourt',
--   'port harcourt','Port-Harcourt'                 → 'Port Harcourt'

-- Standardise customers.city
UPDATE customers
SET city = CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(city)), '[^A-Z]', '', 'g') = 'LAGOS'
        THEN 'Lagos'
    WHEN REGEXP_REPLACE(UPPER(TRIM(city)), '[^A-Z]', '', 'g') = 'ABUJA'
        THEN 'Abuja'
    WHEN REGEXP_REPLACE(UPPER(TRIM(city)), '[^A-Z]', '', 'g') = 'KANO'
        THEN 'Kano'
    WHEN REGEXP_REPLACE(UPPER(TRIM(city)), '[^A-Z]', '', 'g') = 'IBADAN'
        THEN 'Ibadan'
    WHEN REGEXP_REPLACE(UPPER(TRIM(city)), '[^A-Z]', '', 'g') IN ('PORTHARCOURT','PORTHACOURT')
        OR UPPER(TRIM(city)) IN ('PORT HARCOURT','PORT-HARCOURT','PORT HARCOURT','port harcourt')
        THEN 'Port Harcourt'
    ELSE TRIM(city)
END;

-- Standardise sellers.city
UPDATE sellers
SET city = CASE
    WHEN REGEXP_REPLACE(UPPER(TRIM(city)), '[^A-Z]', '', 'g') = 'LAGOS'
        THEN 'Lagos'
    WHEN REGEXP_REPLACE(UPPER(TRIM(city)), '[^A-Z]', '', 'g') = 'ABUJA'
        THEN 'Abuja'
    WHEN REGEXP_REPLACE(UPPER(TRIM(city)), '[^A-Z]', '', 'g') = 'KANO'
        THEN 'Kano'
    WHEN REGEXP_REPLACE(UPPER(TRIM(city)), '[^A-Z]', '', 'g') = 'IBADAN'
        THEN 'Ibadan'
    WHEN REGEXP_REPLACE(UPPER(TRIM(city)), '[^A-Z]', '', 'g') IN ('PORTHARCOURT','PORTHACOURT')
        OR UPPER(TRIM(city)) IN ('PORT HARCOURT','PORT-HARCOURT','PORT HARCOURT','port harcourt')
        THEN 'Port Harcourt'
    ELSE TRIM(city)
END;

-- Verify city names are now clean
SELECT DISTINCT city FROM customers ORDER BY city;
SELECT DISTINCT city FROM sellers ORDER BY city;


-- ─────────────────────────────────────────────────────────────
-- SECTION 4: INCONSISTENT FORMATTING — DATE COLUMNS
-- All DATE columns in PostgreSQL already enforce YYYY-MM-DD.
-- Verify no invalid dates exist.
-- ─────────────────────────────────────────────────────────────

-- Date columns are stored as DATE type; PostgreSQL rejects malformed dates
-- at insert time. Confirming range is sensible (2023–2024 window).
SELECT MIN(signup_date), MAX(signup_date) FROM customers;
SELECT MIN(order_date),  MAX(order_date)  FROM orders;
SELECT MIN(review_date), MAX(review_date) FROM reviews;


-- ─────────────────────────────────────────────────────────────
-- SECTION 5: INCONSISTENT FORMATTING — PRODUCT CATEGORIES
-- Normalise to Title Case with standardised separator (&)
-- ─────────────────────────────────────────────────────────────

-- Category mapping (products table):
--   All Electronics variants          → 'Electronics'
--   All Fashion variants              → 'Fashion'
--   All Food variants                 → 'Food & Beverages'
--   All Home & Garden variants        → 'Home & Garden'
--   All Sports & Fitness variants     → 'Sports & Fitness'
--   All Beauty & Personal Care vars   → 'Beauty & Personal Care'
--   All Books & Stationery variants   → 'Books & Stationery'

UPDATE products
SET category = CASE
    WHEN UPPER(TRIM(category)) IN ('ELECTRONICS','ELECTRONIS') THEN 'Electronics'
    WHEN UPPER(TRIM(category)) IN ('FASHION','FASHON')         THEN 'Fashion'
    WHEN UPPER(TRIM(category)) IN ('FOOD','FOOD & BEVERAGES','FOOD AND BEVERAGES',
         'food & beverages')                                   THEN 'Food & Beverages'
    WHEN UPPER(TRIM(category)) IN ('HOME & GARDEN','HOME AND GARDEN',
         'home & garden')                                      THEN 'Home & Garden'
    WHEN UPPER(TRIM(category)) IN ('SPORTS','SPORTS & FITNESS','SPORTS AND FITNESS',
         'sports & fitness')                                   THEN 'Sports & Fitness'
    WHEN UPPER(TRIM(category)) IN ('BEAUTY','BEAUTY & PERSONAL CARE',
         'BEAUTY AND PERSONAL CARE','beauty & personal care')  THEN 'Beauty & Personal Care'
    WHEN UPPER(TRIM(category)) IN ('BOOKS','BOOKS & STATIONERY','BOOKS AND STATIONERY',
         'books & stationery')                                 THEN 'Books & Stationery'
    ELSE TRIM(category)
END;

-- Same for sellers.product_category
UPDATE sellers
SET product_category = CASE
    WHEN UPPER(TRIM(product_category)) IN ('ELECTRONICS','ELECTRONIS') THEN 'Electronics'
    WHEN UPPER(TRIM(product_category)) IN ('FASHION','FASHON')         THEN 'Fashion'
    WHEN UPPER(TRIM(product_category)) IN ('FOOD','FOOD & BEVERAGES','FOOD AND BEVERAGES',
         'food & beverages')                                           THEN 'Food & Beverages'
    WHEN UPPER(TRIM(product_category)) IN ('HOME & GARDEN','HOME AND GARDEN',
         'home & garden')                                              THEN 'Home & Garden'
    WHEN UPPER(TRIM(product_category)) IN ('SPORTS','SPORTS & FITNESS','SPORTS AND FITNESS',
         'sports & fitness')                                           THEN 'Sports & Fitness'
    WHEN UPPER(TRIM(product_category)) IN ('BEAUTY','BEAUTY & PERSONAL CARE',
         'BEAUTY AND PERSONAL CARE','beauty & personal care')          THEN 'Beauty & Personal Care'
    WHEN UPPER(TRIM(product_category)) IN ('BOOKS','BOOKS & STATIONERY','BOOKS AND STATIONERY',
         'books & stationery')                                         THEN 'Books & Stationery'
    ELSE TRIM(product_category)
END;

-- Verify categories
SELECT DISTINCT category FROM products ORDER BY category;
SELECT DISTINCT product_category FROM sellers ORDER BY product_category;


-- ─────────────────────────────────────────────────────────────
-- SECTION 6: DATA VALIDATION — ORDER TOTALS
-- Flag orders where total_amount differs from sum of line items by > ₦10
-- ─────────────────────────────────────────────────────────────

-- Create a table to store flagged orders (for reference in analysis)
DROP TABLE IF EXISTS flagged_order_totals;
CREATE TABLE flagged_order_totals AS
SELECT
    o.order_id,
    o.total_amount                    AS recorded_total,
    SUM(oi.line_total)                AS computed_total,
    ABS(o.total_amount - SUM(oi.line_total)) AS difference
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id, o.total_amount
HAVING ABS(o.total_amount - SUM(oi.line_total)) > 10;

-- Decision: We flag these 124 orders but do NOT delete them.
-- Revenue queries will use SUM(oi.line_total) rather than orders.total_amount
-- to ensure accuracy. Deleting would unfairly suppress real transaction data.
SELECT COUNT(*) AS flagged_orders FROM flagged_order_totals;


-- ─────────────────────────────────────────────────────────────
-- SECTION 7: DATA VALIDATION — REVIEW RATINGS
-- Valid ratings must be between 1 and 5
-- ─────────────────────────────────────────────────────────────

-- Identify invalid ratings (found: -1, 0, 7)
SELECT rating, COUNT(*) AS cnt
FROM reviews
WHERE rating NOT BETWEEN 1 AND 5
GROUP BY rating
ORDER BY rating;

-- Decision: Set out-of-range ratings to NULL.
-- Rationale: We cannot determine the correct rating. Setting to NULL
-- excludes them from AVG calculations without deleting the review record.
-- If these were valid data entries (typos), excluding them slightly
-- understates rating averages — a conservative, safe bias.
UPDATE reviews
SET rating = NULL
WHERE rating NOT BETWEEN 1 AND 5;

-- Confirm fix
SELECT COUNT(*) AS invalid_ratings_remaining
FROM reviews
WHERE rating NOT BETWEEN 1 AND 5;


-- ─────────────────────────────────────────────────────────────
-- SECTION 8: DATA VALIDATION — NEGATIVE PRICES
-- ─────────────────────────────────────────────────────────────

-- Check for negative product prices
SELECT product_id, product_name, unit_price
FROM products
WHERE unit_price < 0;
-- Result: No negative prices found.

-- Check for discount > 100% (no discount column exists in schema)
-- The order_items table has unit_price and line_total.
-- Flag line items where line_total > unit_price * quantity (impossible discount)
SELECT item_id, order_id, product_id, quantity, unit_price, line_total,
       (unit_price * quantity) AS expected_total
FROM order_items
WHERE line_total > (unit_price * quantity) * 1.01  -- allow 1% rounding tolerance
   OR line_total < 0;


-- ─────────────────────────────────────────────────────────────
-- SECTION 9: FINAL VERIFICATION — CLEAN DATA SUMMARY
-- ─────────────────────────────────────────────────────────────

SELECT 'Customers' AS table_name, COUNT(*) AS total_rows FROM customers
UNION ALL SELECT 'Sellers',   COUNT(*) FROM sellers
UNION ALL SELECT 'Products',  COUNT(*) FROM products
UNION ALL SELECT 'Orders',    COUNT(*) FROM orders
UNION ALL SELECT 'OrderItems',COUNT(*) FROM order_items
UNION ALL SELECT 'Payments',  COUNT(*) FROM payments
UNION ALL SELECT 'Reviews',   COUNT(*) FROM reviews;

-- ============================================================
-- END OF DATA CLEANING SCRIPT
-- ============================================================
