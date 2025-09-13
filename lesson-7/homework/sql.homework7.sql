-- 1. Products jadvalidagi eng arzon narxni topish
SELECT MIN(Price) AS Min_Price
FROM Products;

-- 2. Employees jadvalidagi eng yuqori maoshni topish
SELECT MAX(Salary) AS Highest_Salary
FROM Employees;

-- 3. Customers jadvalidagi barcha qatorlarni sanash
SELECT COUNT(*) AS Number_Of_Rows
FROM Customers;

-- 4. Products jadvalidagi noyob (DISTINCT) kategoriyalar soni
SELECT COUNT(DISTINCT Category) AS Unique_Categories
FROM Products;

-- 5. Sales jadvalidan faqat ProductID=7 bo‘yicha umumiy sotuv summasi
SELECT SUM(SaleAmount) AS Total_Sales_For_7
FROM Sales
WHERE ProductID = 7;

-- 6. Employees jadvalidagi xodimlarning o‘rtacha yoshini hisoblash
SELECT AVG(Age) AS Avg_Age
FROM Employees;

-- 7. Har bir bo‘limdagi xodimlar sonini hisoblash
SELECT DepartmentName,
       COUNT(EmployeeID) AS Employee_Count
FROM Employees
GROUP BY DepartmentName;

-- 8. Har bir kategoriya bo‘yicha eng arzon va eng qimmat narxni topish
SELECT Category,
       MIN(Price) AS Min_Price,
       MAX(Price) AS Max_Price
FROM Products
GROUP BY Category;

-- 9. Har bir mijoz bo‘yicha umumiy sotuv summasi
SELECT CustomerID,
       SUM(SaleAmount) AS Total_Sales
FROM Sales
GROUP BY CustomerID;

-- 10. 5 tadan ko‘p xodimi bor bo‘limlarni chiqarish
SELECT DepartmentName,
       COUNT(EmployeeID) AS Employee_Count
FROM Employees
GROUP BY DepartmentName
HAVING COUNT(EmployeeID) > 5;


-- 11. Har bir kategoriya bo‘yicha umumiy va o‘rtacha sotuv summasi
SELECT p.Category,
       SUM(s.SaleAmount) AS Total_Sales,
       AVG(s.SaleAmount) AS Avg_Sale
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.Category;

-- 12. HR bo‘limidagi xodimlar soni
SELECT DepartmentName,
       COUNT(EmployeeID) AS Num_Emp
FROM Employees
WHERE DepartmentName = 'HR'
GROUP BY DepartmentName;

-- 13. Har bir bo‘lim bo‘yicha eng katta va eng kichik maoshni topish
SELECT DepartmentName,
       MAX(Salary) AS Max_Salary,
       MIN(Salary) AS Min_Salary
FROM Employees
GROUP BY DepartmentName;

-- 14. Har bir bo‘lim bo‘yicha o‘rtacha maoshni topish
SELECT DepartmentName,
       AVG(Salary) AS Avg_Salary
FROM Employees
GROUP BY DepartmentName;

-- 15. Har bir bo‘lim bo‘yicha o‘rtacha maosh va xodimlar sonini chiqarish
SELECT DepartmentName,
       AVG(Salary) AS Avg_Salary,
       COUNT(*) AS Num_Emp
FROM Employees
GROUP BY DepartmentName;

-- 16. O‘rtacha narxi 400 dan katta bo‘lgan kategoriyalarni chiqarish
SELECT Category,
       AVG(Price) AS Avg_Price
FROM Products
GROUP BY Category
HAVING AVG(Price) > 400;

-- 17. Har bir yil bo‘yicha umumiy sotuv summasi
SELECT YEAR(SaleDate) AS Sale_Year,
       SUM(SaleAmount) AS Total_Sales
FROM Sales
GROUP BY YEAR(SaleDate)
ORDER BY Sale_Year;

-- 18. Kamida 3 ta buyurtma qilgan mijozlar
SELECT CustomerID,
       COUNT(OrderID) AS Num_Orders
FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) >= 3;

-- 19. O‘rtacha maoshi 60000 dan katta bo‘lgan bo‘limlar
SELECT DepartmentName,
       AVG(Salary) AS Avg_Salary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 60000;

-- 20. Har bir kategoriya bo‘yicha o‘rtacha narx, faqat 150 dan katta bo‘lsa chiqariladi
SELECT Category,
       AVG(Price) AS Avg_Price
FROM Products
GROUP BY Category
HAVING AVG(Price) > 150;

-- 21. Har bir mijoz bo‘yicha umumiy sotuv summasi, faqat 1500 dan katta bo‘lsa chiqariladi
SELECT CustomerID,
       SUM(SaleAmount) AS Total_Amount
FROM Sales
GROUP BY CustomerID
HAVING SUM(SaleAmount) > 1500;

-- 22. Har bir bo‘lim bo‘yicha jami va o‘rtacha maosh,
-- faqat o‘rtacha maosh 65000 dan katta bo‘lsa
SELECT DepartmentName,
       SUM(Salary) AS Total_Salary,
       AVG(Salary) AS Avg_Salary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 65000;

-- 23. Har bir mijoz bo‘yicha freight > 50 bo‘lgan buyurtmalar summasi
-- va eng kichik freight qiymatini topish
SELECT custid,
       SUM(CASE WHEN freight > 50 THEN freight END) AS Total_Freight_Over_50,
       MIN(freight) AS Least_Freight
FROM TSQL2012.Sales.Orders
GROUP BY custid
HAVING SUM(CASE WHEN freight > 50 THEN freight END) IS NOT NULL
ORDER BY custid;

-- 24. Har bir yil/oy va mahsulot bo‘yicha buyurtmalarni sanash,
-- kamida 2 ta buyurtma bo‘lsa chiqariladi
SELECT ProductID,
       COUNT(OrderID) AS Num_Orders,
       MONTH(OrderDate) AS Month,
       YEAR(OrderDate) AS Year
FROM Orders
GROUP BY ProductID, YEAR(OrderDate), MONTH(OrderDate)
HAVING COUNT(OrderID) >= 2
ORDER BY Year, Month, ProductID;

-- 25. Har bir yil bo‘yicha eng kichik va eng katta buyurtma miqdori (Quantity)
SELECT YEAR(OrderDate) AS Year,
       MIN(Quantity) AS Min_Order,
       MAX(Quantity) AS Max_Order
FROM Orders
GROUP BY YEAR(OrderDate);
