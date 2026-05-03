-- ============================================================
-- Q3: Seller Fulfilment Efficiency
-- Business Question: Calculate the average time in hours between
-- order placement and delivery for each seller. Return the top 20
-- sellers with the fastest average fulfilment among sellers who
-- have completed at least 20 orders. Include total completed orders
-- and average customer rating.
-- ============================================================

WITH seller_fulfilment AS (
    SELECT
        o.seller_id,
        COUNT(*)                                                  AS completed_orders,
        ROUND(
            AVG(
                EXTRACT(EPOCH FROM (o.delivery_date::TIMESTAMP - o.order_date::TIMESTAMP))
                / 3600.0
            ), 2
        )                                                         AS avg_fulfilment_hours
    FROM orders o
    WHERE o.order_status = 'Delivered'
      AND o.delivery_date IS NOT NULL
      AND o.order_date IS NOT NULL
    GROUP BY o.seller_id
    HAVING COUNT(*) >= 20
),
seller_ratings AS (
    SELECT
        p.seller_id,
        ROUND(AVG(r.rating), 2) AS avg_rating
    FROM reviews r
    JOIN products p ON r.product_id = p.product_id
    WHERE r.rating IS NOT NULL
    GROUP BY p.seller_id
)
SELECT
    sf.seller_id,
    s.seller_name,
    sf.completed_orders,
    sf.avg_fulfilment_hours,
    COALESCE(sr.avg_rating, 0) AS avg_customer_rating
FROM seller_fulfilment sf
JOIN sellers      s  ON sf.seller_id = s.seller_id
LEFT JOIN seller_ratings sr ON sf.seller_id = sr.seller_id
ORDER BY sf.avg_fulfilment_hours ASC
LIMIT 20;
