----------------------------------------------------------Level 1--------------------------------------------------------------------------------------------
--1.Retrieve employees who earn minimum salary in company.
--Kompaniyadagi eng kam oylik oluvchi ishchilarni chiqarish.

SELECT id,
       name,
       salary
FROM employees
WHERE salary IN
    (SELECT MIN(salary)
     FROM employees);

--2.Retrieve products priced above the average price.
--O'rtacha oylikdan ham qimmat bo'lgan mahsulotlarni ko'rsatish.

SELECT id,
       product_name,
       price
FROM products
WHERE price >
    (SELECT AVG(price)
     FROM products);

------------------------------------------------------------Level 2--------------------------------------------------------------------------------------------
--3.Retrieve employees who work in 'Sales' department.
--'Sales' bo'limida ishlovchi ishchilarni chiqarish.

SELECT id, 
       name, 
       department_id
FROM employees 
WHERE department_id = 
    (SELECT id
     FROM departments AS D 
     WHERE department_name = 'Sales');

--4.Retrieve customers who have not placed any order.
--Hech qachon buyurtma bermagan mijozni topish.

SELECT customer_id,
       name
FROM customers
WHERE customer_id NOT IN
    (SELECT customer_id
     FROM orders);

-----------------------------------------------------------Level 3--------------------------------------------------------------------------
--5.Retrieve products with highest price to each category.
--Har bir tur uchun mahsulotning eng yuqori narxini aytish.

SELECT id,
       product_name,
       price,
       category_id
FROM products AS P
WHERE P.price =
    (SELECT MAX(P1.price)
     FROM products AS P1
     WHERE P1.category_id = P.category_id);

--6.Retrieve employees working in department with highest average salary.
--Eng katta o'rtacha maoshga eha bo'limda ishlovchi xodimlarni ko'rsatish.

SELECT *
FROM employees
WHERE department_id =
    (SELECT TOP 1 department_id
     FROM employees
     GROUP BY department_id
     ORDER BY AVG(salary) DESC);

-------------------------------------------------------------------Level 4------------------------------------------------------------------------
--7.Returt employees who earn more tahen the average salary in their department.
--O'z bo'limidagi o'rtacha maoshdan ko'p maosh oluvchi ishchini chiqarish.

SELECT id,
       name,
       salary,
       department_id
FROM employees EO
WHERE salary >
    (SELECT AVG(salary)
     FROM employees AS EI
     WHERE EO.department_id= EI.department_id);

--8. Retrieve students who received the highest grade in each course.
--O'z kursida eng katta baho olgan o'quvchini chiqarish.

SELECT S.*,
       G.course_id,
       G.grade
FROM students AS S
INNER JOIN grades AS G ON S.student_id = G.student_id
WHERE G.grade =
    (SELECT MAX(G2.grade)
     FROM grades AS G2
     WHERE G.course_id = G2.course_id)
ORDER BY S.student_id;

---------------------------------------------------------Level 5----------------------------------------------------------------------------------
--9.Retrieve third-highest proced product.
--3- eng qimman mahsulotni ko'rsatish.

SELECT id,
       product_name,
       price,
       category_id
FROM products
WHERE price =
    (SELECT MIN(price)
     FROM
       (SELECT TOP 3 price
        FROM products
        ORDER BY price DESC) AS TOP3);

--10.Retrieve employees with salaries above the company average but below the maximum in their department.
--Maoshi kompaniya o'rtacha maoshidan katta ammo bo'lim eng yuqori maoshidan kam bo'lgan ishchilarni chiqarish.

SELECT *
FROM employees AS E
WHERE salary >
    (SELECT AVG(salary)
     FROM employees)
  AND salary <
    (SELECT MAX(salary)
     FROM employees as D
     WHERE E.department_id = D.department_id
     GROUP BY department_id);

