-- ============================================================
-- Q1: Customer Acquisition & 30-Day Conversion
-- Business Question: Find the top 5 states by number of new customer
-- sign-ups in 2024. For each state, calculate what percentage of these
-- new customers made at least one purchase within their first 30 days.
-- ============================================================

WITH new_customers_2024 AS (
    SELECT
        customer_id,
        state,
        signup_date
    FROM customers
    WHERE signup_date >= '2024-01-01'
      AND signup_date <  '2025-01-01'
),
first_purchase AS (
    -- For each new 2024 customer, find their earliest order date
    SELECT
        o.customer_id,
        MIN(o.order_date) AS first_order_date
    FROM orders o
    WHERE o.order_status NOT IN ('Cancelled', 'Returned')
    GROUP BY o.customer_id
),
conversion_check AS (
    SELECT
        nc.customer_id,
        nc.state,
        nc.signup_date,
        fp.first_order_date,
        CASE
            WHEN fp.first_order_date IS NOT NULL
             AND fp.first_order_date <= nc.signup_date + INTERVAL '30 days'
            THEN 1 ELSE 0
        END AS converted_within_30_days
    FROM new_customers_2024 nc
    LEFT JOIN first_purchase fp ON nc.customer_id = fp.customer_id
),
state_summary AS (
    SELECT
        state,
        COUNT(*)                                   AS new_customers,
        SUM(converted_within_30_days)              AS converted_customers,
        ROUND(
            100.0 * SUM(converted_within_30_days) / COUNT(*), 2
        )                                          AS conversion_rate_pct
    FROM conversion_check
    GROUP BY state
)
SELECT
    state,
    new_customers,
    converted_customers,
    conversion_rate_pct
FROM state_summary
ORDER BY new_customers DESC
LIMIT 5;
