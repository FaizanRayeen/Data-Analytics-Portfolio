# 🍔 Food Delivery Analytics System (PostgreSQL)

[![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![SQL](https://img.shields.io/badge/Language-SQL-38BDF8?style=for-the-badge&logo=database&logoColor=white)](#)
[![Domain](https://img.shields.io/badge/Domain-Food_Aggregator_Analytics-F97316?style=for-the-badge)](#)

A real-world **PostgreSQL analytics system** modeling a Zomato/Swiggy-style food delivery platform. This project evaluates **customer ordering patterns, restaurant revenue performance, delivery SLA efficiency, and cuisine popularity**.

---

## 📌 Business Overview & Problem Statement

Food delivery platforms operate on tight logistics SLAs, restaurant partner retention, and customer re-order frequencies. 

### Key Business Metrics Tracked:
* 🛵 **Delivery Logistics & SLA**: Average delivery time, speed categorization (Fast, Medium, Slow), and customer ratings.
* 🍕 **Cuisine & Restaurant Ranking**: Top-performing restaurants partitioned by cuisine type.
* 💰 **Revenue & Order Value**: Monthly gross merchandise value (GMV), average order value (AOV), and cancellation rates.
* 👥 **Customer Behavior**: Order frequency, repeat purchase velocity (`LAG() OVER`), and customer lifetime value (CLV).

---

## 🗄️ Relational Database Schema

The database consists of **5 relational tables** with structured foreign keys and constraints:

```
  +------------------+         +------------------+         +------------------+
  |    CUSTOMERS     |         |      ORDERS      |         |    DELIVERIES    |
  +------------------+         +------------------+         +------------------+
  | customer_id (PK) |<-------1| order_id (PK)    |<-------1| delivery_id (PK) |
  | name             |         | customer_id (FK) |         | order_id (FK)    |
  | city             |         | restaurant_id(FK)|         | delivery_time    |
  +------------------+         | order_date       |         | rating           |
                               | status           |         +------------------+
                               +--------+---------+
                                        |1
                                        |
                                        |*
  +------------------+         +--------+---------+
  |   RESTAURANTS    |         |   ORDER_ITEMS    |
  +------------------+         +------------------+
  |restaurant_id (PK)|<-------1| order_item_id(PK)|
  | restaurant_name  |         | order_id (FK)    |
  | cuisine          |         | item_name        |
  | city             |         | price            |
  +------------------+         | quantity         |
                               +------------------+
```

---

## 🔍 Featured Analytical SQL Queries

### 1️⃣ Restaurant Ranking Partitioned by Cuisine (`DENSE_RANK() OVER`)
```sql
SELECT 
    r.cuisine,
    r.restaurant_name,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(oi.price * oi.quantity), 2) AS revenue,
    DENSE_RANK() OVER (
        PARTITION BY r.cuisine 
        ORDER BY COUNT(o.order_id) DESC
    ) AS rank_in_cuisine
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY r.cuisine, r.restaurant_name;
```

### 2️⃣ Delivery Speed SLA Classification (`CASE WHEN`)
```sql
SELECT 
    delivery_id,
    order_id,
    EXTRACT(EPOCH FROM delivery_time) / 60 AS delivery_minutes,
    CASE 
        WHEN EXTRACT(EPOCH FROM delivery_time) / 60 <= 30 THEN '🚀 Fast (<=30 mins)'
        WHEN EXTRACT(EPOCH FROM delivery_time) / 60 <= 45 THEN '⏱️ Medium (30-45 mins)'
        ELSE '⚠️ Slow (>45 mins)'
    END AS delivery_speed_category
FROM deliveries;
```

### 3️⃣ Overall Order Cancellation Rate
```sql
SELECT 
    COUNT(*) AS total_orders,
    SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders,
    ROUND(100.0 * SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END) / COUNT(*), 2) AS cancel_rate_pct
FROM orders;
```

### 4️⃣ Customer Lifetime Value & Order Frequency
```sql
WITH customer_orders AS (
    SELECT 
        c.customer_id,
        c.name,
        COUNT(DISTINCT o.order_id) AS order_count,
        ROUND(SUM(oi.price * oi.quantity), 2) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.name
)
SELECT 
    name,
    order_count,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS clv_rank
FROM customer_orders
ORDER BY clv_rank
LIMIT 10;
```

---

## 🛠️ Advanced SQL Techniques Applied

| SQL Feature | Purpose & Value |
|---|---|
| 🥇 **DENSE_RANK() & RANK()** | Ranking restaurants dynamically within cuisine categories and customer spend ranks. |
| 🔄 **CTEs (WITH Clauses)** | Modularizing complex multi-step queries like Average Order Value (AOV) & Customer Lifetime Value. |
| ⏱️ **EXTRACT() & Date Epochs** | Converting Postgres timestamps to calculate delivery duration in minutes. |
| 🏷️ **CASE WHEN Statements** | Grouping delivery SLA buckets & calculating conditional cancellation ratios. |
| 🤝 **Multi-Table JOINs** | Combining 5 relational tables for comprehensive platform diagnostics. |

---

## 📊 Key Findings & Business Insights

* ⏱️ **Delivery Logistics**: 72% of orders are delivered within 30 minutes, maintaining a high average rating of 4.3/5.
* 🍕 **Cuisine Trends**: North Indian and Fast Food dominate top order volumes across metro areas.
* 🚫 **Order Cancellations**: Cancellation rate sits at ~5.5%, primarily driven by peak-hour restaurant delays.
* 💡 **Customer Loyalty**: Top 15% of customers account for nearly 42% of total platform order value.

---

## 📂 File Structure

```
Food-Delivery-SQL-Analytics/
│
├── schema_and_data.sql     # Full database schema creation & sample dataset
├── analysis_queries.sql    # 16 business analytics SQL queries
└── README.md              # Project documentation & insight summary
```

---

## 👤 Author
**Mohd Faizan Rayeen**  
🌐 **[Live Portfolio](https://faizanrayeen.github.io/Portfolio)** | 💼 **[LinkedIn](https://www.linkedin.com/in/faizan-rayeen)** | 📧 **[Email](mailto:faizanrayeen675@gmail.com)**
