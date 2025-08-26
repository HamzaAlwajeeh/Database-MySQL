-----Create Database-----
Create database H1;

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'H3')
BEGIN
	CREATE DATABASE H3;
END
--------------------------
-----Drop Database--------
DROP database H1;

IF EXISTS(SELECT * FROM sys.databases where name = 'H2')
BEGIN 
	DROP DATABASE H2
END
----------------------------
-----Switch Database--------
use H1;
----------------------------
-----Create Table-----------
USE H1;

CREATE TABLE Employees(
ID int NOT NULL,
firstName nvarchar(10) NOT NULL,
lastName nvarchar(10) NOT NULL,
phone varchar(10) NOT NULL,
salary int,
);

if NOT EXISTS(Select * from sys.tables where name = 'Employees')
BEGIN
	CREATE TABLE Employees(
	ID int NOT NULL,
	firstName nvarchar(10) NOT NULL,
	lastName nvarchar(10) NOT NULL,
	phone varchar(10) NOT NULL,
	email varchar(20),
	);
END
----------------------------
-----DROP Table-------------
DROP TABLE Employees;

IF EXISTS(SELECT * FROM sys.tables where name = 'Employees')
BEGIN
	DROP TABLE Employees;
END
----------------------------
-----Alter Table------------
use H1;
Alter Table Users
Add 
Gender char(1) null,
Age int null;
----------------------------
-----Alter Column-----------

Alter Table Users
Alter Column Age DateTime;

----------------------------
-----Rename Column----------

EXEC sp_rename 'Users.Age' , 'BirthDate' , 'COLUMN';

----------------------------
-----Rename Table-----------

EXEC sp_rename 'Users' , 'Employees';

----------------------------
-----Drop Column------------
use H1;

Alter Table Employees
Drop Column BirthDate;

----------------------------
-----Backup Database--------
Backup database DB3
To disk = 'E:\Database Course\Backup\DB3.bak';

----------------------------
-----Backup Database Diff---
Backup database H1
To disk = 'E:\Database Course\Backup\H1.bak'
With Differential;

----------------------------
-----Restore Database-------

use master;
Restore database car
From disk = 'E:\Database Course\Backup\car.bak'

----------------------------
-----Insert Into------------
use H1;

--One Record--
INSERT INTO Employees
values
(1 , 'Hamza' , 'Alwajeeh' , '1234' , 5000);
select * from Employees;

--multi Records--
INSERT INTO Employees
values
(2 , 'Ali' , 'Ahmed' , '1234' , 2000),
(3 , 'Ahmed' , 'Naser' , '1234' , 2500),
(4 , 'Rami' , 'Abdo' , '1234' , 4000);
select * from Employees;

--insert someinfo--
INSERT INTO Employees (ID , firstName , lastName , phone)
values
(5 , 'Ali' , 'Ahmed' , '1234' ),
(6 , 'Ahmed' , 'Naser' , '1234' ),
(7 , 'Rami' , 'Abdo' , '1234');
select * from Employees;

----------------------------
-----Update Set-------------

update Employees
SET firstName = 'Mohammed'
WHERE ID = 5;

select * from Employees;

update Employees
set salary = salary + 300
where salary <= 4000;

update Employees
set salary = null
where salary =1500;

----------------------------
-----Delete from------------

Delete from Employees
where salary is null;

select * from Employees;

--delete all records--
Delete from Employees;

----------------------------
-----Select Into Statment---

Select * 
into EmployeesCopy1
from Employees

select * from EmployeesCopy1;

Select ID,firstName,Salary
into Salaries
from Employees
where Salary is not null;

select * 
from Salaries;

----------------------------
---Insert into Select From--

insert into Salaries
Select ID,firstName,salary
From Employees
Where salary is null;

select * 
from Salaries;


-------------
---practise--
--Select into and Insert into..Select From :
--áÏíäÇ ÌÏæá ááØáÇÈ Ýíå ÏÑÌÇÊåã ÇÝÕá ÇáØáÇÈ ÇáããÊÇÒíä Ýí ÌÏæá ÌÏíÏ áæÍÏå æÇÖÝ ÇáÑÇÓÈíä Ýí ÌÏæá ãæÌæÏ

Create Table Students(
student_ID int identity(1 , 1) Primary Key,
Name nvarchar(50) not null,
Age tinyint null,
Grade decimal not null,
);

insert into Students
Values
('Ali' ,20 , 95.2),
('Mohammed' ,21 , 71.5),
('Naser' ,23 , 49),
('Nader' ,21 , 47.6);

select * from Students;

--select into--
Select student_ID , Name , Grade
Into ExllentStudents
From Students
Where Grade >= 90;

select * From ExllentStudents;

--insert into..select from--
insert into FailureStudents
Select  Name , Age , Grade
From Students
Where Grade < 50;

select * From FailureStudents;
------------------------------
-----Identity Feild-----------
use H1;

create Table Dept(
ID int Identity(1 , 1) not null,
DeptName varchar(12) not null,
Primary key(ID),
);

create Table Users(
ID int Identity(1 , 1) not null,
Name nvarchar(30) not null,
salary int,
Dept_ID int References Dept(ID),
);

select * from Dept;
select * from Users2;

Alter Table Users2
Add Dept_ID int ;

ALter Table Users2
Add Foreign Key(Dept_ID) References Dept(ID);


------------------------------
-----Trancate Statement-------
--Delete all records and restart Identity
use H1;
Truncate Table Users;

select * from Users;

------------------------------
-----Queries Statement--------
Use HR_Database;
Go
--Get All info--
SELECT * FROM Employees;
SELECT Employees.* From Employees;
SELECT * FROM Departments;

--Get Some info--
SELECT ID , FirstName , LastName , Gender
From Employees;

--Get By Distinct--
SELECT DISTINCT FirstName
From Employees;

SELECT DISTINCT FirstName,DepartmentID
From Employees;

--Get By Conditions--
--[1] Where --
USE HR_Database;

Select * from Employees
Where MonthlySalary < 1500

--[2] Where , AND --
Select * from Employees
Where MonthlySalary < 1500 AND Gender = 'F';

--[3] Where , OR --
Select * from Employees
Where DepartmentID = 1 OR DepartmentID = 2;

--[4] Where , IS --
Select * from Employees
Where ExitDate is Null;

--[5] Where , IS NOT --
Select * from Employees
Where ExitDate is NOT Null;

--[6] Where , <> --
-- <> => (Not Equal == !=)
Select * from Employees
Where Gender <> 'F'; -- Will Give All Male Employees

--[6] Where , (IN , NOT IN) --

--Select * From Employees
--Where DepartmentID = 1 or DepartmentID = 3 or DepartmentID = 5;

Select * From Employees
Where DepartmentID in (1 , 3 , 5);

SELECT * FROM Employees
WHERE FirstName in ('Omar' , 'Ali' , 'Sara');

Select Name From Departments
Where ID in (Select Distinct DepartmentID From Employees Where MonthlySalary = 2500 );

Select Name From Departments
Where ID Not in (Select Distinct DepartmentID From Employees Where MonthlySalary = 2500 );

------------------------------
-----Order By Statment--------
use HR_Database;
Go
Select * From Employees
Order By FirstName;

Select FirstName , MonthlySalary from Employees
Order By MonthlySalary ASC;

Select FirstName ,DepartmentID, MonthlySalary from Employees
Where DepartmentID = 1
Order By FirstName;