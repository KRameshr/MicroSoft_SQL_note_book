📘 SQL Notes – Theory (DDL & Basic Concepts)

This repository contains theory notes on SQL fundamentals, mainly focusing on Data Definition Language (DDL). 
These notes help beginners understand how databases and tables are created, modified, and managed in SQL.

📌 What is SQL?
SQL (Structured Query Language) is used to store, manage, and retrieve data in relational databases.

📌 What is DDL?
DDL stands for Data Definition Language.
It is used to define or modify the structure of database objects like databases, tables, and columns.

Common DDL commands include:
Create, Alter, Drop, Truncate, Rename

📘 Create Database
 Used to create a new database in SQL.
 

📘 Drop Database 
Permanently deletes an entire database and all its objects.

📘 Create Table
Used to create a new table with defined columns and data types.

📘 Select Statement
Used to retrieve all or specific data from a table.

📘 Add Column
Allows adding a new column to an existing table without deleting data.

📘 Drop Column
Allows removing a column from a table
Data stored in that column will be permanently deleted.

📘 Modify Column Datatype
Used to change the datatype or size of an existing column.

📘 Rename Table
Used to change the name of a table without affecting its data.

📘 Rename Column
Used to change a column's name inside a table.

📘 Truncate Table
Removes all rows from a table but keeps the table structure.
It is faster than deleting row by row.

📘 Drop Table
Permanently deletes a table and all its data.
This cannot be undone.

📘 Insert Data
Used to add new records (rows) into a table.
Values must match the number and order of table columns.

📘 Incorrect Insert Example
If the number of values does not match the number of columns, SQL will return an error.

📘 Insert Using Specific Columns
SQL allows inserting data into selected columns if all required fields are provided.

