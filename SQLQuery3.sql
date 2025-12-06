foreign key constrain ;
it is used to prevent action that would destroy the between tables.

A foreign key is  a field in one table that refers to the primary key in another table.

the table with the foreign key is called the child tabel and the table with the primary key is 
called the referenced or parent tabel.

persons table 
personID primary key 
lastName
firstName
Age

orders table 
OrderID primary key 
OrderNum
PersonID foreign Key



 if an employee is working  in a department then
that department should also have informtion about the employee

create table dept_details (
 DeptId int primary key,
 deptName varchar(100) not null,
 deptLocation varchar(100) not null,
 deptHead varchar(100) not null
) 

create table Emp_details (
 EmpID int primary Key,
 firstName varchar(100) not null,
 lastName varchar(100) not null,
 DeptId int not null ,
 mgrID int not null,
 Salary int not null,
 constraint fk_emp_dept foreign key(DeptId) REFERENCES dept_details(DeptId),
 constraint chk_Salery CHeck (Salary>0)
)

insert into dept_details (DeptId ,deptName ,deptLocation,deptHead ) values
(06,'Analytics','Mumbai','Akram'),
(02,'HR','bengaloor','Subham'),
(03,'Sales','chennai','Nithin'),
(04,'IT Support','Delhi','Akram'),
(05,'Finance','chennai','Nithin')

select *from dept_details

insert into Emp_details (EmpID ,firstName ,lastName,DeptId,mgrID ,Salary ) values
(01,'N','Ahmed',3,6,750000),
(06,'KT','Rakesh',6,6,450000),
(02,'N','Suresh',4,5,550000),
(03,'M','Ganesh',1,2,650000),
(04,'Rk','Ambarish',3,6,750000),
(05,'N','Ahmed',3,6,750000)

select *from Emp_details
Go
select *from dept_details

adding the foreign key for an existing table
syntax:
alter table table_name
add constraint  constraint_name
foreign key (column_name) references parent_Table(column_name)
ex

alter table  Emp_details 
add constraint PK_department
foreign key (DeptId) references dept_details(DeptId)

drop foreign key constraint

alter table employee
drop constraint PK_department

 
DML data manupulation language
insert
ex
insert into dept_details (DeptId ,deptName ,deptLocation,deptHead ) values
(06,'Analytics','Mumbai','Akram')

Update,
update the existing the data in table 

update table table_name
set column_name = value where condition

set column_name1 = value1,col_name2 = value2 where condition

where clause used to filter the data based on condition 

select * from Emp_details  where  Salary > 500000

update Emp_details 
set DeptId = 3  where EmpID = 6

delete,

syntax you can delete the data base on condition 
you can delete specific columns or entire data but the strature of table till exist

delete from table_name

deleting the data based on condition 

delete from  Emp_details where Salary = 550000
delete from  Emp_details where Salary = 750000 and firstName = 'Rk'

select * from Emp_details 


data control language

 grant this gives users access privileags to the database

 syntax 
   grant select ,update on my_table to some_user, ANother_user;

   example
   grant update on employee to 'SHUBHAM'

revoke is use dto withdraw the access
sytax
  revoke select ,update on my_table from user1, user2

  revoke update on employee from 'SHUBHAM'

  TCL : transaction control language
  transcation is a set of operataion executed in a single unit
  commit : is used to commit a transcation
  rollback : is to revert the change in case of any error
  savepoint : is used to save a transaction


