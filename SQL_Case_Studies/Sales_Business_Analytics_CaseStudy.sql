

/* 

  Problem Statement:


	You are a database administrator. You want to use the data to answer afewquestions about your customers, 
	especially about the sales and profit comingfrom different states, 
	money spent in marketing and various other factorssuchasCOGS (Cost of Goods Sold), 
	budget profit etc. You plan on using theseinsightsto help find out which items are being sold the most. 
	You have beenprovidedwith the sample of the overall customer data due to privacy issues. But youhopethat 
	these samples are enough for you to write fully functioning SQLqueriestohelp answer the questions.  

	Dataset:

		The 3 key datasets for this case study:

		 a. FactTable: The Fact Table has 14 columns mentioned belowand4200rows.
			Date, ProductID, Profit, Sales, Margin, COGS, Total Expenses, Marketing,
			Inventory, Budget Profit, Budget COGS, Budget Margin, Budget Sales, and Area Code
			Note: COGS stands for Cost of Goods Sold
*/
            CREATE TABLE Fact (
            FactID INT IDENTITY(1,1) PRIMARY KEY,  -- Surrogate PK
            Date DATE NOT NULL,
            ProductID INT NOT NULL,                -- FK to ProductTable
            Area_Code INT NOT NULL,                -- FK to LocationTable
            Profit DECIMAL(10, 2),
            Sales DECIMAL(10, 2),
            Margin DECIMAL(10, 2),
            COGS DECIMAL(10, 2),
            Total_Expenses DECIMAL(10, 2),
            Marketing DECIMAL(10, 2),
            Inventory INT,
            Budget_Profit DECIMAL(10, 2),
            Budget_COGS DECIMAL(10, 2),
            Budget_Margin DECIMAL(10, 2),
            Budget_Sales DECIMAL(10, 2)
        );


        INSERT INTO Fact (
            Date, ProductID, Profit, Sales, Margin, COGS, Total_Expenses, 
            Marketing, Inventory, Budget_Profit, Budget_COGS, Budget_Margin, 
            Budget_Sales, Area_Code
        )
        VALUES 
        ('2023-01-01', 101, 150.00, 500.00, 200.00, 300.00, 50.00, 20.00, 1000, 140.00, 310.00, 190.00, 500.00, 415),
        ('2023-01-02', 102, 80.00, 300.00, 120.00, 180.00, 40.00, 15.00, 500, 90.00, 170.00, 130.00, 300.00, 212),
        ('2023-12-31', 105, 210.00, 700.00, 300.00, 400.00, 90.00, 50.00, 1200, 200.00, 410.00, 290.00, 700.00, 312);
        -- ... Repeat for additional rows 1397...

         (OR)

        ;WITH RowGenerator AS (
            SELECT 1 AS n
            UNION ALL
            SELECT n + 1
            FROM RowGenerator
            WHERE n < 1400
        )
        INSERT INTO Fact (
            Date,
            ProductID,
            Profit,
            Sales,
            Margin,
            COGS,
            Total_Expenses,
            Marketing,
            Inventory,
            Budget_Profit,
            Budget_COGS,
            Budget_Margin,
            Budget_Sales,
            Area_Code
        )
        SELECT 
            DATEADD(DAY, (n % 365), '2023-01-01') AS Date,
            100 + (n % 10)                        AS ProductID,
            ABS(CHECKSUM(NEWID()) % 100) + 50    AS Profit,
            ABS(CHECKSUM(NEWID()) % 500) + 400   AS Sales,
            ABS(CHECKSUM(NEWID()) % 200) + 100   AS Margin,
            ABS(CHECKSUM(NEWID()) % 300) + 200   AS COGS,
            ABS(CHECKSUM(NEWID()) % 50) + 20     AS Total_Expenses,
            ABS(CHECKSUM(NEWID()) % 30) + 10     AS Marketing,
            ABS(CHECKSUM(NEWID()) % 1000) + 100  AS Inventory,
            ABS(CHECKSUM(NEWID()) % 100) + 45    AS Budget_Profit,
            ABS(CHECKSUM(NEWID()) % 300) + 190   AS Budget_COGS,
            ABS(CHECKSUM(NEWID()) % 200) + 90    AS Budget_Margin,
            ABS(CHECKSUM(NEWID()) % 500) + 380   AS Budget_Sales,
            CASE 
                WHEN (n % 3) = 0 THEN 415
                WHEN (n % 3) = 1 THEN 212
                ELSE 312
            END AS Area_Code
        FROM RowGenerator
        OPTION (MAXRECURSION 0);

        SELECT COUNT(*) AS TotalRows FROM Fact
        SELECT * FROM Fact;



/* 


     
	     b. ProductTable: The ProductTable has four columns named Product Type, Product, ProductID, and Type. 
		    It has 13 rows which can be brokendowninto further details to retrieve the information mentioned in theFactTable.

*/
            CREATE TABLE Product(
                ProductID INT PRIMARY KEY,
                ProductType VARCHAR(50) NOT NULL,
                Product VARCHAR(100)NOT NULL,
                Type VARCHAR(50)NOT NULL
            );
	
            INSERT INTO Product(ProductID, ProductType, Product, Type)
            VALUES
            (100, 'Coffee', 'Colombian Coffee', 'Beverage'),
            (101, 'Coffee', 'Ethiopian Coffee', 'Beverage'),
            (102, 'Tea', 'Green Tea', 'Beverage'),
            (103, 'Tea', 'Black Tea', 'Beverage'),
            (104, 'Soft Drink', 'Cola', 'Drink'),
            (105, 'Soft Drink', 'Orange Soda', 'Drink'),
            (106, 'Energy Drink', 'Power Boost', 'Drink'),
            (107, 'Juice', 'Apple Juice', 'Beverage'),
            (108, 'Juice', 'Mango Juice', 'Beverage'),
            (109, 'Water', 'Mineral Water', 'Drink'),
            (110, 'Snacks', 'Potato Chips', 'Food'),
            (111, 'Snacks', 'Nachos', 'Food'),
            (112, 'Snacks', 'Popcorn', 'Food');

SELECT  * FROM Product;

/*

c. LocationTable: Finally, the LocationTable has 156 rows andfollowsasimilar approach to ProductTable.
It has four columns named AreaCode, State, Market, and Market Size.
 */

        CREATE TABLE Location(
            AreaCode INT PRIMARY KEY,
            State VARCHAR(50)NOT NULL,
            Market VARCHAR(50)NOT NULL,
            MarketSize VARCHAR(20)NOT NULL
        );

        ;WITH LocationGenerator AS (
            SELECT 1 AS n
            UNION ALL
            SELECT n + 1
            FROM LocationGenerator
            WHERE n < 156
        )
        INSERT INTO Location (AreaCode, State, Market, MarketSize)
        SELECT
            200 + n AS AreaCode,
            CASE 
                WHEN n % 5 = 0 THEN 'California'
                WHEN n % 5 = 1 THEN 'Texas'
                WHEN n % 5 = 2 THEN 'New York'
                WHEN n % 5 = 3 THEN 'Florida'
                ELSE 'Illinois'
            END AS State,
            CASE 
                WHEN n % 4 = 0 THEN 'West'
                WHEN n % 4 = 1 THEN 'South'
                WHEN n % 4 = 2 THEN 'East'
                ELSE 'Central'
            END AS Market,
            CASE 
                WHEN n % 3 = 0 THEN 'Large'
                WHEN n % 3 = 1 THEN 'Medium'
                ELSE 'Small'
            END AS MarketSize
        FROM LocationGenerator
        OPTION (MAXRECURSION 0);


        (OR)

        INSERT INTO Location (AreaCode, State, Market, MarketSize)
        VALUES
        (415, 'California', 'West', 'Large'),
        (212, 'New York', 'East', 'Medium');
        ----UP REST ADD 152....

        SELECT COUNT(*) AS Location FROM Location;
        SELECT * FROM Location;




        ADD CONSTRAINT FK_Fact_Location
        FOREIGN KEY (Area_Code)
        REFERENCES Location(AreaCode);

        ALTER TABLE Fact
        ADD CONSTRAINT FK_Fact_Product
        FOREIGN KEY (ProductID)
        REFERENCES Product(ProductID);


Tasks to be performed:

-- 1. Display the number of states present in the LocationTable.

        SELECT COUNT(DISTINCT STATE)  AS Count_Of_State 
        FROM LOCATION


--2. How many products are of Snacks type?

        SELECT COUNT(DISTINCT Product)  AS Count_Of_State 
        FROM Product
        WHERE ProductType = 'Snacks'

--3. How much spending has been done on marketing of  FactID  1?

        select sum(Marketing) as [product sum]
        from [fact]
        where  FactID=1 

--4. What is the minimum sales of a product?

    select min(Sales) as [sum of sales]
    from [fact]
 
--5. Display the max Cost of Good Sold (COGS).
        select max(COGS) as [max cogs]
        from [fact]

--6. Display the details of the product where product type is coffee.

    SELECT* FROM Product
    WHERE ProductType = 'coffee'

--7. Display the details where total expenses are greater than 40.

    select * from [fact]
    where Total_Expenses>40

--8. What is the average sales in area code 212?

        select avg(sales) as [avg sales]
        from [fact]
        where Area_Code=212

--9. Find out the total profit generated by Colorado state.

        select sum(profit) as  [Profit of Colorado]
        from [fact] F
        INNER join
        [Location] L
        on
        L.AreaCode=F.Area_Code
        where State='California'

--10. Display the average inventory for each product ID.

    SELECT AVG(Inventory) AS [Inventory price], productID 
    FROM Fact
    Group by productID

-- 11. Display state in a sequential order in a Location Table.

        SELECT  STATE  FROM LOCATION
        ORDER BY STATE 

--12. Display the average budget of the Product where the average budget margin should be greater than 100. 

    SELECT AVG(Budget_Margin) AS [margin], productID 
    FROM FACT
    GROUP BY productID 
    HAVING avg(Budget_Margin)>100

--13. What is the total sales done on date 2023-03-29?
        select sum(sales) as sales_value  from [fact]
        where Date='2023-03-29'
--14. Display the average total expense of each product ID on an individual date.
    
    SELECT AVG(Total_expenses) AS [avg expense], ProductId,Date
    FROM [FACT]
    GROUP BY ProductId,Date
    ORDER BY ProductId,Date

-- 15. Display the table with the following attributes such as date, productID, producttype, product, sales, profit, state, areacode.

        select F.Date,F.ProductID,P.ProductType,P.Product,F.Sales,F.Profit,L.State,L.AreaCode
        from [fact ] F
        Inner JOin
        [Location ] L
        on 
        l.AreaCode=F.Area_Code
        inner join
        Product P
        on 
        P.ProductId=F.ProductId

-- 16. Display the rank without any gap to show the sales wise rank. 
        
       select sales,
           DENSE_RANK() over(order by sales desc) as ranks
           from [fact]

-- 17. Find the state wise profit and sales.

SELECT SUM(profit) AS PROFIT , SUM(sales) AS SALES, STATE  
FROM [FACT] F
INNER JOIN 
[LOCATION] L
ON
L.AreaCode=F.Area_Code
GROUP BY STATE
ORDER BY STATE

        

--18. Find the state wise profit and sales along with the productname. 

    select sum(profit) as profit,sum(sales) as sales,L.State,P.Product
    from [fact]F
    inner JOin
    [LocatioN] L
    on
    L.AreaCode=F.Area_Code
    inner join
    Product P
    on
    P.ProductId=F.ProductId
    group by L.State,P.Product
    order by L.State,P.Product

-- 19. If there is an increase in sales of 5%, calculate the increasedsales.


    select sales,(sales*0.05) as [increasedsales.]
    from [fact ]

-- 20. Find the maximum profit along with the product ID and producttype. 


        select max(profit) as profit,P.ProductId,P.ProductType 
        from
        [fact ] F
        inner join
        [Product] P
        on 
        p.ProductId=f.ProductId
        GROUP BY P.ProductId,P.ProductType 


--21. Create a stored procedure to fetch the result according to the producttype from Product Table. 
         
       CREATE OR ALTER PROC FETCH_TABLE
       @PROC_TYPE VARCHAR(100)
       AS
       BEGIN
         SELECT * FROM DBO.Product
         WHERE ProductType = @PROC_TYPE
       END

       EXEC FETCH_TABLE @PROC_TYPE='coffee'
       EXEC FETCH_TABLE @PROC_TYPE='TEA'


--22. Write a query by creating a condition in which if the total expenses is lessthan60 then it is a profit or else loss. 
  
       select Total_Expenses,
       iif(Total_Expenses>60,'profit','loss') as status
       from [fact]

--23. Give the total weekly sales value with the date and product IDdetails. Useroll-up to pull the data in hierarchical order.

            SELECT 
                DATEPART(WEEK, Date) AS Week_Number,
                SUM(Sales) AS Total_Sales,
                date,ProductId
            FROM Fact
            GROUP BY DATEPART(WEEK, Date),date,ProductId
            ORDER BY Week_Number;


--24. Apply union and intersection operator on the tables which consist of attribute area code. 

            select Areacode from [Location ]
            UNION
            select Area_code from [fact ]

            select Areacode from [Location ]
            Intersect
            select Area_code from [fact ]

--25. Create a user-defined function for the product table to fetch a particular product type based upon the user’s preference. 



        CREATE FUNCTION USER_DEFUNCION(@TYPE VARCHAR(30))
        RETURNS TABLE
        RETURN
        SELECT * FROM Product
        WHERE ProductType = @TYPE

        SELECT * FROM USER_DEFUNCION('TEA')


-- 26. Change the product type from coffee to tea where product ID is 1 and un do it. 


        begin transaction

        update Product
        set ProductType='TEA'
        where ProductId=100

        rollback transaction

        select * from Product

-- 27. Display the date, product ID and sales where total expenses are between 20 to 30. 

        select Total_Expenses,date,productid,sales from [fact]
        where Total_Expenses between 20 and 30




---28. Delete the records in the Product Table for regular type. 

         DELETE FROM Product
         WHERE TYPE = 'regular'
          select * from Product

         INSERT INTO Product  values(113,'Snacks','Cola','regular'),(114,'Coke','Green Tea','regular')
         select * from Product


-- 29. Display the ASCII value of the fifth character from the column Product.
          
          SELECT Product, SUBSTRING(Product,5,1) AS[CHAR], 
          ASCII(SUBSTRING(Product,5,1)) AS ascii_value  
          FROM Product


