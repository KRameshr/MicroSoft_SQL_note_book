

select * from Emp_details

SQL Server, when you create a Primary Key, by default it creates a clustered index on that column—if no clustered index already exists on the table.

Here’s a breakdown:

 Primary Key:
    Ensures uniqueness for the column(s).
    Does not allow NULLs.
 Clustered Index:
    Determines the physical order of rows in the table.
    Only one clustered index per table.
 Behavior:
    If you create a Primary Key and the table doesn’t have a clustered index, SQL Server creates a clustered index by default.
    If a clustered index already exists, the primary key will create a non-clustered index instead.

Example:
    CREATE TABLE Emp_details (
        EmpID INT PRIMARY KEY,  -- This creates a clustered index by default
        EmpName VARCHAR(100)
    );

----------------------------------------------------------------------------
indexes

Indexes are not just for faster queries — they directly impact how databases scale in real systems.

What an Index does:

    Speeds up SELECT queries
    Reduces full table scans
    Improves search, filtering, and sorting


    
create INDEX idx_EmpSalary ON Emp_details(Salary)
Exec sp_helpindex Emp_details  ---check the index
Select * from Emp_details Where Salary >500000


Important types in SQL Server:

Clustered Index

A Clustered Index determines the physical order of data in a table.
    Physically sorts data in the table
    Only one per table
    Created by default with a PRIMARY KEY


CREATE TABLE Emp_details (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary INT
);

Here, EmpID is the PRIMARY KEY, so SQL Server creates a Clustered Index on EmpID.
----------------
Non-Clustered Index
A Non-Clustered Index is a separate structure that stores index keys and a pointer to the actual table data.
      Does NOT change table order
      You can create multiple non-clustered indexes on a table


        CREATE NONCLUSTERED INDEX idx_salary
        ON Emp_details(Salary);

 This creates an index on Salary, but table order remains based on EmpID.

Real-world tradeoff:

    Indexes improve read performance
    But too many indexes can slow down INSERT / UPDATE / DELETE
    Indexing is always about balance, not quantity.

-------
Composite Index (Multi-Column Index)
A Composite Index is an index created on two or more columns of a table.

Improves performance when queries filter or sort using multiple columns together
Can be Clustered or Non-Clustered
Order of columns matters

Why Composite Index?

    Used when queries commonly include:
    WHERE column1 AND column2
    ORDER BY column1, column2
    Combination of filtering + sorting

----------------------------------------------------------------------------

coorelated subquery 
is  a subquery that refers to a column that is not in its from clause

sy
select col1,col2,..... from table1 as ourter where col1 operator(
select col1,col2,..... from table2 Where exp1= outer.exp2)

select avg(Salary) from Emp_details

select * from Emp_details where
Salary >(select avg(Salary) from Emp_details) 
------------------
exists

EXISTS is a subquery operator used to check whether a subquery returns any rows.

    Returns TRUE if the subquery returns at least one row
    Returns FALSE if the subquery returns no rows
    Commonly used with correlated subqueries

Why use EXISTS?

    Faster than IN for large datasets
    Stops searching as soon as a match is found

select * from Emp_details where
exists (select avg(Salary) from Emp_details) 


NOT EXISTS in SQL

NOT EXISTS is used to find records in the main table that do NOT have matching rows in a subquery.
    Returns TRUE when the subquery returns no rows
    Commonly used to find missing relationships
    Safer and more efficient than NOT IN, especially with NULL value

select * from Emp_details where
not exists (select avg(Salary) from Emp_details) 

------
VIEW

A VIEW is a virtual table created using a SELECT query.

        It does not store data physically
        It stores only the query definition
        Data is fetched from base tables each time the view is used

     🔹 Why use a VIEW?

        ✅ Simplifies complex queries
        ✅ Improves security (hide sensitive columns)
        ✅ Provides reusable SQL logic
        ✅ Makes queries easier to read & maintain

CREATE VIEW vw_EmployeeBasic
AS
SELECT EmpID, FirstName, LastName, DeptID
FROM Emp_details;

SELECT * FROM vw_EmployeeBasic;

drop view vw_EmployeeBasic
