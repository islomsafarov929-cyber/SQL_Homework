------------------------------------EASy Level---------------------------------
--1.Create Number from 1 to 1000 with recursive CTE.
--1 dab 1000 gacha sonlarni chiqarish.
 WITH NUMS AS
  (SELECT 1 AS NUM
   UNION ALL SELECT NUM + 1
   FROM NUMS)
SELECT NUM
FROM NUMS OPTION (MAXRECURSION 999);

--2.Total sales per employee with derived table.
 --Har bir ishchi uchun jami sotuv.

SELECT E.EmployeeID,
       E.DepartmentID,
       CONCAT_WS(' ', E.FirstName, E.LAStName) AS Name,
       E.Salary,
       S.SaleCount
FROM Employees AS E
INNER JOIN
  (SELECT COUNT(SalesID) AS SaleCount,
          EmployeeID
   FROM SALES
   GROUP BY EmployeeID) AS S ON E.EmployeeID = S.EmployeeID;

--3.Average salary of an employee with CTE.
--Xodimning o'zrtacha maoshi.
WITH AVGS AS
  (SELECT AVG(SALARY) AS AVG_SAL
   FROM Employees)
SELECT *
FROM AVGS;

--4.Highest sales for each product.
--Har bir mahsulotga eng katta sotuv.

SELECT P.ProductID,
       P.CategoryID,
       P.ProductName,
       P.Price,
       S.SaleAmount
FROM Products AS P
INNER JOIN
  (SELECT MAX(SalesAmount) AS SaleAmount,
          ProductID
   FROM Sales
   GROUP BY ProductID) AS S ON P.ProductID = S.ProductID;

--5.Starting with 1, output the number multiplied by 2 each time, the lASt number must be less than 1000000.
--1 dan boshlab har safar sonni 2 ga ko‘paytirilganini chiqarish, oxirgi son 1000000 dan kichik bo‘lishi kerak.
WITH NUMS2 AS
  (SELECT 1 AS NUM
   UNION ALL SELECT NUM * 2
   FROM NUMS2
   WHERE NUM * 2 < 1000000)
SELECT *
FROM NUMS2;

--6.Names of employees who have more than 5 sales.
--5 tadan ko'p saltuv qilgsn ishchilar ismlari.
WITH EMP_Name AS 
  (SELECT EmployeeID, 
          CONCAT_WS(' ', FirstName, LAStName) AS Name
   FROM Employees),
     SalesCount AS
  (SELECT EmployeeID,
          COUNT(SalesID) AS SaleCount
   FROM Sales
   GROUP BY EmployeeID
   HAVING COUNT(SalesID) > 5)
SELECT E.Name,
       S.SaleCount
FROM EMP_Name AS E
INNER JOIN SalesCount AS S ON E.EmployeeID = S.EmployeeID;

--7.The product with sales greater then 500$.
--500$ dan ko'p sotuvga ega bo'lgan barcha mahsulotlarni ko'rsatish.
WITH SaleAmount AS
  (SELECT ProductID,
          SalesAmount
   FROM Sales
   WHERE SalesAmount > 500)
SELECT P.ProductID,
       P.CategoryID,
       P.ProductName,
       P.Price,
       S.SalesAmount
FROM Products AS P
INNER JOIN SaleAmount AS S ON P.ProductID = S.ProductID;

--8.Employees with salaries above the average salary.
--Maoshi o'rtacha maoshdan balan bo'lgan ishchilar.
WITH AVG_SALARY AS
  (SELECT AVG(Salary) AS AverageSalary
   FROM Employees)
SELECT EmployeeID,
       CONCAT(FirstName, ' ', LAStName) AS Name,
       Salary
FROM Employees
WHERE Salary >
    (SELECT *
     FROM AVG_SALARY);

------------------------------------Medium Level-----------------------------------
--1.Top 5 employees by the number of orders made.
--Amalga oshirilgan buyurmalar soni bo'yicha top 5 ishchi.

SELECT TOP 5 E.EmployeeID, 
           E.DepartmentID, 
           CONCAT_WS(' ', E.FirstName, E.LAStName),
           Salary,
           SaleCount
FROM Employees AS E
INNER JOIN
  (SELECT COUNT(SalesID) AS SaleCount,
          EmployeeID
   FROM Sales
   GROUP BY EmployeeID) AS S ON E.EmployeeID = S.EmployeeID
ORDER BY SaleCount DESC;

--2.Sales per product category.
--Mahsulot turi bo'yicha sotuvlar soni.

SELECT P.CategoryID,
       SUM(S.SaleAmount) AS SaleAmount
FROM Products AS P
INNER JOIN
  (SELECT ProductID,
          SUM(SalesAmount) AS SaleAmount
   FROM Sales
   GROUP BY ProductID) AS S ON P.ProductID = S.ProductID
GROUP BY P.CategoryID;

--3.Returning factorial of each value next to it.
--Har bir qiymatning o'zidan keyingi faktorialini qaytarish.
WITH FACTCTE AS
  (SELECT NUMBER, 1 AS I,
                  1 AS FACT
   FROM Numbers1
   UNION ALL SELECT NUMBER, I+1,
                            FACT * (I+1)
   FROM FACTCTE
   WHERE I+1 <= NUMBER)
SELECT NUMBER, MAX(FACT) AS FACTORIAL
FROM FACTCTE
GROUP BY NUMBER
ORDER BY NUMBER;

--4.Splitting string into rows with recursion.
--Satrni qatorlarga ajratish.
WITH STRINGS AS
  (SELECT String , 1 AS POSITION,
                   SUBSTRING (String,1,
                                     1) AS CHARACTER
   FROM Example
   WHERE LEN(String)>=1
   UNION ALL SELECT s.String,
                    s.Position + 1,
                    SUBSTRING(String, POSITION+1, 1)
   FROM Strings AS s
   WHERE s.Position+1 <= LEN(s.String))
SELECT String, POSITION,
               CHARACTER
FROM STRINGS
ORDER BY CHARACTER;

--5.Difference between the cent month and pious month.
--Shu oy va oldingi oy dagi sotuv farqlarini topish.
WITH MonthlySales AS
  (SELECT YEAR(SaleDate) AS SaleYear,
          MONTH(SaleDate) AS SaleMonth,
          SUM(SalesAmount) AS TotalSales
   FROM Sales
   GROUP BY YEAR(SaleDate),
            MONTH(SaleDate))
SELECT c.SaleYear,
       c.SaleMonth,
       c.TotalSales,
       p.TotalSales AS PreviousMonthSales,
       (c.TotalSales - p.TotalSales) AS SalesDifference
FROM MonthlySales c
LEFT JOIN MonthlySales p ON (c.SaleYear = p.SaleYear
                             AND c.SaleMonth = p.SaleMonth + 1)
OR (c.SaleYear = p.SaleYear + 1
    AND c.SaleMonth = 1
    AND p.SaleMonth = 12)
ORDER BY c.SaleYear,
         c.SaleMonth;

--6.Employees with salary over $45000 in each quarter.
--Har bir chorak uchun $45000 dan ko'p maoshga ega ishchi.

SELECT E.FIRSTName,
       E.LASTName,
       s.SaleYear,
       s.SaleQuarter,
       s.TotalSales
FROM Employees e
JOIN
  (SELECT EMPLOYEEID,
          YEAR(SALEDATE) AS SaleYear,
          DATEPART(QUARTER, SALEDATE) AS SaleQuarter,
          SUM(SALESAMOUNT) AS TotalSales
   FROM Sales
   GROUP BY EMPLOYEEID,
            YEAR(SALEDATE),
            DATEPART(QUARTER, SALEDATE)
   HAVING SUM(SALESAMOUNT) > 45000) AS s ON e.EMPLOYEEID = s.EMPLOYEEID
ORDER BY E.FIRSTName,
         E.LASTName,
         s.SaleYear,
         s.SaleQuarter;

------------------------------------Hard Level-------------------------------------
--1.Fibonicci numbers.
--O'zidan oldingi 2 sonning yig'indisini ifodalovchi sonlar.

WITH Fibonicci AS
  (SELECT 1 AS N,
          0 AS A,
          1 AS B
   UNION ALL SELECT N+1,
                    B,
                    A+B
   FROM Fibonicci)
SELECT N AS POSITION,
       A AS FibonicciNumbers
FROM Fibonicci;

--2.All characters are the same and length is greater than 1.
--Barcha belgilari bir xil va uzunligi 1 dan katta.
WITH FibStrings AS
  (SELECT Id,
          Vals,
          LEN(Vals) AS LENGTH,
          REPLICATE(LEFT(Vals, 1), LEN(Vals)) AS Repeated
   FROM FindSameCharacters)
SELECT id,
       Vals
FROM FibStrings
WHERE LENGTH > 1
  AND Vals = Repeated;

--3.Increasing by the next number in the sequence.
--Keyingi sonni yoniga olib o'sib borish.
WITH Numbers AS 
  (SELECT CAST('1' AS VARCHAR(10)) AS seq,
          1 AS n
   UNION ALL SELECT seq + CAST(n + 1 AS VARCHAR(10)),
                    n + 1
   FROM Numbers
   WHERE n < 4)
SELECT seq
FROM Numbers;

--4.Employees with Most sales in 6 months.
--6 oy ichida eng ko'p sotuv qilgan ishchi.

SELECT E.EmployeeID, 
       CONCAT(E.FirstName, ' ', E.LastName) AS Name,
       S.SalesCount
FROM Employees AS E
JOIN
  (SELECT EmployeeID,
          COUNT(SalesID) AS SalesCount
   FROM Sales
   WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
   GROUP BY EmployeeID) AS S ON E.EmployeeID = S.EmployeeID
WHERE S.SalesCount =
    (SELECT MAX(SalesCount)
     FROM
       (SELECT EmployeeID,
               COUNT(SalesID) AS SalesCount
        FROM Sales
        WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
        GROUP BY EmployeeID) AS T);

--5.Remove duplicate integer values.
--Takrorlangan son qiymatlarni olib tashlash.

DELETE
FROM RemoveDuplicateIntsFromNames
WHERE RIGHT(Pawan_slug_name, LEN(Pawan_slug_name) - CHARINDEX('-', Pawan_slug_name)) IN
    (SELECT IntPart
     FROM
       (SELECT RIGHT(Pawan_slug_name, LEN(Pawan_slug_name) - CHARINDEX('-', Pawan_slug_name)) AS IntPart
        FROM RemoveDuplicateIntsFromNames) AS X
     GROUP BY IntPart
     HAVING COUNT(*) > 1)
  OR LEN(RIGHT(Pawan_slug_name, LEN(Pawan_slug_name) - CHARINDEX('-', Pawan_slug_name))) = 1;
