--------------------------------------Easy Level---------------------------------------------
--1.Outputting "100-Steven King", meaning emp_id + first_name + last_name in that format using employees table.
--Xodimlar jadvali yordamida "100-Stiven King," ya’ni emp_id + first_name + last_name formatini chiqaradi.

SELECT TOP 1 CONCAT(EMPLOYEE_ID, '-', FIRST_NAME, ' ', LAST_NAME) AS EMPINFO
FROM Employees;

--2.Updating the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'.
--Xodimlar jadvalidagi telefon_raqam qismini yangilang, telefon raqamida ’124’ kichik satri ’999’ bilan almashtirish.

SELECT REPLACE(PHONE_NUMBER, '124', '999') AS NEW_PHONE_NUM
FROM Employees;

--3.Displaying the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'.
--Give each column an appropriate label. Sort the results by the employees' first names.
--Ismi "A," "J" yoki "M" harflari bilan boshlanadigan barcha xodimlarning ismi va ism uzunligini ko‘rsating. Har bir ustunga tegishli yorliq bering. 
--Natijalarni xodimlarning ismlari bo‘yicha tartiblang. (Xodimlar)

SELECT FIRST_NAME AS FirstName, 
       LEN(FIRST_NAME) AS LengthOfName 
FROM Employees 
WHERE FIRST_NAME LIKE '[AJM]%'
ORDER BY FirstName --4.Finding the total salary for each manager ID.
--Har bir menejer ID uchun umumiy ish haqini topish.

SELECT MANAGER_ID,
       SUM(SALARY) AS TotalSalary
FROM Employees
GROUP BY MANAGER_ID;

--5.Retrieving the year and the highest value from the columns Max1, Max2, and Max3 for each row in the TestMax table.
--TestMax jadvalidagi har bir qator uchun Max1, Max2 va Max3 ustunlaridan yil va eng yuqori qiymatni oling.

SELECT Year1,
       CASE
           WHEN Max1 >= Max2
                AND Max1 >= Max3 THEN Max1
           WHEN Max2 >= Max1
                AND Max2 >= Max3 THEN Max2
           ELSE Max3
       END AS MAX_VAL
FROM TestMax;

--6.Finding me odd numbered movies and description is not boring.
--Toq sonli va tavsifi zerikarli emas filmlarni ko'rsatish.

SELECT movie, 
       description
FROM cinema 
WHERE ID % 2 = 1
  AND description <> 'boring';

--7.Id with 0 always should be the last.
--Id 0 ga teng bo'lganlari doyim oxirgi bo'lishi kerak

SELECT *
FROM SingleOrder
ORDER BY CASE
             WHEN Id = 0 THEN 1
             ELSE 0
         END,
         Id DESC;

--8.select the first non-null value from a set of columns. If the first column is null, move to the next, and so on. If all columns are null, return null.
--ustunlar to‘plamidan birinchi noldan farqli qiymatni tanlash. Agar birinchi ustun nol bo‘lsa, keyingisiga o‘ting va hokazo.
--Agar barcha ustunlar bo‘sh bo‘lsa, bo‘sh qaytarish.

SELECT COALESCE(ssn, passportid, itin) AS FirstNonnullval
FROM person;

-------------------------------Medium Level---------------------------------------------------------------------------------------------------
--1.Splitting column FullName into 3 part.
--FullName ustunini 3 qismga ajratish.

SELECT PARSENAME(REPLACE(fullname, ' ', '.'), 3) AS firstname,
       PARSENAME(REPLACE(fullname, ' ', '.'), 2) AS middlename,
       PARSENAME(REPLACE(fullname, ' ', '.'), 1) AS lastname
FROM Students;

--2.For every customer that had a delivery to California, providing a result set of the customer orders that were delivered to Texas.
--Kaliforniyaga yetkazib berilgan har bir mijoz uchun Texasga yetkazib berilgan mijozlar buyurtmalarining natijaviy to‘plamini taqdim etish.

SELECT OTX.*
FROM Orders AS OCA
INNER JOIN Orders AS OTX ON OCA.CustomerID = OTX.CustomerID
WHERE OCA.DeliveryState = 'CA'
  AND OTX.DeliveryState = 'TX';

--3.Grouping concatenate the following values.
--Qiymatlarni guruhlab biriktirmoq.

SELECT STRING_AGG(String, ' ') AS GroupConcatenate
FROM DMLTable;

--4.Find all employees whose names contain the letter "a" at least 3 times.
--Ismida kamida 3 marta 'a' mavjud bo'lgan barcha ishchilarni topish.

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS FullName
FROM Employees 
WHERE LEN(REPLACE(LOWER(CONCAT(FIRST_NAME, LAST_NAME)), 'a', '')) <= LEN(LOWER(CONCAT(FIRST_NAME, LAST_NAME))) - 3;

--5.The total number of employees in each department and the percentage of those employees who have been with the company for more than 3 years.
--Har bir bo‘limdagi xodimlarning umumiy soni va kompaniyada 3 yildan ortiq ishlagan xodimlarning ulushi.

SELECT DEPARTMENT_ID,
       COUNT(*) AS TotalEmployees,
       COUNT(CASE
                 WHEN DATEADD(YEAR, 3, HIRE_DATE) <= GETDATE() THEN 1
             END) * 100.0 / COUNT(*) AS PercentageOver3Years
FROM Employees
GROUP BY DEPARTMENT_ID;

------------------------Hard Level------------------------------
--1.Replaces each row with the sum of its value and the previous rows' value.
--Har bir satrni uning qiymati va oldingi satrlarning qiymati yig‘indisi bilan almashtirish.

SELECT StudentID,
       FullName,
       SUM(Grade) OVER (
                        ORDER BY STUDENTID) AS Value
FROM Students;

--2.Finding the students that share the same birthday.
--Tug'ilgan kuni bir xil bo'lgan o'quvchilarni topish

SELECT *
FROM Student
WHERE Birthday IN
    (SELECT Birthday
     FROM Student
     GROUP BY Birthday
     HAVING COUNT(*) > 1)
ORDER BY Birthday;

--3.Pairing mutiple entries, aggrigateing and others
--Bir necha kirishlarni ulash, to'plash va boshqalar.

SELECT CASE
           WHEN PlayerA < PlayerB THEN PlayerA
           ELSE PlayerB
       END AS Player1,
       CASE
           WHEN PlayerB < PlayerA THEN PlayerB
           ELSE PlayerA
       END AS Player2,
       SUM(Score) AS TotalScore
FROM PlayerScores
GROUP BY CASE
             WHEN PlayerA < PlayerB THEN PlayerA
             ELSE PlayerB
         END,
         CASE
             WHEN PlayerB < PlayerA THEN PlayerB
             ELSE PlayerA
         END;

--4.Separating the uppercase letters, lowercase letters, numbers, and other characters from the given string 'tf56sd#%OqH' into separate columns.
--Berilgan tf56sd#%OqH satridagi bosh harflar, kichik harflar, raqamlar va boshqa belgilarni alohida ustunlarga ajratish.
DECLARE @STR VARCHAR(20) = 'tf56sd#%OqH' 
  DECLARE @LEN INT = LEN(@STR) 
  DECLARE @CHECKED INT = 0 
  DECLARE @UPPER VARCHAR(20) = ''
  DECLARE @LOWER VARCHAR(20) = '' 
  DECLARE @NUMBER VARCHAR(20) = '' 
  DECLARE @SYMBOL VARCHAR(20) = ''
  WHILE @CHECKED < @LEN 
  BEGIN 
  IF ASCII(SUBSTRING(@STR, @CHECKED+1, 1)) BETWEEN 65 AND 90 
  BEGIN
SET @UPPER += SUBSTRING(@STR, @CHECKED+1, 1) END 
  ELSE IF ASCII(SUBSTRING(@STR, @CHECKED+1, 1)) BETWEEN 97 AND 122 
  BEGIN
SET @LOWER += SUBSTRING(@STR, @CHECKED+1, 1) END 
  ELSE IF ASCII(SUBSTRING(@STR, @CHECKED+1, 1)) BETWEEN 48 AND 57 
  BEGIN
SET @NUMBER +=SUBSTRING(@STR, @CHECKED+1, 1) END 
  ELSE 
  BEGIN
SET @SYMBOL += SUBSTRING(@STR, @CHECKED+1, 1) END
SET @CHECKED += 1
  END
  
SELECT UPPERCASE = @UPPER,
       LOWERCASE = @LOWER,
       NUMBERS = @NUMBER,
       SYMBOLS = @SYMBOL;
