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

11.
SELECT TOP 10 * FROM Products
ORDER BY Price DESC

12.
SELECT COALESCE (FirstName, LastName)  FROM Employees

13.
SELECT DISTINCT Category, Price FROM Products

14.
SELECT * FROM Employees
WHERE AGE  BETWEEN 30 AND 40 OR DepartmentName = 'Marketing'

15.
SELECT * FROM Employees
ORDER BY SALARY DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY

16.
SELECT * FROM Products
WHERE Price<=1000 AND StockQuantity > 50 

17.
SELECT * FROM Products
WHERE ProductName LIKE '%e%'

18.
SELECT * FROM EMPLOYEES
WHERE DepartmentName IN ('HR', 'IT', 'Finance')

19.
SELECT * FROM Customers 
ORDER BY CITY ASC, POSTALCODE DESC
