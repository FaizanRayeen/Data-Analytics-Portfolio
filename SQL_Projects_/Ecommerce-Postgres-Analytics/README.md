# 🛒 E-Commerce Sales Analytics (PostgreSQL)

[![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![SQL](https://img.shields.io/badge/Language-SQL-38BDF8?style=for-the-badge&logo=database&logoColor=white)](#)
[![Analytics](https://img.shields.io/badge/Domain-E--Commerce_Analytics-2563EB?style=for-the-badge)](#)

A comprehensive, end-to-end **PostgreSQL analytics project** analyzing an e-commerce platform's transactional data. This project solves critical business questions across **customer purchasing behavior, product performance, revenue trends, and payment efficiency**.

---

## 📌 Business Overview & Objectives

In e-commerce, understanding customer lifetime value, category contribution, order completion rates, and regional revenue growth is vital for strategic decision-making. 

### Key Analytics Goals:
* 💰 **Revenue Analysis**: Track total revenue, category contributions, and average order value (AOV).
* 👥 **Customer Insights**: Identify top spenders, repeat purchase rates, and inactive customers.
* 📦 **Product Intelligence**: Rank best-selling items per category and detect high-demand inventory.
* 💳 **Payment & Order Fulfillment**: Measure payment gateway success rates and order cancellation ratios.

---

## 🗄️ Relational Database Schema

The database consists of **5 relational tables** designed with primary and foreign key constraints:

```
  +------------------+         +------------------+         +------------------+
  |    CUSTOMERS     |         |      ORDERS      |         |     PAYMENTS     |
  +------------------+         +------------------+         +------------------+
  | customer_id (PK) |<-------1| order_id (PK)    |<-------1| payment_id (PK)  |
  | name             |         | customer_id (FK) |         | order_id (FK)    |
  | email            |         | order_date       |         | payment_method   |
  | city             |         | status           |         | payment_status   |
  +------------------+         +--------+---------+         +------------------+
                                        |1
                                        |
                                        |*
                               +--------+---------+         +------------------+
                               |   ORDER_ITEMS    |         |     PRODUCTS     |
                               +------------------+         +------------------+
                               | order_item_id(PK)|         | product_id (PK)  |
                               | order_id (FK)    |*------>1| product_name     |
                               | product_id (FK)  |         | category         |
                               | quantity         |         | price            |
                               +------------------+         +------------------+
```

---

## 🔍 Key Analytical Queries & Solutions

### 1️⃣ Top-Selling Products by Quantity
```sql
SELECT 
    p.product_name, 
    p.category,
    SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name, p.category
ORDER BY total_units_sold DESC
LIMIT 5;
```

### 2️⃣ Category Revenue Contribution
```sql
SELECT 
    p.category, 
    ROUND(SUM(p.price * oi.quantity), 2) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;
```

### 3️⃣ High-Value Customer Ranking (`RANK() Window Function`)
```sql
SELECT 
    c.name,
    c.city,
    ROUND(SUM(p.price * oi.quantity), 2) AS total_spent,
    RANK() OVER (ORDER BY SUM(p.price * oi.quantity) DESC) AS customer_rank
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.name, c.city;
```

### 4️⃣ Monthly Revenue & Cumulative Growth (`SUM() OVER()`)
```sql
WITH monthly_revenue AS (
    SELECT 
        TO_CHAR(o.order_date, 'YYYY-Mon') AS month,
        SUM(p.price * oi.quantity) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY TO_CHAR(o.order_date, 'YYYY-Mon')
)
SELECT 
    month,
    revenue,
    SUM(revenue) OVER (ORDER BY month) AS running_total_revenue
FROM monthly_revenue;
```

---

## 🛠️ Advanced SQL Concepts Applied

| SQL Technique | Business Application |
|---|---|
| 🔗 **Multi-Table JOINs** | Joining `customers`, `orders`, `order_items`, and `products` for full funnel analysis. |
| 📊 **Window Functions** | `RANK()`, `SUM() OVER()` for cumulative growth and customer segmentation. |
| ⚙️ **CTEs & Aggregations** | Clean, modular query design using `WITH` clauses and `GROUP BY / HAVING`. |
| 🗓️ **Date & String Formatting** | Extracting monthly trends using `TO_CHAR()` and `EXTRACT()`. |
| ⚖️ **Conditional Logic** | `CASE WHEN` statements to categorize order statuses and payment modes. |

---

## 💡 Key Business Insights

* 🔝 **Top Products**: Electronics & Apparel categories contribute to over 60% of total revenue.
* 📍 **Geographic Distribution**: Metro cities show higher average order values compared to tier-2 cities.
* 💳 **Payment Preferences**: UPI and Credit Cards account for the majority of successful transactions.
* 🔄 **Customer Retention**: 28% of total customers are repeat buyers who drive nearly 50% of monthly sales.

---

## 📂 File Structure

```
Ecommerce-Postgres-Analytics/
│
├── schema_setup.(ecommerce_sales).sql   # Database schema & sample dataset insert scripts
├── analysis_queries.sql                # 20 analytical SQL queries grouped by business domain
└── README.md                           # Documentation & Insights Summary
```

---

## 👤 Author
**Mohd Faizan Rayeen**  
🌐 **[Live Portfolio](https://faizanrayeen.github.io/Portfolio)** | 💼 **[LinkedIn](https://www.linkedin.com/in/faizan-rayeen)** | 📧 **[Email](mailto:faizanrayeen675@gmail.com)**
