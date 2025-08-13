-----Create Database-----
Create database H2;

IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'H3')
BEGIN
	CREATE DATABASE H3;
END
--------------------------
-----Drop Database--------
DROP database H3;

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

CREATE TABLE Users(
ID int NOT NULL,
firstName nvarchar(10) NOT NULL,
lastName nvarchar(10) NOT NULL,
phone varchar(10) NOT NULL,
email varchar(20),
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
-----Restore Database-------










	

