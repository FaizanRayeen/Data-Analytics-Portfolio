
-- Query 1: total customers in system
SELECT COUNT(*) AS total_customers FROM customers;

-- Query 2: total products available
SELECT COUNT(*) AS total_products FROM products;

-- Query 3: total orders placed
SELECT COUNT(*) AS total_orders FROM orders;

-- Query 4: total revenue generated
SELECT SUM(p.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

-- Query 5: order status distribution
SELECT status, COUNT(*) FROM orders GROUP BY status;

-- Query 6: payment method usage
SELECT payment_method, COUNT(*) FROM payments GROUP BY payment_method;

-- Query 7: payment status breakdown
SELECT payment_status, COUNT(*) FROM payments GROUP BY payment_status;

-- Query 8: top 5 best selling products
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 5;

-- Query 9: category wise revenue
SELECT p.category, SUM(p.price * oi.quantity) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

-- Query 10: top spending customers
SELECT c.name, SUM(p.price * oi.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.name
ORDER BY total_spent DESC;

-- Query 11: city wise revenue
SELECT c.city, SUM(p.price * oi.quantity) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.city
ORDER BY revenue DESC;

-- Query 12: average order value
SELECT SUM(p.price * oi.quantity) / COUNT(DISTINCT o.order_id) AS avg_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

-- Query 13: repeat customers
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Query 14: monthly revenue trend
SELECT TO_CHAR(o.order_date, 'YYYY-MON') AS month,
       SUM(p.price * oi.quantity) AS revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY TO_CHAR(o.order_date, 'YYYY-MON')
ORDER BY month;


-- Query 15: first order per customer
SELECT customer_id, MIN(order_date) AS first_order_date
FROM orders
GROUP BY customer_id
ORDER BY customer_id;

-- Query 16: last order per customer
SELECT customer_id, MAX(order_date) AS last_order_date
FROM orders
GROUP BY customer_id
ORDER BY customer_id;

-- Query 17: customers with no orders
SELECT c.customer_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- Query 18: high value orders
SELECT o.order_id,
       SUM(p.price * oi.quantity) AS order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY o.order_id
HAVING SUM(p.price * oi.quantity) > 20000;

-- Query 19: running total revenue
SELECT o.order_date,
       SUM(p.price * oi.quantity) AS daily_revenue,
       SUM(SUM(p.price * oi.quantity)) OVER (ORDER BY o.order_date) AS running_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY o.order_date
ORDER BY o.order_date;

-- Query 20: top product per category
SELECT *
FROM (
    SELECT p.category,
           p.product_name,
           SUM(oi.quantity) AS total_sold,
           RANK() OVER (PARTITION BY p.category ORDER BY SUM(oi.quantity) DESC) AS rnk
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.category, p.product_name
) t
WHERE rnk = 1;

