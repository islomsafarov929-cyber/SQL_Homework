--1.Temporary table that shows Store the total quantity sold and total revenue for each product in the current month.
--Joriy oyda har bir mahsulot bo‘yicha sotilgan umumiy miqdor va umumiy daromadga ega vaqtinchalik jadval.

SELECT P.ProductID,
       SUM(S.Quantity) AS TotalQuantity,
       SUM(S.Quantity * P.Price) AS TotalRevenue INTO #MonthlySales
FROM Products AS P
JOIN Sales AS S ON P.ProductID = S.ProductID
WHERE MONTH(S.SaleDate) = MONTH(GETDATE())
  AND YEAR(S.SaleDate) = YEAR(GETDATE())
GROUP BY P.ProductID;

--2.View that shows product information along vith total sales quantity across all the time.
--Barcha vaqt davomida umumiy sotuvlar soni bo‘yicha mahsulot ma’lumotlarini ko‘rsatuvchi View.

CREATE VIEW vw_ProductSalesSummary AS
SELECT P.ProductID,
       P.ProductName,
       P.Category,
       S.TotalQuantitySold
FROM Products AS P
JOIN
  (SELECT ProductID,
          SUM(Quantity) AS TotalQuantitySold
   FROM Sales
   GROUP BY ProductID) AS S ON P.ProductID = S.ProductID;

--3.Function that shows Total revenue.
--Daromadni ko'rsatuvchi funksiya.

CREATE FUNCTION fn_GetTotalRevenueForProduct(@ProductID INT) RETURNS DECIMAL(18, 2) AS BEGIN DECLARE @TotalRevenue DECIMAL(18, 2);
SELECT @TotalRevenue = SUM(P.Price * S.Quantity)
FROM Products AS P
JOIN Sales AS S ON P.ProductID = S.ProductID
WHERE P.ProductID = @ProductID; RETURN @TotalRevenue; END;

--4.Total revenue and total quantity sold by category (function).
--Tur bo'yicha daromad va qiymatni ko'rsatuvchi funksiya.

CREATE FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50)) RETURNS TABLE AS RETURN
  (SELECT P.ProductName, SUM(S.Quantity) AS TotalQuantity, SUM(S.Quantity * P.Price) AS TotalRevenue
   FROM Products AS P
   JOIN Sales AS S ON P.ProductID = S.ProductID
   WHERE P.Category = @Category
   GROUP BY ProductName);

--5.Prime number or not prime number.
--Tub yoki tub emas son.

CREATE FUNCTION dbo.fn_IsPrime (@Number INT) 
  RETURNS VARCHAR(5) 
  AS 
  BEGIN 
  IF @Number <= 1 RETURN 'No'; 
DECLARE @i INT = 2; 
DECLARE @Limit INT = CAST(SQRT(@Number) AS INT); 
WHILE @i <= @Limit 
  BEGIN IF @Number % @i = 0 RETURN 'No';
SET @i = @i + 1; END 
  RETURN 'Yes'; 
END; 

--6.Table with numbers.
--Sonli jadval.

CREATE FUNCTION fn_GetNumbersBetween(@Start INT, @End INT) 
  RETURNS @RESULT TABLE (N INT) 
  AS 
  BEGIN 
  DECLARE @C INT = @START; 
WHILE @C <= @End 
  BEGIN
INSERT INTO @RESULT
VALUES (@C)
SET @C += 1 
  END 
  RETURN; 
END; 

--7.Nth hiighest salary.
--N inchi eng baland maosh.

CREATE FUNCTION GetNthHighestSalary (@N INT) 
  RETURNS INT 
  AS 
  BEGIN 
  DECLARE @result INT;
SELECT @result =
  (SELECT DISTINCT TOP 1 Salary
   FROM Employees
   WHERE Salary NOT IN
       (SELECT DISTINCT TOP (@N - 1) Salary
        FROM Employees
        ORDER BY Salary DESC)
   ORDER BY Salary DESC); RETURN @result END 
  
  --8.Most friend.
--Eng ko'p do'st.

SELECT TOP 1 ID,
           SUM(CNT) AS NUM
FROM
  (SELECT requester_id AS ID,
          COUNT(accepter_id) AS CNT
   FROM RequestAccepted
   GROUP BY requester_id
   UNION ALL SELECT accepter_id AS ID,
                    COUNT(requester_id) AS CNT
   FROM RequestAccepted
   GROUP BY accepter_id) AS Q
GROUP BY ID
ORDER BY 2 DESC; 

--9.View that shows Customer Order Summary.
--Mijozning buyurtmalar soni.

CREATE VIEW vw_CustomerOrderSummary
  AS
SELECT C.customer_id,
       C.name,
       COUNT(O.order_id) AS total_orders,
       SUM(amount) AS total_amount,
       MAX(O.order_date) AS last_order_date
FROM Customers AS C
JOIN Orders AS O ON C.customer_id = O.customer_id
GROUP BY C.customer_id, C.name;

--10.Filling empty gaps.
--Bo'sh katakchalarni to'ldirish.

SELECT A.RowNumber,
       COALESCE(A.Workflow,
                  (SELECT TOP 1 B.WORKFLOW
                   FROM WORKFLOWTABLE AS B
                   WHERE B.ROWNUMBER< A.ROWNUMBER
                     AND B.WORKFLOW IS NOT NULL
                   ORDER BY B.ROWNUMBER DESC)) AS Workflow
FROM WorkflowTable AS A;
