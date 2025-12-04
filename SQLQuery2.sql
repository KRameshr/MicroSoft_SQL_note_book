 Constraints, DDL & Examples (Clean & Formatted)


INSERT INTO employee_Details VALUES
(1,'L','Naresh','Software','Technical',350000),
(2,'K','Suresh','Software','Associate',350000),
(3,'SK','Ganesh','Analyst','Supporting',400000);

SELECT * FROM employee_Details;

TRUNCATE TABLE employee_Details;


SQL CONSTRAINTS
Constraints are rules applied to columns to maintain data integrity.

Types of Constraints

* **NOT NULL** – Ensures a column cannot have NULL value.
* **PRIMARY KEY** – Unique + Not Null.
* **UNIQUE** – Ensures all values in a column are different (NULL allowed).
* **CHECK** – Restricts value range.
* **DEFAULT** – Sets a default value.
* **FOREIGN KEY** – Links two tables.

---
CREATE TABLE table_Name (
  column_name_1 datatype NOT NULL,
  column_name_2 datatype,
  column_name_3 datatype,
  PRIMARY KEY(column_name_1)
);

 Example:

CREATE TABLE employee (
  employee_id INT PRIMARY KEY,
  first_name VARCHAR(255),
  second_name VARCHAR(255),
  department VARCHAR(255),
  salary INT NOT NULL
);

---
 PRIMARY KEY Examples
 Type 1

CREATE TABLE employee (
  employee_id INT NOT NULL PRIMARY KEY,
  first_name VARCHAR(255),
  second_name VARCHAR(255),
  department VARCHAR(255)
);


Type 2 (Primary key separately)

CREATE TABLE employee (
  employee_id INT NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  second_name VARCHAR(255) NOT NULL,
  department VARCHAR(255) NOT NULL,
  PRIMARY KEY(employee_id)
);


Type 3 (Named constraint)

CREATE TABLE employee (
  employee_id INT NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  second_name VARCHAR(255) NOT NULL,
  department VARCHAR(255) NOT NULL,
  CONSTRAINT PK_employee PRIMARY KEY(employee_id)
);

---

 Adding Constraints Using ALTER
 Make a column NOT NULL

ALTER TABLE table_name
ALTER COLUMN column_name datatype NOT NULL;


 Add Primary Key

ALTER TABLE employee_Details
ADD CONSTRAINT PK_emp PRIMARY KEY(employee_id);


Show constraints

SELECT constraint_name
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'employee_Details';


 Drop a constraint

ALTER TABLE table_name
DROP CONSTRAINT constraint_name;


---
 CHECK Constraint
 Create table with CHECK

CREATE TABLE employee_details (
  employee_id INT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  middle_name VARCHAR(100),
  last_name VARCHAR(100) NOT NULL,
  department VARCHAR(100) NOT NULL,
  job_title VARCHAR(100) NOT NULL,
  salary INT NOT NULL CHECK (salary > 0)
);


Named CHECK constraint

CREATE TABLE employee_details (
  employee_id INT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  middle_name VARCHAR(100),
  last_name VARCHAR(100) NOT NULL,
  department VARCHAR(100) NOT NULL,
  job_title VARCHAR(100) NOT NULL,
  CONSTRAINT chk_salary CHECK (salary > 0)
);


 Add CHECK via ALTER

ALTER TABLE employee_details
ADD CONSTRAINT chk_salary CHECK (salary > 0);

 Drop CHECK

ALTER TABLE employee_details
DROP CONSTRAINT chk_salary;

---
 Inserting Data to Test CHECK Constraint

INSERT INTO employee_details (employee_id, first_name, last_name, department, job_title, salary)
VALUES (01,'K','Ramesh','IT-support','Development',222000);


---
DEFAULT Constraint
CREATE TABLE employee_details (
  employee_id INT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  middle_name VARCHAR(100) DEFAULT 'Not Applicable',
  last_name VARCHAR(100) NOT NULL,
  department VARCHAR(100) NOT NULL,
  job_title VARCHAR(100) NOT NULL,
  CONSTRAINT chk_salary CHECK (salary > 0)
);

Add DEFAULT using ALTER
ALTER TABLE employee_details
ADD CONSTRAINT df_lastName DEFAULT 'Not Applicable' FOR last_name;


---
 UNIQUE Constraint

CREATE TABLE employee_details (
  employee_id INT NOT NULL UNIQUE,
  first_name VARCHAR(100) NOT NULL,
  middle_name VARCHAR(100) DEFAULT 'Not Applicable',
  last_name VARCHAR(100) NOT NULL,
  department VARCHAR(100) NOT NULL,
  job_title VARCHAR(100) NOT NULL,
  CONSTRAINT chk_salary CHECK (salary > 0)
);

UNIQUE on specific column

CREATE TABLE employee_details (
  employee_id INT NOT NULL PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  middle_name VARCHAR(100) DEFAULT 'Not Applicable',
  last_name VARCHAR(100) NOT NULL,
  department VARCHAR(100) NOT NULL,
  job_title VARCHAR(100) NOT NULL,
  CONSTRAINT chk_salary CHECK (salary > 0),
  CONSTRAINT uniq_position UNIQUE (job_title)
);


UNIQUE on multiple columns

ALTER TABLE employee_details
ADD CONSTRAINT uc_emp UNIQUE (department, job_title);

---

 FOREIGN KEY Constraint

Used to link two tables.

CREATE TABLE department (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(100) NOT NULL,
  dept_id INT,
  FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

---

 DQL (Data Query Language)

SELECT → Used to retrieve data

Select all columns
SELECT * FROM table_name;

Select specific columns

SELECT column1, column2 FROM table_name;





