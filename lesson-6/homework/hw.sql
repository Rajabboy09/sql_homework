CREATE DATABASE class6;
GO
USE class6;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    DepartmentID INT NULL,
    Salary DECIMAL(10,2) NOT NULL
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50) NOT NULL,
    EmployeeID INT NULL
);


INSERT INTO Projects (ProjectID, ProjectName, EmployeeID) VALUES
    (1, 'Alpha', 1),
    (2, 'Beta', 2),
    (3, 'Gamma', 1),
    (4, 'Delta', 4),
    (5, 'Omega', NULL);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
    (101, 'IT'),
    (102, 'HR'),
    (103, 'Finance'),
    (104, 'Marketing');

INSERT INTO Employees (EmployeeID, Name, DepartmentID, Salary) VALUES
    (1, 'Alice', 101, 60000),
    (2, 'Bob', 102, 70000),
    (3, 'Charlie', 101, 65000),
    (4, 'David', 103, 72000),
    (5, 'Eva', NULL, 68000);

SELECT * FROM Employees
SELECT * FROM Departments
SELECT * FROM Projects

--1
SELECT 
	e.Name,
	d.DepartmentName
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID

--2
SELECT 
	e.Name,
	d.DepartmentName
FROM Employees e
LEFT JOIN Departments d
ON e.DepartmentID = d.DepartmentID

--3
SELECT 
	e.Name,
	d.DepartmentName
FROM Employees e
RIGHT JOIN Departments d
ON e.DepartmentID = d.DepartmentID

--4
SELECT 
	e.Name,
	d.DepartmentName
FROM Employees e
FULL OUTER JOIN Departments d
ON e.DepartmentID = d.DepartmentID

--5
SELECT 
	d.DepartmentName,
	SUM(e.Salary) AS Total_Salary
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName

--6
SELECT 
    d.DepartmentName, 
    p.ProjectName
FROM Departments d
CROSS JOIN Projects p;

--7
SELECT 
    e.Name, 
    d.DepartmentName, 
    p.ProjectName
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
LEFT JOIN Projects p ON e.EmployeeID = p.EmployeeID;
