

Data vs Information

Data = raw values (rows & facts)

Information = meaningful processed data

SSMS & SQL Server

✔ SSMS → SQL Server Management Studio (Frontend UI)
✔ SQL Server → Database backend
✔ SQL → Structured Query Language


----------------------------------------------


 LIKE (pattern search)
SELECT Emp_ID,Emp_Name 
FROM Employe_detail 
WHERE Emp_Name LIKE 'G%'


CREATE TABLE Employe_detail (
 Emp_ID INT,
 Emp_Name VARCHAR(100),
 Emp_City VARCHAR(100),
 Emp_Team VARCHAR(30),
 Joining_Date DATE,
 Emp_Salary INT
)

Insert (correct spelling)
INSERT INTO Employe_detail VALUES
(4545,'Ramesh','Delhi','Technical','2022-05-23',80000),
(4546,'Dinesh','Bangalore','Analysis','2020-01-23',90000),
(4547,'Vikas','Chennai','Development','2021-05-08',100000),
(4548,'Rupesh','Mumbai','HR','2022-06-23',60000),
(4549,'Ganesh','Noida','Sales','2022-07-09',70000)



----------------------------------------------
Aggregate Functions
Count
SELECT COUNT(*) AS TotalEmployees FROM Employe_detail

Sum
SELECT SUM(Emp_Salary) FROM Employe_detail

Average
SELECT AVG(Emp_Salary) FROM Employe_detail

Minimum
SELECT MIN(Emp_Salary) FROM Employe_detail

Maximum
SELECT MAX(Emp_Salary) FROM Employe_detail

Second Highest Salary ✔ Corrected
with nested quary

SELECT MAX(Emp_Salary)
FROM Employe_detail
WHERE Emp_Salary < (SELECT MAX(Emp_Salary) FROM Employe_detail);

----------------------------------------------
https://www.databasestar.com/sql-cheat-sheet/


----------------------------------------------
operators

And 
this operator is used to combine two or more filter condition and 
it returns data if both the conditions satisfy.

SELECT Emp_ID,Emp_Name 
FROM Employe_detail 
WHERE Emp_Team='HR' AND Emp_City='Delhi'

Or 
this operator is used to combine two or more filter conditions and 
it returns data if one of condition is satisfy.

WHERE, CREATE, TABLE, etc. are keywords
 OR & IN → Same Column
Used when conditions belong to the same column

SELECT Emp_ID,Emp_Name 
FROM Employe_detail 
WHERE Emp_Team = 'HR' OR Emp_Team = 'Sales'

SELECT Emp_ID,Emp_Name 
FROM Employe_detail 
WHERE Emp_Team IN ('HR','Sales')
 

not
this operator is used to combine two or more filter conditions and 
it returns not satisfy condition.

SELECT * FROM Employe_detail 
WHERE NOT Emp_Salary > 60000

SELECT * FROM Employe_detail 

union
union are used to combine the result set of two or more select statement


data types and Columns, should be same both in table_one and table_two

SELECT Emp_City ,Emp_Salary FROM Employe_detail 
where NOT Emp_Salary > 60000
union
SELECT Emp_City, Emp_Salary FROM Employe_detail 
WHERE  Emp_Salary > 60000


 union all
 union all are used to combine the result duplicates set of two or more select statement

SELECT * FROM Employe_detail 
union all
SELECT * FROM Employe_detail 
WHERE  Emp_Salary > 60000


intersect 
 intersect all are used to combine  set of two or more select statement the result  comman records 

SELECT * FROM Employe_detail 
intersect
SELECT * FROM Employe_detail 
WHERE  Emp_Salary > 60000
intersect
SELECT * FROM Employe_detail 
WHERE  Emp_Team = 'Technical'

-- Except 
-- return uncommon records oppositive of intersect

SELECT * FROM Employe_detail 
WHERE  Emp_Salary > 60000
Except
SELECT * FROM Employe_detail 
WHERE  Emp_Team = 'Technical'


----------------------------------------------

-- character with ending S

--with initial letter 
SELECT * FROM Employe_detail 
WHERE  Emp_Name like 'v%'
go
--- with end letter 
SELECT * FROM Employe_detail 
WHERE  Emp_Name like '%h'
--- with middle letter 
SELECT * FROM Employe_detail 
WHERE  Emp_Name like '%a%'

--- with bouble letter 
SELECT * FROM Employe_detail 
WHERE  Emp_Team like '%a%a%'

--- position of letter
SELECT * FROM Employe_detail 
WHERE  Emp_Team like '__a%'

SELECT * FROM Employe_detail 
WHERE  Emp_Name like 'D__%' 

SELECT * FROM Employe_detail 
WHERE  Emp_Name like 'D%h' 


----------------------------------------------
-- Between range of data

SELECT * FROM Employe_detail 
WHERE  Emp_Salary between 60000 and 80000
SELECT * FROM Employe_detail 
WHERE Emp_Salary between 50000 and 60000

where is flilter data based on condition 
SELECT * FROM Employe_detail 
WHERE Emp_Salary between 50000 and 60000


----------------------------------------------
Group by is used to get an aggregate result with respect to a ground 
 
SELECT Emp_ID, Sum(Emp_Salary)  as total_Salary FROM Employe_detail 
group by Emp_ID

wrong statement
SELECT Emp_ID,Emp_name, Sum(Emp_Salary)  as total_Salary FROM Employe_detail 
group by Emp_ID

here the Emp_ID,Emp_name is non aggregate non aggreate should be part of group 
here  Sum(Emp_Salary) is  aggregate 
non aggreate should be part of group by

SELECT Emp_ID,Emp_name, Sum(Emp_Salary)  as total_Salary FROM Employe_detail 
group by Emp_ID,Emp_name

Order by

Select * from Employe_detail
order by Emp_Salary  -- default it is a Accending order ASC

Select * from Employe_detail
order by Emp_Salary  Desc

Select * from Employe_detail
order by Emp_Name Desc, Emp_Salary Asc

----------------------------------------------
-- where clause use by filter  data the table level
-- Having clause use by filter  data the group level
-- where clause used select update, delete,
-- Having used in only select statement 
-- where clause use by filter  data the row wise
-- having clause use by filter  data the Column wise

----------------------------------------------
 
select Emp_ID , Sum(Emp_Salary) from Employe_detail
group by  Emp_ID having Sum(Emp_Salary) > 80000

 order by

select Emp_ID ,Emp_Salary ,Sum(Emp_Salary) from Employe_detail
group by  Emp_ID ,Emp_Salary having Sum(Emp_Salary) > 80000 
order by Emp_Salary desc  

-- order of execution in sql for clauses

 -- from  table are joined to get the data
 -- where  the base(table) data is filtered
 -- group by  the table data is grouped
 -- having  the grouped data is filtered
 -- select  the final data is returned
 -- order by  the final data is sorted
 -- Limit/ top  
 
----------------------------------------------
 temporary table

CREATE TABLE #Employe_detail (
 Emp_ID INT,
 Emp_Name VARCHAR(100),
 Emp_City VARCHAR(100),
 Emp_Team VARCHAR(30),
 Joining_Date DATE,
 Emp_Salary INT
)

Insert (correct spelling)

INSERT INTO #Employe_detail VALUES
(4545,'Ramesh','Delhi','Technical','2022-05-23',80000),
(4546,'Dinesh','Bangalore','Analysis','2020-01-23',90000),
(4547,'Vikas','Chennai','Development','2021-05-08',100000),
(4548,'Rupesh','Mumbai','HR','2022-06-23',60000),
(4549,'Ganesh','Noida','Sales','2022-07-09',70000)

select * from #Employe_detail --tempo
select * from Employe_detail