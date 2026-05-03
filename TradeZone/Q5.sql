-- ============================================================
-- Q5: Customer Spend Segmentation
-- Business Question: Segment customers based on their total spend
-- in 2024 into three groups: High Spenders (≥ ₦100,000),
-- Medium Spenders (₦50,000–₦99,999), Low Spenders (< ₦50,000).
-- For each group: customer count, average spend, total revenue contribution.
-- ============================================================

WITH customer_spend AS (
    SELECT
        o.customer_id,
        SUM(COALESCE(oi.line_total, oi.unit_price * oi.quantity)) AS total_spend
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_date >= '2024-01-01'
      AND o.order_date <  '2025-01-01'
      AND o.order_status NOT IN ('Cancelled', 'Returned')
    GROUP BY o.customer_id
),
segmented AS (
    SELECT
        customer_id,
        total_spend,
        CASE
            WHEN total_spend >= 100000 THEN 'High Spenders'
            WHEN total_spend >= 50000  THEN 'Medium Spenders'
            ELSE                            'Low Spenders'
        END AS segment
    FROM customer_spend
)
SELECT
    segment,
    COUNT(*)                              AS customer_count,
    ROUND(AVG(total_spend), 2)            AS avg_spend_per_customer,
    ROUND(SUM(total_spend), 2)            AS total_revenue_contribution
FROM segmented
GROUP BY segment
ORDER BY MIN(total_spend) DESC;
