# Sales Business Analytics Case Study (SQL Server)

## Problem Statement
As a Database Administrator, the goal of this case study is to analyze customer sales data
to derive meaningful business insights related to sales, profit, marketing spend,
COGS (Cost of Goods Sold), inventory, and budget performance across different states and products.

The insights help identify:
- High-performing products
- State-wise sales and profit trends
- Marketing effectiveness
- Budget vs actual performance

Due to data privacy constraints, a sample dataset is provided, but it is sufficient to
write fully functional and production-level SQL queries.

---

## Dataset Overview

### 1. FactTable (4200 rows)
Columns:
- Date
- ProductID
- Profit
- Sales
- Margin
- COGS
- Total Expenses
- Marketing
- Inventory
- Budget Profit
- Budget COGS
- Budget Margin
- Budget Sales
- Area Code

### 2. ProductTable (13 rows)
Columns:
- ProductID
- Product
- Product Type
- Type

### 3. LocationTable (156 rows)
Columns:
- Area Code
- State
- Market
- Market Size

---

## Key Business Questions Solved
- State-wise sales and profit analysis
- Product performance evaluation
- Marketing spend analysis
- Budget vs actual comparisons
- Inventory and expense analysis
- Ranking products by sales
- Weekly and daily sales trends
- Profit/Loss classification using business rules

---

## SQL Concepts Used
- SELECT, WHERE, ORDER BY
- Aggregate functions (SUM, AVG, MIN, MAX)
- GROUP BY, HAVING
- JOINS
- Subqueries
- CASE statements
- RANK() and Window Functions
- ROLLUP & CUBE
- Stored Procedures
- User Defined Functions (UDF)
- UNION & INTERSECT
- Transactions (COMMIT / ROLLBACK)

---

## Tools & Technologies
- SQL Server
- SQL Server Management Studio (SSMS)

---

## Author
**K Ramesh**

Learning SQL through real-world business case studies and building strong fundamentals
for Backend and Data-driven roles.

