--PL/SQL Engine

BEGIN
    SELECT avg(salary from hr_employees;
    
    SELECT last_name, employee_id, salaray from hr_employess 
    WHERE salary > temp variable and employee_id=103;
    
    new salary = salary * 1.10;
END;
----------
DECLARE
var_last varchar(25); 
var_first varchar(20); 
var_salary hr_employees.salary%TYPE; --clones the type
var_annualPlusBonus number(8, 2);

BEGIN
    SELECT first_name, last_name, salary INTO var_last, var_first, var_salary
    FROM hr_employees WHERE employee_id = 105;
    
    DBMS_OUTPUT.PUT_LINE (var_last || ' ' || var_first || ' ' || var_salary);
    var_annualPlusBonus := var_salary * 12 + 500;
    DBMS_OUTPUT.PUT_LINE (var_annualPlusBonus);
END;

--Practice 1 PL/SQL
DECLARE
v_today DATE := SYSDATE;
v_tomorrow v_today%TYPE;

BEGIN
    v_tomorrow := v_today + 1;
    DBMS_OUTPUT.PUT_LINE( 'Hello World!' );
    DBMS_OUTPUT.PUT_LINE( v_today );
    DBMS_OUTPUT.PUT_LINE( v_tomorrow );
END;

--Practice 2
-- I'm a single line comment
/* I'm 
 a
 Multi
     Line
    Comment...

Hooray!
*/
DECLARE
v_basic_percent number := 0.45;
v_pf_percent number := 0.12;
v_fname varchar2(15);
v_emp_sal number(10);
BEGIN
 SELECT first_name, salary 
 INTO v_fname, v_emp_sal FROM hr_employees
 WHERE employee_id = 110;
 
 DBMS_OUTPUT.PUT_LINE( 'Hello ' || v_fname );
 DBMS_OUTPUT.PUT_LINE( 'Your salary is: ' || v_emp_sal );
 DBMS_OUTPUT.PUT_LINE( 'Your Pf Contributions is: ' || v_emp_sal * v_pf_percent );
END;
