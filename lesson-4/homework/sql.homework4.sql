1.
SELECT TOP 5 * FROM Employees 

2.
SELECT DISTINCT ProductCategory AS Category FROM Products

3.
SELECT * FROM Products
WHERE Price > 100

4.
SELECT * FROM Customers
WHERE FirstName LIKE 'A%'

5.
SELECT * FROM Products
ORDER BY Price ASC

6.
SELECT * FROM Employees
WHERE Salary >= 60000 AND DepartmentName = 'HR'

7.
SELECT ISNULL(Email ,'noemail@example.com') FROM Employees

8.
SELECT * FROM Products
WHERE  Price BETWEEN 50 AND 100

9.
SELECT DISTINCT ProductCategory AS Category, ProductName FROM Products

10.
SELECT DISTINCT ProductCategory AS Category, ProductName FROM Products
ORDER BY ProductName DESC
