
Stored Procedure

      A Stored Procedure is a precompiled set of SQL statements that can be saved, reused, and executed multiple times.

      Why use Stored Procedures?
	  Improves performance (precompiled execution plan)
	  Reusable SQL logic
	  Enhances security (limit direct table access)
	  Easier maintenance & consistency



	    USE intellipaat;
		GO

		CREATE PROCEDURE GetEmpDetails
		AS
		BEGIN
			SELECT FirstName, LastName, Salary
			FROM Emp_details;
		END;


		USE [intellipaat];
		GO

		ALTER PROCEDURE GetEmpDetails
		AS
		BEGIN
			SELECT FirstName, LastName, Salary
			FROM Emp_details
			WHERE EmpID NOT IN (
				SELECT EmpID
				FROM Emp_details
				WHERE Salary > 600000
			);
		END;

		exec GetEmpDetails
		drop procedure GetEmpDetails

--- Equivalent Normal Query (Without Stored Procedure)
  SELECT FirstName, LastName, Salary FROM Emp_details;

  Stored Procedures are preferred in enterprise systems because they reduce network traffic, improve security, and ensure consistent business logic across applications.
----------------------------------------


Transactions in SQL (TCL – Transaction Control Language)

A Transaction is a logical unit of work that consists of one or more database operations executed together.
If any operation fails, the entire transaction can be rolled back to maintain data integrity.

Acid propeties -Atomicity , Consistency ,Isolation, Durability
	Atomicity - Either all the transactions should be complete successfully or failed
	Consistency - A transaction brings the database from one state to another state consistency
	Isolation - The ensure the intermediate state of the transaction is not visible to 
	other transaction until it is committed. it also prevents conflicts and ensures
	concurrent operations
	durability: Changes are permanent
	--------------------------------
	
	Command	Description
	BEGIN TRANSACTION	Starts a transaction
	COMMIT	Saves changes permanently
	ROLLBACK	Undoes changes
	SAVEPOINT	Creates a point to rollback partially

---started transaction

begin transaction
Update Emp_details set
Salary = Salary+5000 where EmpID = 1
rollback;

Insert Into Emp_details values(7,'Raj','Shinha',3,4,48000)
Commit;

--after commit transaction we cannot retrive the data
begin transaction;
Update Emp_details set
Salary = Salary+5000 where EmpID = 1

save transaction my_savepoint;
delete from Emp_details where EmpID=3;
update Emp_details set
Salary = Salary * 2 where EmpID=2;
rollback transaction my_savepoint;
Print 'Rollback is commited'
Commit transaction
select * from Emp_details

----------------

Exception

SQL Server provides TRY…CATCH blocks to handle runtime errors gracefully and maintain data consistency, especially when transactions are involved.
It is commonly used with transactions to ensure that failures do not leave the database in an inconsistent state.


Try/Catch Basic Syntax

	Prevents partial data updates
	Ensures failed transactions are rolled back
	Helps debug errors using system error functions
	Essential for production-grade backend systems

BEGIN TRY
    -- SQL statements
END TRY
BEGIN CATCH
    -- Error handling logic
    -- ROLLBACK transaction
    -- Print or log error
END CATCH;


Function	         Description
ERROR_MESSAGE() 	 Returns error message
ERROR_NUMBER()	    Error code
ERROR_SEVERITY()	Error severity
ERROR_STATE()	    Error state
ERROR_LINE()	    Line number where error occurred

--Example

BEGIN TRY
    BEGIN TRANSACTION;

    UPDATE Emp_details
    SET Salary = Salary + 5000
    WHERE EmpID = 1;

    -- This will cause a runtime error (divide by zero)
    UPDATE Emp_details
    SET Salary = Salary / 0
    WHERE EmpID = 2;

    COMMIT TRANSACTION;
END TRY

BEGIN CATCH
    ROLLBACK TRANSACTION;

    SELECT 
        ERROR_MESSAGE() AS ErrorMessage,
        ERROR_NUMBER() AS ErrorNumber;
END CATCH;


select * from Emp_details


TRY / CATCH with transactions is heavily used in banking systems, payment processing, order management, and backend APIs to ensure ACID compliance and fault tolerance.



------
ROLLUP & CUBE in SQL Server

ROLLUP and CUBE are extensions of the GROUP BY clause used to generate subtotal and grand total rows in aggregation queries.
They are commonly used in reporting, dashboards, and analytics.


What is ROLLUP?

ROLLUP is a subclause of GROUP BY that generates hierarchical subtotals and a grand total.

It follows the order of columns you specify.
Syntax
GROUP BY ROLLUP (column1, column2)


Important ROLLUP Rule

Column order matters!
ROLLUP (DeptId, mgrID)   -- Dept → Manager hierarchy
ROLLUP (mgrID, DeptId)   -- Manager → Dept hierarchy




Example without ROLLUP

SELECT mgrID, DeptId, SUM(Salary) AS TotalSalary
FROM Emp_details
GROUP BY DeptId, mgrID;


 Returns only detailed group totals (per Dept + Manager).

 Exampleڍ Using ROLLUP

SELECT mgrID, DeptId, SUM(Salary) AS TotalSalary
FROM Emp_details
GROUP BY ROLLUP (DeptId, mgrID);


What is CUBE?

CUBE generates all possible combinations of subtotals for the grouped columns.
Unlike ROLLUP, it does not follow hierarchy.

Syntax
GROUP BY CUBE (column1, column2)

SELECT mgrID, DeptId, SUM(Salary) AS TotalSalary
FROM Emp_details
GROUP BY CUBE (DeptId, mgrID);

Use ROLLUP when you need hierarchical totals (Department → Manager → Total).
Use CUBE when you need multi-dimensional analysis (Department-wise, Manager-wise, and combined).

----
Triggers
	A Trigger is a special type of stored procedure that automatically executes (fires) when a specific event occurs on a table or view.
	Triggers are mainly used to enforce business rules, maintain audit logs, and ensure data integrity.

	Triggers fire on DML events:

		INSERT
		UPDATE
		DELETE
syntax

create trigger triggerName on table_Name
[After/for/instead of] [insert,delete,update]
as
begin
select statemnets 
end


Types of Triggers in SQL Server

1 -- AFTER Trigger (FOR Trigger)
Executes after the DML operation completes successfully.

 AFTER INSERT, UPDATE, DELETE


2 -- INSTEAD OF Trigger

Executes instead of the DML operation.
Mostly used on views or to override default behavior.

INSTEAD OF INSERT, UPDATE, DELETE
AFTER INSERT Trigger Example

Requirement:
Log employee insert details into an audit table.

CREATE TABLE Emp_Audit (
    EmpID INT,
    Action VARCHAR(20),
    ActionDate DATETIME
);

CREATE TRIGGER trg_AfterInsert_Emp
ON Emp_details
AFTER INSERT
AS
BEGIN
    INSERT INTO Emp_Audit (EmpID, Action, ActionDate)
    SELECT EmpID, 'INSERT', GETDATE()
    FROM inserted;
END;

inserted is a virtual table that holds newly inserted rows.


-- AFTER UPDATE Trigger Example

CREATE TRIGGER trg_AfterUpdate_Emp
ON Emp_details
AFTER UPDATE
AS
BEGIN
    PRINT 'Employee record updated';
END;

AFTER DELETE Trigger Example

CREATE TRIGGER trg_AfterDelete_Emp
ON Emp_details
AFTER DELETE
AS
BEGIN
    PRINT 'Employee record deleted';
END;

deleted is a virtual table that holds deleted rows.

---
INSTEAD OF Trigger Example
Prevent DELETE from Emp_details table

CREATE TRIGGER trg_InsteadOfDelete_Emp
ON Emp_details
INSTEAD OF DELETE
AS
BEGIN
    PRINT 'Delete operation is not allowed on Emp_details table';
END;


inserted & deleted Tables (Very Important)
	Trigger Type	Virtual Table Used
	INSERT	inserted
	DELETE	deleted
	UPDATE	inserted & deleted


	select * from Emp_Audit



	------------------

	coalesce()

	COALESCE() is a NULL-handling function that returns the first non-NULL value from a list of expressions.
	Syntax

      --COALESCE(expression1, expression2, ..., expressionN)


	  SELECT COALESCE(lastName, CONCAT(DeptId, '')) AS Result FROM Emp_details;
	  select * from Emp_details
	  -----------------

	  IsNull()

	ISNULL() in SQL Server — Clear & Interview-Ready Explanation
	ISNULL() is a NULL-handling function in SQL Server.
	It replaces NULL values with a specified replacement value.

	SELECT EmpID, ISNULL(lastName, 'Unknown') AS LastName
    FROM Emp_details;

	SELECT ISNULL(lastName, CAST(DeptId AS VARCHAR(10))) AS Result
   FROM Emp_details;


   ------
   convert ()

   CONVERT() is a SQL Server function used to change one data type into another.
   It is commonly used for type safety, formatting, and avoiding runtime errors.

   SELECT Salary,CONVERT(decimal(10,2), Salary) AS Salary_Text
   FROM Emp_details;
   ------

   CTE (Common Table Expression)

   A CTE (Common Table Expression) is a temporary named result set that exists only for the duration of a single SQL statement.
   It helps make complex queries more readable, modular, and maintainable.


   --- Basic Syntax

	WITH cte_name AS (
		SELECT column1, column2
		FROM table_name
		WHERE condition
	)
	SELECT *
	FROM cte_name;


    WITH AvgSalaryCTE AS (
    SELECT AVG(Salary) AS AvgSal FROM Emp_details
	)
	SELECT *
	FROM Emp_details
	WHERE Salary > (SELECT AvgSal FROM AvgSalaryCTE);
