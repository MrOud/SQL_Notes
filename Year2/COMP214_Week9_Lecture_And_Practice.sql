CREATE OR REPLACE PROCEDURE sp_return_emp_info
 (p_id     IN  hr_employees.employee_id%TYPE,
  p_name   OUT hr_employees.last_name%TYPE,
  p_salary OUT hr_employees.salary%TYPE) IS
BEGIN
  SELECT  last_name, salary INTO p_name, p_salary
  FROM    hr_employees
  WHERE   employee_id = p_id;
END  ;

DECLARE
    lv_emp_name hr_employees.last_name%TYPE;
    lv_emp_sal hr_employees.salary%TYPE;
BEGIN
    sp_return_emp_info(171, lv_emp_name, lv_emp_sal);
    DBMS_OUTPUT.PUT_LINE(lv_emp_name || ' earns ' || to_char(lv_emp_sal, '$999,999.00'));
END;

--

CREATE OR REPLACE PROCEDURE sp_format_phone
 (p_phone_no IN OUT VARCHAR) IS
BEGIN
    p_phone_no := '(' || SUBSTR(p_phone_no, 1, 3) ||
                  ')' || SUBSTR(p_phone_no, 4, 3) ||
                  '-' || SUBSTR(p_phone_no, 7, 4);
END;

DECLARE
    p_phone VARCHAR(20);
BEGIN
    p_phone := '9052891213';
    sp_format_phone(p_phone);
    DBMS_OUTPUT.PUT_LINE(p_phone);
END;

--

CREATE OR REPLACE FUNCTION get_sal
    (p_id hr_employees.employee_id%TYPE) RETURN NUMBER IS
    v_sal hr_employees.salary%TYPE := 0;
BEGIN
    SELECT salary
    INTO v_sal
    FROM hr_employees
    WHERE employee_id = p_id;
    RETURN v_sal;
END;

--Calling functions....
EXECUTE   dbms_output.put_line( fn_get_sal (105)); --inline

--as part of select....
SELECT employee_id,last_name,salary , get_sal(employee_id)
FROM hr_employees 
  
SELECT employee_id, last_name, salary , get_sal(employee_id)*12   asyearlysal 
FROM hr_employees
WHERE department_id=60

SELECT employee_id, first_name, last_name FROM hr_employees
WHERE get_sal(employee_id) * 12 > 80000

UPDATE ko_employees
SET salary = salary + 100
WHERE get_sal(employee_id) * 12 > 80000

SELECT * FROM ko_employees WHERE get_sal(employee_id) * 12 > 80000

CREATE TABLE ko_employees as SELECT * FROM hr_employees
--Quesiton :  update employee's salary make same yearly salary as employee 101 for all employees whose yearly salary is less than 80,000  (by using fn

rollback;

UPDATE ko_employees
SET salary = get_sal(101)
WHERE get_sal(employee_id) * 12 > 80000

--question:     remove employees who are making more than 85000 yearly salary (use function)

DELETE FROM ko_employees WHERE get_sal(employee_id) * 12 > 85000


CREATE TABLE jl_customercredit AS select customer#, 0 as balance , 0 as credit from jl_customers;
select * from jl_customercredit;

update jl_customercredit
set credit = 25000
WHERE customer# between 1001 and 1008;

update jl_customercredit
set credit = 52000
WHERE customer# between 1009 and 1015;

update jl_customercredit
set credit = 14000
WHERE customer# between 1016 and 1020;

--Question 1
CREATE OR REPLACE FUNCTION findCreditLevel
 (p_id jl_customercredit.customer#%TYPE) 
 RETURN VARCHAR AS
    v_level VARCHAR(15);
    v_credit jl_customercredit.credit%TYPE;
BEGIN
    SELECT credit INTO v_credit FROM jl_customercredit WHERE customer# = p_id;
    IF (v_credit <= 20000) THEN
        RETURN 'SILVER';
    ELSIF (v_credit <= 50000) THEN
        RETURN 'GOLD';
    ELSE
        RETURN 'PLATINUM';
    END IF;
END;
execute DBMS_OUTPUT.PUT_LINE(findCreditLevel(1001)) -- -> GOLD
execute DBMS_OUTPUT.PUT_LINE(findCreditLevel(1010)) -- -> PLATINUM
execute DBMS_OUTPUT.PUT_LINE(findCreditLevel(1018)) -- -> SILVER

--Question 2

CREATE OR REPLACE PROCEDURE evaluate_all_customers IS
BEGIN
    FOR cust IN (SELECT * FROM jl_customercredit)
    LOOP
        IF (findCreditLevel(cust.customer#) = 'GOLD') THEN
            UPDATE jl_customercredit
            SET balance = -3000
            WHERE customer# = cust.customer#;
        ELSIF (findCreditLevel(cust.customer#) = 'SILVER') THEN
            UPDATE jl_customercredit
            SET balance = -2000
            WHERE customer# = cust.customer#;
        ELSIF (findCreditLevel(cust.customer#) = 'PLATINUM') THEN
            UPDATE jl_customercredit
            SET balance = -5000
            WHERE customer# = cust.customer#;
        END IF;
    END LOOP;
    COMMIT;
END;

EXECUTE evaluate_all_customers();
select * from jl_customercredit;