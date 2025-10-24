--1.Row number for each sale based on the saledate.
--Sotuv kuniga qarab har bir sotuv uchun qator soni.
SELECT *, 
	   ROW_NUMBER() OVER (ORDER BY SaleDate) AS RN 
FROM ProductSales;

--2.Ranking products by total quantity sold.
--Sotuv soniga qarab mahsulotlarni o'rinlash.
SELECT ProductName, 
	   Quantity, 
	   DENSE_RANK() OVER (ORDER BY QUANTITY) AS DR 
FROM ProductSales;

--3.Top sale for each customer based on the SaleAmount.
--SaleAmount asosida har bir mijoz uchun eng yaxshi sotuv.
SELECT CustomerID, 
	   ProductName, 
	   SaleAmount, 
	   DENSE_RANK() OVER (PARTITION BY CUSTOMERID ORDER BY SALEAMOUNT DESC) AS DR 
FROM ProductSales;

--4.Each sale's amount along with the next sale amount in the order of SaleDate.
--SaleDate tartibida har bir sotuv summasi keyingi sotuv summasi bilan birga.
SELECT SaleAmount,
	   LEAD(SaleAmount,1) OVER (ORDER BY SaleDate) NextSaleAmount 
FROM ProductSales;

--5.Each sale's amount along with the previous sale amount in the order of SaleDate.
--SaleDate tartibida har bir sotuv summasi oldingi. sotuv summasi bilan birga.
SELECT SaleAmount,
	   LAG(SaleAmount,1) OVER (ORDER BY SaleDate) PreviousSaleAmount 
FROM ProductSales;

--6.Sales amounts that are greater than the previous sale's amount.
--Oldingi sotuv summasidan katta bo‘lgan sotuv summasi.
WITH CTE AS (
SELECT SaleAmount, 
	   LAG(SaleAmount,1) OVER (ORDER BY SaleDate) PreviousSaleAmount 
FROM ProductSales)
SELECT SaleAmount FROM CTE
WHERE SaleAmount > PreviousSaleAmount;

--7.Difference between saleamount and previuous one.
--Oldingi va xaqiqiy sotuvniing farqi.
SELECT *, 
	   ISNULL(SaleAmount - PreviousSaleAmount, 0) AS Difference 
FROM (SELECT SaleAmount, LAG(SaleAmount,1) OVER (ORDER BY SaleDate) PreviousSaleAmount  FROM ProductSales) AS A;

--8.Compare the current sale amount with the next sale amount in terms of percentage change.
--Foiz o‘zgarishi bo‘yicha joriy sotuv summasini keyingi sotuv summasi bilan taqqoslang.
SELECT SaleAmount, 
	   LEAD(SaleAmount,1) OVER (ORDER BY SaleDate) AS NextSaleAmount, 
	    ROUND((CAST(LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount AS FLOAT) / SaleAmount) * 100, 2) AS PercentageChange
FROM ProductSales;

--9.Calculate the ratio of the current sale amount to the previous sale amount within the same product.
--Shu mahsulot doirasida joriy sotish summasining avvalgi sotish summasiga nisbatini hisoblang.
SELECT ProductName ,
	   SaleAmount, 
	   LAG(SaleAmount,1) OVER (PARTITION BY PRODUCTNAME ORDER BY SaleDate) PreviousSaleAmount,
	   CAST(LAG(SaleAmount,1) OVER (PARTITION BY PRODUCTNAME ORDER BY SaleDate) AS float) / SaleAmount AS Ratio
FROM ProductSales;

--10.Calculate the difference in sale amount from the very first sale of that product.
--Shu tovarni birinchi sotishdayoq sotish summasidagi farqni hisoblang.
SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    FIRST_VALUE(SaleAmount) OVER (PARTITION BY PRODUCTNAME ORDER BY SaleDate) AS FirstSaleAmount,
    SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY PRODUCTNAME ORDER BY SaleDate) AS DifferenceFromFirst
FROM ProductSales;

--11.Find sales that have been increasing continuously for a product
--Mahsulot uchun uzluksiz o‘sib borayotgan sotuvlarni toping
SELECT ProductName,
	   SaleAmount,
	   LAG(SaleAmount,1) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PreviousSaleAmount,
	   CASE
		WHEN LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) IS NULL THEN 'No Previous Sale'
		WHEN SaleAmount > LAG(SaleAmount,1) OVER (PARTITION BY ProductName ORDER BY SaleDate) THEN 'Increasing'
		ELSE 'Not Increasing' END AS Status
FROM ProductSales;

--12.Running total saleamount.
--.....Gacha sotuv summasi.
SELECT
    ProductName,
    SaleDate,
    SaleAmount,
    SUM(SaleAmount) OVER (
        PARTITION BY ProductName 
        ORDER BY SaleDate 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS ClosingBalance
FROM ProductSales
ORDER BY ProductName, SaleDate;

--13.Avg amount in last 3 sales.
--Oxirgi 3 ta sotuvning o'rtacha sotuv summasi.
SELECT 
    ProductName,
    SaleDate,
    SaleAmount,
    AVG(SaleAmount) OVER (
        PARTITION BY ProductName
        ORDER BY SaleDate
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MovingAvg_Last3
FROM ProductSales
ORDER BY ProductName, SaleDate;

--14.Difference between saleamount and average amount.
--Sotuv summasi va o'rtacha sotuv orasidagi farq.
SELECT
    ProductName,
    SaleAmount,
    AVG(SaleAmount) OVER (PARTITION BY ProductName) AS AvgSaleAmount,
    SaleAmount - AVG(SaleAmount) OVER (PARTITION BY ProductName) AS DifferenceWithAvg
FROM ProductSales;

--15.Find Employees Who Have the Same Salary Rank.
--Bir xil maosh o'rniga ega bo'lgan ishchilar.
WITH CTE AS (SELECT *, DENSE_RANK() OVER (ORDER BY SALARY DESC) AS DR FROM Employees1) 
SELECT Name, Salary, DR FROM CTE
WHERE DR IN (SELECT DR FROM CTE GROUP BY DR HAVING COUNT(*)>1);

--16.Top 2 highest salary in each department.
--Har bir bo'limdagi eng baland 2 ta maosh.
SELECT Department,
	   Salary
FROM (SELECT Department, 
	   Salary,
	   ROW_NUMBER() OVER (PARTITION BY DEPARTMENT ORDER BY SALARY DESC) AS RN
FROM Employees1)AS A
WHERE RN IN (1, 2);

--17.Lowest-paid employee in each department.
--Har bir bo'limdagi eng kam to'lanadigan ishchi.
SELECT Department, 
	   Salary 
FROM (SELECT Department, Salary, ROW_NUMBER() OVER (PARTITION BY DEPARTMENT ORDER BY SALARY) AS RN FROM Employees1) AS D
WHERE RN = 1;

--18.Running total salaries in each department.
--Har bir bo'limdagi jami maoshlar.
SELECT 
    Department,
    Salary,
    SUM(Salary) OVER (
        PARTITION BY Department 
        ORDER BY Salary
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS RunningTotal
FROM Employees1;

--19.Total salary in each department without group by.
--Har bir bo'limdagi jami maosh.
SELECT DISTINCT Department,
	   SUM(Salary) OVER (PARTITION BY DEPARTMENT) AS TotalSalary
FROM Employees1;

--20.Average salary in each department without group by.
--Har bir bo'limdagi o'rtacha maosh.
SELECT DISTINCT Department,
	   AVG(Salary) OVER (PARTITION BY DEPARTMENT) AS AverageSalary
FROM Employees1;

--21.Difference between employees' salary end departments' average salary.
--Bo'limning o'rtacha maoshi va ishchining maoshi orasidagi farq.
SELECT Name,
	   Salary,
	   Salary - AVG(Salary) OVER (PARTITION BY DEPARTMENT) AS Difference
FROM Employees1;

--22.Moving average salary.
--Harakatlanayotgan o'rtacha maosh.
SELECT 
	Name,
    Salary,
    AVG(Salary) OVER (
        ORDER BY EmployeeID 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS MovingAvgSalary
FROM Employees1;

--23.Sum of Salaries for the Last 3 Hired Employees.
--Eng oxirgi 3 ta ishga olingan ishchining moash yig'indisi.
SELECT SUM(E.Salary) AS TotalSalary FROM (
SELECT TOP 3 EmployeeID, 
	   HireDate,
	   ROW_NUMBER() OVER (ORDER BY HIREDATE DESC) AS RN
FROM Employees1) AS E1 JOIN Employees1 AS E ON E1.EmployeeID = E.EmployeeID;
