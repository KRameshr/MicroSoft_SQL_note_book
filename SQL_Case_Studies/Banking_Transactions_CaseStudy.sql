	
	
	Problem Statement:

/*
			You are the database developer of an international bank. You are responsible for
			managing the bank’s database. You want to use the data to answer a few
			questions about your customers regarding withdrawal, deposit and so on,
			especially about the transaction amount on a particular date across various
			regions of the world. Perform SQL queries to get the key insights of a customer. 
*/

			Dataset:
			The 3 key datasets for this case study are:
/*

			a. Continent: The Continent table has two attributes i.e., region_id and
			region_name, where region_name consists of different continents such as
			Asia, Europe, Africa etc., assigned with the unique region id.
*/
				CREATE TABLE Continent (
					region_id   INT PRIMARY KEY,
					region_name VARCHAR(50) NOT NULL UNIQUE
				);

				INSERT INTO Continent (region_id, region_name) VALUES
				(1, 'Asia'),
				(2, 'Europe'),
				(3, 'Africa'),
				(4, 'North America'),
				(5, 'South America'),
				(6, 'Australia'),
				(7, 'Antarctica');

				SELECT * FROM Continent


/*
			b. Customers: The Customers table has four attributes named customer_id,
			region_id, start_date and end_date which consists of 3500 records.
*/

				CREATE TABLE Customers (
					customer_id INT PRIMARY KEY,
					region_id   INT NOT NULL,
					start_date  DATE NOT NULL,
					end_date    DATE,
    
					CONSTRAINT fk_customers_region
						FOREIGN KEY (region_id)
						REFERENCES Continent(region_id)
				);


				INSERT INTO Customers (customer_id, region_id, start_date, end_date) VALUES
				(1001, 1, '2021-01-15', NULL),
				(1002, 2, '2020-06-10', '2023-05-30'),
				(1003, 3, '2022-03-01', NULL),
				(1004, 1, '2019-09-20', '2022-12-31');
				----- UP TO 3500 RECODES
				 
				 oR

				;WITH RowGenerator AS (
					SELECT 1 AS n
					UNION ALL
					SELECT n + 1
					FROM RowGenerator
					WHERE n < 3500
				)
				INSERT INTO Customers (customer_id, region_id, start_date, end_date)
				SELECT
					n AS customer_id,
					((n - 1) % 7) + 1 AS region_id,
					-- 1. Generate a random Start Date within the last 2 years
					DATEADD(DAY, -(ABS(CHECKSUM(NEWID()) % 730)), GETDATE()) AS start_date,
					-- 2. Generate an End Date that is 1 to 30 days AFTER the start date
					DATEADD(DAY, (ABS(CHECKSUM(NEWID()) % 30)) + 1, 
						DATEADD(DAY, -(ABS(CHECKSUM(NEWID()) % 730)), GETDATE())
					) AS end_date
				FROM RowGenerator
				OPTION (MAXRECURSION 0);


				SELECT COUNT(*) AS TotalCustomers FROM Customers;
                SELECT  * FROM Customers;


/*
			c. Transaction: Finally, the Transaction table contains around 5850 records
			and has four attributes named customer_id, txn_date, txn_type and
			txn_amount.  
			
*/
				CREATE TABLE [Transaction] (
					txn_id INT IDENTITY(1,1) PRIMARY KEY,
					customer_id INT NOT NULL,
					txn_date DATE NOT NULL,
					txn_type VARCHAR(50) NOT NULL,
					txn_amount DECIMAL(10,2) NOT NULL,
					CONSTRAINT FK_Transaction_Customers FOREIGN KEY (customer_id)
					REFERENCES Customers(customer_id)
				);

				;WITH Numbers AS (
					SELECT TOP 5850 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
					FROM  sys.all_objects a CROSS JOIN sys.all_objects b -- Cross join to ensure we have enough rows
				)
				INSERT INTO [Transaction] (customer_id, txn_date, txn_type, txn_amount)
				SELECT 
					-- More efficient random customer selection
					(ABS(CHECKSUM(NEWID())) % 3500) + 1, 
    
					-- Random date in 2025
					DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 365, '2025-01-01'),
    
					-- Random transaction type
					CASE ABS(CHECKSUM(NEWID())) % 3 
						WHEN 0 THEN 'Purchase'
						WHEN 1 THEN 'Refund'
						ELSE 'Recharge'
					END,
    
					-- Random amount
				CAST((ABS(CHECKSUM(NEWID())) % 990000 + 10000) / 100.0 AS DECIMAL(10,2))
				FROM Numbers;

              select * from [Transaction]


-- 1. Display the count of customers in each region who have done the transaction in the year 2025.





				select count(distinct c.customer_id)  as customer_count ,c.region_id 
				From Customers c
				join  [Transaction] t
				on c.customer_id = t.customer_id
				where year(t.txn_date) = 2025
				group by c.region_id
				order by  count(distinct c.customer_id) desc






-- 2. Display the maximum and minimum transaction amount of each transaction type.

			select txn_type, max(txn_amount) as max_tra_Amount ,min(txn_amount) as min_tra_Amount  
			from [Transaction] 
			group by txn_type
			order by txn_type


-- 3. Display the customer id, region name and transaction amount where transaction type is Purchase and transaction amount > 2000.



				select c.customer_id,
				ct.region_name,
				t.txn_amount
				from Customers c
				inner join Continent ct on c.region_id = ct.region_id 
				inner join [Transaction]  t on c.customer_id = t.customer_id
				where t.txn_type = 'Purchase' 
				and  t.txn_amount > 2000 
				order by txn_amount desc



-- 4. Find duplicate records in the Customer and [Transaction] table .

				select customer_id ,region_id,start_date,end_date ,count(*) as duplicate_count 
				from Customers
				group by customer_id,region_id,start_date,end_date  
				having count(*) > 1


				SELECT * FROM [Transaction]
				WHERE customer_id IN (
					SELECT customer_id
					FROM [Transaction]
					GROUP BY customer_id
					HAVING COUNT(*) > 1
				)
				ORDER BY customer_id;


-- 5. Display the customer id, region name, transaction type and transaction amount for the minimum transaction amount in Recharge.

			SELECT C.customer_id ,CT.region_name, T.txn_type,T.txn_amount
			FROM Customers C
			INNER JOIN [Transaction] T 
			ON C.customer_id = T.customer_id
			INNER JOIN Continent CT
			ON C.region_id = CT.region_id 
			WHERE t.txn_type = 'Recharge'
			AND txn_amount = (
			 select min(txn_amount) from [Transaction]
			 where txn_type = 'Recharge'
			)
 





--- 6. Create a stored procedure to display details of customers in the Transaction table where the transaction date is greater than Jun 2020.

		create procedure usp_GetCustomersAfterJune2020
		as
		begin 
		 select c.customer_id,
		 t.txn_amount,
		 t.txn_date,
		 t.txn_type
		 from Customers c
		 inner join [Transaction] t
		 on t.customer_id = c.customer_id
		 inner join Continent ct
		  on c.region_id = ct.region_id 
		  where t.txn_date > '2020-06-30'
		  order by t.txn_date;
		end

		EXEC usp_GetCustomersAfterJune2020;


--7. Create a stored procedure to insert a record in the Continent table.

		create procedure usp_InsertContinent 
		@region_id INT,
		@region_name VARCHAR(100)
		as
		begin
		 insert into Continent  values (@region_id ,@region_name )
		end


		exec usp_InsertContinent
		@region_id = 8,
		@region_name = 'united State America'

		 select * from Continent
		  order by region_id 



-- 8. Create a stored procedure to display the details of transactions that happened on a specific day.



		CREATE PROCEDURE usp_GetTransactionsByDate
			@TxnDate DATE
		AS
		BEGIN
			SELECT 
				t.txn_date,
				t.txn_type,
				t.txn_amount
			FROM [Transaction] t
			WHERE t.txn_date = @TxnDate
			ORDER BY t.txn_amount DESC;
		END;


		exec usp_GetTransactionsByDate  @TxnDate ='2025-07-15'
		exec usp_GetTransactionsByDate  '2025-07-15'

-- 9. Create a user defined function to add 10% of the transaction amount in a table.

		create function dbo.fn_AddTenPercent
		(
		 @txnamount decimal(10,2)
		)
		returns decimal(10,2)
		as
		begin
		 return @txnamount + (@txnamount* 0.10)
		end


		SELECT 
			txn_amount,
			dbo.fn_AddTenPercent(txn_amount) AS amount_with_10_percent
		FROM [Transaction];


--10. Create a user defined function to find the total transaction amount for a given transaction type.

		CREATE FUNCTION dbo.fn_TotalAmountByTxnType
		(
			@TxnType VARCHAR(20)
		)
		RETURNS DECIMAL(18,2)
		AS
		BEGIN
			DECLARE @TotalAmount DECIMAL(18,2);

			SELECT 
				@TotalAmount = SUM(txn_amount)
			FROM [Transaction]
			WHERE txn_type = @TxnType;
			RETURN ISNULL(@TotalAmount, 0);
		END;
		Go

		SELECT dbo.fn_TotalAmountByTxnType('Recharge') AS Total_Deposit_Amount;



-- 11. Create a table value function which comprises the columns customer_id, region_id ,txn_date , txn_type , txn_amount which will retrieve data from the above table.

		CREATE FUNCTION dbo.fn_GetTransactionDetails()
		RETURNS TABLE
		AS
		RETURN
		(
			SELECT 
				c.customer_id,
				c.region_id,
				t.txn_date,
				t.txn_type,
				t.txn_amount
			FROM Customers c
			INNER JOIN [Transaction] t
				ON c.customer_id = t.customer_id
		);
		GO

		SELECT * FROM dbo.fn_GetTransactionDetails();


--12. Create a TRY...CATCH block to print a region id and region name in a single column.

		BEGIN TRY
		 SELECT  CONCAT(region_id ,' - ',region_name) AS  Region_Details
		 FROM Continent
		END TRY
		BEGIN CATCH
		 PRINT 'Error Message:  ' + ERROR_MESSAGE()
		END CATCH


--13. Create a TRY...CATCH block to insert a value in the Continent table.


		BEGIN TRY
		 INSERT INTO Continent VALUES(9,'Asia Pacific')
		 PRINT 'Record inserted successfully.'
		END TRY
		BEGIN CATCH
		 PRINT 'Error Message:  ' + ERROR_MESSAGE()
		END CATCH


--14. Create a trigger to prevent deleting a table in a database.

		CREATE TRIGGER trg_PreventDropTable
		ON DATABASE
		FOR DROP_TABLE
		AS
		BEGIN
			PRINT 'Dropping tables is not allowed in this database.';
			ROLLBACK;
		END;
		GO

--15. Create a trigger to audit the data in a table.

			CREATE TABLE Customers_Audit
			(
				audit_id     INT IDENTITY(1,1) PRIMARY KEY,
				customer_id  INT,
				action_type  VARCHAR(10),
				old_region_id INT,
				new_region_id INT,
				changed_by   SYSNAME,
				changed_on   DATETIME DEFAULT GETDATE()
			);

			CREATE TRIGGER trg_Customers_Audit
			ON Customers
			AFTER INSERT, UPDATE, DELETE
			AS
			BEGIN
				SET NOCOUNT ON;

				-- INSERT
				INSERT INTO Customers_Audit
				(customer_id, action_type, new_region_id, changed_by)
				SELECT 
					i.customer_id,
					'INSERT',
					i.region_id,
					SYSTEM_USER
				FROM inserted i
				WHERE NOT EXISTS (SELECT 1 FROM deleted);

				-- DELETE
				INSERT INTO Customers_Audit
				(customer_id, action_type, old_region_id, changed_by)
				SELECT 
					d.customer_id,
					'DELETE',
					d.region_id,
					SYSTEM_USER
				FROM deleted d
				WHERE NOT EXISTS (SELECT 1 FROM inserted);

				-- UPDATE
				INSERT INTO Customers_Audit
				(customer_id, action_type, old_region_id, new_region_id, changed_by)
				SELECT 
					i.customer_id,
					'UPDATE',
					d.region_id,
					i.region_id,
					SYSTEM_USER
				FROM inserted i
				JOIN deleted d
					ON i.customer_id = d.customer_id;
			END;
			GO

			UPDATE Customers
			SET region_id = 2
			WHERE customer_id = 101;

			SELECT * FROM Customers_Audit;




--16. Create a trigger to prevent login of the same user id in multiple pages.

				CREATE TABLE User_Login_Audit
				(
					login_name SYSNAME,
					session_id INT,
					login_time DATETIME DEFAULT GETDATE()
				);

				CREATE TRIGGER trg_PreventMultipleLogin
				ON ALL SERVER
				FOR LOGON
				AS
				BEGIN
					DECLARE @LoginName SYSNAME;
					DECLARE @SessionID INT;

					SET @LoginName = ORIGINAL_LOGIN();
					SET @SessionID = @@SPID;

					-- Check if user already has an active session
					IF EXISTS (
						SELECT 1
						FROM User_Login_Audit
						WHERE login_name = @LoginName
					)
					BEGIN
						ROLLBACK;
					END
					ELSE
					BEGIN
						INSERT INTO User_Login_Audit (login_name, session_id)
						VALUES (@LoginName, @SessionID);
					END
				END;
				GO

--17. Display top n customers on the basis of transaction type.

			SELECT TOP 3
				customer_id,
				txn_type,
				SUM(txn_amount) AS total_amount
			FROM [Transaction]
			GROUP BY customer_id, txn_type
			ORDER BY total_amount DESC;

--18. Create a pivot table to display the total purchase, withdrawal and deposit for all the customers.


			SELECT 
				customer_id,
				ISNULL([Purchase], 0) AS Total_Purchase,
				ISNULL([Withdrawal], 0) AS Total_Withdrawal,
				ISNULL([Deposit], 0) AS Total_Deposit
			FROM
			(
				SELECT 
					customer_id,
					txn_type,
					txn_amount
				FROM [Transaction]
			) AS SourceTable
			PIVOT
			(
				SUM(txn_amount)
				FOR txn_type IN ([Purchase], [Withdrawal], [Deposit])
			) AS PivotTable
			ORDER BY customer_id;


