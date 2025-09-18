--1.Listing all combinations of product names and supplier names.
--Mahsulot nomlari va yetkazib beruvchilar nomlarining barcha birikmalarini sanab o‘tish.

SELECT Products.ProductName,
       Suppliers.SupplierName
FROM Products
CROSS JOIN Suppliers;

--2.Getting all combinations of departments and employees.
--Bo‘limlar va xodimlarning barcha kombinatsiyalarini olish.

SELECT Departments.DepartmentName,
       Employees.Name
FROM Departments
CROSS JOIN Employees;

--3.Listing only the combinations where the supplier actually supplies the product. Return supplier name and product name.
--Faqat yetkazib beruvchi mahsulotni haqiqatda yetkazib beradigan kombinatsiyalarni sanab o‘ting. Ta’minotchisi nomi va mahsulot nomini chiqaring.

SELECT P.ProductName,
       S.SupplierName
FROM Products AS P
INNER JOIN Suppliers AS S ON P.SupplierID = S.SupplierID;

--4.Listing customer names and their orders ID.
--Mijozlarning ismlari va ularning buyurtma ID raqamlarini ko‘rsatish.

SELECT C.FirstName,
       C.LastName,
       O.OrderID
FROM Customers AS C
INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID;

--5.Getting all combinations of students and courses.
--Talabalar va kurslarning barcha kombinatsiyalarini olish.

SELECT *
FROM Students
CROSS JOIN Courses;

--6.Getting product names and orders where product IDs match.
--Mahsulot identifikatorlari mos keladigan mahsulot nomlari va buyurtmalarini oling.

SELECT P.ProductName,
       O.*
FROM Products AS P
INNER JOIN Orders AS O ON P.ProductID = O.ProductID;

--7.Listing employees whose DepartmentID matches the department.
--DepartmentID bo‘limga mos keladigan xodimlarni sanab o‘tish.

SELECT E.*
FROM Employees AS E
INNER JOIN Departments AS D ON E.DepartmentID = D.DepartmentID;

--8.Listing student names and their enrolled course IDs.
--Talabalar ismlari va ular o‘qiyotgan kurs identifikatorlarini ko‘rsatish.

SELECT S.Name,
       E.CourseID
FROM Students AS S
INNER JOIN Enrollments AS E ON S.StudentID = E.StudentID;

--9.Listing all orders that have matching payments.
--To‘lovlari mos keladigan barcha buyurtmalarni sanab o‘tish.

SELECT O.*
FROM Orders AS O
INNER JOIN Payments AS P ON O.OrderID = P.OrderID;

--10.Showing orders where product price is more than 100.
--Mahsulot narxi 100 dan yuqori buyurtmalarni ko‘rsatish.

SELECT O.*
FROM Orders AS O
INNER JOIN Products AS P ON O.ProductID = P.ProductID
WHERE P.Price > 100;

--11.Listing employee names and department names where department IDs are not equal. It means: Show all mismatched employee-department combinations.
--ID raqamlari teng bo‘lmagan xodimlar va bo‘limlar nomlarini ko‘rsatish.

SELECT E.Name, D.DepartmentName
FROM Employees AS E
CROSS JOIN Departments AS D
WHERE E.DepartmentID <> D.DepartmentID;

--12.Showing orders where ordered quantity is greater than stock quantity.
--Buyurtma miqdori zaxira miqdoridan ko‘p bo‘lgan buyurtmalarni ko‘rsatish.

SELECT O.*
FROM Orders AS O
INNER JOIN Products AS P ON O.ProductID =P.ProductID
AND O.Quantity > P.StockQuantity;

--13.Listing customer names and product IDs where sale amount is 500 or more.
--Sotuv summasi 500 yoki undan ortiq bo‘lgan mijozlar ismlari va mahsulot identifikatorlarini ko‘rsatish.

SELECT C.FirstName,
       C.LastName,
       S.ProductID
FROM Customers AS C
INNER JOIN Sales AS S ON C.CustomerID = S.CustomerID
WHERE S.SaleAmount >= 500;

--14.Listing student names and course names they’re enrolled in.
--Talabalar ismlari va ular o‘qiydigan kurslar nomlarini ko‘rsatish.

SELECT S.Name,
       C.CourseName
FROM Courses AS C
INNER JOIN Enrollments AS E ON C.CourseID = E.CourseID
INNER JOIN Students AS S ON E.StudentID = S.StudentID;

--15.Listing product and supplier names where supplier name contains “Tech”.
--Ta’minotchi nomi "Tech" so‘zini o‘z ichiga olgan mahsulot va ta’minotchi nomlarini ko‘rsatish.

SELECT P.ProductName, S.SupplierName
FROM Products AS P
INNER JOIN Suppliers AS S ON P.SupplierID = S.SupplierID
WHERE S.SupplierName LIKE '%Tech%';

--16.Showing orders where payment amount is less than total amount.
--To‘lov miqdori jami miqdordan kam bo‘lgan buyurtmalarni chiqarish.

SELECT O.*
FROM Orders AS O
INNER JOIN Payments AS P ON O.OrderID = P.OrderID
WHERE P.Amount < O.TotalAmount;

--17.Getting the Department Name for each employee.
--Har bir xodim uchun Bo‘lim nomini olish.

SELECT E.Name,
       D.DepartmentName
FROM Employees AS E
INNER JOIN Departments AS D ON E.DepartmentID = D.DepartmentID;

--18.Showing products where category is either 'Electronics' or 'Furniture'.
--Turkum "Elektronika" yoki "Mebel" bo‘lgan mahsulotlarni ko‘rsatish.

SELECT P.*
FROM Products AS P
INNER JOIN Categories AS C ON P.Category = C.CategoryID
WHERE C.CategoryName IN ('Electronics',
                         'Furniture');

--19.Showing all sales from customers who are from 'USA'.
--"AQSH"dan kelgan mijozlarning barcha sotuvlarini ko‘rsatish.

SELECT S.*
FROM Customers AS C
INNER JOIN Sales AS S ON C.CustomerID = S.CustomerID
WHERE C.Country = 'USA';

--20.Listing orders made by customers from 'Germany' and order total > 100.
--"Germaniya"dan mijozlar tomonidan qilingan buyurtmalarni ro‘yxatga olish va buyurtmalar jami > 100.

SELECT O.*
FROM Customers AS C
INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
WHERE C.Country = 'Germany'
  AND O.TotalAmount > 100;

--21.List all pairs of employees from different departments.
--Turli bo‘limlardagi barcha juft xodimlarni sanab o‘tish.

SELECT E1.EmployeeID AS Employee1_ID,
       E1.Name AS Employee1_Name,
       D1.DepartmentName AS Employee1_Department,
       E2.EmployeeID AS Employee2_ID,
       E2.Name AS Employee2_Name,
       D2.DepartmentName AS Employee2_Department
FROM Employees AS E1
JOIN Employees AS E2 ON E1.EmployeeID < E2.EmployeeID
JOIN Departments AS D1 ON E1.DepartmentID = D1.DepartmentID
JOIN Departments AS D2 ON E2.DepartmentID = D2.DepartmentID
WHERE E1.DepartmentID <> E2.DepartmentID;

--22.Listing payment details where the paid amount is not equal to (Quantity × Product Price).
--To‘langan summa (Miqdori × Mahsulot narxi) ga teng bo‘lmagan to‘lov tafsilotlarini ko‘rsatish.

SELECT P.*
FROM Payments AS P
INNER JOIN Orders AS O ON P.OrderID = O.OrderID
INNER JOIN Products AS PR ON O.ProductID = PR.ProductID
WHERE P.Amount <> (O.Quantity) * PR.Price;

--23.Finding students who are not enrolled in any course.
--Hech qaysi kursga yozilmagan o‘quvchilarni topish.

SELECT S.StudentID,
       S.Name
FROM Students S
LEFT JOIN Enrollments E ON S.StudentID = E.StudentID
WHERE E.CourseID IS NULL;

--24.Listing employees who are managers of someone, but their salary is less than or equal to the person they manage.
--Biror kishining menejeri bo‘lgan, ammo maoshi u boshqaradigan odamdan kam yoki unga teng bo‘lgan xodimlarni sanab o‘tish.

SELECT M.EmployeeID AS ManagerID,
       M.Name AS ManagerName,
       M.Salary AS ManagerSalary,
       E.EmployeeID AS EmployeeID,
       E.Name AS EmployeeName,
       E.Salary AS EmployeeSalary
FROM Employees M
INNER JOIN Employees E ON M.EmployeeID = E.ManagerID
WHERE M.Salary <= E.Salary;

--25.Listing customers who have made an order, but no payment has been recorded for it.
--Buyurtma bergan, lekin to‘lov qayd etilmagan mijozlar ro‘yxati.

SELECT C.CustomerID,
       C.FirstName,
       C.LastName
FROM Customers C
INNER JOIN Orders O ON C.CustomerID = O.CustomerID
LEFT JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.PaymentID IS NULL;

