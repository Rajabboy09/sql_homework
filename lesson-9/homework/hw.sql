CREATE DATABASE class9;
GO
USE class9;
CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');

--1

WITH EmployeeHierarchy AS (
    SELECT EmployeeID, ManagerID, JobTitle, 0 AS Depth
    FROM Employees
    WHERE ManagerID IS NULL
    UNION ALL

    SELECT e.EmployeeID, e.ManagerID, e.JobTitle, eh.Depth + 1
    FROM Employees e
    JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT * FROM EmployeeHierarchy ORDER BY Depth, EmployeeID;

--2
WITH Factorial AS (
    SELECT 1 AS Num, 1 AS Factorial
    UNION ALL
    SELECT Num + 1, Factorial * (Num + 1)
    FROM Factorial
    WHERE Num + 1 <= 10
)
SELECT * FROM Factorial;

--3
WITH Fibo(NUM,Fibo_num, Prev) AS
(
	SELECT	1,1,0
	UNION ALL
	SELECT NUM+1, Fibo_num + Prev, Fibo_num
	FROM Fibo
	WHERE NUM < 10
)
SELECT NUM,Fibo_num FROM Fibo ORDER BY NUM
