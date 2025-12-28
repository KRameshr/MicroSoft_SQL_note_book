
/*

Problem Statement:
How to get details about customers by querying a database?


Topics:

In this project, you will work on downloading a database and restoring it on the
server. You will then query the database to get customer details like name, phone
number, email ID, sales made in a particular month, increase in month-on-month
sales and even the total sales made to a particular customer.


Highlights:
Table basics and data types
Various SQL operators
Various SQL functions


Tasks To Be Performed:
1. Download the AdventureWorks database from the following location and
restore it in your server:

Location:

 https://github.com/Microsoft/sql-server-samples/releases/tag/adventureworks

File Name: AdventureWorks2012.bak

AdventureWorks is a sample database shipped with SQL Server and it can
be downloaded from the GitHub site. AdventureWorks has replaced
Northwind and Pubs sample databases that were available in SQL Server
in 2005. Microsoft keeps updating the sample database as it releases new VERSIONS.


2. Restore Backup:

Follow the below steps to restore a backup of your database using SQL
Server Management Studio:
a. Open SQL Server Management Studio and connect to the target SQL Server instance
b. Right-click on the Databases Node and select Restore Database
c. Select Device and click on the ellipsis (...)
d. In the dialog box, select Backup devices, click on Add, navigate to
the database backup in the file system of the server, select the backup, and click on OK.
e. If needed, change the target location for the data and log files in the Files pane
Note: It is a best practice to place the data and log files on different drives.
f. Now, click on OK

This will initiate the database restore. After it completes, you will have the
AdventureWorks database installed on your SQL Server instance.


  3. Perform the following with help of the above database:
*/
-- a. Get all the details from the person table including email ID, phone number and phone number type

    USE AdventureWorks2012;
    GO
    SELECT 
        p.BusinessEntityID,
        p.FirstName,
        p.LastName,
        e.EmailAddress,
        pp.PhoneNumber,
        pt.Name AS PhoneNumberType
    FROM Person.Person p
    LEFT JOIN Person.EmailAddress e
        ON p.BusinessEntityID = e.BusinessEntityID
    LEFT JOIN Person.PersonPhone pp
        ON p.BusinessEntityID = pp.BusinessEntityID
    LEFT JOIN Person.PhoneNumberType pt
        ON pp.PhoneNumberTypeID = pt.PhoneNumberTypeID;



-- b. Get the details of the sales header order made in May 2011

    SELECT *
    FROM Sales.SalesOrderHeader
    WHERE YEAR(OrderDate) = 2011
      AND MONTH(OrderDate) = 5;
   

--c. Get the details of the sales details order made in the month of May 2011

    SELECT d.*
    FROM Sales.SalesOrderDetail d
    JOIN Sales.SalesOrderHeader h
        ON d.SalesOrderID = h.SalesOrderID
    WHERE YEAR(h.OrderDate) = 2011
      AND MONTH(h.OrderDate) = 5;


-- d. Get the total sales made in May 2011

    SELECT SUM(TotalDue) AS TotalSales_May2011
    FROM Sales.SalesOrderHeader
    WHERE YEAR(OrderDate) = 2011
      AND MONTH(OrderDate) = 5;
    

--e. Get the total sales made in the year 2011 by month order by increasing sales

    SELECT MONTH(OrderDate) AS SaleMonth, SUM(TotalDue) AS TotalSales
    FROM Sales.SalesOrderHeader
    WHERE YEAR(OrderDate) = 2011
    GROUP BY MONTH(OrderDate)
    ORDER BY TotalSales ASC;


--f. Get the total sales made to the customer with FirstName='Gustavo' AND LASTNAEM ='ACHONG'

    SELECT SUM(h.TotalDue) AS TotalSales_GustavoAchong
    FROM Sales.SalesOrderHeader h
    JOIN Sales.Customer c
        ON h.CustomerID = c.CustomerID
    JOIN Person.Person p
        ON c.PersonID = p.BusinessEntityID
    WHERE p.FirstName = 'Gustavo'
      AND p.LastName = 'ACHONG';

