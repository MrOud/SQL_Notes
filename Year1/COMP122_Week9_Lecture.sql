--Week 9 - Single Row Functions

SELECT SYSDATE, to_char (SYSDATE, 'DD-MM-YYYY HH:MM:SS am') FROM DUAL
SELECT SYSDATE, to_char (SYSDATE-12, 'DDth-MM-YYYY HH:MM:SS am') FROM DUAL
SELECT SYSDATE, to_char (SYSDATE-12, 'DD-MM-YYYY HH24:MM:SS') FROM DUAL
--find hour many months worker worked for us
SELECT last_name, hire_date, SYSDATE, SYSDATE-hire_date FROM hr_employees --number of days
SELECT last_name, hire_date, SYSDATE, (SYSDATE-hire_date)/365 as num_of_years FROM hr_employees --number of years
SELECT last_name, hire_date, SYSDATE, (SYSDATE-hire_date)/30 as num_of_months FROM hr_employees --these cals introduce small errors
SELECT last_name, hire_date, SYSDATE, TRUNC((SYSDATE-hire_date)/30) as num_of_months FROM hr_employees 
SELECT last_name, hire_date, SYSDATE, ROUND((SYSDATE-hire_date)/30) as num_of_months FROM hr_employees 
SELECT last_name, hire_date, SYSDATE, (SYSDATE-hire_date)/7 as num_of_months FROM hr_employees --find how many weeks...

SELECT last_name, hire_date, hire_date+60 as probation_end from hr_employees


SELECT ROUND(746.971, 0) FROM DUAL --747
SELECT ROUND(746.971, 1) FROM DUAL --747
SELECT ROUND(746.971, 2) FROM DUAL --746.97

SELECT TRUNC(746.971, 0) FROM DUAL --746
SELECT TRUNC(746.971, 1) FROM DUAL --746.9

SELECT last_name, hire_date, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) from hr_employees
SELECT last_name, hire_date, ROUND(ADD_MONTHS(hire_date, 6)) from hr_employees

SELECT last_name, hire_date, NEXT_DAY(hire_date, 'MONDAY') from hr_employees

--NVL converts null to not null value
SELECT last_name, salary,job_id, commission_pct, salary * commission_pct FROM hr_employees --give nulls for formula
SELECT last_name, salary,job_id, commission_pct, salary * NVL(commission_pct, 0) FROM hr_employees --turns null to zero
SELECT last_name, salary,job_id, commission_pct, salary * 12, ROUND(salary * 12 +  NVL(commission_pct, 0) * 12, 2) FROM hr_employees
SELECT clientno, viewdate, NVL(comments, '--No Comment Left--') from dh_viewing --Works for strings

--NVL2: NVL2([check], if not null output, if null output)
SELECT clientno, viewdate, NVL2(comments, '++Client left comment++' ,'--No Comment Left--') as Comment_left from dh_viewing

--CASE
SELECT last_name, hire_date, ROUND(MONTHS_BETWEEN('01-JUL-09', hire_date)/12) "Years",
CASE
    WHEN (MONTHS_BETWEEN('01-JUL-09', hire_date)/12) < 4 THEN 'Level 1'
    WHEN (MONTHS_BETWEEN('01-JUL-09', hire_date)/12) < 8 THEN 'Level 2'
    WHEN (MONTHS_BETWEEN('01-JUL-09', hire_date)/12) < 11 THEN 'Level 3'
    WHEN (MONTHS_BETWEEN('01-JUL-09', hire_date)/12) < 15 THEN 'Level 4'
    ELSE 'Level 5'
END as "Retire Level"
FROM hr_employees WHERE (MONTHS_BETWEEN('01-JUL-09', hire_date)/12) > 15

SELECT * from hr_employees

SELECT last_name, first_name, salary, job_id,
CASE
 WHEN job_id = 'IT_PROG' THEN 'Technical'
 WHEN job_id = 'SA_REP' THEN 'Field'
 WHEN job_id = 'FI_ACCOUNT' THEN 'Back Office'
 WHEN job_id = 'ST_CLERK' THEN 'Front Office'
 ELSE 'Others'
END area
FROM hr_employees

--like CASE but only needs field input once, final is ELSE 
SELECT last_name, first_name, salary, job_id,
 DECODE(job_id, 'IT_PROG', 'Technical',
                'SA_REP', 'Field',
                'FI_ACCOUNT', 'Back Office',
                'ST_CLERK', 'Front Office',
                            'Others') "Area"
FROM hr_employees

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

SELECT to_char(99.99, '$99.99') FROM DUAL
SELECT INITCAP('welcome to class') FROM DUAL