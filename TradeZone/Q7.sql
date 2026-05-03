-- ============================================================
-- Q7: Review Ratings and Sales Performance
-- Business Question: Group products by average review rating into
-- High Rated (≥ 4.0), Mid Rated (3.0–3.99), Low Rated (< 3.0).
-- For each category: product count, total revenue, average unit price.
-- ============================================================

WITH product_ratings AS (
    SELECT
        product_id,
        AVG(rating) AS avg_rating
    FROM reviews
    WHERE rating IS NOT NULL   -- exclude ratings nulled out during cleaning
    GROUP BY product_id
),
product_revenue AS (
    SELECT
        p.product_id,
        p.unit_price,
        ROUND(
            SUM(COALESCE(oi.line_total, oi.unit_price * oi.quantity)), 2
        ) AS total_revenue
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    JOIN orders      o  ON oi.order_id  = o.order_id
    WHERE o.order_status = 'Delivered'
    GROUP BY p.product_id, p.unit_price
),
combined AS (
    SELECT
        pr.product_id,
        pr.avg_rating,
        rev.total_revenue,
        rev.unit_price,
        CASE
            WHEN pr.avg_rating >= 4.0 THEN 'High Rated'
            WHEN pr.avg_rating >= 3.0 THEN 'Mid Rated'
            ELSE                           'Low Rated'
        END AS rating_category
    FROM product_ratings pr
    JOIN product_revenue rev ON pr.product_id = rev.product_id
)
SELECT
    rating_category,
    COUNT(*)                       AS product_count,
    ROUND(SUM(total_revenue), 2)   AS total_revenue,
    ROUND(AVG(unit_price), 2)      AS avg_unit_price
FROM combined
GROUP BY rating_category
ORDER BY MIN(avg_rating) DESC;
