1.
BULK INSERT is a Transact-SQL (T-SQL) command in SQL Server that allows you to quickly 
import large volumes of data from an external file (such as a .csv, .txt, or other delimited format)
directly into a database table.
For example: 
BULK INSERT Students
FROM 'C:\Data\students.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

2.
CSV - Comma-Separated Values;
Excel Files (.xls, .xlsx);
XML - eXtensible Markup Language;
JSON - JavaScript Object Notation;
TXT - text format (.txt)

3.
CREATE TABLE Products (ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2))

4.
INSERT INTO Products (ProductID, ProductName, Price)
VALUES 
(1, 'AirPods', 230.00),
(2, 'Smartphone', 545.00),
(3, 'Dyson', 750.00)

5.
NULL means no value is stored — it is empty or unknown.
NOT NULL means the column must always have a value — no blanks allowed.
Examples:
SELECT * FROM Students WHERE Email IS NULL;
CREATE TABLE Users (
  ID INT,
  Username VARCHAR(50) NOT NULL
);

6. 
ALTER TABLE Products
ADD CONSTRAINT UQ_Products_ProductName UNIQUE (ProductName)

7.
-- Delete all records of customers who have canceled their account
DELETE FROM customers
WHERE status = 'canceled'

8.
ALTER TABLE Products
ADD CategoryID INT 

9.
CREATE TABLE Categories (CategoryID INT PRIMARY KEY, CategoryName VARCHAR(50) UNIQUE)

10.
The IDENTITY column in SQL Server is used to automatically generate unique numeric values for each row in a table.
It’s commonly applied to primary key columns to ensure each row has a distinct identifier without manual input.

11.
BULK INSERT Products
FROM 'C:\SQL2022/bulk insert.txt'
WITH (
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FIRSTROW = 2
)

12.
ALTER TABLE Products
ADD CONSTRAINT fk_category
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)

13.
 PRIMARY KEY: Uniquely identifies each row. Only one per table. Cannot be NULL.
Automatically combines UNIQUE and NOT NULL.
 UNIQUE KEY: Ensures values in a column (or group of columns) are unique.
You can have multiple UNIQUE keys. Allows one NULL value.

14.
ALTER TABLE Products 
ADD CONSTRAINT chk_Price CHECK (Price > 0)

15.
ALTER TABLE Products 
ADD Stock INT NOT NULL

16.
SELECT Price, ISNULL(Price, 0) AS Price FROM Products

17.
A FOREIGN KEY links two tables by referencing the PRIMARY KEY of another. 
It ensures data matches across tables, keeping relationships valid. 
You define it in CREATE TABLE or with ALTER TABLE, and can add rules like 
ON DELETE CASCADE to manage related data automatically. It protects consistency and builds structured connections.

18.
CREATE TABLE Customers (Age INT CHECK (Age >= 18))

19.
CREATE TABLE Stores (StoreID INT IDENTITY (100,10))

20.
CREATE TABLE OrderDetails (
  OrderID   INT NOT NULL,
  ProductID INT NOT NULL,
  Quantity  INT NOT NULL,
  PRIMARY KEY (OrderID, ProductID)
);

21.
ISNULL replaces a NULL with a given value (SQL Server only), while COALESCE returns 
the first non-NULL value from multiple inputs (standard SQL). Use ISNULL for simple cases, 
COALESCE for more flexibility.
For example:
SELECT ISNULL(NULL, 'N/A');
SELECT COALESCE(NULL, NULL, 'Hello');

22.
CREATE TABLE Employees (EmpID INT PRIMARY KEY, Email VARCHAR(35) UNIQUE)

23.
CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100)
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(200),
    AuthorID INT,
    CONSTRAINT FK_Books_Authors
        FOREIGN KEY (AuthorID)
        REFERENCES Authors(AuthorID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
    )
