--Week 10 - Group by
--Single row functions take from one table alone; multi row group values for entire table

SELECT * FROM hr_employees;

SELECT MIN(Salary) FROM hr_employees;
SELECT MAX(Salary) FROM hr_employees;

SELECT MIN(salary), MAX(salary), count(*), SUM(salary), AVG(salary) FROM hr_employees;
SELECT MIN(salary), MAX(salary), count(*), SUM(salary), AVG(salary) FROM hr_employees WHERE job_id='IT_PROG';

SELECT count (*) FROM hr_employees;
SELECT count (employee_id) FROM hr_employees;
SELECT count (commission_pct) FROM hr_employees; --ignores null values

SELECT AVG(salary) FROM hr_employees WHERE job_id='SA_REP'

SELECT * FROM jl_books

--1) Avergae cost of all books in inv
SELECT AVG(cost) FROM jl_books

--2) total number of books in computer category
SELECT COUNT(*) FROM jl_books WHERE category='COMPUTER'

--3) total cost of books in either FAMILY LIFE or COMPUTER
SELECT SUM(cost) FROM jl_books WHERE category IN ('FAMILY LIFE', 'COMPUTER')

SELECT * FROM jl_orders

--4) total ship cost for customer 1005
SELECT SUM(shipcost) FROM jl_orders WHERE customer#=1005

--5) min shipcost, max shipcost , avg ship cost for entire orders ?
SELECT MIN(shipcost), MAX(shipcost), AVG(shipcost) FROM jl_orders


SELECT * FROM hr_employees;

SELECT department_id, COUNT(department_id), MIN(salary), MAX(salary), AVG(salary) FROM hr_employees GROUP BY department_id ORDER BY department_id

SELECT job_id, AVG(salary) FROM hr_employees GROUP BY job_id ORDER BY job_id

SELECT job_id, department_id, SUM(salary), COUNT(*) FROM hr_employees GROUP BY department_id, job_id ORDER BY department_id

SELECT job_id, department_id, SUM(salary), COUNT(*) FROM hr_employees GROUP BY ROLLUP(department_id, job_id) ORDER BY department_id --Provides a sum of groups

SELECT department_id, AVG(salary) FROM hr_employees GROUP BY department_id ORDER BY department_id
SELECT department_id, AVG(salary) FROM hr_employees WHERE salary > 10000 GROUP BY department_id ORDER BY department_id
SELECT department_id, AVG(salary) FROM hr_employees GROUP BY department_id HAVING AVG(salary) > 10000 ORDER BY department_id
--WHERE -> filters inidividual records
--HAVING -> filters the groups
