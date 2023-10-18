select database();
show tables;

select * from salaries;

-- Determine the historic average salary for each employee. 
-- When you hear, read, or think "for each" with regard to SQL,
--  you'll probably be grouping by that exact column.
select emp_no, avg(salary) as avg_salary
from salaries
group by emp_no;

-- Using the dept_emp table, count how many current employees work in each department. 
-- The query result should show 9 rows, one for each department and the employee count.
select dept_no, count(*)
from dept_emp
where to_date = '9999-01-01'
group by dept_no;

-- Determine how many different salaries each employee has had. This includes both historic and current.
select emp_no, count(*)
from salaries
group by emp_no;

-- Find the maximum salary for each employee.
select emp_no, max(salary), min(salary)
from salaries
group by emp_no;

-- Find the minimum salary for each employee.
select emp_no, max(salary), min(salary)
from salaries
group by emp_no;

-- Find the standard deviation of salaries for each employee.
select emp_no, round(std(salary))
from salaries
group by emp_no;
-- Find the max salary for each employee where that max salary is greater than $150,000.
select emp_no, max(salary) as max_sal
from salaries
group by emp_no
having max_sal > 150000;

-- Find the average salary for each employee where that average salary is between $80k and $90k.
select emp_no, round(avg(salary)) as avg_sal
from salaries
group by emp_no
having avg_sal between 80000 and 90000;
