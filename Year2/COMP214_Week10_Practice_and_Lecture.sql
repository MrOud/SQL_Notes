-- Practice 
SELECT * FROM dh_privateowner;

CREATE OR REPLACE FUNCTION dh_owner_email
(
    p_owner dh_privateowner.ownerno%TYPE
) RETURN VARCHAR AS
    v_email VARCHAR(50);
    v_domain VARCHAR(50);
BEGIN
    SELECT email INTO v_email FROM dh_privateowner WHERE ownerno = p_owner;
    v_domain := SUBSTR(v_email, INSTR(v_email, '@') + 1, 10);
    RETURN v_domain;
END;


BEGIN
    DBMS_OUTPUT.PUT_LINE(dh_owner_email('CO46'));
END;

--Triggers

CREATE TABLE audit_emp (
  user_name     VARCHAR2(30),
  time_stamp    date,
  id            NUMBER(6),
  old_last_name VARCHAR2(25),
  new_last_name VARCHAR2(25),
  old_title     VARCHAR2(10),
  new_title     VARCHAR2(10),
  old_salary    NUMBER(8,2),
  new_salary    NUMBER(8,2) 
);

CREATE OR REPLACE TRIGGER audit_emp_values
AFTER DELETE OR INSERT OR UPDATE ON hr_employees
FOR EACH ROW
BEGIN
  INSERT INTO audit_emp(user_name, time_stamp, id,
    old_last_name, new_last_name, old_title,
    new_title, old_salary, new_salary)
  VALUES (USER, SYSDATE, :OLD.employee_id,
    :OLD.last_name, :NEW.last_name, :OLD.job_id,
    :NEW.job_id, :OLD.salary, :NEW.salary);
END;
  
select * from hr_employees;
select * from audit_emp;
INSERT INTO hr_employees VALUES (301, 'Kris', 'Oud', 'merp@derp.com', '555.123.2323', SYSDATE, 'AC_MGR', 16000, NULL, NULL, 90); --1 row
UPDATE hr_employees SET salary = 18000 WHERE department_id=50; --45 rows
DELETE FROM hr_employees WHERE employee_id = 301; -- 1 row

rollback;

-- Trigger in class Practice

SELECT * FROM hr_jobs;

CREATE OR REPLACE PROCEDURE KO_CHECK_SALARY
(
    p_sal NUMBER,
    p_jobid hr_employees.job_id%TYPE
) AS
    v_sal_min hr_jobs.min_salary%TYPE;
    v_sal_max hr_jobs.max_salary%TYPE;
BEGIN
    SELECT min_salary, max_salary INTO v_sal_min, v_sal_max FROM hr_jobs WHERE job_id = p_jobid;
    IF p_sal < v_sal_min OR p_sal > v_sal_max THEN
        raise_application_error(-20001, 'Invalid Salary: ' || p_sal || '. Salaries for ' || p_jobid || ' must be between ' || v_sal_min || ' and ' || v_sal_max);
    END IF;
END;

execute ko_check_salary(1000, 'AD_PRES'); --Fails
execute ko_check_salary(25000, 'AD_PRES'); --Passes
execute ko_check_salary(25000, 'FI_MGR'); --Passes

CREATE OR REPLACE TRIGGER CHECK_SAL_TRG
BEFORE UPDATE OR INSERT ON hr_employees
FOR EACH ROW
BEGIN
    ko_check_salary(:NEW.salary, :NEW.job_id);
END;

SELECT * FROM hr_employees;

UPDATE hr_employees SET salary = 45000 WHERE employee_id = 100; --fails as expected
UPDATE hr_employees SET salary = 38000 WHERE employee_id = 100; --passes as expects

--Retiree

create table hr_retired_employees
(
    employee_id number(7) Primary Key,
    first_name varchar(50),
    last_name varchar(50),
    salary number(9,2),
    department_id number(4)
)

CREATE OR REPLACE TRIGGER retirement_automation
BEFORE DELETE ON hr_employees
FOR EACH ROW
BEGIN
    INSERT INTO hr_retired_employees VALUES
    (
        :OLD.employee_id,
        :OLD.first_name,
        :OLD.last_name,
        :OLD.salary,
        :OLD.department_id
    );
END;

SELECT * FROM hr_retired_employees;
DELETE hr_employees WHERE employee_id = 168;
DELETE hr_employees WHERE employee_id IN (173, 174);

rollback;

