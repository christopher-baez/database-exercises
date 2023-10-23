-- Using the example from the lesson, create a temporary table called employees_with_departments that 
-- contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely
--  sure to create this table on your own database. If you see "Access denied for user ...", it means that 
--  the query was attempting to write a new table to a database that you can only read.
use ursula_2337;
create temporary table employees_with_departments as
select first_name, last_name, dept_name
from employees.employees
join employees.dept_emp using(emp_no)
join employees.departments using(dept_no)
where to_date > now();
drop table employees_with_departments;
select * from employees_with_departments;

-- Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns.
-- Update the table so that the full_name column contains the correct data.
 ALTER TABLE employees_with_departments add full_name VARCHAR(100);

UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

alter table employees_with_departments 
drop column first_name, drop column last_name;  -- Remove the first_name and last_name columns from the table.

use employees;  -- What is another way you could have ended up with this same table?
select concat(first_name, ' ', last_name) as full_name, 
	dept_name as department
from employees
join dept_emp using(emp_no)
join departments using(dept_no);
  


-- Create a temporary table based on the payment table from the sakila database.
-- Write the SQL necessary to transform the amount column such that it is stored as an 
-- integer representing the number of cents of the payment. For example, 1.99 should become 199.
create temporary table temp_payment as
select *
from sakila.payment;
drop table temp_payment;

select *
from temp_payment;
alter table temp_payment add payment_in_pennies int;
update temp_payment set payment_in_pennies = amount * 100;



-- Go back to the employees database. Find out how the current average pay in each department 
-- compares to the overall current pay for everyone at the company. For this comparison, you will 
-- calculate the z-score for each salary. In terms of salary, what is the best department right now to work for? The worst?
select 
	avg(salary), 
    std(salary)
from employees.salaries 
where to_date > now();

-- 72,012 overall average salary
-- 17,310 overall standard deviation


-- Saving my values for later... that's what variables do (with a name)
-- Think about temp tables like variables
use employees;

drop table overall_aggregates;
-- get overall std 
create temporary table overall_aggregates as (
    select 
		avg(salary) as avg_salary,
        std(salary) as overall_std
    from employees.salaries  where to_date > now()
);

select * from overall_aggregates;


-- Let's check out our current average salaries for each department
-- If you see "for each" in the English for a query to build..
-- Then, you're probably going to use a group by..
-- want to compare each departments average salary to the overall std and overall avg salary

drop table current_info;
-- get current average salaries for each department
create temporary table current_info as (
    select 
		dept_name, 
        avg(salary) as department_current_average
    from employees.salaries s
    join employees.dept_emp de
		on s.emp_no=de.emp_no and 
        de.to_date > NOW() and 
        s.to_date > NOW()
    join employees.departments d
		on d.dept_no=de.dept_no
    group by dept_name
);

select * from current_info;


-- add on all the columns we'll end up needing:
alter table current_info add overall_avg float(10,2);
alter table current_info add overall_std float(10,2);
alter table current_info add zscore float(10,2);

-- set the avg and std
update current_info set overall_avg = (select avg_salary from overall_aggregates);
update current_info set overall_std = (select overall_std from overall_aggregates);


-- update the zscore column to hold the calculated zscores
update current_info 
set zscore = (department_current_average - overall_avg) / overall_std;


select * from current_info;

select 
	max(zscore) as max_score
from current_info 
where max(zscore) = .97





