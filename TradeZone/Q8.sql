-- ============================================================
-- Q8: Top Seller Bonus Qualification
-- Business Question: Identify the top 10 sellers in 2024 by total
-- revenue who completed at least 10 orders and have an average
-- customer rating of 4.0 or above. Include total orders, average
-- rating, and total revenue.
-- ============================================================

WITH seller_2024_revenue AS (
    SELECT
        o.seller_id,
        COUNT(DISTINCT o.order_id)                                            AS total_orders,
        ROUND(
            SUM(COALESCE(oi.line_total, oi.unit_price * oi.quantity)), 2
        )                                                                     AS total_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_date >= '2024-01-01'
      AND o.order_date <  '2025-01-01'
      AND o.order_status = 'Delivered'
    GROUP BY o.seller_id
    HAVING COUNT(DISTINCT o.order_id) >= 10
),
seller_ratings AS (
    SELECT
        p.seller_id,
        ROUND(AVG(r.rating), 2) AS avg_rating
    FROM reviews  r
    JOIN products p ON r.product_id = p.product_id
    WHERE r.rating IS NOT NULL
    GROUP BY p.seller_id
)
SELECT
    sr2.seller_id,
    s.seller_name,
    sr2.total_orders,
    srt.avg_rating,
    sr2.total_revenue
FROM seller_2024_revenue sr2
JOIN sellers       s   ON sr2.seller_id = s.seller_id
JOIN seller_ratings srt ON sr2.seller_id = srt.seller_id
WHERE srt.avg_rating >= 4.0
ORDER BY sr2.total_revenue DESC
LIMIT 10;
