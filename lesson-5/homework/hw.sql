CREATE DATABASE class5;
GO

USE class5;

CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);

INSERT INTO Employees (Name, Department, Salary, HireDate) VALUES
    ('Alice', 'HR', 50000, '2020-06-15'),
    ('Bob', 'HR', 60000, '2018-09-10'),
    ('Charlie', 'IT', 70000, '2019-03-05'),
    ('David', 'IT', 80000, '2021-07-22'),
    ('Eve', 'Finance', 90000, '2017-11-30'),
    ('Frank', 'Finance', 75000, '2019-12-25'),
    ('Grace', 'Marketing', 65000, '2016-05-14'),
    ('Hank', 'Marketing', 72000, '2019-10-08'),
    ('Ivy', 'IT', 67000, '2022-01-12'),
    ('Jack', 'HR', 52000, '2021-03-29');

--1
SELECT *, 
	DENSE_RANK() OVER(ORDER BY Salary DESC) AS Rank
FROM Employees

--2
SELECT Salary, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY Salary
HAVING COUNT(*) > 1;


--3
SELECT EmployeeID, Name, Department, Salary
FROM (
    SELECT *,
        DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS RankInDept
    FROM Employees
) AS RankedEmployees
WHERE RankInDept <= 2
ORDER BY Department, RankInDept;

--4
SELECT EmployeeID, Name, Department, Salary
FROM (
    SELECT *,
        DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary ) AS RankInDept
    FROM Employees
) AS RankedEmployees
WHERE RankInDept = 1 
ORDER BY Department, RankInDept;

--5
SELECT 
    Department, 
    SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Department;
--6
SELECT 
    DISTINCT Department, 
    SUM(Salary) OVER(PARTITION BY Department) AS TotalSalary
FROM Employees;

--7
SELECT 
    DISTINCT Department, 
    CAST(AVG(Salary) OVER(PARTITION BY Department) AS DECIMAL(10,2)) AS TotalSalary
FROM Employees;

--8
SELECT 
    Name, Department, 
    (Salary - CAST(AVG(Salary) OVER(PARTITION BY Department) AS DECIMAL(10,2))) AS Diff
FROM Employees;
--9
SELECT 
    EmployeeID, Name, Department, 
    CAST(AVG(Salary) OVER (ORDER BY EmployeeID ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING ) AS DECIMAL(10,2)) AS Moving_Avg_Salary
FROM Employees;
--10
SELECT SUM(Salary) AS Salary_Last_3
FROM (
    SELECT TOP 3 Salary 
    FROM Employees 
    ORDER BY HireDate DESC
) AS Last3;
--11
SELECT 
    EmployeeID, 
    Name, 
    Department, 
    Salary, 
    AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Running_Avg_Salary
FROM Employees;

--12
SELECT 
    EmployeeID, 
    Name, 
    Department, 
    Salary, 
    MAX(Salary) OVER (ORDER BY EmployeeID ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS Max_Salary_Window
FROM Employees;

--13
SELECT 
     Name,Department, 
    CAST(Salary / SUM(Salary) OVER(PARTITION BY Department) AS DECIMAL(10,2)) *100 AS TotalSalary
FROM Employees;
