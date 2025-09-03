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
ADD UNIQUE (ProductName)

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

