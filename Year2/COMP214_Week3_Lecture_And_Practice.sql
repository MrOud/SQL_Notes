SELECT * FROM hr_employees WHERE salary > (SELECT AVG(salary) from hr_employees);

SELECT * from hr_employees WHERE salary > (SELECT salary from hr_employees WHERE first_name='Ellen' and last_name='Abel');

--Non pairwise
SELECT * from hr_employees 
    WHERE salary = (SELECT salary from hr_employees WHERE first_name = 'Valli') 
    AND job_id = (SELECT job_id from hr_employees WHERE first_name = 'Valli');
    
--pairwise    
SELECT * from hr_employees WHERE (job_id, salary) = (SELECT job_id, salary FROM hr_employees WHERE first_name='Valli');

SELECT first_name, last_name, department_id, salary 
    FROM hr_employees o 
    WHERE salary > (SELECT AVG(salary) FROM hr_employees i WHERE o.department_id = i.department_id)
    ORDER BY o.department_id;
    
SELECT first_name, last_name from hr_employees o
    WHERE 2 <=  (SELECT count(*) FROM hr_job_history i WHERE i.employee_id = o.employee_id);
    
SELECT * from hr_employees;

--Find out any employees who does not have anybody to report to that person?
SELECT employee_id, first_name, last_name from hr_employees o
    WHERE NOT EXISTS ( SELECT * FROM hr_employees WHERE manager_id = o.employee_id)
    
--Find out who does same job as Valli Pataballi but makes more than him

SELECT employee_id, first_name, last_name, job_id, salary FROM hr_employees 
    WHERE job_id = (SELECT job_id from hr_employees WHERE first_name='Valli') AND
    salary > (SELECT salary from hr_employees WHERE first_name='Valli')
    
    
--Practice 1)
--Correlated subquery:
--Find out any employees who does not have anybody to report to that person?

SELECT employee_id, first_name, last_name from hr_employees o
    WHERE NOT EXISTS ( SELECT * FROM hr_employees WHERE manager_id = o.employee_id)
    
--Practice 2) 
--Normal subquery and/or pariwise

--Find our who does same job as Valli Pataballi but makes more salary than Valli Patalli

SELECT employee_id, first_name, last_name, job_id, salary FROM hr_employees 
    WHERE job_id = (SELECT job_id from hr_employees WHERE first_name='Valli') AND
    salary > (SELECT salary from hr_employees WHERE first_name='Valli')

--Practice 3)
-- Find those people ( Find our who does same job as Valli Pataballi but makes more salary than Valli Patalli)
-- and also Update those folks set their salary same as Valli Pataballi 
 
 UPDATE hr_employees
 SET salary = (SELECT salary from hr_employees WHERE first_name='Valli')
 WHERE job_id = (SELECT job_id from hr_employees WHERE first_name='Valli') AND
    salary > (SELECT salary from hr_employees WHERE first_name='Valli')
    
rollback;
--Practice 4) 
--Find those people ( Find our who does same job as Valli Pataballi but makes more salary than Valli Patalli)
-- and also DELETE those folks

DELETE FROM hr_employees 
    WHERE job_id = (SELECT job_id from hr_employees WHERE first_name='Valli') AND
    salary > (SELECT salary from hr_employees WHERE first_name='Valli')
    
--Get get an error: integrity constraint (COMP214_F23_ERS_64.DEPT_MGR_FK) violated - child record found

SELECT * FROM hr_departments where manager_id IN (103, 104)

--We see employee 103 is manager of the IT dept (60) so let's update that
UPDATE hr_departments
SET manager_id = (SELECT employee_id FROM hr_employees WHERE first_name='Valli')
WHERE department_id = 60

--We also need to make sure they are not anyone's manager
UPDATE hr_employees
SET manager_id = (SELECT employee_id FROM hr_employees WHERE first_name='Valli')
WHERE department_id = 60 AND manager_id IN (103, 104)

--Then we can delete them
DELETE FROM hr_employees 
    WHERE job_id = (SELECT job_id from hr_employees WHERE first_name='Valli') AND
    salary > (SELECT salary from hr_employees WHERE first_name='Valli')

rollback;