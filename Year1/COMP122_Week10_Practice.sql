--1.What is the average salary in this organization (Employees Table)?
SELECT AVG(salary) FROM hr_employees;

--2. Show total employee count in each department and also total salary that they get in each department
SELECT department_id, COUNT(*), SUM(salary) FROM hr_employees GROUP BY department_id ORDER BY department_id;
SELECT department_id, COUNT(*), SUM(salary) FROM hr_employees GROUP BY department_id ORDER BY COUNT(*) DESC; -- <- Neat that this works =]

--3. Display job ID and find out each job categories’ average salary but show only average salary more than 10000.
SELECT job_id, AVG(salary) FROM hr_employees WHERE salary > 10000 GROUP BY job_id;

--4. Display departments where any manager is managing more than 5 employees.
SELECT department_id, manager_id, COUNT(*) FROM hr_employees GROUP BY department_id, manager_id HAVING COUNT(*) > 5

--5. Display job ID, number of employees, sum of salary, and difference between highest salary and lowest salary of the employees of the job.
--SELECT job_id, COUNT(*) "# of Employees", SUM(salary), MIN(salary), MAX(salary), (MAX(salary) - MIN(salary)) "Salary Delta" FROM hr_employees GROUP BY job_id
SELECT job_id, COUNT(*) "# of Employees", SUM(salary), (MAX(salary) - MIN(salary)) "Salary Delta" 
FROM hr_employees 
GROUP BY job_id ORDER BY (MAX(salary) - MIN(salary)) DESC