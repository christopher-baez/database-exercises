select database();
use employees;
show tables;

##Find all employees with first names 'Irena', 'Vidya', or 'Maya', 
##and order your results returned by first name. In your comments, answer: 
##What was the first and last name in the first row of the results? 
##What was the first and last name of the last person in the table?
SELECT * from employees
where first_name in ("vidya", "Maya", "Irena")
order by first_name; -- irena reutaneuer and vidya simmen

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', 
-- and order your results returned by first name and then last name. 
-- In your comments, answer: What was the first and last name in the first row of the results? 
-- What was the first and last name of the last person in the table?
SELECT * from employees
where 
first_name = "vidya" or 
first_name = "Maya" or 
first_name = "Irena"
order by first_name, last_name; -- irena acton and vidya zweizig

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and 
-- order your results returned by last name and then first name. In your comments, 
-- answer: What was the first and last name in the first row of the results?
--  What was the first and last name of the last person in the table?
SELECT * from employees
where 
first_name = "vidya" or 
first_name = "Maya" or 
first_name = "Irena"
order by last_name, first_name;-- irena acton and maya zyda 

-- Write a query to find all employees whose last name starts and ends with 'E'. 
-- Sort the results by their employee number. Enter a comment with the number of 
-- employees returned, the first employee number and their first and last name, 
-- and the last employee number with their first and last name.
select distinct * from employees
where last_name like "E%" and last_name like "%E"
order by emp_no; -- 10021 ramzi erde and 499648 tadahiro erde

-- Write a query to find all employees whose last name starts and ends with 'E'. 
-- Sort the results by their hire date, so that the newest employees are listed first. 
-- Enter a comment with the number of employees returned, the name of the newest employee, 
-- and the name of the oldest employee.
select distinct * from employees
where last_name like "E%" and last_name like "%E"
order by hire_date desc; -- 67892 teiji eldridge and 233488 sergi erde

-- Find all employees hired in the 90s and born on Christmas. Sort the results so
--  that the oldest employee who was hired last is the first result. Enter a comment 
--  with the number of employees returned, the name of the oldest employee who was 
--  hired last, and the name of the youngest employee who was hired first.
select * from employees
where hire_date between '1990-01-01' and '1999-12-31' and birth_date like '%12-25'
order by birth_date, hire_date desc; -- doudadi pettis



