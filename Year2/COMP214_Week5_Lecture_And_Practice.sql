--Practice week 5

CREATE TABLE messages ( results number)

BEGIN
    FOR i IN 50..100 LOOP
        CONTINUE WHEN i IN (65, 75, 85, 95);
        INSERT INTO messages VALUES (i);
    END LOOP;
    commit;
    FOR x IN (SELECT results from messages) LOOP
        DBMS_OUTPUT.PUT_LINE(x.results);
    END LOOP;
END;

SELECT * FROM messages;

drop table messages;

-- Week 5 Lecture notes

SELECT * FROM hr_departments;

DECLARE
    --4 ways to make records
    recordA same%ROWTYPE as hr_departments; --copy table
    recordB (department_id number, department_name char); --subset
    recordC (same%ROWTYPE as hr_departments, city char(50), town(50)); --superset
    recordD (recordA, city char(50), town(50)); --same as RecordC
BEGIN

END;

DECLARE
    sv_salary hr_employees.salary%TYPE;
    cv_recdept hr_departments%ROWTYPE;
BEGIN
    SELECT * INTO cv_recdept FROM hr_departments WHERE department_id=40;
    DBMS_OUTPUT.PUT_LINE(cv_recdept.department_name);
END;

--Practice:
 --pull employee 175 entire info into composite record data type
 --and once you select INTO it, use composite.salary * 12 and print employee name and print yearly salary
 
SELECT * FROM hr_employees

DECLARE
    cv_emp hr_employees%ROWTYPE;
BEGIN
    SELECT * INTO cv_emp FROM hr_employees WHERE employee_id=175;
    DBMS_OUTPUT.PUT_LINE(cv_emp.first_name || ' ' || cv_emp.last_name || ' -> ' || cv_emp.salary * 12);
END;

--or prompt user for eid
DECLARE
    cv_emp hr_employees%ROWTYPE;
BEGIN
    SELECT * INTO cv_emp FROM hr_employees WHERE employee_id=&eid;
    DBMS_OUTPUT.PUT_LINE(cv_emp.first_name || ' ' || cv_emp.last_name || ' -> ' || cv_emp.salary * 12);
END;


--sampe 2:
 --use only department_id and department_name from hr_departments table and create type/composite variable for that
 
 DECLARE
    TYPE sub_dept IS RECORD
    (
        d_id hr_departments.department_id%TYPE,
        d_name varchar(40)
    );
    cv_subdept sub_dept;
 BEGIN
    SELECT department_id, department_name INTO cv_subdept FROM hr_departments WHERE department_id=40;
    DBMS_OUTPUT.PUT_LINE(cv_subdept.d_id || ' ' || cv_subdept.d_name);
 END;
 
--2.1 Add an extra field
DECLARE
    TYPE sub_dept IS RECORD
    (
        d_id hr_departments.department_id%TYPE,
        d_name varchar(40),
        d_city hr_locations.city%TYPE
    );
    cv_subdept sub_dept;
 BEGIN
    SELECT department_id, department_name INTO cv_subdept.d_id, cv_subdept.d_name FROM hr_departments WHERE department_id=40;
    cv_subdept.d_city := 'Toronto';
    DBMS_OUTPUT.PUT_LINE(cv_subdept.d_id || ' ' || cv_subdept.d_name || ' ' || cv_subdept.d_city);
 END;
 
 
 -- TYPE type_name IS TABLE OF
 --    ....
 --  INDEX BY PLS_INTEGER
 
DECLARE
   TYPE emp_table_type IS TABLE OF
      hr_employees%ROWTYPE INDEX BY PLS_INTEGER;
  
    cv_emp_table  emp_table_type;

    var_a number := 7;
BEGIN
  FOR i IN 100..104
  LOOP
    SELECT * INTO cv_emp_table(i) FROM hr_employees
     WHERE employee_id = i; 
  END LOOP;

DBMS_OUTPUT.PUT_LINE(cv_emp_table(103).hire_date);

--IF var_a > 5 THEN 
--     DELETE cv_emp_table(104).DELETE; 
--END IF;

  FOR i IN cv_emp_table.FIRST..cv_emp_table.LAST 
  LOOP
     DBMS_OUTPUT.PUT_LINE(cv_emp_table(i).last_name);
  END LOOP;
END; 
 