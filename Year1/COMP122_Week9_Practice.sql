-- 1 List all of criminals t to show all the criminals who do not register any phone?
SELECT * FROM CJ_criminals WHERE phone IS NULL

-- 2- Provide me  a list to show all the criminals who did provide  phone?
SELECT * FROM CJ_criminals WHERE phone IS NOT NULL

-- 3.List  criminals' location /city info? which city they are located 
SELECT last, first, street, city FROM CJ_criminals ORDER BY city

-- 4. List of Unique City from Criminals table
SELECT UNIQUE city FROM CJ_criminals

--5. Provide one column list (same as below ) from Officers table    (+ represent  concatanation) 
--	  'Last name of Officer is '  +  last + ' first name of Officer is ' + first + ' and his/her phone number is ' + phone  as officerInfo
SELECT ('Last Name of Officer is ' || last || ' first name of Officer is ' || first || ' and his/her phone number is ' || phone ) as OfficerInfo FROM CJ_Officers

--use DreamHome_Realtor  DH_XXXX tables
--show us all the staff whose salary is greater than 5000 but less than 12000
SELECT fname, lname, position, salary FROM DH_staff WHERE salary > 5000 AND salary < 12000 ORDER BY salary DESC

--show us all the staff whose salary is greater than or equal to 5000 but less than or equal to 12000
SELECT fname, lname, position, salary FROM DH_staff WHERE salary >= 5000 AND salary <= 12000 ORDER BY salary DESC


--show us all the employees from either Branch B005 or B007 and at the same time people who are making more than 10000
SELECT fname, lname, position, salary, branchno FROM DH_staff WHERE (branchno = 'B005' OR branchno = 'B007') AND salary > 10000

--  Search for any customer whose address inludes toronto
SELECT * FROM DH_CLIENT --Sanity check, no Toronto listings
SELECT * FROM DH_client WHERE city LIKE '%Toronto%'

--show us all the staff who are working for either B7 or B5
SELECT * FROM dh_staff WHERE (branchno = 'B005' OR branchno = 'B007')

--show us all the staff who are not working for either B7 or B5
SELECT * FROM dh_staff WHERE (branchno <> 'B005' AND branchno <> 'B007')

--show the employee whose salary is in between 5000 and 12000
SELECT * FROM dh_staff WHERE salary BETWEEN 5000 AND 12000

--show the employee whose salary is NOT in between 5 and 12k
SELECT * FROM dh_staff WHERE salary NOT BETWEEN 5000 AND 12000

--List Staff fname, lname, dob  and , DAY of hisher DOB,  MONTH of his/her DOB, YEAR of DOB
SELECT fname, lname, dob, to_char(dob, 'DAY') as Day_of_Birth, to_char(dob, 'MONTH') as Month_of_Birth, to_char(dob, 'YYYY') as Year_of_Birth FROM DH_staff

--list of all   staff who was born in the month of June?
SELECT * FROM DH_staff WHERE to_char(dob, 'MM') = '06'

-- list of all our staff who was born at the second half of the year?
SELECT * FROM DH_staff WHERE to_char(dob, 'MM') > '06'

--list us all the staff who was born in the year of 1945
SELECT * FROM DH_staff WHERE to_char(dob, 'YYYY') =  '1945'

--List us all the staff who was born after the year of 1945
SELECT * FROM DH_staff WHERE to_char(dob, 'YYYY') >  '1945'