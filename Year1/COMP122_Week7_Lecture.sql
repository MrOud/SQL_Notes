--Task: create clone(copy) of hr_departments with the name of hr_departments_Mar1 without data
--Then insert all 32 records from original departments table to newly created table
--
--select * from hr_departments
--
--select * from hr_departments_Mar1
--
--option 1:
--INSERT INTO hr_departments_Mar1
--INSERT INTO
--Option2:
--
--Use INSERT with subquery
--INSERT INTO hr_departments_Mar1 SELECT * FROM hr_departments
--
--Task2: Copy some data(s) from hr_Departments to newly create _Mar1 for departments
--which is in location 1800
--
--INSERT INTO hr_departments_Mar1 SELECT * FROM hr_departments WHERE location_id=1700
--
--select * from hr_departments_Mar1

select * from w5p_orders

update w5p_orders set purch_amt = '&amount' where ord_id = '&order'