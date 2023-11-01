select * from jl_books;

CREATE OR REPLACE PROCEDURE sp_registerbook AS
BEGIN
    INSERT INTO jl_books VALUES (100005566, 'How to Climb a mountain', SYSDATE, 4, 14.50, 19.50, NULL, 'FITNESS');
END;

BEGIN
    sp_registerbook();
END;

--practice 2)
create or replace PROCEDURE sp_registerbook1(p_isbn IN jl_books.isbn%TYPE    , p_title  IN VARCHAR   ,
    p_pubdate IN DATE   , p_pubid IN NUMBER , p_cost  IN NUMBER , p_retail IN NUMBER ,
    p_discount IN NUMBER , p_category IN VARCHAR)
    IS
    
BEGIN
    INSERT INTO jl_books (isbn, title, pubdate, pubid,cost, retail, discount, category) values (p_isbn, p_title, p_pubdate, p_pubid, p_cost,p_retail, p_discount, p_category);
    COMMIT;
END;



--a) 
execute sp_registerbook1 ('10005566','HOW TO CLIMB a MOUNTAIN',SYSDATE(),4,14.50,19.50,null,'FITNESS');
execute sp_registerbook1 ('100055675','HOW TO COOK OCEAN FISH',SYSDATE(),4,12.50,18.50,null,'COOKING');

select * from hr_employees;

CREATE OR REPLACE PROCEDURE raise_salary
    (
        p_id IN hr_employees.employee_id%TYPE,
        p_percent IN NUMBER
    ) IS
BEGIN
    UPDATE hr_employees 
    SET salary = salary * (1 + p_percent / 100)
    WHERE employee_id = p_id;
    --commit
END;

BEGIN
    raise_salary(176, 10);
END;

BEGIN
    FOR emp_record IN (SELECT * FROM hr_employees WHERE employee_id IN (101, 102, 103))
    LOOP
        raise_salary(emp_record.employee_id, 10);
    END LOOP;
END;


--     If employee department is either 50 or 70 and salary >5000
--        sp_process_all_emp (empid, 8)
        
--     If employee department is either 30 or 40 and salary >5500
--        sp_process_all_emp (empid, 10)
--     If employee department is either 90 or 100 and salary >6000
 --       sp_process_all_emp (empid, 15)
--     everyone else gets 5%
     
BEGIN
    FOR emp_record IN (SELECT * FROM hr_employees WHERE employee_id IN (101, 102, 103))
    LOOP
        IF emp_record.department_id IN (50, 70)THEN
            IF emp_record.salary > 5000 THEN
                 raise_salary(emp_record.employee_id, 8);
            ELSE
                raise_salary(emp_record.employee_id, 5);
            END IF;
        ELSIF emp_record.department_id IN (30, 40) THEN
             IF emp_record.salary > 5500 THEN
                raise_salary(emp_record.employee_id, 10);
            ELSE
                raise_salary(emp_record.employee_id, 5);
            END IF;
        ELSIF emp_record.department_id IN (90, 100) THEN
            IF emp_record.salary > 6000 THEN
                 raise_salary(emp_record.employee_id, 15);
            ELSE
                raise_salary(emp_record.employee_id, 5);
            END IF;
        ELSE
            raise_salary(emp_record.employee_id, 5);
        END IF;
    END LOOP;
    commit;
END;

rollback;