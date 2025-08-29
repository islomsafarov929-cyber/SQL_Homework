1. Data - raw, unorganized facts, numbers, observations, or other pieces of information collected about an object or phenomenon;
   Database -an organized, electronically stored collection of structured or unstructured data that is managed by a Database Management System;
   Relational database - View data from any table in your database, that is to say, access any location on the server;
   Table - sorted data table inside the schema.

2. 1)You can work with databases;
   2)Sort data, find the required row or table using codes;
   3)Create a database in a specific tree using codes;
   4)Easily transfer and find data via the server;
   5)Delete, edit, and modify data in the table.

3. Windows authentication, SQL Server authentication.

4. CREATE DATABASE SchoolDB.

5. CREATE TABLE Students 
(
StudentID INT, PRIMARY KEY
Name VARCHAR(50),
Age INT
)

6. SQL - This is a standardized programming language used to manage and manipulate relational databases;
   SQL SERVER - This is a relational database management system developed by Microsoft. 
   It is a software application designed to store, retrieve, manage, and secure data;
   SSMS - This is a graphical user interface tool provided by Microsoft for managing, administering,
   and developing within SQL Server environments.

7. DQL - DATA QUERY LANGUAGE, used to get data from tebles or something. 
For example: SELECT * FROM Students;
   DML - DATA MANIPULATING LANGUAGE, Used to enter or change data to/from table. 
For example: INSERT INTO Students ...
   DDL - DATA DEFINITION LANGUAGE, Used to create, change, remove table.
For example: CREATE TABLE Students ...
   DCL - DATA CONTROL LANGUAGE, Used to control access to data for a user.
For example: GRANT ....
   TCL - TANSACTION CONTROL LANGUAGE, Prevents mistakes while coding.
For example: COMMIT TRAN ...

8. USE SchoolDB
 
 INSERT INTO Students
(StudentID, Name, Age)
VALUES (886699, 'Alan', 16)


9. Download "AdvenrureWorksDW2022" from internet -> go to SQL Server -> 
from "Object Explorer" Right click to "Databases" ->click to "Restore Database..." -> 
change to "Device" -> click three dots (...) -> click "Add" -> select "AdventureWorksDW2022" -> 
click "OK" -> click "OK"-> restart the "Object Explorer".


  
