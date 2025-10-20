--1.Stored procedure that has temp table #EmployeeBonus.
--EmployeeBonus nomli vaqtinchalik jadvalga ega stored proc yaratish.

CREATE PROCEDURE sp_EmployeeBonus AS BEGIN
SELECT E.EmployeeID,
       CONCAT(E.FirstName, ' ', E.LastName) AS FullName,
       E.Department,
       E.Salary,
       CAST(E.Salary * D.BonusPercentage / 100 AS INT) AS BonusAmount INTO #EmployeeBonus
FROM Employees AS E
JOIN DepartmentBonus AS D ON E.Department = D.Department;
SELECT *
FROM #EmployeeBonus; END;

--2.Updates employees salary by given department name and increase percentage.
--Ishchining maoshini bo'limga qarab va o'shirish foiziga qarab o'zgartirish.

CREATE PROCEDURE sp_UPDATE_EMP_SAL @DEPT VARCHAR(20),
                                         @INC_PERC INT AS BEGIN
UPDATE Employees
SET SALARY = Salary * (1 + @INC_PERC / 100.0)
WHERE DEPARTMENT = @DEPT;
  SELECT *
  FROM Employees WHERE DEPARTMENT = @DEPT; END;

--3.Merge the tables with several conditions.
--Bir necha shartlar orqali jadvallarni bir xil ko'rinishga keltirish.

MERGE Products_Current AS TARGET USING Products_New AS SOURCE ON TARGET.ProductID = SOURCE.ProductID WHEN MATCHED THEN
UPDATE
SET ProductName = SOURCE.ProductName,
    Price = SOURCE.Price WHEN NOT MATCHED BY SOURCE THEN
DELETE WHEN NOT MATCHED BY TARGET THEN
INSERT
VALUES (SOURCE.ProductID, SOURCE.ProductName, SOURCE.Price) ;


SELECT *
FROM Products_Current;

--4.Tree Node
--Daraxt qismlari.

SELECT id,
       CASE
           WHEN p_id IS NULL THEN 'Root'
           WHEN id IS NOT NULL
                AND ID IN
                  (SELECT p_id
                   FROM Tree) THEN 'Inner'
           ELSE 'Leaf'
       END AS TYPE
FROM TREE;

--5.Confirmation Rate.
--Qabul qilinish foizi.

SELECT S.user_id,
       ROUND(AVG(CASE
                     WHEN C.action = 'confirmed' THEN 1.00
                     ELSE 0
                 END), 2) AS confirmation_rate
FROM Signups AS S
LEFT JOIN Confirmations AS C ON S.user_id = C.user_id
GROUP BY S.user_id
ORDER BY 2;

--6.Employees with lowest salary.
--Eng kam maosh oluvchi ishchilar.

SELECT *
FROM Employees
WHERE Salary =
    (SELECT MIN(Salary)
     FROM Employees);

--7.Get Product Sales Summary.
--Mahsulotning jami sotuvi.

CREATE PROCEDURE sp_GetProductSalesSummary @ProductID INT AS
SELECT P.ProductName,
       SUM(S.Quantity) AS TotalQuantitySold,
       SUM(S.Quantity * P.Price) AS TotalSalesAmount,
       MIN(S.SaleDate) AS FirstSaleDate,
       MAX(S.SaleDate) AS LastSaleDate
FROM Products AS P
LEFT JOIN Sales AS S ON P.ProductID = S.ProductID
WHERE P.ProductID = @ProductID
GROUP BY P.ProductName;
