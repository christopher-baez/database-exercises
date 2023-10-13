use employees;
-- List the first 10 distinct last names sorted in descending order.
select distinct * from employees 
order by last_name desc limit 10;
-- Find all previous or current employees hired in the 90s and born on Christmas.
--  Find the first 5 employees hired in the 90's by sorting by hire date and limiting
--  your results to the first 5 records. Write a comment in your code that lists the
--  five names of the employees returned.
select * from employees
where hire_date between '1990-01-01' and '1999-12-31' and birth_date like '%12-25'
order by hire_date limit 5;
-- yinghua dredge, jinpo langford, tina speek, takahira spataro, jaber piveteau


-- Try to think of your results as batches, sets, or pages. 
-- The first five results are your first page. The five after that would be your second page, etc. 
-- Update the query to find the tenth page of results.
select * from employees
where hire_date between '1990-01-01' and '1999-12-31' and birth_date like '%12-25'
order by hire_date 
limit 5 offset 45;

-- (number od results per page * number of pages) - result of one page
