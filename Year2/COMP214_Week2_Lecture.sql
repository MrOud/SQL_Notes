select * from cj_crimes where status = 'CA'

create table email (mailaddress varchar2(50) );

INSERT INTO email (mailaddress) VALUES ('ersan.cam@my.centennialcollege.ca');
INSERT INTO email (mailaddress) VALUES ('james.curry@gmail.com');
INSERT INTO email (mailaddress) VALUES ('sandra.jenson@yahoo.com');
INSERT INTO email (mailaddress) VALUES ('samantha.jenson@yahoo.ca');
commit

SELECT mailaddress,  
       SUBSTR(mailaddress,1, LENGTH(SUBSTR(mailaddress,1,INSTR(mailaddress,'.')-1))) "First Name",
       SUBSTR(mailaddress, INSTR(mailaddress,'.')+1, INSTR(mailaddress,'@')-INSTR(mailaddress,'.')-1) "Last Name",
       SUBSTR(mailaddress, INSTR(mailaddress,'@')+1) "Domain Name",
       SUBSTR(SUBSTR(mailaddress, -4), INSTR(SUBSTR(mailaddress, -4),'.')+1) "TLD"
FROM email


select order#, shipdate-orderdate  from jl_orders where  shipdate-orderdate  > 3

SELECT o.order#, o.shipdate-o.orderdate "days since shipped", c.firstname, c.lastname  
    FROM jl_orders o JOIN jl_customers c 
    ON (c.customer# = o.customer#)
    WHERE o.shipdate-o.orderdate > 3
    
SELECT * FROM jl_customers

SELECT lastname, firstname, address, 
CASE
    WHEN city = 'AUSTIN' THEN 'Nearby'
    WHEN city = 'CHEYENNE' THEN 'Nearby'
    WHEN city = 'ALBANY' THEN 'Nearby'
    WHEN city = 'EASTPOINT' THEN 'Midrange'
    ELSE 'Distant'
END "SHIP_RANGE"
FROM jl_customers

SELECT * FROM hr_employees

SELECT MIN(salary), 
    MAX(salary), 
    AVG(salary), 
    job_id 
FROM hr_employees 
GROUP BY job_id 
HAVING job_id LIKE '%REP'

SELECT MIN(salary), 
    MAX(salary), 
    AVG(salary), 
    SUM(salary), 
    COUNT(department_id), 
    department_id
FROM hr_employees 
GROUP BY ROLLUP(department_id)
ORDER BY department_id

SELECT department_id,
    job_id,
    MIN(salary), 
    MAX(salary), 
    AVG(salary), 
    SUM(salary), 
    COUNT(*)
FROM hr_employees
GROUP BY ROLLUP(department_id, job_id)
ORDER BY department_id

SELECT department_id,
    job_id,
    MIN(salary), 
    MAX(salary), 
    AVG(salary), 
    SUM(salary), 
    COUNT(*)
FROM hr_employees
GROUP BY CUBE(department_id, job_id)
ORDER BY department_id

--WHERE pre-filters results
--HAVING post-filters results after grouping

--Research ROLLUP vs CUBE