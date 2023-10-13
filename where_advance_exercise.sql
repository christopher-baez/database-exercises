use employees;
show tables;

## Find all current or previous employees with first names 
## 'Irena', 'Vidya', or 'Maya' using IN. What is the employee 
## number of the top three results?
SELECT * from employees
where first_name in ("vidya", "Maya", "Irena"); -- 10200, 10397, and 10610

## Find all current or previous employees with first names 
## 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. 
## What is the employee number of the top three results? Does it match the previous question?
SELECT * from employees
where 
first_name = "vidya" or 
first_name = "Maya" or 
first_name = "Irena"; -- same as last question (10200, 10397, and 10610)

## Find all current or previous employees with first names 
## 'Irena', 'Vidya', or 'Maya', using OR, and who is male. 
## What is the employee number of the top three results?
SELECT * from employees
where (first_name = "vidya" or first_name = "Maya" or first_name = "Irena") 
and gender = "M"; -- 10200, 10397, 10821

## Find all unique last names that start with 'E'.
select distinct last_name from employees
where last_name like "E%";

##Find all unique last names that start or end with 'E'.
select distinct last_name from employees
where last_name like "E%" or last_name like "%E";

##Find all unique last names that end with E, but does not start with E?
select distinct last_name from employees
where last_name not like "E%" and last_name like "%E";

##Find all unique last names that start and end with 'E'.
select distinct last_name from employees
where last_name like "E%E";

##Find all current or previous employees hired in the 90s. 
##Enter a comment with the top three employee numbers.
select * from employees
where hire_date like "199%";-- 10008, 10011, 10012

##Find all current or previous employees born on Christmas. 
##Enter a comment with the top three employee numbers.
select * from employees
where birth_date like '%12-25'; -- 10078,10115,10261
##Find all current or previous employees hired in the 90s and born on Christmas. 
##Enter a comment with the top three employee numbers.
select * from employees
where hire_date like "199%" and birth_date like '%12-25'; -- 110261, 10438, 10681

##Find all unique last names that have a 'q' in their last name.
select distinct last_name from employees
where last_name like "%q%";

##Find all unique last names that have a 'q' in their last name but not 'qu'.
select distinct last_name from employees
where last_name like "%q%" and last_name not like "%qu%";

