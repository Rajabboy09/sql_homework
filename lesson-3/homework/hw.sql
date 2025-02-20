CREATE DATABASE class3;
go
USE class3;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate) VALUES
(1, 'Alice', 'Johnson', 'IT', 95000.00, '2015-06-10'),
(2, 'Bob', 'Smith', 'Finance', 86000.00, '2017-08-21'),
(3, 'Charlie', 'Brown', 'IT', 79000.00, '2018-01-05'),
(4, 'David', 'White', 'HR', 75000.00, '2016-03-15'),
(5, 'Emma', 'Watson', 'Sales', 70000.00, '2019-07-22'),
(6, 'Frank', 'Miller', 'IT', 92000.00, '2020-10-30'),
(7, 'Grace', 'Lee', 'Finance', 55000.00, '2021-11-11'),
(8, 'Harry', 'Davis', 'Marketing', 48000.00, '2014-12-02'),
(9, 'Isabella', 'Taylor', 'HR', 53000.00, '2015-09-14'),
(10, 'Jack', 'Brown', 'Sales', 46000.00, '2017-04-18');

SELECT TOP 10 PERCENT *
FROM Employees
ORDER BY Salary DESC

SELECT Department, AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY Department
ORDER BY AverageSalary DESC
OFFSET 2 ROWS FETCH NEXT 5 ROWS ONLY;



SELECT Salary, 
	CASE 
		WHEN Salary > 80000 THEN 'HIGH'
		WHEN Salary BETWEEN 50000 AND 80000 THEN 'MEDIUM'
		ELSE 'LOW'
	END AS SalaryCategory
FROM Employees


--2

INSERT INTO Orders (OrderID, CustomerName, OrderDate, TotalAmount, Status) VALUES
(1, 'Alice Johnson', '2023-02-15', 2500.00, 'Shipped'),
(2, 'Bob Smith', '2023-03-10', 3200.00, 'Delivered'),
(3, 'Charlie Brown', '2023-04-05', 1800.00, 'Pending'),
(4, 'David White', '2023-05-20', 7500.00, 'Cancelled'),
(5, 'Emma Watson', '2023-06-12', 4600.00, 'Shipped'),
(6, 'Frank Miller', '2023-07-08', 5400.00, 'Pending'),
(7, 'Grace Lee', '2023-08-23', 8700.00, 'Delivered'),
(8, 'Harry Davis', '2023-09-15', 1200.00, 'Pending'),
(9, 'Isabella Taylor', '2023-10-30', 6100.00, 'Shipped'),
(10, 'Jack Brown', '2023-11-25', 7200.00, 'Delivered');

SELECT 
    CASE 
        WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
    END AS OrderStatus,
    COUNT(*) AS TotalOrders,
    SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY 
    CASE 
        WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
    END
HAVING SUM(TotalAmount) > 5000
ORDER BY TotalRevenue DESC;

INSERT INTO Products (ProductID, ProductName, Category, Price, Stock) VALUES
(1, 'iPhone 15 Pro', 'Phones', 1300.00, 5),
(2, 'Samsung Galaxy S23', 'Phones', 1200.00, 2),
(3, 'Dell XPS 15', 'Laptops', 1800.00, 15),
(4, 'MacBook Pro 16', 'Laptops', 2500.00, 0),
(5, 'Lenovo ThinkPad X1', 'Laptops', 1400.00, 8),
(6, 'iPad Pro', 'Tablets', 1100.00, 12),
(7, 'Samsung Galaxy Tab S8', 'Tablets', 900.00, 0),
(8, 'Apple Watch Ultra', 'Watches', 900.00, 0),
(9, 'Garmin Fenix 7', 'Watches', 800.00, 4),
(10, 'Sony WH-1000XM5', 'Headphones', 400.00, 25);

SELECT
	Category,
	max(Price) AS MostExpensive,
	IIF(
		sum(Stock) = 0,
		'Out of Stock',
		IIF(sum(Stock) BETWEEN 1 AND 10,
		'Low Stock',
		'In Stock'
		)
		)
		 AS Stock
FROM Products
GROUP BY Category
ORDER BY MostExpensive DESC;
