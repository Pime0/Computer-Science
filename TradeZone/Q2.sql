-- ============================================================
-- Q2: Product Performance
-- Business Question: Identify the top 10 products by total revenue
-- in 2024. Include product name, category, total revenue and total
-- number of orders. Sort by revenue descending.
-- ============================================================

-- Note: Revenue is computed from order_items using COALESCE(line_total,
-- unit_price * quantity) to handle 4 products with NULL prices in order_items.
-- Only Delivered orders are counted as confirmed revenue.

SELECT
    p.product_id,
    p.product_name,
    p.category,
    COUNT(DISTINCT oi.order_id)                                         AS total_orders,
    ROUND(
        SUM(COALESCE(oi.line_total, oi.unit_price * oi.quantity)), 2
    )                                                                   AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders   o ON oi.order_id   = o.order_id
WHERE o.order_date >= '2024-01-01'
  AND o.order_date <  '2025-01-01'
  AND o.order_status = 'Delivered'
GROUP BY p.product_id, p.product_name, p.category
HAVING SUM(COALESCE(oi.line_total, oi.unit_price * oi.quantity)) IS NOT NULL
ORDER BY total_revenue DESC
LIMIT 10;
