--- joints 

select * from dept_details
go
select * from Emp_details

--cross join all cartion product 
select * from dept_details cross join Emp_details 

--INNER join all the matching records
select * from dept_details as dep Inner join Emp_details as emp  on dep.DeptId = emp.DeptId

--Left join all the matching records for Left side
select * from dept_details as dep Left join Emp_details as emp  on dep.DeptId = emp.DeptId

--Right join all the matching records for right side
select * from dept_details as dep Right join Emp_details as emp  on dep.DeptId = emp.DeptId

--Full /Full outer join all the matching union  records for right side and left side
select * from dept_details as dep Full outer join Emp_details as emp  on dep.DeptId = emp.DeptId

--------------------------------------------------------------------------------
use [intellipaat] -- batabase name
go
select * from Emp_details
go 
select EmpID, count(Salary) as salary  from Emp_details
group by EmpID

SQL Server Functions & Window Functions (Notes)

Aggregate function  is widely used in industry
Aggregate functions perform calculations on multiple rows and return a single value.

Common Aggregate Functions
Function	Description
AVG()	Returns average of non-NULL values
COUNT()	Returns number of rows (includes NULL rows)
MAX()	Returns highest value
MIN()	Returns lowest value
SUM()	Returns total of non-NULL values
CHECKSUM_AGG()	Returns checksum of values
COUNT_BIG()	Same as COUNT but supports very large datasets
STDEV()	Standard deviation (sample)
STDEVP()	Standard deviation (population)
VAR()	Variance (sample)
VARP()	Variance (population)

SELECT * FROM Emp_details;

SELECT EmpID, COUNT(Salary) AS Salary_Count
FROM Emp_details
GROUP BY EmpID;

SELECT AVG(Salary) AS Avg_Salary FROM Emp_details;
SELECT SUM(Salary) AS Total_Salary FROM Emp_details;
SELECT MAX(Salary) AS Max_Salary FROM Emp_details;
SELECT MIN(Salary) AS Min_Salary FROM Emp_details;

SELECT CHECKSUM_AGG(Salary) AS Salary_Checksum
FROM Emp_details;
--------------------------------------------------------------------------------
String Functions

LEN() – Length of string
SELECT lastName, LEN(lastName) AS Name_Length
FROM Emp_details;

CONCAT() – Join strings
SELECT CONCAT(firstName,'.', lastName) AS FullName
FROM Emp_details;

Proper Case Formatting
SELECT 
    CONCAT(
        UPPER(LEFT(firstName,1)),
        LOWER(SUBSTRING(firstName,2,LEN(firstName))),
        '.',
        UPPER(LEFT(lastName,1)),
        LOWER(SUBSTRING(lastName,2,LEN(lastName)))
    ) AS FullName
FROM Emp_details;

Trimming Spaces
SELECT LTRIM('   Ramesh');
SELECT RTRIM('Ramesh   ');
SELECT TRIM('   Ramesh   ');

REPLACE()
SELECT REPLACE('Sukhpal Singh','Singh','Oberoi');

SELECT firstName, lastName,
REPLACE(firstName,'Ramesh','Tara') AS UpdatedName
FROM Emp_details;

REVERSE()
SELECT REVERSE(lastName) AS Reversed_Name
FROM Emp_details;

SELECT firstName, lastName,
REVERSE(lastName) AS Reverse_Name
FROM Emp_details
WHERE EmpID = 2;

SUBSTRING()
SELECT SUBSTRING(lastName,1,3) AS Short_Name
FROM Emp_details;

Case Conversion
SELECT UPPER('mansi jain') AS Upper_Name;
SELECT LOWER('MANSI JAIN') AS Lower_Name;

ASCII Value
SELECT ASCII('A');

🔹 Math Functions
SELECT ABS(-10);
SELECT CEILING(12.3);
SELECT FLOOR(12.9);
SELECT ROUND(12.567,2);
SELECT POWER(2,3);
SELECT SQUARE(5);

🔹 Date Functions
SELECT GETDATE();
SELECT DAY(GETDATE());
SELECT MONTH(GETDATE());
SELECT YEAR(GETDATE());

DATEADD()
SELECT DATEADD(MONTH,5,GETDATE());

DATEDIFF()
SELECT 
    DATEDIFF(MONTH, Joining_Date, GETDATE()) AS Months_Diff,
    DATEDIFF(DAY, Joining_Date, GETDATE()) AS Days_Diff,
    DATEDIFF(YEAR, Joining_Date, GETDATE()) AS Years_Diff
FROM Emp_details;

DATEPART()
SELECT DATEPART(MONTH,'2025-12-13') AS Month;
SELECT DATEPART(DAY,'2025-12-13') AS Day;

--------------------------------------------------------------------------------
Window / Analytic Functions

Window functions perform calculations without collapsing rows.

Common Window Functions


ROW_NUMBER() assigns a unique sequential number to each row in the result set.
Even if values are the same, numbering is always unique.

Example

SELECT *,
ROW_NUMBER() OVER (ORDER BY Salary) AS RowNum
FROM Emp_details;

RANK()  assigns a rank to each row.
If duplicate values exist, same rank is given, and the next rank is skipped.

Example
SELECT *,
RANK() OVER (ORDER BY Salary) AS Rank_Function
FROM Emp_details;


DENSE_RANK()

DENSE_RANK() works like RANK() but does not skip rank numbers.
Example
SELECT *,
DENSE_RANK() OVER (ORDER BY Salary) AS DenseRank_Function
FROM Emp_details;

LEAD()

LEAD() returns the value from the next row.
Example
SELECT EmpID, Salary,
LEAD(Salary) OVER (ORDER BY Salary) AS Next_Salary
FROM Emp_details;


LAG() returns the value from the previous row.

Example
SELECT EmpID, Salary,
LAG(Salary) OVER (ORDER BY Salary) AS Previous_Salary
FROM Emp_details;


NTILE(n) divides rows into n equal groups.

Example
SELECT EmpID, Salary,
NTILE(4) OVER (ORDER BY Salary ) AS Salary_Group
FROM Emp_details;


CUBE generates all possible combinations of subtotals.

Example
    SELECT Emp_Team, Emp_City, SUM(Salary) AS Total_Salary
    FROM Emp_details
    GROUP BY CUBE (Emp_Team, Emp_City);

ROLLUP generates subtotals and grand totals.

    Example
    SELECT Emp_Team, SUM(Salary) AS Total_Salary
    FROM Emp_details
    GROUP BY ROLLUP (Emp_Team);

--------------------------------------------------------------------------------
Scalar Valued Function 


A Scalar Valued Function returns a single value based on one or more input parameters.

✔ Accepts parameters
✔ Returns only one value
✔ Can be used inside SELECT, WHERE, ORDER BY, etc.

Syntax

CREATE FUNCTION function_name (@parameter datatype)
RETURNS return_datatype
AS
BEGIN
    RETURN expression
END


create function faranheit(@temperature float)
returns float as
begin
return (@temperature +5)
end

SELECT *, dbo.faranheit (Salary)as increment FROM Emp_details;
GO

drop function  dbo.faranheit

create function function_Name(parameter_name)
returns datatype
as
begin
return
end
_________________________________________

Table-Valued Function 

A Table-Valued Function returns a result set (table) instead of a single value.

✔ Returns multiple rows & columns
✔ Can be used like a table in SELECT
✔ Commonly used to filter or transform data

-- Types of Table-Valued Functions

1  Inline Table-Valued Function (Inline TVF)
2  Multi-Statement Table-Valued Function


CREATE FUNCTION function_name (@parameter datatype)
RETURNS TABLE
AS
RETURN
(
    SELECT statement
)


create function Empdept_details(@dept int)
returns table
as return
select * from Emp_details where DeptId =@dept 

select * from dbo.Empdept_details(1)

Alter function Empdept_details(@dept int,@Salary int)
returns table
as return
select EmpID,firstName,lastName ,Salary from Emp_details  join
dept_details on Emp_details.DeptId = dept_details.DeptId
where  Emp_details.DeptId =@dept and Salary > @Salary

select * from dbo.Empdept_details(1,5000)

drop function  dbo.Empdept_details
_________________________________________

What is PIVOT?

PIVOT is used to transform rows into columns, creating a summary (cross-tab) table.

-- It is mainly used for:

 Reporting
 Data analysis
 Dashboard preparation
 Converting row-based data into column format

-- Why PIVOT?

Without PIVOT → Data is row-oriented
With PIVOT → Data becomes column-oriented (easy to read & analyze)

-- PIVOT Syntax (Simplified)

SELECT column1, column2, [pivot_column],[pivot_column]
FROM source_table
PIVOT (
    aggregate_function(column_to_aggregate)
    FOR pivot_column IN ([value1], [value2], ...)
) AS pivot_table;

--- Explanation of Syntax

    column1, column2 → Columns to keep in the result
    aggregate_function() → SUM, COUNT, AVG, etc.
    column_to_aggregate → Column on which aggregation is applied
    pivot_column → Column whose values become new columns
    IN (...) → Distinct values that become columns
    pivot_table → Alias for the pivoted result

-- Sample Table
CREATE TABLE Sales (
    Product VARCHAR(10) NOT NULL,
    Region VARCHAR(10) NOT NULL,
    SalesAmount INT NOT NULL
);

Insert Data

INSERT INTO Sales VALUES ('A', 'North', 100);
INSERT INTO Sales VALUES ('A', 'South', 200);
INSERT INTO Sales VALUES ('B', 'North', 150);
INSERT INTO Sales VALUES ('B', 'South', 250);

select * from Sales

-- Data Before PIVOT
Product	  Region	SalesAmount
A	      North	    100
A	       South	200
B	       North	150
B	       South	250

-- PIVOT Example
Convert Region rows into columns

SELECT Product, [North], [South]
FROM Sales
PIVOT (
    SUM(SalesAmount)
    FOR Region IN ([North], [South])
) AS PivotResult;


select * from PivotResult

 -- Output After PIVOT

Product	   North	South
A	         100	200
B	         150	250
-------------------------


 UNPIVOT?

UNPIVOT is used to convert columns into rows.

   It is the reverse of PIVOT
   Useful when column-based data needs to be normalized into row format

Why UNPIVOT?

  Converts wide tables into long (row-based) format
  Makes data easier to analyze
  Used in reporting, analytics, and ETL processes

Syntax

SELECT column1, pivot_column, value_column
FROM source_table
UNPIVOT (
    value_column
    FOR pivot_column IN ([col1], [col2], ...)
) AS unpivot_table;


    column1 → Columns to keep unchanged
    value_column → Values moved into rows
    pivot_column → New column storing former column names
    IN (...) → Columns to unpivot
    unpivot_table → Alias for result

Example


CREATE TABLE Sales_Pivot (
    Product VARCHAR(10),
    North INT,
    South INT
);

INSERT INTO Sales_Pivot VALUES
('A', 100, 200),
('B', 150, 250);

SELECT * from Sales_Pivot
Apply UNPIVOT

SELECT Product, Region, SalesAmount
FROM Sales_Pivot
UNPIVOT (
    SalesAmount
    FOR Region IN ([North], [South])
) AS UnpivotResult;


UNPIVOT using a Subquery (No Table Creation)

SELECT Product, Region, SalesAmount
FROM (
    SELECT 'A' AS Product, 100 AS North, 200 AS South
    UNION ALL
    SELECT 'B', 150, 250
) s
UNPIVOT (
    SalesAmount
    FOR Region IN ([North], [South])
) u;


--------------------
STUFF

STUFF() is a string function in SQL Server.
It is used to delete part of a string and insert another string at a specified position.

Syntax

STUFF ( character_expression, start, length, replace_with )

Parameters
    character_expression → Original string
    start → Starting position
    length → Number of characters to remove
    replace_with → New string to insert

select Stuff( 'Hello World' ,7,12,'Universe') as modifiedString
select *,stuff( Region, 1,len(Region),'Universe') as modifiedString from Sales
---------------------------
IIF() Function 

    IIF() is a conditional (logical) function in SQL Server.
    It works like an IF–ELSE statement in a single line.

Syntax
     IIF(condition, true_value, false_value)

Parameters
    condition → Expression to evaluate
    true_value → Returned if condition is TRUE
    false_value → Returned if condition is FALSE

Simple Example
  SELECT IIF(10 > 5, 'True', 'False') AS Result;

Example with Table (Salary Check)

SELECT EmpID,Salary,firstName,lastName,
IIF(Salary >= 80000, 'High Salary', 'Low Salary') AS Salary_Status
FROM Emp_details;

Select EmpID,firstName,lastName,Salary, iiF(Salary >= 500000,'HigestSalary','LowestSalary' ) as Salary_Status from Emp_details

Select * FROM Emp_details;

Multiple Conditions (Nested IIF)

SELECT  EmpID,firstName,lastName,Salary,
IIF(Salary >= 100000, 'Very High',
    IIF(Salary >= 80000, 'High', 'Normal')
) AS Salary_Level
FROM Emp_details;

--Example (Preferred in real projects)

SELECT firstName, Salary,
CASE 
    WHEN Salary >= 100000 THEN 'Very High'
    WHEN Salary >= 80000 THEN 'High'
    ELSE 'Normal'
END AS Salary_Level
FROM Emp_details;

