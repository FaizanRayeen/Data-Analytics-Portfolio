# E-Commerce Sales Analytics – SQL Project

## Project Overview
This project demonstrates end-to-end SQL-based analysis of an e-commerce dataset.  
The objective is to extract actionable business insights from transactional data using structured SQL queries.

The analysis covers customer behavior, product performance, revenue trends, and payment analytics to support data-driven decision making.

---

## Data Model Overview

The database consists of the following relational tables:

- **customers** – Customer profile information
- **products** – Product catalog with category and pricing
- **orders** – Order-level transactional data
- **order_items** – Line-item details for each order
- **payments** – Payment method and transaction status

---

## Key Analytical Areas

### 1. Customer Analytics
- Total customers in the system
- Repeat customer identification
- First and last purchase tracking
- Customers with no purchase activity

---

### 2. Product Performance Analysis
- Total products available in catalog
- Best-selling products based on quantity sold
- Top-performing product per category
- Category-level sales distribution

---

### 3. Revenue Analytics
- Total revenue generated
- Category-wise revenue contribution
- City-wise revenue performance
- High-value orders identification

---

### 4. Order Analytics
- Total orders placed in the system
- Order status distribution (Completed, Pending, Cancelled, etc.)
- Monthly revenue trend analysis
- Average order value calculation

---

### 5. Payment Analytics
- Payment method usage distribution
- Payment status breakdown (Success / Failed / Pending)

---

### 6. Advanced Analytics
- Running total revenue using window functions
- Product ranking within categories
- Time-based revenue trend analysis
- Contribution analysis of products/categories

---

## SQL Concepts Applied

This project demonstrates practical usage of:

- Aggregate Functions: `SUM()`, `COUNT()`, `AVG()`
- Joins: INNER JOIN, LEFT JOIN
- Grouping & Filtering: `GROUP BY`, `HAVING`
- Subqueries & Derived Tables
- Common Table Expressions (CTEs)
- Window Functions:
  - `RANK()`
  - `SUM() OVER()`
- Date & Time Functions

---

## Business Insights Derived

- Identification of top-performing products and categories
- Revenue contribution analysis across segments
- Customer purchasing behavior patterns
- Monthly sales performance trends
- High-value customer segmentation
- Operational insights from order status distribution

---

## Project Objective

To simulate real-world business intelligence reporting using SQL by transforming raw transactional data into structured insights for decision-making.

---

## Tools & Environment

- PostgreSQL / SQL
- Relational Database Design
- Analytical Query Development
