--------------Easy Level----------------------
 --1.Split the Name column by a comma into two separate columns: Name and Surname.
--Ism ustunini vergul bilan ikkita alohida ustunga ajrating: Ism va Familiya.

SELECT Name,
       left(Name, CHARINDEX(',', Name) - 1) AS Name,
       SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(name)) AS Surname
FROM TestMultipleColumns;

--2.Find strings from a table where the string itself contains the % character.
--Jadvaldan satrlarni toping, bu satrning o‘zida % belgisi bo‘lsin.

SELECT Strs
FROM TestPercent
WHERE Strs LIKE '%[%]%';

--3.Split a string based on dot.
--Satrni nuqta orqali ajratish.

SELECT Id,
       Vals,
       value
FROM Splitter CROSS APPLY string_split(Vals, '.') ;

--4.Return all rows where the value in the Vals column contains more than two dots.
--Vals ustunidagi qiymatlarning orasida 2 tadan ortiq nuqta bo'lgan qatorlarni ko'rsatish.

SELECT *
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;

--5.Count the spaces present in the string.
--Satrda mavjud bo‘sh joylarni sanang.

SELECT LEN(texts) - LEN(REPLACE(texts, ' ', ''))
FROM CountSpaces;

--6.Finds out employees who earn more than their managers.
--O'z boshliqlaridan ham ko'p maosh oluvchi ishchilarni topish.

SELECT E.*,
       M.Salary AS Man_Salary
FROM Employee AS E
JOIN Employee AS M ON E.ManagerId = M.Id
WHERE E.Salary > M.Salary;

--7.Find the employees who have been with the company for more than 10 years, but less than 15 years.
--Kompaniya bilan 10 yil birga bo'lgan ammo 15 yildan ko'p bo'lmagan ishchilarni topish.

SELECT EMPLOYEE_ID,
       FIRST_NAME,
       LAST_NAME,
       HIRE_DATE,
       DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS Experience
FROM Employees
WHERE DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 15;

--------------------------------------Medium Level----------------------------------
 --1.Find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.
--Oldingi kunga qaraganda issiqroq bo'lgan kun idlarini topish.
--SOLUTION.1

SELECT W1.Id
FROM weather AS W1
INNER JOIN weather W2 ON DATEADD(DAY, -1, W1.RecordDate) = W2.RecordDate
WHERE W1.Temperature > W2.Temperature;

--SOLUTION.2

SELECT Id
FROM
  (SELECT *,
          LAG(Temperature) OVER (
                                 ORDER BY RecordDate) AS PrevTemp
   FROM weather) t
WHERE Temperature > PrevTemp;

--2.Reports the first login date for each player.
--Har bir o'yinchi uchun birinchi ro'yxatdan o'tishni ko'rsatish.

SELECT player_id,
       MIN(event_date) AS firstlogin
FROM Activity
GROUP BY player_id;
 
--3.Return the third item from that list.
--Ushbu jadvaldan 3 chi narsani chiqarish.

SELECT SUBSTRING(fruit_list,
                 CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) + 1, 
                 CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) + 1) - CHARINDEX(',', fruit_list, CHARINDEX(',', fruit_list) + 1) - 1) AS third_value
FROM fruits;

--4.Determining Employees based on their hire dates.
--Ishchilarni ularning ishka olinish kunlari bo'yocha guruhlash.

SELECT CONCAT_WS(' ', FIRST_NAME, LAST_NAME) AS FullName, 
       HIRE_DATE, 
       CASE 
           WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire' 
           WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 1 AND 4 THEN 'Junior' 
           WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 5 AND 9 THEN 'Mid-Level' 
           WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 20 THEN 'Senior' 
           WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 20 THEN 'Veteran'
       END AS EmployeeStage
FROM Employees;

--5.Extract the integer value that appears at the start of the string in a column named Vals
--Satr boshida keluvchi sonni chiqarib olish.

SELECT LEFT(VALS, PATINDEX('[0-9]%', VALS)) AS INTS
FROM GetIntegers;

----------------------Hard level--------------------
 --1.Swapping to comma seperated string.
--Vergul bilan ajratilgan satrga o'tkazish.
WITH SplitVals AS 
  (SELECT ID, 
          VALS, 
          SUBSTRING(Vals, 1, CHARINDEX(',', Vals) - 1) AS first_val, 
          SUBSTRING(Vals, CHARINDEX(',', Vals) + 1, CHARINDEX(',', Vals, CHARINDEX(',', Vals) + 1) - CHARINDEX(',', Vals) - 1) AS second_val, 
          SUBSTRING(Vals, CHARINDEX(',', Vals, CHARINDEX(',', Vals) + 1) + 1, LEN(Vals)) AS rest_vals 
   FROM MultipleVals) 
SELECT Id, 
       VALS, 
       CONCAT_WS(',', second_val, first_val, rest_vals) SplittedVals
FROM SplitVals;

--2.Create a table where each character from the string will be converted into a row
--.Har bir belgi alohida qatorga o'tkazilgan jadval yaratish.
DECLARE @INP VARCHAR(50)= 'sdgfhsdgfhs@121313131' DECLARE @CH INT = 1 DECLARE @L INT = LEN(@INP)
CREATE TABLE #SMTH (POS INT, CHAR NVARCHAR(1)) WHILE @CH <= @L BEGIN
INSERT INTO #SMTH (POS, CHAR)
VALUES(@CH,
       SUBSTRING(@INP, @CH, 1))
SET @CH += 1 END
SELECT *
FROM #SMTH;

--3.Reports the device that is first logged in for each player
--Har bir o‘yinchi uchun birinchi kirilgan qurilma haqida xabar beradi.

SELECT player_id,
       MIN(device_id) AS [1stLogged_Device]
FROM Activity
GROUP BY player_id;

--4.Separate the integer values and the character values into two different columns
--Butun son qiymatlari va belgi qiymatlarini ikkita turli ustunga ajrating.
DECLARE @STRING VARCHAR(40) = 'rtcfvty34redt' 
DECLARE @N INT = 0 
DECLARE @LENGTH INT = LEN(@STRING) 
DECLARE @NUM VARCHAR(50) = '' 
DECLARE @CHARACTER VARCHAR(50) = '' 
WHILE @N <= @LENGTH 
BEGIN 
  IF ASCII(SUBSTRING(@STRING, @N+1, 1)) BETWEEN 48 AND 57 
  BEGIN
    SET @NUM += SUBSTRING(@STRING, @N+1, 1) 
  END 
ELSE IF ASCII(SUBSTRING(@STRING, @N+1, 1)) BETWEEN 97 AND 122 
  BEGIN
    SET @CHARACTER += SUBSTRING(@STRING, @N+1, 1) 
  END
    SET @N = @N + 1 
  END
SELECT NUMBER = @NUM,
       CHARACTER = @CHARACTER;
