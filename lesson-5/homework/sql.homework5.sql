1.
SELECT ProductName AS Name, * FROM Products;

2.
SELECT * FROM Customers AS Client;

3.
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

4.
SELECT * FROM Products
INTERSECT
SELECT * FROM Products_Discounted;

5.
SELECT DISTINCT	FirstName, LastName, Country FROM Customers;

6.
SELECT ProductName, Price,  
CASE 
WHEN Price > 1000 THEN 'High'
WHEN Price <= 1000 THEN 'Low'
END AS PriceLevel
FROM Products;

7.
SELECT ProductName, StockQuantity, 
IIF (StockQuantity > 100, 'Yes', 'No') AS StockStatus
FROM Products_Discounted;

8.
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

9.
SELECT * FROM Products
EXCEPT
SELECT * FROM Products_Discounted;

10.
SELECT ProductName, Price, 
IIF (Price > 1000, 'Expensive', 'Affordable') AS PriceStatus
FROM Products;

11.
SELECT * FROM Employees
WHERE AGE < 25 OR Salary > 60000;

12.
UPDATE Employees
SET Salary = Salary * 0.90
WHERE DepartmentName = 'HR' OR EmployeeID = 5;

13.
SELECT SaleID, SaleAmount,
CASE 
WHEN SaleAmount > 500 THEN 'Top Tier'
WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
ELSE 'Low Tier'
END AS SaleCategory
FROM Sales;

14.
SELECT CustomerID  FROM Orders
EXCEPT
SELECT CustomerID FROM Sales;

15.
SELECT CustomerID, Quantity,
CASE
WHEN Quantity = 1 THEN '3%'
WHEN Quantity BETWEEN 1 AND 3 THEN '5%'
ELSE '7%'
END AS Discount_Percentage
FROM Orders

