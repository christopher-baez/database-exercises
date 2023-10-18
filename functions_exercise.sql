-- Write a query to find all employees whose last name starts and ends with 'E'. 
-- Use concat() to combine their first and last name together as a single column named full_name.
select distinct 
	concat(first_name,' ',last_name) as full_name
from employees
where last_name like "e%e";

-- Convert the names produced in your last query to all uppercase.
select distinct 
	upper(concat(first_name,' ',last_name)) as full_name
from employees
where last_name like "e%e";
use employees;
-- Use a function to determine how many results were returned from your previous query.
select distinct 
	count(upper(concat(first_name,' ',last_name))) as full_name
from employees
where last_name like "e%e";-- 899

-- Find all employees hired in the 90s and born on Christmas. 
-- Use datediff() function to find how many days they have been working at 
-- the company (Hint: You will also need to use NOW() or CURDATE()),
select first_name, datediff(curdate(), hire_date) as days_worked
from employees
where hire_date like '199%' and birth_date like '%12-25';

-- Find the smallest and largest current salary from the salaries tables
show tables;
select min(salary) as smallest_salary
from salaries; -- 38623
 
 show tables;
select max(salary) as largest_salary
from salaries; -- 158220

-- Use your knowledge of built in SQL functions to generate a username
--  for all of the employees. A username should be all lowercase, and 
--  consist of the first character of the employees first name, 
--  the first 4 characters of the employees last name, an underscore, 
--  the month the employee was born, and the last two digits of the year that they were born. 
--  Below is an example of what the first 10 rows will look like:
show tables;

select 
lower(concat(substr(first_name, 1, 1), substr(last_name, 1, 4), '_', substr(birth_date, 6, 2),substr(birth_date, 3, 2))) as username,
first_name, last_name, birth_date
from employees;
