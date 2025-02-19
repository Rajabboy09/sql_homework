create database homework;

use homework;

--1
create table student
(
	id int,
	name varchar(20),
	age int
);
alter table student
alter column id integer not null;

--2
create table product
(
	product_id int unique,
	product_name varchar(max),
	price decimal
);
alter table product
drop constraint product_id;

alter table product
add unique(product_id);

alter table product
add unique (product_id, product_name);

--3

create table orders
(
	order_id int primary key,
	customer_id varchar(max),
	order_date date
);
alter table orders
drop constraint order_id ;

alter table orders
add constraint order_id primary key;

--4
create table category
(
	category_id int primary key,
	category_name varchar(max)
);
create table item
(
	item_id int primary key,
	item_name varchar(max),
	category_id int foreign key references category(category_id) 
);
alter table item
drop constraint category_id ;

alter table item
add constraint catergory_id foreign key references category(category_id);

--5
create table account
(
	account_id int primary key,
	balance decimal check(balance >= 0),
	account_type varchar(max) check(account_type in ( 'Saving', 'Checking'))
);

alter table account
drop constraint account_type;

alter table account
add constraint account_type check(account_type in ( 'Saving', 'Checking'))
--6
create table customer
(
	customer_id int primary key ,
	name varchar(max),
	city varchar(max) default 'Unknown'
);

alter table customer 
drop constraint city ;

alter table customer
add constraint city default 'Unknown';

--7
CREATE TABLE invoice (
    invoice_id INT IDENTITY(1,1) PRIMARY KEY,
    amount DECIMAL(10,2)
);
INSERT INTO invoice (amount) VALUES 
(100.50), 
(200.75), 
(150.25), 
(300.00), 
(250.60);

SET IDENTITY_INSERT invoice ON;

INSERT INTO invoice (invoice_id, amount) VALUES (100, 500.00);

SET IDENTITY_INSERT invoice OFF;

SELECT * FROM invoice;

--8
CREATE TABLE books (
    book_id INT IDENTITY(1,1) PRIMARY KEY, 
    title VARCHAR(255) NOT NULL,             
    price DECIMAL(10,2) CHECK (price > 0),   
    genre VARCHAR(100) DEFAULT 'Unknown'     
);

INSERT INTO books (title, price, genre) VALUES 
('The Great Gatsby', 10.99, 'Fiction'),
('Clean Code', 25.50, 'Programming'),
('Atomic Habits', 15.75, 'Self-Help');

--9

-- Kitoblar jadvali
CREATE TABLE Book (
    book_id INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    published_year INT CHECK (published_year > 0)
);

-- Kutubxona a'zolari jadvali
CREATE TABLE Member (
    member_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL
);

-- Kitob ijarasi (Many-to-Many bog‘liqlikni yaratish)
CREATE TABLE Loan (
    loan_id INT IDENTITY(1,1) PRIMARY KEY,
    book_id INT,
    member_id INT,
    loan_date DATE NOT NULL,
    return_date DATE NULL, -- Agar NULL bo‘lsa, hali qaytarilmagan
    CONSTRAINT fk_loan_book FOREIGN KEY (book_id) REFERENCES Book(book_id) ON DELETE CASCADE,
    CONSTRAINT fk_loan_member FOREIGN KEY (member_id) REFERENCES Member(member_id) ON DELETE CASCADE
);

INSERT INTO Book (title, author, published_year) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 1925),
('To Kill a Mockingbird', 'Harper Lee', 1960),
('1984', 'George Orwell', 1949);

INSERT INTO Member (name, email, phone_number) VALUES
('Alice Johnson', 'alice@example.com', '123-456-7890'),
('Bob Smith', 'bob@example.com', '987-654-3210'),
('Charlie Brown', 'charlie@example.com', '555-666-7777');

INSERT INTO Loan (book_id, member_id, loan_date, return_date) VALUES
(1, 1, '2025-02-01', '2025-02-10'),  
(2, 2, '2025-02-05', NULL),          
(3, 3, '2025-02-08', NULL);          

select * from Book
select * from Member
select * from Loan