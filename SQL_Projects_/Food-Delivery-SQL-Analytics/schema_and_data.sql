DROP TABLE IF EXISTS deliveries;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS customers;

-- Customers table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);
SELECT* FROM customers;


-- Restaurants table
CREATE TABLE restaurants (
    restaurant_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    cuisine VARCHAR(50),
    city VARCHAR(50)
);
SELECT* FROM restaurants;

-- Orders table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);
SELECT* FROM orders;

-- Order items table
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT,
    item_name VARCHAR(100),
    price NUMERIC,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
SELECT* FROM order_items;

-- Deliveries table
CREATE TABLE deliveries (
    delivery_id SERIAL PRIMARY KEY,
    order_id INT,
    delivery_time INT,
    rating INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
SELECT* FROM deliveries;

------ Data Summary----------
-- customers: 100 records
-- restaurants: 50 records
-- orders: 200 records
-- order_items: 400 records
-- deliveries: 200 records
