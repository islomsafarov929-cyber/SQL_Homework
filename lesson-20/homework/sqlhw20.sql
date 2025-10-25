--1.Customers who have purchased at least 1 item in March 2024.
--2024-yil martda kamida 1 ta mahsulot xarid qilgan mijozlar.

SELECT S1.CustomerName
FROM Sales AS S1
WHERE EXISTS
    (SELECT 1
     FROM Sales S2
     WHERE S1.CustomerName= S2.CustomerName
       AND Quantity >=1
       AND SaleDate LIKE '2024-03%');

--2.Products with highest total sales revenue.
--Eng katta daromad keltirgan mahsulot.

SELECT Product,
       SUM(Quantity*Price) AS TotalSalesRevenue
FROM Sales
GROUP BY Product
HAVING SUM(Quantity*Price) =
  (SELECT MAX(TTLREV)
   FROM
     (SELECT SUM(Quantity*Price) AS TTLREV
      FROM Sales
      GROUP BY Product) AS B);

--3.Second highest sale amount.
--Ikkinchi eng baland sotuv.

SELECT SaleID,
       CustomerName,
       Product,
       Quantity,
       Price,
       Price*Quantity AS SALEAMOUNT
FROM Sales
WHERE Price*Quantity IN
    (SELECT MIN(SA)
     FROM
       (SELECT TOP 2 Price*Quantity AS SA
        FROM Sales
        ORDER BY 1 DESC) AS D);
  
--4.Total quanity of product by month.
--Oylar bo'yicha jami sotilgan mahsulotlar.

  SELECT MONTH(S.SaleDate) AS SaleMonth,

    (SELECT SUM(Quantity)
     FROM Sales AS S1
     WHERE MONTH(S.SaleDate) = MONTH(S1.SaleDate)) AS TotalQuantity
  FROM Sales AS S
GROUP BY MONTH(S.SaleDate);

--5.Customers who bought same product.
--Bir xil mahsulot xarid qilgan mijozlar.

SELECT DISTINCT CustomerName
FROM Sales AS S
WHERE EXISTS
    (SELECT 1
     FROM Sales AS S1
     WHERE S1.Product = S.PRODUCT
       AND S.CustomerName <> S1.CustomerName);

--6.Individual fruit level.
--Shaxsiy mevalar soni.

SELECT *
FROM Fruits PIVOT(COUNT(Fruit)
                  FOR Fruit IN ([Apple], [Orange], [Banana])) AS pvt_table;

--7.Parent and children.
--Ota va bolalar.
WITH CTE AS
  (SELECT *
   FROM Family
   UNION ALL SELECT C.ParentId,
                    F.ChildID
   FROM CTE AS C
   JOIN Family AS F ON C.ChildID = F.ParentId)
SELECT *
FROM CTE
ORDER BY 1,
         2;

--8.California and Texas.
--Californiya va Teksas.

SELECT *
FROM Orders
WHERE CustomerID IN
    (SELECT CustomerID
     FROM Orders
     WHERE DeliveryState = 'CA')
  AND DeliveryState = 'TX';

--9.Inserting names of residentd if they are missing.
--Agar fuqaroning ismi yoq bo'lsa uni qo'shish.

UPDATE r
SET fullname = SUBSTRING(r.address, CHARINDEX('name=', r.address) + 5, -- "name="dan keyingi pozitsiyadan boshlab
 CHARINDEX(' age=', r.address + ' age=') - CHARINDEX('name=', r.address) - 5 -- "age="gacha bo'lgan uzunlikni topish
)
FROM residents AS r 
WHERE r.fullname IS NULL 
  AND r.address LIKE '%name=%';

--10.The cheapest and most expensive route from Tashkent to Khorezm.
--Toshkentdan Xorazmgacha eng arzon va eng qimmat yo'l.
 WITH RoutePaths AS 
  (SELECT DepartureCity, 
          ArrivalCity, 
          CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(200)) AS Route, 
          Cost 
   FROM Routes 
   UNION ALL SELECT p.DepartureCity, 
                    r.ArrivalCity, 
                    CAST(p.Route + ' - ' + r.ArrivalCity AS VARCHAR(200)) AS Route, 
                    p.Cost + r.Cost AS Cost 
   FROM RoutePaths AS p 
   JOIN Routes AS r ON p.ArrivalCity = r.DepartureCity 
   WHERE p.Route NOT LIKE '%' + r.ArrivalCity + '%') 
SELECT Route, 
       Cost
FROM RoutePaths 
WHERE Route LIKE 'Tashkent%' 
  AND ArrivalCity = 'Khorezm'
  AND COST NOT IN (600,
                   550)
ORDER BY Cost;

--11.Ranking products by their order of insertion.
--Mahsulotlarni joylashtirish tartibi bo'yicha.
WITH Ranked AS 
  (SELECT *, -- Har safar 'Product' chiqqanda yangi guruh boshlanadi
 SUM(CASE 
         WHEN Vals = 'Product' THEN 1
         ELSE 0
     END) OVER (
                ORDER BY ID ROWS UNBOUNDED PRECEDING) AS ProductRank
   FROM RankingPuzzle)
SELECT ProductRank,
       Vals
FROM Ranked
ORDER BY ID;

--12.Employees whose sales are higher then the average sales in their department.
--O'z bo'limidagi o'rtacha sotuvdan ham ko'p sotuv qilgan ishchi.
WITH CTE AS
  (SELECT Department,
          AVG(SalesAmount) AS AVG_SAL
   FROM EmployeeSales
   GROUP BY Department)
SELECT E.EmployeeName
FROM CTE AS C
JOIN EmployeeSales AS E ON C.DEPARTMENT = E.Department
WHERE SalesAmount > AVG_SAL;

--13.Highest sales in any given month.
--Berilgan oydagi eng yuqori sotuv.

SELECT DISTINCT E1.EmployeeID,
                EmployeeName,
                E1.SalesMonth,
                E1.SalesAmount
FROM EmployeeSales AS E1
WHERE NOT EXISTS
    (SELECT 1
     FROM EmployeeSales AS E2
     WHERE E2.SalesMonth = E1.SalesMonth
       AND E2.SalesAmount > E1.SalesAmount);

--14.Employees who have sales in every month.
--Hamma oyda sotuvga ega ishchilar.

SELECT EmployeeName
FROM EmployeeSales
GROUP BY EmployeeName
HAVING COUNT(*) =
  (SELECT COUNT(DISTINCT SalesMonth)
   FROM EmployeeSales);

--15.The names of products that are expencice than the average price of all products.
--Barcha mahsulotning o'rtacha narxidan ham qimmat bo'lgan mahsulotlar.

SELECT Name
FROM Products
WHERE Price >
    (SELECT AVG(Price)
     FROM Products);

--16.Products that have stock count lower than the highest stock count.
--Soni eng ko'p songa ega mahsulotnikidan kam bo'lgan mahsulotlar.

SELECT Name,
       Stock
FROM Products
WHERE Stock <
    (SELECT MAX(Stock)
     FROM Products);

--17.Names of products that belong to the same category as 'Laptop'.
--'Laptop' bilan bir xil kategoriyadagi mahsulotlar.

SELECT Name
FROM Products
WHERE Category =
    (SELECT Category
     FROM Products
     WHERE Name = 'Laptop');

--18.Price greater than the lowest price in electronics category.
--Narxi elekronika kategoriyasidagi eng arzonidan qimmatroq bo'lgan mahsulotlar.

SELECT Name, 
       Price
FROM Products 
WHERE PRICE > 
    (SELECT MIN(Price)
     FROM Products 
     WHERE Category = 'Electronics');

--19.Products that have a higher price than the average price of their respective category.
--O'zlari tegishli bo'lgan kategoriyadagi o'rtacha narrxdan qimmat bo'lgan mahsulotlar.

SELECT Name,
       Price
FROM Products AS P
WHERE Price >
    (SELECT AVG(Price)
     FROM Products AS C
     WHERE P.Category = C.Category);

--20.Products that have ordered at least once.
--Kamida 1 marta buyurtma qilingan mahsulotlar.

SELECT Name
FROM Products
WHERE ProductID IN
    (SELECT ProductID
     FROM Orders);
  
--21.Names of products that have been ordered more than the average quantity ordered.
--Buyurtma qilinganlarning o'rtacha sonidan ko'proq buyurtma qilingan mahsulotlar.

  SELECT P.Name
  FROM Products P
  JOIN Orders O ON P.ProductID = O.ProductID WHERE O.Quantity >
    (SELECT AVG(Quantity)
     FROM Orders);

--22.Products that have never been ordered.
--Buyurtma qilinmagan mahsulotlar.

SELECT Name
FROM Products
WHERE ProductID NOT IN
    (SELECT ProductID
     FROM Orders)--23.Products with the highest total quantity ordered.
--Eng ko'p buyurtma qilingan mahsulot.

  SELECT P.Name
  FROM Products P
  JOIN Orders O ON P.ProductID = O.ProductID WHERE O.Quantity =
    (SELECT MAX(Quantity)
     FROM Orders);
