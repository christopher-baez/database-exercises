-- List all the databases
SHOW databases; 
-- Write the SQL code necessary to use the albums_db database
USE albums_db; 
-- Show the currently selected database
SELECT database();
-- List all tables in the database
SHOW TABLES;
-- Write the SQL code to switch to the employees database
USE employees;
-- Show the currently selected database
SELECT database();
-- List all tables in the database
SHOW tables;
-- 10 Explore the employees table. What different data types are present in this table?
DESCRIBE employees; 
-- 11 do you think contain a numeric type column? 
-- 		 deptartments, dept_emp, 
-- 12 do you think contain a string type column? 
-- 		 first name and last name
-- 13 do you think contain a date type column? 
--       birth date and hire date

-- 14 What is the relationship between the employees and the departments tables?
--      there is no similar collums

-- What is the relationship between the employees and the departments tables? (Write this question and your answer in a comment)
show tables;

-- 15 Show the SQL code that created the dept_manager table.
show create table dept_manager;






