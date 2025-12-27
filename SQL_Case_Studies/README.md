# SQL Case Studies 

This repository contains two real-world SQL case studies demonstrating **Sales & Business Analytics** and **Banking Customer Transaction Analysis**. These projects showcase advanced SQL skills applied to practical business scenarios.

---

## Case Study 1: Sales Business Analytics

### Problem Statement
As a Database Administrator, the goal of this case study is to analyze customer sales data to derive meaningful business insights related to sales, profit, marketing spend, COGS (Cost of Goods Sold), inventory, and budget performance across different states and products.

The insights help identify:
- High-performing products
- State-wise sales and profit trends
- Marketing effectiveness
- Budget vs actual performance

Due to data privacy constraints, a sample dataset is provided, but it is sufficient to write fully functional and production-level SQL queries.

### Dataset Overview
**FactTable (4200 rows)**  
- Date, ProductID, Profit, Sales, Margin, COGS, Total Expenses, Marketing, Inventory, Budget Profit, Budget COGS, Budget Margin, Budget Sales, Area Code  

**ProductTable (13 rows)**  
- ProductID, Product, Product Type, Type  

**LocationTable (156 rows)**  
- Area Code, State, Market, Market Size  

### Key Business Questions Solved
- State-wise sales and profit analysis  
- Product performance evaluation  
- Marketing spend analysis  
- Budget vs actual comparisons  
- Inventory and expense analysis  
- Ranking products by sales  
- Weekly and daily sales trends  
- Profit/Loss classification using business rules  

### SQL Concepts Used
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

## Case Study 2: Banking Customer Transaction Analysis

### Problem Statement
As a Database Developer for an international bank, the goal is to analyze customer transactions across regions to gain insights into deposits, withdrawals, purchases, and refunds. This helps manage customer accounts and improve operational efficiency.

### Dataset Overview
**Continent Table**  
- region_id, region_name  

**Customers Table**  
- customer_id, region_id, start_date, end_date  

**Transaction Table**  
- txn_id, customer_id, txn_date, txn_type, txn_amount  

### Key Business Questions Solved
- Customer count per region per year  
- Maximum and minimum transaction amounts by type  
- Transactions above specific thresholds  
- Duplicate detection in tables  
- Total transaction amount by type  
- Pivot table summaries of transactions  
- Ranking customers by transaction amount  

### SQL Concepts Used
- Aggregations (COUNT, SUM, MAX, MIN)  
- Joins (INNER JOIN)  
- Filtering with WHERE and date functions  
- GROUP BY, PIVOT  
- Stored Procedures (data retrieval, insert)  
- User-Defined Functions (scalar & table-valued)  
- Triggers (audit, prevent multiple logins, prevent DROP TABLE)  
- Error handling with TRY…CATCH  
- Ranking and TOP queries  

---

## Tools & Technologies
- SQL Server  
- SQL Server Management Studio (SSMS)  

---
```
Folder Structure
SQL_Case_Studies/
│
├── Sales_Business_Analytics_CaseStudy.sql
├── Banking_Transactions_CaseStudy.sql
└── README.md
```
----

## Author
**K Ramesh**  

---

**Usage:** Clone this repository and run the SQL scripts in SQL Server to reproduce the analysis and insights.
