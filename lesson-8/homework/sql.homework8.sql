--1.Total number of products available in each category.
--Har bir mahsulot guruhi uchun umumiy mahsulotlar soni.
SELECT Category,
       COUNT(*) AS NUM_QUANTITY
FROM Products
GROUP BY Category;

--2.Finding products average price in the 'Electronics' category.
--'Electronics' jadvalidagi mahsulotlarning o'rtacha narxi.
SELECT AVG(PRICE) AS AVG_PRICE
FROM Products 
WHERE Category = 'Electronics';

--3.List of customers who from the city which it's name starts with letter 'L'
--Nomi 'L' harfi bilan boshlanuvchi shaharda yashovchi mijozlarning ro'yxati.
SELECT *
FROM Customers
WHERE City LIKE 'L%';

--4.List of all products which name end with 'er'.
--Nomi 'er' bilan tugaydigan barcha mahsulotlar ro'yxati.
SELECT ProductName
FROM Products 
WHERE ProductName LIKE '%er';

--5.List of all customers from countries ending 'A'
--Nomining tugashi 'A' bo'lgan barcha mijozlar ro'yxati.
SELECT FirstName,
       LastName,
       Country
FROM Customers
WHERE Country LIKE '%A';

--6.The highest price among all products.
--Barcha mahsulotlar ichidagi eng qimmat narx.
SELECT MAX(Price) AS HighestPrice
FROM Products;


--7.Labeling the stock as 'Low Stock' if quantity < 30 else 'Sufficent', in Products table.
--Mahsulotlar jadvalida miqdor < 30 bo‘lsa, zaxirani "Kam zaxira" yoki "Yetarli" deb belgiladi
SELECT ProductName,
       CASE
           WHEN StockQuantity < 30 THEN 'Low Stock'
           ELSE 'Sufficient'
       END AS Quantity
FROM Products;

--8.Finding the total number of customers in each country.
--Har bir davlat uchun barcha mijozlar.
SELECT Country,
       COUNT(CustomerID) AS NUM_CUSTOMERS
FROM Customers
GROUP BY Country;

--9.Finding the minimum and maximum quantity ordered.
--Eng ko'p va eng kam buyurtmalar.
SELECT MIN(Quantity),
       MAX(Quantity)
FROM Orders;

--10.From Orders and Invoices tables, listed customer IDs who placed orders in 2023 January to find those who did not have invoices.
--Buyurtmalar va hisobvaraq-fakturalar jadvallaridan 2023-yil yanvar oyida buyurtma bergan mijozlarning identifikatorlari ko‘rsatilgan,
--hisobvaraq-fakturalari bo‘lmagan mijozlarni topish.
SELECT DISTINCT CustomerID
FROM Orders 
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-01-31'
  AND CustomerID NOT IN 
    (SELECT DISTINCT CustomerID 
     FROM Invoices 
     WHERE InvoiceDate BETWEEN '2023-01-01' AND '2023-01-31'
     AND CustomerID IS NOT NULL);


--11.Combining all product names from Products and Products_Discounted including duplicates.
--Mahsulotlar va Mahsulotlar_Chegirmalidagi barcha mahsulot nomlarini, jumladan, dublikatlarini birlashmasi.
SELECT ProductName
FROM Products
UNION ALL
SELECT ProductName
FROM Products_Discounted;

--12.Combining all product names from Products and Products_Discounted without duplicates.
--Mahsulotlar va Mahsulotlar_Chegirmalidagi barcha mahsulot nomlarini, dublikatlarisiz.
SELECT ProductName
FROM Products
UNION
SELECT ProductName
FROM Products_Discounted;

--13.Finding average order amount by year.
--Yil bo'yicha o'rtacha buyurtma bahosi.
SELECT AVG(TotalAmount) AS AVG_AMOUNT,
       YEAR(OrderDate) AS BY_YEAR
FROM Orders
GROUP BY YEAR(OrderDate);

--14.Grouping products based on price: 'Low' (<100), 'Mid' (100-500), 'High' (>500). Returning productname and pricegroup.
--Mahsulotlarni narx bo'yicha: 'Low' (<100), 'Mid' (100-500), 'High' (>500), guruhlash. Mahsulot nomi va narx guruhini ko'rsatish.
SELECT ProductName,
       CASE
           WHEN Price < 100 THEN 'Low'
           WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
           WHEN Price > 500 THEN 'High'
       END AS PriceGroup
FROM Products;

--15.Using Pivot to show values of Year column in seperate columns ([2012], [2013]) and copying results to a new Population_Each_Year table.
--Yil ustuni qiymatlarini alohida ustunlarda ko‘rsatish uchun Pivot funksiyasidan foydalanish ([2012], [2013])
--va natijalarni yangi Population_Each_Year jadvaliga nusxalash.
SELECT district_name,
       [2012],
       [2013] INTO Population_Each_Year
FROM
  (SELECT district_name,
          YEAR,
          Population
   FROM City_Population) AS SourceTable 
PIVOT (SUM(Population)FOR YEAR IN ([2012], [2013])
) AS PivotTable;

--16.Finding total sales per product Id.
--Har bir mahsulotlar uchun jami sotuvlarni topish.
SELECT ProductID,
       SUM(SaleAmount) AS TotalAmount
FROM Sales
GROUP BY ProductID;

--17.Using wildcard to find products that contain 'oo' in the name. Returning productname.
--'Wildcard'dan foydalanib mahsulot nomida 'oo' bolganlarni topish.
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%oo%';

--18.Using Pivot to show values of City column in seperate columns (Bektemir, Chilonzor, Yakkasaroy) and copying results to a new Population_Each_City table.
--Pivot yordamida Shahar ustuni qiymatlarini alohida ustunlarda (Bektemir, Chilonzor, Yakkasaroy) ko‘rsatish
--va natijalarni yangi Population_Each_City jadvaliga nusxalash.
SELECT YEAR,
       [Bektemir],
       [Chilonzor],
       [Yakkasaroy] INTO Population_Each_City
FROM
  (SELECT district_name,
          YEAR,
          population
   FROM city_population) AS soursetbl 
PIVOT(SUM(POPULATION) FOR DISTRICT_NAME IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS PIVOTtable;

--19.Showing top 3 customers with the highest total invoice amount. Returning CustomerID and Totalspent.
--Hisob-faktura summasi eng yuqori bo‘lgan top 3 mijozni ko‘rsatish. CustomerID va Totalspent qaytarmoq.
SELECT TOP 3 CustomerID,
           SUM(TotalAmount) AS Total_Spent
FROM Invoices
GROUP BY CustomerID
ORDER BY SUM(TotalAmount) DESC;

--20.Transforming Population_Each_Year table to its original format.
--Population_Each_Year jadvalini uning daslabki holatiga qaytarish.
SELECT district_name,
       YEAR,
       POPULATION
FROM Population_Each_Year 
UNPIVOT(
population FOR YEAR IN ([2012], [2013])
) AS BCK_TO;

--21.Listing product names and the number of times each has been sold. (Researched for Joins)
--Mahsulot nomlari va har birining sotilish soni ko‘rsatilgan. (Joinlar uchun izlanish qilindi)
SELECT P.ProductName,
       COUNT(SaleID) AS SaleCount,
       SUM(SaleAmount) AS TotalQuantity
FROM Products AS P
INNER JOIN Sales AS S ON P.ProductID = S.ProductID
GROUP BY P.ProductName;

--22.Transforming Population_Each_City table to its original format.
--Population_Each_City jadvalini uning daslabki holatiga qaytarish.
SELECT district_name,
       YEAR,
       POPULATION
FROM Population_Each_City 
UNPIVOT(
population FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS BCK_TO_city;        
