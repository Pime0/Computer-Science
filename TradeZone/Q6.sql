-- ============================================================
-- Q6: Payment Method Preferences by State
-- Business Question: Analyse payment method preferences across
-- each state. Show transaction count and total amount per method
-- (Cash on Delivery, Card, Mobile Money, Bank Transfer) and identify
-- the most popular method per state.
-- ============================================================

WITH payment_state AS (
    SELECT
        c.state,
        p.payment_method,
        COUNT(p.payment_id)     AS transaction_count,
        ROUND(SUM(p.amount), 2) AS total_amount
    FROM payments p
    JOIN orders    o ON p.order_id    = o.order_id
    JOIN customers c ON o.customer_id = c.customer_id
    GROUP BY c.state, p.payment_method
),
ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY state ORDER BY transaction_count DESC) AS rnk
    FROM payment_state
)
SELECT
    state,
    payment_method,
    transaction_count,
    total_amount,
    CASE WHEN rnk = 1 THEN 'Most Popular' ELSE '' END AS most_popular
FROM ranked
ORDER BY state, transaction_count DESC;
