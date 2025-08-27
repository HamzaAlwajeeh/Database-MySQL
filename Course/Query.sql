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

------------------------------
-----Select Top Statment------

Select Top 10 *  From Employees; -- 10 records

Select Top 10 percent * From Employees; -- 5%

Select Top 3 MonthlySalary From Employees
Order by MonthlySalary Desc; -- ãÚ ÇáÊßÑÇÑ

Select distinct Top 3 MonthlySalary From Employees
Order by MonthlySalary Desc; -- ÈÏæä ÊßÑÇÑ


-- Fetch Employees That Have Top 3 Monthly Salary --

SELECT ID , FirstName , LastName , DepartmentID , MonthlySalary
From Employees
Where MonthlySalary in (
	SELECT Distinct TOP 3 MonthlySalary From Employees
	ORDER BY MonthlySalary Desc
)
ORDER BY MonthlySalary Desc;

-- Fetch Employees That Have Less 3 Monthly Salary --
SELECT ID , FirstName , LastName , DepartmentID , MonthlySalary
From Employees
WHERE MonthlySalary in (
	SELECT Distinct Top 3 MonthlySalary From Employees
	Order By MonthlySalary ASC
)
ORDER BY MonthlySalary ASC;


------------------------------
-----Select AS Statment-------

Select A = 5 * 2 , B = 4 + 5;

Select ID , FirstName + ' ' + LastName as FullName
From Employees

Select ID , FullName = FirstName + ' ' + LastName , MonthlySalary
From Employees
Where DepartmentID = 1;

--Get Full Name--
Select FullName = FirstName + ' ' + LastName From Employees;

--Get Yearly Salary--
Select MonthlySalary * 12 AS YearlySalary
From Employees
Order By YearlySalary Desc;


--Get Date Today--
Select Todaty = getDate();

--Get Age--
Select Age = DATEDIFF(Year , DateBirth , GETDATE()) From Employees;

--Get Employees's (ID - FullName - Department - Age - YearlySalary - BonusAmount) --
SELECT 
	ID, 
	FullName = (FirstName + ' ' + LastName), 
	DepartmentID , Age = (DATEDIFF(YEAR , DateBirth , GETDATE())), 
	YearlySalary = (MonthlySalary * 12),
	BonusAmount = MonthlySalary * BonusPerc
FROM Employees
ORDER BY YearlySalary Desc;


------------------------------
-----Between Operator---------
Use HR_Database;
GO
Select * From Employees
Where MonthlySalary >= 1500 and MonthlySalary <= 2000
order by MonthlySalary desc;

SELECT * FROM Employees
WHERE MonthlySalary BETWEEN 1500 AND 2000
ORDER BY MonthlySalary DESC;

-- Fetch all employees that have age between 22 and 30--
SELECT 
	ID,
	FullName = FirstName + ' ' + LastName,
	Gender,
	Age = DATEDIFF(YEAR , DateBirth , GETDATE()),
	MonthlySalary
FROM Employees
WHERE DATEDIFF(Year , DateBirth , GetDate()) BETWEEN 22 AND 30
ORDER BY Age;

------------------------------
--------Functions-------------

SELECT
	TotalCount = COUNT(MonthlySalary),
	TotalSum = SUM(MonthlySalary),
	Avarage = AVG(MonthlySalary),
	MinSalary = MIN(MonthlySalary),
	MaxSalary = MAX(MonthlySalary)
FROM Employees;

--Get Total Employees--
SELECT TotalEmployees = COUNT(ID) FROM Employees;

--Get Resigned Employees--
SELECT ResignedEmployees = COUNT(ExitDate) FROM Employees;

--Get Exsist Employees--
SELECT ExsistEmployees = COUNT(ID) FROM Employees
WHERE ExitDate is NULL;


------------------------------
----------Group By------------
SELECT
	TotalCount = COUNT(MonthlySalary),
	TotalSum = SUM(MonthlySalary),
	Avarage = AVG(MonthlySalary),
	MinSalary = MIN(MonthlySalary),
	MaxSalary = MAX(MonthlySalary)
FROM Employees
WHERE DepartmentID = 2;

--With Group by--
SELECT
	DepartmentID,
	TotalCount = COUNT(MonthlySalary),
	TotalSum = SUM(MonthlySalary),
	Avarage = AVG(MonthlySalary),
	MinSalary = MIN(MonthlySalary),
	MaxSalary = MAX(MonthlySalary)
FROM Employees
Group By DepartmentID;


------------------------------
--------Having Statmet--------

-- Having is a Filteration for Group by --
-- 
	--its like where statment 
	--but where can notused with Group by
--

--Select where total count of department < 10
SELECT
	DepartmentID,
	TotalCount = COUNT(MonthlySalary),
	TotalSum = SUM(MonthlySalary),
	Avarage = AVG(MonthlySalary),
	MinSalary = MIN(MonthlySalary),
	MaxSalary = MAX(MonthlySalary)
FROM Employees
Group By DepartmentID
Having COUNT(MonthlySalary) < 10;


--If you don’t want to use HAVING, you can use WHERE with GROUP BY like this: --
Select * From(
	SELECT 
		DepartmentID,
		TotalCount = Count(ID),
		TotalSum = Sum(MonthlySalary),
		Avarage = Avg(MonthlySalary),
		MinSalary = Min(MonthlySalary),
		MaxSalary = Max(MonthlySalary)
	From Employees
	Group By DepartmentID
)Query1
Where Query1.TotalCount < 10;


--Get Age Between 22 - 30 Using Sub Query--
Select * From (
	Select
		ID,
		FullName = FirstName + ' ' + LastName,
		DepartmentID,
		Age = DATEDIFF(Year , DateBirth , getDate())
	From Employees
)Q2
Where Q2.Age Between 22 AND 30
Order By Q2.Age;


------------------------------
---------Like Statmet---------

Select * From Employees;

--Finds any values that start with "a"
	SELECT ID,FirstName FROM Employees
	WHERE FirstName LIKE 'a%'

--Finds any values that end with "a"
	SELECT ID,FirstName FROM Employees
	WHERE FirstName LIKE '%a'

--Finds any values that have "na" in any position
	SELECT ID,FirstName FROM Employees
	WHERE FirstName LIKE '%na%'

--Finds any values that start with "a" and ends with "a"
	SELECT ID,FirstName FROM Employees
	WHERE FirstName LIKE 'a%a'

--Finds any values that have "a" in the second position
	SELECT ID,FirstName FROM Employees
	WHERE FirstName LIKE '_a%'

--Finds any values that have "a" in the third position
	SELECT ID,FirstName FROM Employees
	WHERE FirstName LIKE '__a%'

--Finds any values that start with "a" and are at least 3 characters in length
	SELECT ID,FirstName FROM Employees
	WHERE FirstName LIKE 'a__%'

--Finds any values that start with "a" and are at least 4 characters in length
	SELECT ID,FirstName FROM Employees
	WHERE FirstName LIKE 'a___%'

--Finds any values that start with "a" or "b"
	SELECT ID,FirstName FROM Employees
	WHERE FirstName LIKE 'a%' or FirstName Like 'b';


------------------------------
----------Wild Cards----------

--Execute these satatements to update data
update  Employees
Set FirstName = 'Ahmed'
where ID = 40;

update  Employees
Set FirstName = 'Ahmad'
where ID = 30;
------------------------

Select ID , FirstName From Employees
Where FirstName = 'Ahmed' or FirstName = 'Ahmad';

-- will search form Ahmed or Ahmad
	Select FirstName , LastName From Employees
	Where FirstName Like 'Ahm[ea]d';
--You can use Not 
	Select FirstName , LastName From Employees
	Where FirstName Not Like 'Ahm[ea]d';
---------------------------------------
-- search for all employees that their first name start with a or b or c
--Normal Way
	Select FirstName , LastName From Employees
	Where FirstName Like 'a%' or FirstName like 'b%' or FirstName like 'c%'
	Order By FirstName;
--Using Wild Cards
	Select FirstName , LastName From Employees
	Where FirstName Like '[abc]%'
	Order By FirstName;
---------------------------------------
-- search for all employees that their first name start with any letter from a to h
	Select FirstName , LastName From Employees
	Where FirstName Like '[a-h]%'
	Order By FirstName;
-----------------------
--some exercises
--Get Employees whose:
-----------------------
--[1] first name Is exactly 5 characters long, ends with a vowel
	SELECT FirstName FROM Employees
	WHERE FirstName LIKE '____[aeiou]'
-----------------------
--[2] First names that Begin with S or T, and have 6 total letters
	SELECT FirstName FROM Employees
	WHERE FirstName LIKE '[ST]_____'
-----------------------
--[3] Last names where the second letter is a, and it ends with n
	SELECT LastName FROM Employees
	WHERE LastName LIKE '_a%n'
-----------------------
--[4] Last names that Start with 'M', and the second letter is a vowel
	SELECT LastName FROM Employees
	WHERE LastName LIKE 'M[aeiou]%'
-----------------------


------------------------------
-------Create Database--------

CREATE DATABASE Shop_Database;
Use Shop_Database;
GO

Create Table Customers(
CustomerID int not null,
Name nvarchar(50) not null
Primary Key(CustomerID)
);

Create Table Orders(
OrderID int not null,
Amount int not null,
Customer_ID int,
Primary Key(OrderID),
Foreign Key(Customer_ID) References Customers(CustomerID)
);