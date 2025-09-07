1.
SELECT TOP 5 * FROM Employees 

2.
SELECT DISTINCT Category FROM Products

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
SELECT EmployeeID, FirstName, LastName, DepartmentName, Salary, HireDate, Age, 
       ISNULL(Email, 'noemail@example.com') AS Email, Country
FROM Employees;

8.
SELECT * FROM Products
WHERE  Price BETWEEN 50 AND 100

9.
SELECT DISTINCT Category, ProductName FROM Products

10.
SELECT DISTINCT Category, ProductName FROM Products
ORDER BY ProductName DESC

11.
SELECT TOP 10 * FROM Products
ORDER BY Price DESC

12.
SELECT COALESCE (FirstName, LastName) AS Name  FROM Employees

13.
SELECT DISTINCT Category, Price FROM Products

14.
SELECT * FROM Employees
WHERE (AGE  BETWEEN 30 AND 40) OR DepartmentName = 'Marketing'

15.
SELECT * FROM Employees
ORDER BY SALARY DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY

16.
SELECT * FROM Products
WHERE Price<=1000 AND StockQuantity > 50 
ORDER BY StockQuantity ASC
17.
SELECT * FROM Products
WHERE ProductName LIKE '%e%'

18.
SELECT * FROM EMPLOYEES
WHERE DepartmentName IN ('HR', 'IT', 'Finance')

19.
SELECT * FROM Customers 
ORDER BY CITY ASC, POSTALCODE DESC

20.
SELECT TOP 5 * FROM Sales
ORDER BY SaleAmount DESC

21.
SELECT COALESCE(FirstName, '') + ' ' + COALESCE(LastName, '') AS FullName FROM Employees;

22.
SELECT DISTINCT Category, Price, ProductName FROM Products
WHERE PRICE > 50

23.
SELECT * FROM Products
WHERE Price < (SELECT AVG(Price) FROM Products) * 0.10 

24.
SELECT * FROM Employees
WHERE AGE < 30 AND DepartmentName IN ('HR', 'IT' )

25.
SELECT * FROM Customers
WHERE Email LIKE '%@gmail.com'

26.
SELECT * FROM Employees
WHERE Salary > ALL (SELECT Salary FROM Employees
WHERE DepartmentName = 'Sales')

27.
SELECT * FROM Orders
WHERE OrderDate BETWEEN DATEADD(DAY, -180, GETDATE()) AND GETDATE();

