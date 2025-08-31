1. 
CREATE TABLE Employees (EmpID INT, Name VARCHAR(50), Salary DECIMAL(10,2))

2. 
INSERT INTO Employees (EmpID, Name, Salary) VALUES (1, 'Diddy', 7300.55)

INSERT INTO Employees (EmpID, Name, Salary) VALUES (2, 'Carolina', 6500.07), (3, 'Jhonny', 5000.00), 

3. 
UPDATE Employees 
SET Salary = '7000' 
WHERE EmpID = 1

4.
DELETE FROM Employees
WHERE EmpID = 2

5.
DELETE - Removes specific rows from a table based on a condition. Can be rolled back.
TRUNCATE - Deletes all rows from a table instantly. Faster than DELETE, but not reversible.
DROP - Completely removes a table (or other database object) from the database.

6. 
ALTER TABLE Employees
ALTER COLUMN NAME VARCHAR(100)

7. 
ALTER TABLE Employees
ADD Department VARCHAR(50)

8. 
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT

9. 
CREATE TABLE Department (DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50)) 

10. 
TRUNCATE TABLE Employees

11.
INSERT INTO Department (DepartmentID,DepartmentName)
SELECT 1, 'Laura'
UNION ALL
SELECT 2, 'Hannah'
UNION ALL
SELECT 3, 'Gwen'
UNION ALL
SELECT 4, 'Piter'
UNION ALL
SELECT 5, 'Harry'

12.
UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000.00

13. 
TRUNCATE TABLE Employees

14. 
ALTER TABLE Employees
DROP COLUMN Department

15. 
EXEC sp_rename 'Employees_db.dbo.Employees', 'StaffMembers'

16.
DROP TABLE Department

17. 
CREATE TABLE Products (
ProductID INT PRIMARY KEY, 
ProductName VARCHAR(75), 
Category VARCHAR(50), 
Price DECIMAL(10,2), 
Profit INT
)

18.
ALTER TABLE Products 
ADD CONSTRAINT chk_Price CHECK (Price > 0)

19. 
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50

20.
EXEC sp_rename 'Employees_db.dbo.Products.Category', ' ProductCategory', 'COLUMN'

21.
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, Profit, StockQuantity)
VALUES 
(1, 'Apple', 'Fruit', 1.37, 0.37, 300),
(2, 'Laptop', 'Device', 234.50, 34.50, 20),
(3, 'Bread', 'Food', 2.00, 1.00, 35),
(4, 'Nike AF1', 'Clothing', 153.00, 23.00, 40),
(5, 'Jacket', 'Clothing', 81.47, 11.47, 45)

22.
SELECT * INTO Products_Backup FROM Products

23.
EXEC sp_rename 'Employees_db.dbo.Products', 'Inventory'

24.
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT

25.
ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000,5)
