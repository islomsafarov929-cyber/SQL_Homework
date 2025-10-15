--1.All combinations of distributors by region.
--Joy bo'yivha yetkazib beruvchilar.
;

WITH DIS AS
  (SELECT DISTINCT Distributor
   FROM #RegionSales),
     REG AS
  (SELECT DISTINCT Region
   FROM #RegionSales),
     ALL_COMB AS
  (SELECT Region,
          Distributor
   FROM DIS
   CROSS JOIN REG)
SELECT AC.*,
       ISNULL(RS.Sales, 0)
FROM ALL_COMB AS AC
LEFT JOIN #RegionSales AS RS ON AC.Region = RS.Region
AND AC.Distributor = RS.Distributor;

--2.Managers with at least 5 direct reports.
--Kamida 5 ta to'g'ridan to'g'ri joylashtirilgan boshqaruvchilar.

SELECT E.id,
       E.name,
       COUNT(*) REP_CNT
FROM Employee E
JOIN Employee M ON E.ID = M.managerId
GROUP BY M.managerId,
         E.name,
         E.id
HAVING COUNT(*) >= 5;

--3.Products with units at least 100 and ordered in february.
--Kamida 100 ta va fevralda buyurtma qilingan mahsulotlar.

SELECT P.product_name,
       SUM(O.unit) AS unit
FROM Products AS P
JOIN Orders AS O ON P.product_id = O.product_id
WHERE O.order_date BETWEEN '2020-02-01' AND '2020-02-28'
GROUP BY P.product_name
HAVING SUM(O.unit) >= 100
ORDER BY 2 DESC;

--4.Vendors that each customer plased most orders.
--Har bir mijoz eng ko'p buyurtma qilgan sotuvchilar.

SELECT O.CustomerID,
       O.Vendor
FROM
  (SELECT CustomerID,
          MAX(COUNT) AS MXCNT
   FROM Orders
   GROUP BY CustomerID) AS MXCNT
JOIN Orders AS O ON MXCNT.CustomerID = O.CustomerID
AND MXCNT.MXCNT = O.Count
ORDER BY O.CustomerID ASC;

--5.Checking the number is prime or not.
--Son tub yoki tub emasligini tekshirish.
DECLARE @Check_Prime INT = 91;

DECLARE @I INT=2 DECLARE @B BIT = 1 WHILE @I <= @Check_Prime /2 BEGIN IF @Check_Prime % @I = 0 BEGIN
SET @B = 0 BREAK;

END
SET @I += 1 END
SELECT CASE
           WHEN @B = 1 THEN 'This number is prime'
           ELSE 'This number is not prime'
       END AS RESULT;

--6.Locations which have most signlas sent, and total signals.
--Eng ko'p belgi jo'natgan manzil va belgilar soni.
WITH DeviceLocationCount AS
  (SELECT device_id,
          locations,
          COUNT(*) AS signals_per_location
   FROM Device
   GROUP BY device_id,
            locations),
     MaxSignalLocation AS
  (SELECT dl.device_id,
          dl.locations AS max_signal_location,
          dl.signals_per_location
   FROM DeviceLocationCount dl
   JOIN
     (SELECT device_id,
             MAX(signals_per_location) AS max_signals
      FROM DeviceLocationCount
      GROUP BY device_id) m ON dl.device_id = m.device_id
   AND dl.signals_per_location = m.max_signals),
     Totals AS
  (SELECT device_id,
          SUM(signals_per_location) AS no_of_signals,
          COUNT(*) AS no_of_location
   FROM DeviceLocationCount
   GROUP BY device_id)
SELECT t.device_id,
       t.no_of_location,
       m.max_signal_location,
       t.no_of_signals
FROM Totals t
JOIN MaxSignalLocation m ON t.device_id = m.device_id
ORDER BY t.device_id;

--7.Employees who earn more than the average salary in their department.
--O'z bo'limidagi o'rtacha maoshdan ko'proq topuvchi ishchilar.
--Solution.1
;

WITH CTE AS
  (SELECT DEPTID,
          AVG(Salary) AS AVG_SAL_DEPT
   FROM Employee
   GROUP BY DeptID)
SELECT E.EmpID,
       E.EmpName,
       E.Salary
FROM Employee AS E
JOIN CTE AS C ON E.DeptID = C.DeptID
WHERE E.Salary > C.AVG_SAL_DEPT;

--Solution.2

SELECT E.EmpID,
       E.EmpName,
       E.Salary
FROM Employee AS E
JOIN
  (SELECT DeptID,
          AVG(Salary) AS AVG_SAL_DEPT
   FROM Employee
   GROUP BY DeptID) AS D ON E.DeptID = D.DeptID
WHERE E.Salary > D.AVG_SAL_DEPT;

  --8.Lottery numbers and winnings.
--Lotoreya raqamlari va yutuqlar.

WITH CTE AS
    (SELECT T.TicketID,
            COUNT(*) AS CNT_NUM
     FROM Numbers AS N
     JOIN Tickets AS T ON N.Number = T.Number
     GROUP BY T.TicketID)
  SELECT DISTINCT T.TicketID,
                  CASE
                      WHEN C.CNT_NUM =
                             (SELECT COUNT(*)
                              FROM Numbers) THEN 100
                      WHEN C.CNT_NUM > 0 THEN 10
                      ELSE 0
                  END WINS
  FROM Tickets AS T
  LEFT JOIN CTE AS C ON T.TicketID = C.TicketID;

--9.Time spent with mobile and desktop.
--Kompyuter va telefonda sarflangan vaqt.
;

WITH CTE AS
  (SELECT COUNT(DISTINCT User_id) AS Total_users,
          Spend_date,
          SUM(Amount) AS Total_Amount
   FROM Spending
   GROUP BY Spend_date)
SELECT Spend_date,
       Platform,
       CASE
           WHEN PLATFORM = 'MOBILE'
                OR Platform = 'DESKTOP' THEN SUM(Amount)
           ELSE 0
       END AS Total_Amount,
       COUNT(DISTINCT User_id) AS Total_users
FROM Spending
GROUP BY Spend_date,
         PLATFORM
UNION ALL
SELECT Spend_date,
       'Both' AS Platform,
       Total_Amount,
       Total_users
FROM CTE
ORDER BY Spend_date,
         Platform DESC;

--10.De-group the following data.
--Ma'lumotni guruhlashdan chiqarish.
WITH Numbers AS
  (SELECT Product,
          Quantity,
          1 AS n
   FROM Grouped
   UNION ALL SELECT Product,
                    Quantity,
                    n + 1
   FROM Numbers
   WHERE n + 1 <= Quantity)
SELECT Product,
       1 AS Quantity
FROM Numbers
ORDER BY Product OPTION (MAXRECURSION 0);
