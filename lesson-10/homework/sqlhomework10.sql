--1.Writing a query to return the names and salaries of employees whose salary is greater than 50000, along with their department names.
--ish haqi 50 000 dan yuqori bo‘lgan xodimlarning ismlari va maoshlarini bo‘lim nomlari bilan birga qaytarish.
SELECT E.Name,
       E.Salary,
       D.DepartmentName
FROM Employees AS E
INNER JOIN Departments AS D ON E.DepartmentID = D.DepartmentID
WHERE E.Salary > 50000;

--2.Writing a query to display customer names and order dates for orders placed in the year 2023.
--2023-yilda berilgan buyurtmalar uchun mijozlar nomi va buyurtma sanasini ko‘rsatish uchun so‘rov yozing.
-- eng aniq va portable (sana oralig‘i)
SELECT C.FirstName, 
       C.LastName, 
       O.OrderDate
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.OrderDate >= '2023-01-01' AND O.OrderDate < '2024-01-01';

--3.Writing a query to show all employees along with their department names. Include employees who do not belong to any department.
--Barcha xodimlarni bo‘lim nomlari bilan birga ko‘rsatish uchun so‘rov yozish. Hech qanday bo‘limga tegishli bo‘lmagan xodimlarni qo‘shish.
SELECT E.Name,
       D.DepartmentName
FROM Employees AS E
LEFT OUTER JOIN Departments AS D ON E.DepartmentID = D.DepartmentID;

--4.Writing a query to list all suppliers and the products they supply. Show suppliers even if they don’t supply any product.
--Barcha ta’minotchilar va ular yetkazib beradigan mahsulotlarni ko‘rsatish uchun so‘rov yozish.
--Hech qanday mahsulot yetkazib bermasa ham, ta’minotchilarni ko‘rsatish.
SELECT S.SupplierName, 
       P.ProductName
FROM Suppliers AS S
LEFT JOIN Products AS P ON S.SupplierID = P.SupplierID;


--5.Writing a query to return all orders and their corresponding payments. Include orders without payments and payments not linked to any order.
--Barcha buyurtmalar va ularga tegishli to‘lovlarni qaytarish uchun so‘rov yozish. To‘lovlarsiz va hech qanday buyurtmaga bog‘lanmagan to‘lovlarni kiritish.
SELECT O.OrderID,
       O.OrderDate,
       P.PaymentDate,
       P.Amount
FROM Orders AS O
FULL OUTER JOIN Payments AS P ON O.OrderID = P.OrderID;

--6.Writing a query to show each employee's name along with the name of their manager.
--Har bir xodimning ismini uning rahbarining ismi bilan birga ko‘rsatish uchun so‘rov yozish.
SELECT EMP.Name AS EMPNAME,
       MNGR.Name AS MNGRNAME
FROM Employees AS EMP
LEFT JOIN Employees AS MNGR ON EMP.ManagerID = MNGR.EmployeeID;

--7.Writing a query to list the names of students who are enrolled in the course named 'Math 101'.
--"Math 101" nomli kursga yozilgan talabalarning ismlarini ko‘rsatish uchun so‘rov yozish.
SELECT S.Name,
       C.CourseName
FROM Students AS S
INNER JOIN Enrollments AS E ON S.StudentID = E.StudentID
INNER JOIN Courses AS C ON E.CourseID = C.CourseID
WHERE C.CourseName = 'Math 101';

--8.Write a query to find customers who have placed an order with more than 3 items. Return their name and the quantity they ordered.
--3 tadan ortiq mahsulotga buyurtma bergan mijozlarni topish. Ularning nomini va buyurtma qilingan miqdorni qaytarish.
SELECT C.FirstName,
       C.LastName,
       O.Quantity
FROM Customers AS C
INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
WHERE O.Quantity > 3;

--9.Writing a query to list employees working in the 'Human Resources' department.
--"Human Resources" bo‘limida ishlaydigan xodimlarni ro‘yxatlash uchun so‘rov yozing.
SELECT E.Name,
       D.DepartmentName
FROM Employees AS E
INNER JOIN Departments AS D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Human Resources';

--10.Writing a query to return department names that have more than 5 employees.
--5 dan ortiq xodimga ega bo‘lgan bo‘lim nomlarini qaytarish uchun so‘rov yozish.
SELECT D.DepartmentName,
       COUNT(E.EmployeeID) AS EmployeeCount
FROM Departments AS D
INNER JOIN Employees AS E ON D.DepartmentID = E.DepartmentID
GROUP BY D.DepartmentID,
         DepartmentName
HAVING COUNT(E.EmployeeID) > 5;

--11.Writing a query to find products that have never been sold.
--Hech qachon sotilmagan mahsulotlarni topish uchun so‘rov yozish.
SELECT P.ProductID,
       P.ProductName
FROM Products AS P
LEFT JOIN Sales AS S ON P.ProductID = S.ProductID
WHERE S.SaleID IS NULL;

--12.Writing a query to return customer names who have placed at least one order.
--Kamida bitta buyurtma bergan mijozlarning ismlarini qaytarish uchun so‘rov yozing.
SELECT C.FirstName, C.LastName, COUNT(O.OrderID) AS TotalOrders
FROM Customers AS C 
INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID 
GROUP BY C.FirstName, C.LastName;

--13.Writing a query to show only those records where both employee and department exist (no NULLs).
--Faqat xodim va bo‘lim mavjud bo‘lgan yozuvlarni ko‘rsatish uchun so‘rov yozing (NULLlar yo‘q).
SELECT E.Name AS EmployeeName,
       D.DepartmentName
FROM Employees AS E
INNER JOIN Departments AS D ON E.DepartmentID = D.DepartmentID;


--14.Write a query to find pairs of employees who report to the same manager.
--Bitta menejerga bo‘ysunadigan xodimlar juftligini topish uchun so‘rov yozish.
SELECT EMP1.Name AS Employee1,
       EMP2.Name AS Employee2,
       EMP1.ManagerID
FROM Employees AS EMP1
JOIN Employees AS EMP2 ON EMP1.ManagerID = EMP2.ManagerID
WHERE EMP1.ManagerID IS NOT NULL
  AND EMP1.EmployeeID < EMP2.EmployeeID
ORDER BY ManagerID;

--15.Write a query to list all orders placed in 2022 along with the customer name.
--2022-yilda berilgan barcha buyurtmalarni mijoz nomi bilan birga ko‘rsatish uchun so‘rov yozish.
SELECT O.OrderID,
       O.OrderDate,
       C.FirstName,
       C.LastName
FROM Orders AS O
INNER JOIN Customers AS C ON O.CustomerID = C.CustomerID
WHERE O.OrderDate >= '2022-01-01' AND O.OrderDate < '2023-01-01';

--16.Writing a query to return employees from the 'Sales' department whose salary is above 60000.
--"Sales" bo‘limidan ish haqi 60000 dan yuqori bo‘lgan xodimlarni qaytarish uchun so‘rov yozish.
SELECT E.Name,
       E.Salary,
       D.DepartmentName
FROM Employees AS E
INNER JOIN Departments AS D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sales'
  AND E.Salary > 60000;

--17.Writing a query to return only those orders that have a corresponding payment.
--Faqat tegishli to‘lovga ega buyurtmalarni qaytarish uchun so‘rov yozish.
SELECT O.OrderID,
       O.OrderDate,
       P.PaymentDate,
       P.Amount
FROM Orders AS O
INNER JOIN Payments AS P ON O.OrderID = P.OrderID;

--18.Writing a query to find products that were never ordered.
--Hech qachon buyurtma qilinmagan mahsulotlarni topish uchun so‘rov yozish.
SELECT P.ProductID,
       P.ProductName
FROM Products AS P
LEFT OUTER JOIN Orders AS O ON P.ProductID = O.ProductID
WHERE O.OrderID IS NULL;

--19.Writing a query to find employees whose salary is greater than the average salary in their own departments.
--O‘z bo‘limlaridagi o‘rtacha maoshdan ko‘proq maosh oladigan xodimlarni topish uchun so‘rov yozish.
SELECT E.Name AS EmployeeName,
	   E.Salary
FROM Employees AS E
INNER JOIN Departments AS D ON E.DepartmentID = D.DepartmentID
WHERE E.Salary >
    (SELECT AVG(SALARY) AS AVGSALARY
     FROM Employees
     WHERE DepartmentID = E.DepartmentID);

--20.Writing a query to list all orders placed before 2020 that have no corresponding payment.
--2020-yilgacha qo‘yilgan va tegishli to‘lovi bo‘lmagan barcha buyurtmalarni ro‘yxatga olish uchun so‘rov yozish.
SELECT O.OrderID, 
       O.OrderDate 
FROM Orders AS O 
LEFT JOIN Payments AS P ON O.OrderID = P.OrderID 
WHERE P.PaymentID IS NULL AND YEAR(O.OrderDate) < 2020;


--21.Writing a query to return products that do not have a matching category.
--Mos turkumga ega bo‘lmagan mahsulotlarni qaytarish uchun so‘rov yozish.
SELECT P.ProductID,
       P.ProductName
FROM Products AS P
LEFT JOIN Categories AS C ON P.Category = C.CategoryID
WHERE C.CategoryID IS NULL;

--22.Writing a query to find employees who report to the same manager and earn more than 60000.
--Bitta menejerga bo‘ysunadigan va 60000 dan ortiq maosh oladigan xodimlarni topish uchun so‘rov yozish.
SELECT 
    E1.Name AS Employee1,
    E2.Name AS Employee2,
    E1.ManagerID,
    E1.Salary AS Salary1,
    E2.Salary AS Salary2
FROM Employees E1
JOIN Employees E2
    ON E1.ManagerID = E2.ManagerID
   AND E1.EmployeeID < E2.EmployeeID
WHERE E1.Salary > 60000
  AND E2.Salary > 60000;

--23.Writing a query to return employees who work in departments which name starts with the letter 'M'.
--Nomi "M" harfi bilan boshlanadigan bo‘limlarda ishlaydigan xodimlarni qaytarish uchun so‘rov yozish.
SELECT E.Name AS EmployeeName,
       D.DepartmentName
FROM Employees AS E
INNER JOIN Departments AS D ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName LIKE 'M%';

--24.Writing a query to list sales where the amount is greater than 500, including product names.
--Summasi 500 dan ortiq bo‘lgan sotuvlar ro‘yxati, jumladan, mahsulot nomlari uchun so‘rov yozish.
SELECT S.SaleID,
       P.ProductName,
       S.SaleAmount
FROM Sales AS S
INNER JOIN Products AS P ON S.ProductID = P.ProductID
WHERE S.SaleAmount > 500;

--25.Writing a query to find students who have not enrolled in the course 'Math 101'.
--"Math 101" kursiga yozilmagan talabalarni topish uchun so‘rov yozish.
SELECT S.StudentID, 
       S.Name AS StudentName 
FROM Students AS S
WHERE S.StudentID NOT IN (
  SELECT E.StudentID 
  FROM Enrollments AS E 
  INNER JOIN Courses AS C ON E.CourseID = C.CourseID 
  WHERE C.CourseName = 'Math 101'
);

--26.Writing a query to return orders that are missing payment details.
--To‘lov tafsilotlari kiritilmagan buyurtmalarni qaytarish uchun so‘rov yozish.
SELECT O.OrderID,
       O.OrderDate,
       P.PaymentID
FROM Orders AS O
LEFT JOIN Payments AS P ON O.OrderID = P.OrderID
WHERE P.PaymentID IS NULL;

--27.Writing a query to list products that belong to either the 'Electronics' or 'Furniture' category.
--"Elektronika" yoki "Mebel" toifasiga kiruvchi mahsulotlarni ro‘yxatlash uchun so‘rov yozish.
SELECT P.ProductID,
       P.ProductName,
       C.CategoryName
FROM Products AS P
INNER JOIN Categories AS C ON P.Category = C.CategoryID
WHERE C.CategoryName IN ('Electronics',
                         'Furniture')
