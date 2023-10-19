use employees;
show tables;
describe titles;
-- Find all the current employees with the same hire date as employee 101010 using a subquery.
select hire_date
from employees
where emp_no = 101010;

select *
from employees
where hire_date = (select hire_date
		from employees
		where emp_no = 101010
		);

-- Find all the titles ever held by all current employees with the first name Aamod.
select distinct first_name
from employees
where first_name = 'Aamod';

select *
from titles
join employees as e
	using(emp_no)
where first_name  = (select distinct first_name 
		from employees
		where first_name = 'Aamod'
			) and to_date > now();

-- How many people in the employees table are no longer working for the company? 
-- Give the answer in a comment in your code.
select emp_no
from dept_emp
where to_date > now();

select count(*) as cnt 
from employees
where emp_no not in
	(
	select emp_no
	from dept_emp
	where to_date > now()
    ); -- 59900

-- Find all the current department managers that are female. List their names in a comment in your code.
select *
from employees
where gender like "f";

select concat(first_name, ' ', last_name) as 'female managers'
from dept_manager as dm
join employees as e
	using(emp_no)
where dm.emp_no in (select emp_no
from employees
where gender like "f") and to_date > now();

-- Find all the employees who currently have a higher salary than the companie's overall, historical average salary.
select avg(salary) 
from salaries;

select concat(first_name, ' ', last_name) as 'Employee', salary,
		(select avg(salary) 
		from salaries) as 'AVG historical salary'
from employees as e
join salaries as s
	using(emp_no)
where salary > (select avg(salary) 
		from salaries
        ) and s.to_date > now()
        ;

select count(*)
from (
	select concat(first_name, ' ', last_name) as 'Employee', salary,
		(select avg(salary) 
		from salaries) as 'AVG historical salary'
from employees as e
join salaries as s
	using(emp_no)
where salary > (select avg(salary) 
		from salaries
        ) and s.to_date > now()
        ) as table_count;
-- How many current salaries are within 1 standard deviation of the current highest salary? 
-- (Hint: you can use a built-in function to calculate the standard deviation.) What percentage of all salaries is this?
select max(salary)
from salaries
where to_date > now()
; -- max salary

select max(salary) - stddev(salary)
from salaries
where to_date > now();-- set point

select  count(*) as '# of salaries over 1 stddev from max' -- salaries withing 1 standard deviation
from salaries
where  salary >= (
	select max(salary) - stddev(salary)
	from salaries
	where to_date > now()
    ) and to_date > now();

select count(*)-- total of current salaries
from salaries--
where to_date > now();

select (
(select count(*) as '# of salaries over 1 stddev from max' -- salaries withing 1 standard deviation
from salaries
where  salary >= (
	select max(salary) - stddev(salary)
	from salaries
	where to_date > now()
    ) and to_date > now()
) 
/ 
(select count(*)-- total of current salaries
from salaries
where to_date > now())) * 100


