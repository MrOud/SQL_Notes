--SELECT * FROM table_name

--SELECT a, b, c  FROM table_name

SELECT * FROM HR_Employees

SELECT first_name, last_name FROM HR_Employees --Projection

SELECT last_name, department_id FROM hr_employees

SELECT department_id FROM hr_employees -- shows repeats
--Eliminate repeats...
SELECT UNIQUE department_id FROM hr_employees 
--or
SELECT DISTINCT department_id FROM hr_employees

SELECT first_name||' '||last_name from hr_employees --concats... some use '+' -- ugly output shows as statment typed
SELECT first_name||' '||last_name  as "full name" from hr_employees --Use alias to change column name double quotes for multi word strings, single word need no quotes

SELECT first_name, last_name FROM HR_Employees WHERE first_name LIKE 'S%' --All who's first name start with S
SELECT department_id, first_name, last_name FROM HR_Employees WHERE department_id = 90 --All who work in dept 90
SELECT department_id, first_name, last_name FROM HR_Employees WHERE department_id != 90 --Not in 90

SELECT department_id, first_name, last_name, salary FROM HR_Employees WHERE department_id != 90 AND salary < 5000

SELECT department_id, first_name, last_name, salary FROM HR_Employees WHERE salary BETWEEN 4000 AND 6500
SELECT department_id, first_name, last_name, salary FROM HR_Employees WHERE salary >= 4000 AND salary <= 6500 

SELECT department_id, first_name, last_name, salary FROM HR_Employees WHERE department_id IN (60, 80, 100)
SELECT department_id, first_name, last_name, salary FROM HR_Employees WHERE department_id = 60 OR department_id = 80 OR department_id = 100

SELECT first_name, last_name FROM HR_Employees WHERE last_name LIKE '%old'
SELECT first_name, last_name FROM HR_Employees WHERE first_name LIKE 'Alex%'
SELECT first_name, last_name FROM HR_Employees WHERE last_name LIKE '%no%' -- % -> 1 or many _ 1 only
SELECT first_name, last_name FROM HR_Employees WHERE last_name LIKE '_o%' --Second char is 'o'
SELECT first_name, last_name FROM HR_Employees WHERE last_name LIKE '____gos' -- Seven digits ending gos
SELECT first_name, last_name FROM HR_Employees WHERE last_name LIKE '____gos' 

SELECT first_name, last_name, department_id, commission_pct FROM HR_Employees WHERE commission_pct IS NOT NULL
SELECT first_name, last_name, department_id, commission_pct FROM HR_Employees WHERE commission_pct IS NULL

--1) show me all the books we have ?
SELECT * FROM JL_BOOKS

--2) show all the book in our inventory but only present isbn name and cost
SELECT isbn, title, cost FROM JL_BOOKS

--3) show all of the info about books in computer category
SELECT * FROM JL_BOOKS WHERE category = 'COMPUTER'

--4) show me the customer number equal to 1005
SELECT * FROM JL_CUSTOMERS WHERE customer# = 1005

--5) show us all the custiomers where customer numbers is in the range of 1005 and 1010
SELECT * FROM JL_CUSTOMERS WHERE customer# BETWEEN 1005 AND 1010

--AND takes precedence over OR
-- (A AND B) OR C
-- A OR (B AND C)

--Set order of results
SELECT department_id, first_name, last_name, salary FROM HR_Employees WHERE department_id IN (60, 80, 100) ORDER BY first_name
SELECT department_id, first_name, last_name, salary FROM HR_Employees WHERE department_id IN (60, 80, 100) ORDER BY first_name ASC
SELECT department_id, first_name, last_name, salary FROM HR_Employees WHERE department_id IN (60, 80, 100) ORDER BY first_name DESC

SELECT department_id, first_name, last_name, salary FROM HR_Employees WHERE department_id IN (60, 80, 100) ORDER BY last_name DESC, first_name ASC


--Formatting dates
SELECT * FROM hr_employees WHERE hire_date = '89-09-21'

SELECT * FROM hr_employees WHERE hire_date = to_date('21/09/1989','DD/MM/YYYY') --Converting dates for different formats
SELECT * FROM hr_employees WHERE hire_date = to_date('09-21-1989','MM-DD-YYYY')
SELECT * FROM hr_employees WHERE to_char(hire_date, 'YYYY/MM/DD') = '1989/09/21'

INSERT INTO hr_employees VALUES (208, 'Ersan', 'Cam', 'EC', '5555', to_date('04-MAR-23', 'DD-MON-YY'), 'IT_PROG', 4000, null, 105, 60)
SELECT * FROM hr_employees where first_name = 'Ersan'

SELECT * FROM hr_employees WHERE to_char(hire_date, 'YY') = '90'
SELECT * FROM hr_employees WHERE to_char(hire_date, 'YY') LIKE '9_'

SELECT * FROM hr_employees WHERE to_char(hire_date, 'MM') BETWEEN '06'
SELECT * FROM hr_employees WHERE to_char(hire_date, 'MM') BETWEEN '06' AND '09'

--Single row functions

SELECT last_name, length (last_name) FROM hr_employees

--LENGTH : accept STRING return NUMBER
SELECT length('DUAL is a dummy table') FROM dual

--Case conversion

SELECT last_name, first_name, UPPER (last_name), LOWER(first_name) FROM hr_employees 

SELECT * FROM hr_locations
SELECT street_address, SUBSTR(street_address, 5, 10) FROM hr_locations 
--SUBSTR(STRING value [or column], NUMBER starting point, NUMBER length)

SELECT street_address, SUBSTR(street_address, 5) FROM hr_locations --...or to end
SELECT street_address, SUBSTR(street_address, -5) FROM hr_locations --...or from the end

--INSTR(STRING valus [or col], CHAR special) -- returns index of first occurancer
SELECT postal_code, INSTR(postal_code, ' ') FROM hr_locations
SELECT SUBSTR(postal_code, 0, 3) FROM hr_locations WHERE INSTR(postal_code, ' ')=4
SELECT SUBSTR(postal_code, 1, 3) FROM hr_locations WHERE INSTR(postal_code, ' ')=4

-- SUBSTR(a, INSTR(a, '@'))

SELECT c_email, SUBSTR(c_email,INSTR(c_email,'@')) FROM test_customers_ko