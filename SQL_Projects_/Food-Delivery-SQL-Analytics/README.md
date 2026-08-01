# Food Delivery Analytics Project (PostgreSQL)

## Project Overview
This project is a food delivery analytics system built using PostgreSQL.  
It simulates a real-world platform similar to Zomato/Swiggy and focuses on data modeling and SQL-based business analysis.

The objective is to analyze customer behavior, restaurant performance, delivery efficiency, and revenue trends using structured SQL queries.

---

## Database Design

The system is built using a relational schema consisting of five core tables:

- **customers**: Stores customer information such as customer_id, name, and city  
- **restaurants**: Stores restaurant details including cuisine type and location  
- **orders**: Contains order-level information including customer_id, restaurant_id, order_date, and status  
- **order_items**: Stores item-level order details including price and quantity  
- **deliveries**: Stores delivery performance data including delivery_time and rating  

---

## Dataset Summary

- Customers: 100 records  
- Restaurants: 50 records  
- Orders: 200 records  
- Order Items: 400 records  
- Deliveries: 200 records  

---

## Key Analysis Performed

### Customer Analysis
- Identification of top customers based on total spending  
- Analysis of order frequency and purchasing behavior  

### Restaurant Analysis
- Top-performing restaurants based on order volume and revenue  
- Performance comparison across different cuisines  

### City-Level Analysis
- Order distribution across cities  
- Identification of high-demand geographic regions  

### Revenue Analysis
- Total revenue calculation  
- Restaurant-wise revenue contribution analysis  
- Identification of top revenue-generating restaurants  

### Delivery Analysis
- Average delivery time computation  
- Classification of deliveries into Fast, Medium, and Slow categories  
- Analysis of customer ratings distribution  

### Customer Behavior Analysis
- Repeat purchase behavior using window functions  
- Customer Lifetime Value (CLV) estimation  

### Trend Analysis
- Monthly order trends  
- Running revenue growth using window functions  

---

## SQL Concepts Used

- Basic SQL: SELECT, WHERE, ORDER BY, GROUP BY  
- Joins: INNER JOIN across multiple tables  
- Aggregate Functions: SUM, COUNT, AVG  
- Conditional Logic: CASE WHEN  
- Subqueries and Common Table Expressions (CTEs)  
- Window Functions:
  - RANK()  
  - DENSE_RANK()  
  - LAG()  
  - OVER (PARTITION BY / ORDER BY)  

---

## Key Learnings

- Designed and implemented a relational database schema from scratch  
- Generated structured datasets for analytics use cases  
- Applied SQL for real-world business problem-solving  
- Used advanced SQL techniques for analytical insights  
- Transformed raw transactional data into meaningful KPIs  

---

## Tools Used

- PostgreSQL  

---

## Project Outcome

- Developed an end-to-end SQL analytics project  
- Simulated a real-world food delivery platform  
- Demonstrated strong SQL, data modeling, and analytical skills  
- Built a portfolio-ready project suitable for data analyst roles  
