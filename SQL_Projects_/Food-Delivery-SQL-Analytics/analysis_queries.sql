-- Food Delivery Analytics

-- Query 1: Total number of customers
SELECT COUNT(*) FROM customers;

-- Query 2: Total number of restaurants
SELECT COUNT(*) FROM restaurants;

-- Query 3: Total number of orders
SELECT COUNT(*) FROM orders;

-- Query 4: Order status distribution
SELECT status, COUNT(*) 
FROM orders
GROUP BY status;

-- Query 5: Orders per city
SELECT c.city, COUNT(*) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.city;

-- Query 6: Top cuisines by order count
SELECT r.cuisine, COUNT(*) AS total_orders
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY r.cuisine
ORDER BY total_orders DESC;

-- Query 7: Top customers by number of orders
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 5;

-- Query 8: Revenue per restaurant
SELECT o.restaurant_id,
       ROUND(SUM(oi.price * oi.quantity),2) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.restaurant_id
ORDER BY restaurant_id;

-- Query 9: Average order value (using CTE)
WITH order_totals AS (
    SELECT o.order_id,
           SUM(oi.price * oi.quantity) AS total_amount
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id
)
SELECT ROUND(AVG(total_amount),2) FROM order_totals;

-- Query 10: Average delivery time (minutes)
SELECT AVG(EXTRACT(EPOCH FROM delivery_time) / 60)
FROM deliveries;

-- Query 11: Rating distribution
SELECT rating, COUNT(*)
FROM deliveries
GROUP BY rating
ORDER BY rating;


-- Query 12: Monthly order trend
SELECT TO_CHAR(order_date,'YYYY-MON') AS month,
       COUNT(*) AS total_orders
FROM orders
GROUP BY month
ORDER BY month;

-- Query 13: Cancellation rate
SELECT 
    ROUND(100.0 * SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*)) AS cancel_rate
FROM orders;

-- Query 14: Customer ranking by spending
SELECT 
    customer_id,
    ROUND(SUM(oi.price * oi.quantity),2) AS total_spent,
    RANK() OVER (ORDER BY SUM(oi.price * oi.quantity) DESC) AS rank
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY customer_id;

-- Query 15: Restaurant ranking within cuisine
SELECT 
    r.cuisine,
    o.restaurant_id,
    COUNT(*) AS total_orders,
    DENSE_RANK() OVER (
        PARTITION BY r.cuisine 
        ORDER BY COUNT(*) DESC
    ) AS rank_in_cuisine
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY r.cuisine, o.restaurant_id;

-- Query 16: Running revenue over time
SELECT 
    order_date,
    ROUND(SUM(oi.price * oi.quantity),2) AS daily_revenue,
    ROUND(SUM(SUM(oi.price * oi.quantity)) OVER (ORDER BY order_date),2) AS running_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY order_date;

-- Query 17: Delivery speed category
SELECT 
    CASE 
        WHEN delivery_time <= INTERVAL '20 minutes' THEN 'Fast'
        WHEN delivery_time <= INTERVAL '40 minutes' THEN 'Medium'
        ELSE 'Slow'
    END AS delivery_category,
    COUNT(*) AS total_orders
FROM deliveries
GROUP BY delivery_category;

-- Query 18: Customer lifetime value (CLV)
SELECT 
    customer_id,
    ROUND(SUM(oi.price * oi.quantity),2) AS lifetime_value,
    DENSE_RANK() OVER (ORDER BY SUM(oi.price * oi.quantity) DESC) AS rank
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY customer_id;

-- Query 19: Repeat order gap analysis
SELECT 
    customer_id,
    order_date,
    LAG(order_date) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ) AS previous_order,
    (order_date - LAG(order_date) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    )) AS gap_days
FROM orders;

-- Query 20: Revenue contribution percentage
SELECT 
    restaurant_id,
    ROUND(SUM(oi.price * oi.quantity),2) AS revenue,
    ROUND(
        100.0 * SUM(oi.price * oi.quantity)
        / SUM(SUM(oi.price * oi.quantity)) OVER (), 2
    ) AS contribution_percent
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY restaurant_id;