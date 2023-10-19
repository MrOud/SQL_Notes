select * from hr_employees WHERE department_id = 90;

--SQL%ROWCOUNT -- count of rows
--SQL%FOUND -- exists
--SQL%NOTFOUND -- !exists

DECLARE
    sv_empid number := &eid;
BEGIN
    UPDATE hr_employees 
    SET salary = salary + 500
    WHERE emplyee_id = sv_empid;
    
    IF SQL%ROWCOUNT > 1 THEN 
        rollback;
    ELSE 
        commit;
    END IF;
END;


----- Scalars
DECLARE
    CURSOR c_emp_cursor IS
    SELECT employee_id, last_name, salary FROM hr_employees
    WHERE department_id = 30;
    
    sv_empno hr_employees.employee_id%TYPE;
    sv_lname hr_employees.last_name%TYPE;
    sv_salary hr_employees.salary%TYPE;

BEGIN
    OPEN c_emp_cursor;
    LOOP
        FETCH c_emp_cursor INTO sv_empno, sv_lname, sv_salary;
        IF sv_salary < 3000 THEN
            UPDATE hr_employees
            SET salary = salary + 500
            WHERE employee_id = sv_empno;
        ELSE
            UPDATE hr_employees
            SET salary = salary + 300
            WHERE employee_id = sv_empno;
        END IF;
        
        EXIT WHEN c_emp_cursor%NOTFOUND;
        --DBMS_OUTPUT.PUT_LINE( sv_empno || ' ' || sv_lname || ' ' || sv_salary);
    END LOOP;
    CLOSE c_emp_cursor;
END;

rollback

---- Record 
DECLARE
    CURSOR c_emp_cursor IS
    SELECT employee_id, last_name, salary, department_id, salary *12 as ysal FROM hr_employees
    WHERE department_id = 30;
    
   my_emprec     c_emp_cursor%ROWTYPE; 
   
BEGIN
    OPEN c_emp_cursor;
    LOOP
        FETCH c_emp_cursor INTO my_emprec ;
        IF my_emprec.salary < 3000 THEN
            UPDATE hr_employees
            SET salary = salary + 500
            WHERE employee_id = my_emprec.employee_id;
        ELSE
            UPDATE hr_employees
            SET salary = salary + 300
            WHERE employee_id = my_emprec.employee_id;
        END IF;
        
        EXIT WHEN c_emp_cursor%NOTFOUND;
        --DBMS_OUTPUT.PUT_LINE( sv_empno || ' ' || sv_lname || ' ' || sv_salary);
    END LOOP;
    CLOSE c_emp_cursor;
END;

--- Cursor loop
DECLARE
    CURSOR c_emp_cursor IS
    SELECT employee_id, last_name, salary, department_id, salary *12 as ysal FROM hr_employees
    WHERE department_id = 30;
    
BEGIN
    FOR my_emprec IN c_emp_cursor LOOP
        IF my_emprec.salary < 3000 THEN
            UPDATE hr_employees
            SET salary = salary + 500
            WHERE employee_id = my_emprec.employee_id;
        ELSE
            UPDATE hr_employees
            SET salary = salary + 300
            WHERE employee_id = my_emprec.employee_id;
        END IF;
    END LOOP;
END;

---- 

DECLARE
    CURSOR c_emp_cursor IS
    SELECT employee_id, last_name, salary, department_id, salary *12 as ysal FROM hr_employees 
    WHERE department_id = 30 FOR UPDATE WAIT 10; -- Wait for lock on data
    
BEGIN
    FOR my_emprec IN c_emp_cursor LOOP
        IF my_emprec.salary < 3000 THEN
            UPDATE hr_employees
            SET salary = salary + 500
            WHERE CURRENT OF c_emp_cursor;
        ELSE
            UPDATE hr_employees
            SET salary = salary + 300
            WHERE employee_id = my_emprec.employee_id;
        END IF;
    END LOOP;
END;

--- cursor for loop using subquery
BEGIN
    FOR my_emprec IN (SELECT * FROM hr_employees WHERE department_id = 30) LOOP
        IF my_emprec.salary < 3000 THEN
            UPDATE hr_employees
            SET salary = salary + 500
            WHERE employee_id = my_emprec.employee_id;
        ELSE
            UPDATE hr_employees
            SET salary = salary + 300
            WHERE employee_id = my_emprec.employee_id;
        END IF;
    END LOOP;
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN --WHEN NO_DATA_FOUND OR TOO_MANY_ROWS
            DBMS_OUTPUT.PUT_LINE('De nada!');
        WHEN TOO_MANY_ROW THEN
            DBMS_OUTPUT.PUT_LINE('Slow ya roll!');
        WHEN OTHER THEN
            DBMS_OUTPUT.PUT_LINE('Something else went wrong!');
END;

rollback



create table   test55  (id  number primary key,  name   char(50)  not null);

INSERT INTO test55 VALUES (1) 

INSERT INTO test55 VALUES ('name1') 

INSERT INTO test55 VALUES (1,null)

DECLARE
 except_ers EXCEPTION;
 PRAGMA EXCEPTION_INIT (except_ers, -01400);
BEGIN
    INSERT INTO test55 VALUES (1, 'test'); 
EXCEPTION
    WHEN except_ers THEN
        DBMS_OUTPUT.PUT_LINE('custom exception!');
END;


--List all of the employees from either department 30 or 80 and bring their employee_id, last_name, first_name, salary, job_id

--process each employees in this segment and check their salary and job_id
    --if employee is performing SA_MAN job and employee earn less than 12000 then increase their salary
    --by 5% and print emp_id, last_name and increased salary

    --if empoyee is performing SA_MAN job and he/she earn more than 12000 then increase their salary by
    --3% and print emp_id, last_name and increased salary

    --If empoyee is performing SA_REP job and he/she earn more than 8000 then increase their salary by 7%
    --and print emp_id, last_name and increased salary
    
    --If empoyee is performing SA_REP job and he/she earn less than 8000 then increase their salary by 9%
    --and print emp_id, last_name and increased salary

    --everyone else gets only 2%

BEGIN
    FOR emp_record IN (SELECT * FROM hr_employees WHERE department_id IN (30, 80))
    LOOP
        IF emp_record.job_id = 'SA_MAN' THEN
            IF emp_record.salary < 12000 THEN
                UPDATE hr_employees 
                    SET salary = salary + (salary * 0.05)
                    WHERE employee_id = emp_record.employee_id;
                DBMS_OUTPUT.PUT_LINE(emp_record.employee_id || ' ' || emp_record.last_name || ' ' || emp_record.salary || ' SA_MAN 5% raise');
            ELSE
                UPDATE hr_employees 
                    SET salary = salary + (salary * 0.03)
                    WHERE employee_id = emp_record.employee_id;
                DBMS_OUTPUT.PUT_LINE(emp_record.employee_id || ' ' || emp_record.last_name || ' ' || emp_record.salary || ' SA_MAN 3% raise');
            END IF;
        ELSIF emp_record.job_id = 'SA_REP' THEN
            IF emp_record.salary > 8000 THEN
                UPDATE hr_employees 
                    SET salary = salary + (salary * 0.07)
                    WHERE employee_id = emp_record.employee_id;
                DBMS_OUTPUT.PUT_LINE(emp_record.employee_id || ' ' || emp_record.last_name || ' ' || emp_record.salary || ' SA_REP 7% raise');
            ELSE
                UPDATE hr_employees 
                    SET salary = salary + (salary * 0.09)
                    WHERE employee_id = emp_record.employee_id;
                DBMS_OUTPUT.PUT_LINE(emp_record.employee_id || ' ' || emp_record.last_name || ' ' || emp_record.salary || ' SA_REP 9% raise');
            END IF;
        ELSE
            UPDATE hr_employees 
                SET salary = salary + (salary * 0.02)
                WHERE employee_id = emp_record.employee_id;
            DBMS_OUTPUT.PUT_LINE(emp_record.employee_id || ' ' || emp_record.last_name || ' ' || emp_record.salary || ' ' || emp_record.job_id || ' 2% raise');
        END IF;
    END LOOP;
END;

rollback
