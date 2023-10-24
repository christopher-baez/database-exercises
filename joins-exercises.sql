use join_example_db;
-- Use the join_example_db. Select all the records 
-- from both the users and roles tables.
select * from users;
select * from roles;
	


-- Use join, left join, and right join to combine results from the 
-- users and roles tables as we did in the lesson. Before you run each query, 
-- guess the expected number of results.

-- will return all users who have roles
-- due to no nulls being returned from inner joins
select * 
from roles r
inner join users u 
	on r.id=u.role_id;
    
-- in a left join i can expect to return all roles even if they do
-- don't have users 
select * 
from roles r
left join users u 
	on r.id=u.role_id;
	
-- in a right join i can expect to return all users even if they do
-- don't have roles 
select * 
from roles r
right join users u 
	on r.id=u.role_id;


-- Although not explicitly covered in the lesson, aggregate functions like count 
-- can be used with join queries. Use count and the appropriate join type to get a 
-- list of roles along with the number of users that have the role. Hint: You will also 
-- need to use group by in the query.

-- count number of users 
 
select 	
	count(u.id), -- to explicitly count users,
    r.name
from roles r
left join users u 
	on r.id=u.role_id
group by r.name;



-- Use the employees database.
use employees;
-- Using the example in the Associative Table Joins section as a guide, 
-- write a query that shows each department along with the name of the current manager 
-- for that department.

describe departments;
describe employees;
describe dept_manager;

select
	d.dept_name as 'Department Name',
    concat(e.first_name,' ',e.last_name) as 'Department Manager'
from departments d
join dept_manager dm
	on d.dept_no=dm.dept_no and
    dm.to_date > NOW()
join employees e
	on e.emp_no=dm.emp_no
order by dept_name;
-- where dm.to_date like '9999-%';
-- where dm.to_date > NOW();


-- Find the name of all departments currently managed by women.
describe employees;
describe departments;
describe dept_manager;

select
	d.dept_name as 'Department Name',
    concat(e.first_name,' ',e.last_name) as 'Manager Name'
from departments d
join dept_manager dm
	on d.dept_no=dm.dept_no and
    dm.to_date > NOW()
join employees e
	on e.emp_no=dm.emp_no
where e.gender = 'F'
order by dept_name;


-- Find the current titles of employees currently working in the Customer Service department.
describe titles; -- emp_no
describe dept_emp; -- emp_no & dept_no
describe departments; -- dept_no

select
	t.title as Title,
    COUNT(de.emp_no) as Count
from titles t
join dept_emp de
	on t.emp_no=de.emp_no and 
    t.to_date > NOW() and
    de.to_date > NOW()
join departments d
	on d.dept_no=de.dept_no
where d.dept_name = 'Customer Service'
group by t.title
order by t.title;
    
	
-- Find the current salary of all current managers.
describe salaries; -- emp_no
describe dept_manager; -- emp_no & dept_no
describe employees; -- emp_no
describe departments;

select 
	d.dept_name as 'Department Name',
    concat(e.first_name,' ',e.last_name) as 'Name',
    s.salary Salary
from salaries s
join dept_manager dm
	on s.emp_no=dm.emp_no and
    dm.to_date > NOW() and 
    s.to_date > NOW()
join employees e 
	on e.emp_no=dm.emp_no
join departments d
	on d.dept_no=dm.dept_no
order by d.dept_name;


-- Find the number of current employees in each department.
describe dept_emp;
describe departments;

select 
	d.dept_no,
    d.dept_name,
    COUNT(de.dept_no) as num_employees
from departments d
join dept_emp de
	on d.dept_no=de.dept_no and
    de.to_date > NOW()
group by d.dept_no,d.dept_name
order by d.dept_no;


-- Which department has the highest average salary? Hint: Use current not historic information.
describe departments; -- dept_no
describe salaries; -- emp_no
describe dept_emp; -- emp_no & dept_no

SELECT 
	d.dept_name,
	ROUND(AVG(s.salary),2) as average_salary
FROM departments d
JOIN dept_emp de
	ON d.dept_no=de.dept_no and
    de.to_date > NOW()
JOIN salaries s
	ON s.emp_no=de.emp_no and
    s.to_date > NOW()
GROUP BY d.dept_name
ORDER BY average_salary DESC
LIMIT 1;


-- Who is the highest paid employee in the Marketing department?
describe employees; -- emp_no
describe salaries; -- emp_no
describe departments; -- dept_no 
describe dept_emp; -- dept_no & emp_no


select
	e.first_name,
    e.last_name
from employees e 
join salaries s
	on e.emp_no=s.emp_no
join dept_emp de
	on de.emp_no=e.emp_no 
join departments d 
	on d.dept_no=de.dept_no
where 
	d.dept_name = 'Marketing'
order by s.salary DESC
limit 1;



-- Which current department manager has the highest salary?
describe dept_manager;
describe salaries;
describe departments;
describe employees;

select
	e.first_name,
    e.last_name,
    s.salary,
    d.dept_name
from employees e 
join salaries s
	on e.emp_no=s.emp_no and
    s.to_date > NOW()
join dept_manager dm
	on dm.emp_no=e.emp_no and
    dm.to_date > NOW()
join departments d 
	on d.dept_no=dm.dept_no
order by s.salary DESC
limit 1;


-- Determine the average salary for each department. Use all salary information and round your results.
describe salaries;
describe departments;
describe dept_emp;

select 
	d.dept_name,
    ROUND(AVG(s.salary),0) average_salary
from salaries s
join dept_emp de
	on s.emp_no=de.emp_no
join departments d
	on d.dept_no=de.dept_no
group by d.dept_name
order by average_salary desc;



-- Bonus Find the names of all current employees, their department name, and their current manager's name.
-- SELF JOIN
describe employees;
describe departments;
describe dept_manager;
describe dept_emp;

select 
	CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name',
    d.dept_name AS 'Department Name',
    CONCAT(managers.first_name, ' ', managers.last_name) AS 'Manager_name'
from employees e
join dept_emp de
	on e.emp_no=de.emp_no
join departments d
	on d.dept_no=de.dept_no
join dept_manager dm
	on dm.dept_no=de.dept_no and
    dm.to_date > NOW()
-- Join employees again as managers to get manager names.
JOIN employees AS managers 
	ON managers.emp_no = dm.emp_no
WHERE de.to_date > CURDATE()
ORDER BY d.dept_name;



-- SUBQUERY WAY

SELECT
	CONCAT(e.first_name, ' ', e.last_name) AS 'Employee Name',
	d.dept_name AS 'Department Name',
	m.managers AS 'Manager Name'
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no
	AND de.to_date > CURDATE()
JOIN departments AS d ON de.dept_no = d.dept_no 
JOIN (SELECT
		 dm.dept_no,
		 CONCAT(e.first_name, ' ', e.last_name) AS managers
	 FROM employees AS e
	 JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
		 AND to_date > CURDATE()) AS m 
	ON m.dept_no = d.dept_no
ORDER BY d.dept_name;



