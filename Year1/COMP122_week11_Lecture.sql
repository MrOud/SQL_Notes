--Natural join(inner or equijoin)
  --Using clause
  --ON clause
  
SELECT eid, fname, d_name FROM sm_emp NATURAL JOIN sm_dept;

SELECT eid, fname, d_name FROM sm_emp JOIN sm_dept USING (d_id)

SELECT eid, fname, d_id, dname FROM sm_emp e JOIN sm_dept d ON e.d_id = d.d_id


SELECT e.employee_id, e.last_name, e.department_id, d.department_id, d.department_name
FROM hr_employees e JOIN hr_departments d -- <-- Give's alias
ON (e.department_id = d.department_id)
WHERE e.salary > 5000

SELECT e.employee_id, e.last_name, e.department_id, d.department_id, d.department_name, l.city, l.state_province
FROM hr_employees e 
JOIN hr_departments d ON (e.department_id = d.department_id)
JOIN hr_locations l ON d.location_id = l.location_id

--cld.FK = Parent.PK

-- Inner Join = Equi Join - Natural Join

--Outer join -> left, right, full outer

SELECT count(*) FROM HR_employees

SELECT e.employee_id, e.last_name, e.department_id, d.department_id, d.department_name
FROM hr_employees e LEFT OUTER JOIN hr_departments d  <-- get employee without dept
ON (e.department_id = d.department_id) 

SELECT e.employee_id, e.last_name, e.department_id, d.department_id, d.department_name
FROM hr_employees e RIGHT OUTER JOIN hr_departments d <-- get dept without emp
ON (e.department_id = d.department_id)

SELECT e.first_name, e.last_name, mgr.first_name, mgr.last_name
FROM hr_employees e JOIN hr_employees mgr
ON e.manager_id = mgr.employee_id

--Building trees (for adv in Semester 3)
SELECT employee_id, last_name, job_id, manager_id FROM hr_employees
START WITH employee_id = 101
CONNECT BY PRIOR manager_id = employee_id

SELECT employee_id, last_name, job_id, manager_id FROM hr_employees
START WITH last_name = 'King'
CONNECT BY PRIOR manager_id = employee_id

--Non-equi join
SELECT first_name, last_name, salary, grade_level
FROM hr_employees e JOIN hr_job_grades j
ON e.salary between j.lowest_sal AND j.highest_sal

