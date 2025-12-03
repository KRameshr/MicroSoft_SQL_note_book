📌 Basic Concepts

Cell = combination of row + column

Database stores multiple tables

Table stores rows of data

📌 Create & Drop Database
CREATE DATABASE Data_base_name;

DROP DATABASE Data_base_name;

📌 Create Table
CREATE TABLE table_name(
   column_one data_type,
   column_two data_type,
   column_three data_type
);


Common Data Types

INT
CHAR(size)
VARCHAR(size)
DECIMAL(5,2) → 5 digits total, 2 after decimal

🟦 DDL Commands

Command	Use
CREATE	Create database or table
ALTER	Modify structure
DROP	Delete object permanently
TRUNCATE	Delete all rows (structure remains)
🟩 Create Employee Table
CREATE TABLE employee_Details(
   employee_Id INT,
   fist_Name VARCHAR(100),
   last_Name VARCHAR(100),
   department VARCHAR(100),
   job_Title VARCHAR(100),
   salary INT
);

📌 Select Statement
SELECT * FROM employee_Details;

🟧 Rename Table
EXEC sp_rename 'old_table_Name', 'New_table_Name';

EXEC sp_rename 'employee_Details', 'emplo_info';

🟨 ALTER TABLE – Add Column
ALTER TABLE employee_Details
ADD manager_id VARCHAR(100);

🟥 ALTER TABLE – Drop Column
ALTER TABLE employee_Details
DROP COLUMN manager_id;

🟦 ALTER TABLE – Change Column Datatype
ALTER TABLE employee_Details
ALTER COLUMN salary INT;

🟪 Rename Column
EXEC sp_rename 'employee_Details.job_Title', 'Job_Title', 'COLUMN';

🗑️ DROP TABLE (Permanent)
DROP TABLE employee_Details;

🧹 TRUNCATE TABLE (Deletes only data)
TRUNCATE TABLE employee_Details;

🟩 Insert Values (Correct Format)

✔ Must match exact number of columns

INSERT INTO employee_Details VALUES
(234,'k','Ramesh','production','support',35000);

INSERT INTO employee_Details VALUES
(290,'s','suresh','production','testing',45000);

INSERT INTO employee_Details VALUES
(390,'r','naresh','production','software',55000);

INSERT INTO employee_Details VALUES
(380,'a','Ramesh','production','support',35000);

INSERT INTO employee_Details VALUES
(345,'o','suresh','production','testing',45000);

❌ Wrong Insert (missing one value)

INSERT INTO employee_Details VALUES
(391,'w','naresh','production','software');   -- ERROR


✔ Correct way (specific columns):

INSERT INTO employee_Details(
   employee_id, last_Name, department, job_Title, fist_Name
) VALUES (
   391, 'naresh', 'production', 'software', 'w'
);

📌 Final Output
SELECT * FROM employee_Details;