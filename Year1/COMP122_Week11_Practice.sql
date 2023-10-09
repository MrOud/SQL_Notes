--1.	Find the number of staff working in each branch and the sum(Total) of their salaries 
SELECT count(*), SUM(salary) FROM DH_STAFF GROUP BY branchno;

--2.	 Create a report to show all of the employees who work in the branch in City  London? 

SELECT e.fname, e.lname, e.branchno, e.position, b.city 
FROM dh_staff e JOIN dh_branch b
ON e.branchno = b.branchno
WHERE b.city = 'London';

--3.	Provide a report for all of employees( staff) whose salary is greater than the Dream Home 
--      company’s average salary, and calculate by how much their salary is greater than the average salary?

SELECT fname, lname, salary, (SELECT AVG(salary) FROM dh_staff) "Avg Salary", salary - (SELECT AVG(salary) FROM dh_staff) "Salary Diff" from dh_staff WHERE (salary > (SELECT AVG(salary) FROM dh_staff))

-- 4.	Create a report showing all the properties that are handled by employee who work in the branch street at ‘163 Main St’ 

SELECT * FROM dh_propertyforrent
SELECT * FROM dh_branch
SELECT * FROM dh_staff

SELECT p.propertyno, p.city, p.type, b.street 
FROM dh_propertyforrent p 
JOIN dh_branch b ON p.branchno = b.branchno 
WHERE b.street = '163 Main Street'

-- 5.	For each Branch office , list the staff numbers and names of staff who manage properties and the properties that they manage
SELECT e.branchno, e.fname, e.lname, e.telephone, p.propertyno
FROM dh_staff e
JOIN dh_propertyforrent p ON e.staffno = p.staffno
ORDER BY e.branchno 

--6.	List all properties and any branch offices that are in the same city
SELECT p.propertyno, p.city, b.branchno, b.city
FROM dh_propertyforrent p
LEFT JOIN dh_branch b ON p.city = b.city

--7.	Increase all assistant staff salary by %10 
UPDATE dh_staff SET salary = (salary * 1.1) WHERE position = 'Assistant'
commit

--8.	For Staff called Ann Beech , promote her as Manager and increase her salary to 14000 and also move her Branch B005
UPDATE dh_staff SET position = 'Manager', salary = 14000, branchno = 'B005' WHERE fname = 'Ann' AND lname = 'Beech'
commit

-- Use HumanResources
-- 1.	Display department name, manager name, and city.
SELECT (e.first_name || ' ' || e.last_name) "Employee", (m.first_name || ' ' || m.last_name) "Manager", l.city
FROM hr_employees e 
JOIN hr_employees m ON e.manager_id = m.employee_id
JOIN hr_departments d ON e.department_id = d.department_id
JOIN hr_locations l ON d.location_id = l.location_id

--2.	Display country name, city, and department name.
SELECT c.country_name, l.city, d.department_name 
FROM hr_departments d
JOIN hr_locations l ON d.location_id = l.location_id
JOIN hr_countries c ON l.country_id = c.country_id

--3.	Display job title, department name, employee last name, starting date for all jobs from 2000 to 2005.
SELECT j.job_title, d.department_name, e.last_name, e.hire_date  
FROM hr_employees e
JOIN hr_departments d ON e.department_id = d.department_id
JOIN hr_jobs j ON e.job_id = j.job_id
WHERE to_char(e.hire_date, 'YYYY') BETWEEN 2000 AND 2005

--SELECT * FROM hr_employees ORDER BY hire_date -- SANITY CHECK: Just confirming no hires after year 2000

--4.	Display employee name if the employee joined before his manager.
SELECT (e.first_name || ' ' ||e.last_name) "Employee", e.hire_date "Emp Hire Date", m.hire_date "Mgr Hire Date"
FROM hr_employees e
JOIN hr_employees m ON e.manager_id = m.employee_id
WHERE e.hire_date < m.hire_date

--5.	Display details of manager who manages more than 5 employees.
--SELECT manager_id, COUNT(*) FROM hr_employees GROUP BY  manager_id HAVING COUNT(manager_id) > 5 ORDER BY manager_id --Sanity check

--fail
SELECT (m.first_name || ' ' || m.last_name) "Manager"
FROM hr_employees e
JOIN hr_employees m ON e.manager_id = m.employee_id
GROUP BY e.manager_id

--fail
SELECT e.manager_id, m.first_name, m.last_name, COUNT(*) 
FROM hr_employees e 
JOIN hr_employees m ON e.manager_id = m.employee_id 
GROUP BY e.manager_id HAVING COUNT(e.manager_id) > 5 

--fail
SELECT (m.first_name || ' ' || m.last_name) "Manager"
FROM hr_employees e
JOIN hr_employees m ON e.manager_id = m.employee_id
WHERE e.manager_id IN (SELECT manager_id FROM hr_employees GROUP BY  manager_id HAVING COUNT(manager_id) > 5)

--finally!
SELECT DISTINCT (m.first_name || ' ' || m.last_name) "Manager", e.manager_id
FROM hr_employees e
JOIN hr_employees m ON e.manager_id = m.employee_id
WHERE e.manager_id IN (SELECT manager_id FROM hr_employees GROUP BY  manager_id HAVING COUNT(manager_id) > 5)
ORDER BY e.manager_id
