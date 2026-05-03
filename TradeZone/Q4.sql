-- ============================================================
-- Q4: Quarterly Revenue Trends
-- Business Question: Compare quarterly revenue across 2023 and 2024.
-- For each quarter: total revenue, average order value, total orders.
-- Identify which single quarter showed strongest revenue growth YoY.
-- ============================================================

-- PART 1: All quarters side by side
WITH quarterly AS (
    SELECT
        EXTRACT(YEAR    FROM o.order_date)::INTEGER  AS yr,
        EXTRACT(QUARTER FROM o.order_date)::INTEGER  AS qtr,
        COUNT(DISTINCT o.order_id)                   AS total_orders,
        ROUND(SUM(COALESCE(oi.line_total, oi.unit_price * oi.quantity)), 2)  AS total_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
      AND o.order_date BETWEEN '2023-01-01' AND '2024-12-31'
    GROUP BY yr, qtr
),
order_aov AS (
    SELECT
        EXTRACT(YEAR    FROM o.order_date)::INTEGER AS yr,
        EXTRACT(QUARTER FROM o.order_date)::INTEGER AS qtr,
        ROUND(AVG(ord_total), 2)                    AS avg_order_value
    FROM (
        SELECT
            o.order_id,
            o.order_date,
            SUM(COALESCE(oi.line_total, oi.unit_price * oi.quantity)) AS ord_total
        FROM orders o
        JOIN order_items oi ON o.order_id = oi.order_id
        WHERE o.order_status = 'Delivered'
          AND o.order_date BETWEEN '2023-01-01' AND '2024-12-31'
        GROUP BY o.order_id, o.order_date
    ) sub
    GROUP BY yr, qtr
)
SELECT
    q.yr         AS year,
    q.qtr        AS quarter,
    q.total_orders,
    q.total_revenue,
    a.avg_order_value
FROM quarterly q
JOIN order_aov a ON q.yr = a.yr AND q.qtr = a.qtr
ORDER BY q.yr, q.qtr;

-- PART 2: Single quarter with strongest absolute revenue growth 2023 vs 2024
WITH quarterly AS (
    SELECT
        EXTRACT(YEAR    FROM o.order_date)::INTEGER AS yr,
        EXTRACT(QUARTER FROM o.order_date)::INTEGER AS qtr,
        ROUND(SUM(COALESCE(oi.line_total, oi.unit_price * oi.quantity)), 2) AS total_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.order_status = 'Delivered'
      AND o.order_date BETWEEN '2023-01-01' AND '2024-12-31'
    GROUP BY yr, qtr
)
SELECT
    c24.qtr                                              AS quarter,
    c23.total_revenue                                    AS revenue_2023,
    c24.total_revenue                                    AS revenue_2024,
    ROUND(c24.total_revenue - c23.total_revenue, 2)      AS absolute_growth,
    ROUND(100.0 * (c24.total_revenue - c23.total_revenue)
          / NULLIF(c23.total_revenue, 0), 2)             AS growth_pct
FROM quarterly c23
JOIN quarterly c24 ON c23.qtr = c24.qtr
WHERE c23.yr = 2023 AND c24.yr = 2024
ORDER BY absolute_growth DESC
LIMIT 1;
