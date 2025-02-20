create database class2;
go 
use class2;

CREATE TABLE test_identity (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO test_identity (name) VALUES
('Alice'), ('Bob'), ('Charlie'), ('David'), ('Emma');

SELECT * FROM test_identity;

DELETE FROM test_identity WHERE id = 3;

INSERT INTO test_identity (name) VALUES ('Frank');

SELECT * FROM test_identity;
--IDENTITY o‘zgarishsiz qoladi – yangi qator id = 6 bilan kiritiladi, 
--chunki id = 3 o‘chirilgan bo‘lsa ham, oldingi hisoblash davom etadi.
--DELETE identity qiymatini qayta boshlamaydi.

TRUNCATE TABLE test_identity;

INSERT INTO test_identity (name) VALUES ('Grace');

SELECT * FROM test_identity;

--TRUNCATE barcha ma’lumotlarni o‘chiradi.
--IDENTITY qayta boshlanadi! Yangi qator id = 1 dan boshlanadi.

DROP TABLE test_identity;
--DROP jadvalni butunlay o‘chiradi, shu jumladan IDENTITY ham yo‘qoladi.
--Jadvalni qayta yaratmaguncha undan foydalanib bo‘lmaydi.

--2

CREATE TABLE data_types_demo (
    id INT PRIMARY KEY IDENTITY(1,1),  -- Avtomatik ID
    name VARCHAR(50),  -- String (o'lchami cheklangan)
    description TEXT,  -- Uzoq matn
    age TINYINT,  -- Kichik son (0-255)
    salary DECIMAL(10,2),  -- O'nlik kasr
    is_active BIT,  -- Boolean (0 yoki 1)
    created_at DATETIME,  -- To'liq sana-vaqt
    birth_date DATE,  -- Faqat sana
    file_data VARBINARY(MAX)  -- Binar ma'lumot (fayl)
);

INSERT INTO data_types_demo 
(name, description, age, salary, is_active, created_at, birth_date,  file_data)
VALUES 
('Alice', 'Software Developer', 28, 75000.50, 1, GETDATE(), '1996-04-15', NULL),
('Bob', 'Data Analyst', 34, 65000.75, 1, GETDATE(), '1990-07-22', NULL),
('Charlie', 'Graphic Designer', 25, 50000.00, 0, GETDATE(), '1999-02-10', NULL);
 SELECT * FROM data_types_demo;

 --4

 CREATE TABLE student (
    id INT PRIMARY KEY IDENTITY(1,1),  -- Avtomatik ID
    name VARCHAR(50) NOT NULL,  -- Talabaning ismi
    classes INT NOT NULL CHECK (classes > 0),  -- O‘tilgan darslar soni
    tuition_per_class DECIMAL(10,2) NOT NULL CHECK (tuition_per_class > 0),  -- Har bir dars uchun to‘lov
    total_tuition AS (classes * tuition_per_class) PERSISTED  -- Hisoblangan ustun
);

INSERT INTO student (name, classes, tuition_per_class)
VALUES 
('Alice', 5, 100.00),
('Bob', 10, 80.50),
('Charlie', 8, 120.75);

SELECT * FROM student;


--5

CREATE TABLE worker(
	id INT PRIMARY KEY,
	NAME VARCHAR(100) NOT NULL
);

BULK INSERT worker
FROM 'E:\AI and BI\workers.csv'
WITH (
	FORMAT = 'CSV',
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
);

SELECT * FROM worker;
