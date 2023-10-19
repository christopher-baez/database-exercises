-- Write a query that returns all employees, their department number, their start date, their end date, and a new column 
-- 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not. DO NOT WORRY ABOUT DUPLICATE EMPLOYEES.
select concat(first_name, ' ', last_name) as 'full name',
	emp_no,
    hire_date,
    to_date,
    if (to_date > now(), true, false) as 'is_current_employee'
from employees
join dept_emp as de
	using(emp_no)
;

-- Write a query that returns all employee names (previous and current), and a new column 
-- 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
select concat(first_name, ' ', last_name) as Full_Name,

	case 
		when substr(last_name, 1, 1) between 'A' and 'H' THEN 'A-H'
		when substr(last_name, 1, 1) between 'I' and 'Q' THEN 'I-Q'
        else 'R-Z'
        END as 'alpha_group'
from employees
;
-- How many employees (current or previous) were born in each decade?
select 
	case 
		when birth_date like '195%' then '1950s'
        when birth_date like '196%' then '1960s'
		end as decades,
        COUNT(*) AS employee_count
from employees
group by decades
;

select distinct dept_name
from departments;

-- What is the current average salary for each of the following department groups: 
-- R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
select 
	case
     when dept_name like '%custo%' then 'customer service'
     when dept_name like '%sales%' or '%marketing%' then 'sales & marketing'
     when dept_name like '%production%' or '%quality%' then 'prod & QM'
     when dept_name like '%finance%' or '%human%' then 'Finance & HR'
     else 'R&D'
     end as dep,
     avg(salary) as 'salary avg'
from salaries as s
join dept_emp as de
	using(emp_no) 
join departments as d
	using(dept_no) 
where s.to_date > now()
group by dep;

select distinct dep