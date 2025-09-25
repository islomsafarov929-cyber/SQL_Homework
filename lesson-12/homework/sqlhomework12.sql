--1.Combining two table including null values.
--Ikki jadvalni null qiymatlarni ham hisobga olib bog'lash.

SELECT P.firstName,
       P.lastName,
       A.city,
       A.state
FROM Person AS P
LEFT JOIN Address AS A ON P.personId = A.personId;

--2.Employees Earning More Than Their Managers
--O'z boshliqlaridan ham ko'p maosh oluvchi  ishchilar.

SELECT EMP.name
FROM Employee AS EMP
JOIN Employee AS MNGR ON EMP.managerId = MNGR.id
WHERE EMP.salary > MNGR.salary;

--3.Finding duplicate emails.
--Takrorlangan emaillarni topish.

SELECT email
FROM person1
GROUP BY email
HAVING COUNT(email) > 1;

--4.Deleting dupticate values by keeping the smalles id.
--Takroriy qiymatlarni engkichigini saqlab qolib o'chirib yuborish.

DELETE
FROM person1
WHERE ID NOT IN
    (SELECT MIN(id)
     FROM person1
     GROUP BY email);

--5.Find those parents who has only girls.
--Faqat qizi bor ota-onalarni topish.
--Method.1

SELECT ParentName
FROM girls
EXCEPT
SELECT ParentName
FROM boys --Method.2

SELECT DISTINCT G.ParentName
FROM girls AS G
LEFT JOIN boys AS B ON G.ParentName = B.ParentName
WHERE B.ParentName IS NULL;

--6.Total over 50 and least
--Jami sotuv, o'g'irligi 50 dan yuqori va mijoizning eng kam buyurma og'irligi.

SELECT SUM(CASE
               WHEN freight > 50 THEN freight
               ELSE 0
           END) AS TotalAmount,
       MIN(freight) AS LeastFreight
FROM TSQL2012.Sales.Orders
GROUP BY custid;

--7.Carts.
--Xarid ro'yxati.

SELECT C1.ITEM AS [Item Cart 1],
       C2.ITEM AS [Item Cart 2]
FROM CART1 AS C1
FULL JOIN CART2 AS C2 ON C1.ITEM = C2.ITEM
ORDER BY CASE
             WHEN C1.ITEM IS NOT NULL
                  AND C2.ITEM IS NOT NULL THEN 1
             ELSE 2
         END,
         COALESCE(C1.ITEM, C2.ITEM);

--8. Customers Who Never Order
--Hech qachon buyurtma bermagan mijoz.

SELECT C.name
FROM Customers AS C
LEFT JOIN Orders AS O ON C.id = O.customerId
WHERE O.customerId IS NULL;

--9.Students and Examinations.
--O'quvchilar va Imtihonlar.

SELECT s.student_id,
       s.student_name,
       sub.subject_name,
       COUNT(e.subject_name) AS attended_exams
FROM Students AS s
CROSS JOIN Subjects AS sub
LEFT JOIN Examinations AS e ON s.student_id = e.student_id
AND sub.subject_name = e.subject_name
GROUP BY s.student_id,
         s.student_name,
         sub.subject_name
ORDER BY s.student_id,
         sub.subject_name;
