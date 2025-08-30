1. 
CREATE TABLE Employees (EmpID INT, Name VARCHAR(50), Salary DECIMAL(10,2))

2. 
INSERT INTO Employees (EmpID, Name, Salary) VALUES (1, 'Diddy', 7300.55)

INSERT INTO Employees (EmpID, Name, Salary) VALUES (2, 'Carolina', 6500.07), (3, 'Jhonny', 5000.00), (4, 'Mark', 999.09)

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


