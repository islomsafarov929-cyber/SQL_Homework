--1.Showing all orders placed after 2022 along with the names of the customers who placed them.
--2022-yildan keyin joylashtirilgan barcha buyurtmalarni ularni joylashtirgan mijozlarning ismlari bilan birga ko‘rsatish.

SELECT O.OrderID,
       C.FirstName,
       C.LastName,
       O.OrderDate
FROM Orders AS O
INNER JOIN Customers AS C ON O.CustomerID = C.CustomerID
WHERE YEAR(O.OrderDate) > 2022;

--2.Displaying the names of employees who work in either the Sales or Marketing department.
--Savdo yoki marketing bo‘limida ishlaydigan xodimlarning ismlarini ko‘rsatish.

SELECT E.Name AS EmployeeName,
       D.DepartmentName
FROM Employees AS E
INNER JOIN Departments AS D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName IN('Sales',
                          'Marketing');

--3.Showing the highest salary for each department.
--Har bir ish bo'limi uchun eng yuqori maoshni ko'rsatish.

SELECT D.DepartmentName,
       MAX(E.Salary) AS HighestSalary
FROM Departments AS D
INNER JOIN Employees AS E ON D.DepartmentID = E.DepartmentID
GROUP BY D.DepartmentName;

--4.Listing all customers from the USA who placed orders in the year 2023.
--2023-yilda buyutma qilgan AQSHlik barcha mijozlarni ko'rsatish.

SELECT C.FirstName, 
       C.LastName, 
       O.OrderID, 
       O.OrderDate
FROM Customers AS C
INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID 
WHERE YEAR(O.OrderDate) = 2023
  AND C.Country = 'USA';

--5.Showing how many orders each customer has placed.
--Har bir mijoz jami qancha buyurtma qilganini ko'rish.

SELECT C.FirstName,
       C.LastName,
       COUNT(O.OrderID) AS TotalOrders
FROM Customers AS C
INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName,
         C.LastName;

--6.Displaying the names of products that are supplied by either Gadget Supplies or Clothing Mart.
--'Gatget Suppliers' yoki 'Clothing Mart' tomonidan yetkazib berilgan mahsulotlar nomini ko'rsatish.

SELECT P.ProductName, 
       S.SupplierName
FROM Products AS P
INNER JOIN Suppliers AS S ON P.SupplierID = S.SupplierID 
WHERE S.SupplierName IN ('Gadget Supplies', 
                         'Clothing Mart');

--7.For each customer, showing their most recent order. Include customers who haven't placed any orders.
--Har bir mijoz uchun uning oxirgi buyurtmasini ko‘rsatish. Hech qanday buyurtma bermagan mijozlarni qo‘shilgan.

SELECT C.FirstName,
       C.LastName,
       MAX(O.OrderDate) AS MostRecentOrderDate
FROM Customers AS C
LEFT OUTER JOIN Orders AS O ON C.CustomerID = O.CustomerID
GROUP BY C.FirstName,
         C.LastName;

--8.Showing the customers who have placed an order where the total amount is greater than 500.
--Umumiy summasi 500 dan ortiq bo‘lgan buyurtma bergan mijozlarni ko‘rsatish.

SELECT C.FirstName,
       C.LastName,
       SUM(O.TotalAmount) AS OrderTotal
FROM Orders AS O
INNER JOIN Customers AS C ON O.CustomerID = C.CustomerID
GROUP BY C.FirstName,
         C.LastName
HAVING SUM(O.TotalAmount) > 500;

--9.Listing product sales where the sale was made in 2022 or the sale amount exceeded 400.
--2022-yilda sotuv amalga oshirilgan yoki sotuv summasi 400 dan oshgan mahsulot sotuvlarini sanab o‘tish.

SELECT P.ProductName,
       S.SaleDate,
       S.SaleAmount
FROM Products AS P
INNER JOIN Sales AS S ON P.ProductID = S.ProductID
WHERE YEAR(S.SaleDate) = 2022
  OR S.SaleAmount > 400;

--10.Displaying each product along with the total amount it has been sold for.
--Har bir mahsulotni u sotilgan umumiy summa bilan birga ko‘rsatish.

SELECT P.ProductName,
       SUM(S.SaleAmount) AS TotalSalesAmount
FROM Sales AS S
INNER JOIN Products AS P ON S.ProductID = P.ProductID
GROUP BY P.ProductName;

--11.Showing the employees who work in the HR department and earn a salary greater than 60000.
--Kadrlar bo‘limida ishlaydigan va 60000 dan ortiq maosh oladigan xodimlarni ko‘rsatish.

SELECT E.Name AS EmployeeName,
       D.DepartmentName,
       E.Salary
FROM Employees AS E
INNER JOIN Departments AS D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Human Resources'
  AND E.Salary > 60000;

--12.Listing the products that were sold in 2023 and had more than 100 units in stock at the time.
--2023-yilda sotilgan va o‘sha paytda 100 donadan ortiq zaxiraga ega bo‘lgan mahsulotlarni sanab o‘tish.

SELECT P.ProductName,
       S.SaleDate,
       P.StockQuantity
FROM Products AS P
INNER JOIN Sales AS S ON P.ProductID = S.ProductID
WHERE YEAR(S.SaleDate) = 2023
  AND P.StockQuantity > 100;

--13.Showing employees who either work in the Sales department or were hired after 2020.
--Savdo bo‘limida ishlaydigan yoki 2020-yildan keyin ishga qabul qilingan xodimlarni ko‘rsatish.

SELECT E.Name AS EmployeeName,
       D.DepartmentName,
       E.HireDate
FROM Employees AS E
INNER JOIN Departments AS D ON E.DepartmentID = D.DepartmentID
WHERE YEAR(E.HireDate) > 2020
  OR D.DepartmentName = 'Sales';

--14.Listing all orders made by customers in the USA whose address starts with 4 digits.
--AQShdagi manzili 4 ta raqamdan boshlanadigan mijozlar tomonidan berilgan barcha buyurtmalarni sanab berish.

SELECT C.FirstName,
       C.LastName,
       O.OrderID,
       C.Address,
       O.OrderDate
FROM Orders AS O
INNER JOIN Customers AS C ON O.CustomerID = C.CustomerID
WHERE C.Country = 'USA'
  AND C.Address LIKE '[0-9][0-9][0-9][0-9]%';

--15.Displaying product sales for items in the Electronics category or where the sale amount exceeded 350.
--Elektronika toifasidagi yoki sotuv summasi 350 dan oshgan buyumlar uchun mahsulot sotuvini ko‘rsatish.

SELECT P.ProductName,
       C.CategoryName AS Category,
       S.SaleAmount
FROM Sales AS S
INNER JOIN Products AS P ON S.ProductID = P.ProductID
INNER JOIN Categories AS C ON P.Category = C.CategoryID
WHERE C.CategoryName = 'Electronics'
  OR S.SaleAmount > 350;

--16.Showing the number of products available in each category.
--Har bit toifa uchun mahsulotlar sonini ko'rsatish.

SELECT C.CategoryName,
       COUNT(*) AS ProductCount
FROM Products AS P
INNER JOIN Categories AS C ON P.Category = C.CategoryID
GROUP BY C.CategoryName;

--17.Listing orders where the customer is from Los Angeles and the order amount is greater than 300.
--Mijoz Los-Anjelesdan bo‘lgan va buyurtma miqdori 300 dan ortiq bo‘lgan buyurtmalarni ro‘yxatga olish.

SELECT C.FirstName,
       C.LastName,
       O.OrderID,
       O.TotalAmount AS Amount
FROM Customers AS C
INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
WHERE C.City = 'Los Angeles'
  AND O.TotalAmount > 300;

--18.Displaying employees who are in the HR or Finance department, or whose name contains at least 4 vowels.
--Kadrlar bo‘limi yoki Moliya bo‘limida ishlaydigan yoki ismida kamida 4 ta unli harf bo‘lgan xodimlarni ko‘rsatish.

SELECT E.Name AS EmployeeName,
       D.DepartmentName
FROM Employees AS E
INNER JOIN Departments AS D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName IN ('Human Resources',
                           'Finance')
  OR E.Name LIKE '%[AEIOU][AEIOU][AEIOU][AEIOU]%';

--19.Showing employees who are in the Sales or Marketing department and have a salary above 60000.
--Savdo yoki marketing bo‘limida ishlaydigan va maoshi 60000 dan yuqori bo‘lgan xodimlarni ko‘rsatish.

SELECT E.Name AS EmployeeName,
       D.DepartmentName,
       E.Salary
FROM Employees AS E
INNER JOIN Departments AS D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName IN ('Sales',
                           'Marketing')
  AND E.Salary > 60000;
