create database University;
Use University;
GO


create table Colleges(
CollID int identity(1,1) primary key,
CollName varchar(20) not null,
);

create table Departments(
DeptID int identity(1,1) primary key,
DeptName varchar(20) not null,
College_ID int,
foreign key (College_ID) References Colleges(CollID),
);

Delete from Colleges;


ÚSelect 
	Departments.College_ID,
	Departments.DeptName,
	Colleges.CollName
From Departments
inner join Colleges
ON Departments.College_ID = Colleges.CollID;


Backup database University
To disk = 'E:\Database Course\Backup\University.bak';

Backup database University
To disk = 'E:\Database Course\Backup\University.bak'
With Differential;