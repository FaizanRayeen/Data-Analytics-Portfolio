# 🗃️ SQL Projects

A collection of SQL-based data analysis projects built using PostgreSQL, covering database design, business analytics, and advanced query techniques (window functions, CTEs, subqueries).

> 📌 **Note:** These projects live in their own dedicated repositories (linked below) to preserve their commit history. This section provides a summary — click through for the full SQL scripts.

---

### 🛒 [E-Commerce Sales Analytics](https://github.com/FaizanRayeen/ecommerce-postgres-analysis)

End-to-end SQL analysis of an e-commerce dataset covering customer behavior, product performance, revenue trends, and payment analytics — **20 analytical queries** across 5 relational tables (customers, products, orders, order_items, payments).

**Key areas analyzed:**
- Customer Analytics — repeat customers, first/last purchase tracking
- Product Performance — best-sellers, category-level sales distribution
- Revenue Analytics — category-wise & city-wise revenue, high-value orders
- Order Analytics — status distribution, monthly revenue trends, AOV
- Payment Analytics — payment method & status breakdown
- Advanced Analytics — running totals and product ranking using window functions

**SQL concepts used:** Aggregate functions, INNER/LEFT JOIN, GROUP BY/HAVING, Subqueries, CTEs, Window Functions (`RANK()`, `SUM() OVER()`), Date/Time functions

**Tools:** PostgreSQL

🔗 **[View Full Project →](https://github.com/FaizanRayeen/ecommerce-postgres-analysis)**

---

### 🍔 [Food Delivery Analytics](https://github.com/FaizanRayeen/food-delivery-sql-analytics)

A simulated food delivery platform (Zomato/Swiggy-style) analytics system — database design plus SQL-based business analysis across customer behavior, restaurant performance, delivery efficiency, and revenue trends.

**Key areas analyzed:**
- Customer Analysis — top spenders, order frequency, repeat purchase behavior, CLV estimation
- Restaurant Analysis — top performers by order volume & revenue, cuisine comparison
- City-Level Analysis — order distribution, high-demand regions
- Revenue Analysis — total & restaurant-wise revenue contribution
- Delivery Analysis — average delivery time, Fast/Medium/Slow classification, rating distribution
- Trend Analysis — monthly order trends, running revenue growth

**SQL concepts used:** JOINs, Aggregate Functions, CASE WHEN, Subqueries & CTEs, Window Functions (`RANK()`, `DENSE_RANK()`, `LAG()`, `OVER (PARTITION BY / ORDER BY)`)

**Tools:** PostgreSQL

🔗 **[View Full Project →](https://github.com/FaizanRayeen/food-delivery-sql-analytics)**

---

## 👤 Author

**Faizan Rayeen**
