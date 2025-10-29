--1. Running Total Sales per Customer.
--Mijoz boyicha jami sotuv.

SELECT DISTINCT customer_id,
        customer_name,
        SUM(total_amount) OVER (PARTITION BY customer_id
                                ORDER BY customer_id) AS TotalSales
FROM sales_data;

--2.Number of Orders per Product Category.
--Mahsulot toifasi bo'yicha buyurtmalar soni.

SELECT product_category,
       COUNT(sale_id) AS NumberOfOrders
FROM sales_data
GROUP BY product_category;

--3.Maximum Total Amount per Product Category.
--Toifalar bo'yicha eng katta sotuv.

SELECT product_category,
       MAX(total_amount) AS HighestTotalAmount
FROM sales_data
GROUP BY product_category;

--4.Minimum Price of Products per Product Category.
--Toifalar bo'yicha eng arzon mahsulotlar.

SELECT product_category,
       MIN(unit_price) AS LowestTotalAmount
FROM sales_data
GROUP BY product_category;

--5.Moving Average of Sales of 3 days.
--3 kunlik o'rtacha sotuv.

SELECT order_date,
       AVG(total_amount) OVER (
                               ORDER BY order_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS AverageTotalAmount
FROM sales_data;

--6.Total sales per region.
--Hudud bo'yicha umumiy sotuv.

SELECT region,
       SUM(total_amount) AS TotalAmount
FROM sales_data
GROUP BY region;

--7.Rank of Customers Based on Their Total Purchase Amount.
--Mijozlarni umumiy sotib olganiga qarab o'rinlash.

SELECT customer_id,
       customer_name,
       total_amount,
       DENSE_RANK() OVER (
                          ORDER BY total_amount DESC) AS DR
FROM (SELECT customer_id, customer_name, SUM(total_amount) AS total_amount
    FROM sales_data
    GROUP BY customer_id, customer_name
) A;

--8.Difference Between Current and Previous Sale Amount per Customer.
--Har bir mijozga to‘g‘ri keladigan joriy va oldingi sotuv summasi o‘rtasidagi farq.

SELECT *
FROM
  (SELECT customer_id,
          customer_name,
          total_amount - LAG(total_amount, 1) OVER (PARTITION BY customer_id
                                                    ORDER BY order_date) Difference
   FROM sales_data) A
WHERE Difference IS NOT NULL;

--9.Top 3 Most Expensive Products in Each Category.
--Har bir toifa uchun top 3 eng qimmat mahsulotlar.

SELECT product_category,
       product_name,
       unit_price
FROM
  (SELECT product_category,
          product_name,
          unit_price,
          DENSE_RANK() OVER (PARTITION BY product_category
                             ORDER BY unit_price DESC) AS DR
   FROM sales_data) A
WHERE DR IN (1,
             2,
             3);

--10.Cumulative Sum of Sales Per Region by Order Date
--Hudud bo'yicha umumiy sotuv.

SELECT region,
       order_date,
       SUM(total_amount) OVER (PARTITION BY region
                               ORDER BY order_date) AS Amount
FROM sales_data;

--11.Cumulative Revenue per Product Category.
--Toifa bo'yicha umumiy daromad.

SELECT product_category,
       SUM(total_amount) AS TotalAmount
FROM sales_data
GROUP BY product_category;

--12.Sum of previous values.
--Oldingi qiymatlar yig'indisi.

SELECT ID,
       SUM(ID) OVER (
                     ORDER BY ID) AS SumPreValues
FROM sumofprevval;

--13.Sum of Previous Values to Current Value.
--Hozirgi va oldingi qiymatlar yig'indisi.

SELECT Value,
       SUM(Value) OVER (
                        ORDER BY Value ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS [Sum of Previous]
FROM OneColumn;

--14.Customers who have purchased items from more than one product_category.
--1 tadan ortiq toifadan xarid qilgan mijozlar.

SELECT customer_id,
       customer_name,
       COUNT(*) AS CategoryCount
FROM sales_data
GROUP BY customer_id,
         customer_name
HAVING COUNT(DISTINCT product_category) > 1;

--15.Customers with Above-Average Spending in Their Region.
--O'z hududidagi o'rtachadan ko'p ishlatgan mijozlar.
WITH CTE AS
  (SELECT region,
          AVG(total_amount) AS AVGTTL
   FROM sales_data
   GROUP BY region),
     CTE1 AS
  (SELECT region,
          customer_id,
          customer_name,
          SUM(total_amount) AS TotalSpending
   FROM sales_data
   GROUP BY customer_id,
            customer_name,
            region)
SELECT C1.customer_id,
       C1.customer_name,
       C1.TotalSpending
FROM CTE1 C1
JOIN CTE C ON C1.region=C.region
WHERE C1.TotalSpending > C.AVGTTL;

--16.Rank customers based on their total spending within each region.
--Hudud doirasida mijozlarni sarflash bo'yocha o'rinlash.

SELECT region,
       customer_id,
       customer_name,
       Spending,
       DENSE_RANK() OVER (PARTITION BY region
                          ORDER BY Spending DESC) AS DR
FROM ( SELECT region, customer_id, customer_name, SUM(total_amount) AS Spending
    FROM sales_data
    GROUP BY region, customer_id, customer_name
) A;

--17.Running total amount for each customer.
--Mijoz bo'yicha umumiy sotuv.

SELECT customer_id,
       customer_name,
       order_date,
       SUM(total_amount) OVER (PARTITION BY customer_id
                               ORDER BY order_date) cumulative_sales
FROM sales_data;

--18.Sales growth rate for each month compared to the previous month.
--Har bir oyning oldingi oyga nisbatan o'sish miqdori.
--Based on a given table:

SELECT MonthOfOrder,
       (total_amount - LAG(total_amount, 1) OVER (
                                                  ORDER BY MonthOfOrder)) / LAG(total_amount, 1) OVER (
                                                                                                       ORDER BY MonthOfOrder) * 100 AS GrowthRate
FROM
  (SELECT MONTH(order_date) AS MonthOfOrder,
          SUM(total_amount) AS total_amount
   FROM sales_data
   GROUP BY MONTH(order_date)) A;

--With other years (if we have on table):

SELECT YearMonth,
       (total_amount - LAG(total_amount, 1) OVER (
                                                  ORDER BY YearMonth)) / LAG(total_amount, 1) OVER (
                                                                                                    ORDER BY YearMonth) * 100 AS GrowthRate
FROM
  (SELECT CAST(YEAR(order_date) AS VARCHAR) + '-' + RIGHT('0' + CAST(MONTH(order_date) AS VARCHAR), 2) AS YearMonth,
          SUM(total_amount) AS total_amount
   FROM sales_data
   GROUP BY YEAR(order_date),
            MONTH(order_date)) B;

--19.Customers whose total_amount is higher than the last orders total_amount
--Eng oxirgi buyurtma dan kattaroq buyurtma qilgan mijozlar.

SELECT customer_id,
       customer_name,
       total_amount
FROM sales_data
WHERE total_amount >
    (SELECT total_amount
     FROM sales_data
     WHERE order_date =
         (SELECT MAX(order_date)
          FROM sales_data));

--20.Products that prices are above the average product price.
--Ortacha narxdan qimmat bo'lgan mahsulotlar.

SELECT product_name,
       unit_price
FROM sales_data
WHERE unit_price >
    (SELECT AVG(unit_price)
     FROM sales_data);

--21.Sum of val1 and val2.
--Val1 va val2 ning yig'indisi.
WITH CTE AS
  (SELECT ID,
          Grp,
          Val1,
          Val2,
          SUM(Val1) OVER (PARTITION BY GRP) + SUM(Val2) OVER (PARTITION BY GRP) AS Tot,
          ROW_NUMBER() OVER (PARTITION BY GRP
                             ORDER BY ID) AS RN
   FROM MyData)
SELECT ID,
       Grp,
       Val1,
       Val2,
       IIF(RN=1, Tot, NULL) AS Tot
FROM CTE;

--22.Sum of values.
--Qiymatlar yig'indisi.

SELECT ID,
       SUM(Cost) AS Cost,
       SUM(DISTINCT Quantity) AS Quantity
FROM TheSumPuzzle
GROUP BY ID;

--23.Finding Gap start end Gap end.
--Bo'shliq boshlanishi va tugashini topish.
WITH CTE AS
  (SELECT SeatNumber,
          LAG(SeatNumber) OVER (
                                ORDER BY SeatNumber) AS PrevSeat
   FROM Seats),
     CTE1 AS
  (SELECT PrevSeat + 1 AS GapStart,
          SeatNumber - 1 AS GapEnd
   FROM CTE
   WHERE SeatNumber - PrevSeat > 1)
SELECT GapStart,
       GapEnd
FROM CTE1;
