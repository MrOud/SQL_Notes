DECLARE
 v_outer_variable VARCHAR2(20):='GLOBAL VARIABLE';
BEGIN
  DECLARE
   v_inner_variable VARCHAR2(20):='LOCAL VARIABLE';
  BEGIN
   DBMS_OUTPUT.PUT_LINE(v_inner_variable);
   DBMS_OUTPUT.PUT_LINE(v_outer_variable);
  END;
 DBMS_OUTPUT.PUT_LINE(v_outer_variable); 
END;

DECLARE
 v_father_name VARCHAR2(20):='Patrick';
 v_date_of_birth DATE:='20-Apr-1972';
BEGIN
  DECLARE
   v_child_name VARCHAR2(20):='Mike';
   v_date_of_birth DATE:='12-Dec-2002';
  BEGIN
   DBMS_OUTPUT.PUT_LINE('Father''s Name: '||v_father_name);
   DBMS_OUTPUT.PUT_LINE('Date of Birth: '||v_date_of_birth);
   DBMS_OUTPUT.PUT_LINE('Child''s Name: '||v_child_name);
  END;
 DBMS_OUTPUT.PUT_LINE('Date of Birth: '||v_date_of_birth); 
END;

BEGIN <<outer>>
DECLARE
 v_father_name VARCHAR2(20) := 'Patrick';
 v_date_of_birth DATE := '1972-07-20';
BEGIN
  DECLARE
   v_child_name VARCHAR2(20):='Mike';
   v_date_of_birth DATE := '2002-12-12';
  BEGIN
   DBMS_OUTPUT.PUT_LINE('Father''s Name: '||v_father_name);
   DBMS_OUTPUT.PUT_LINE('Date of Birth: ' ||outer.v_date_of_birth);
   DBMS_OUTPUT.PUT_LINE('Child''s Name: '||v_child_name);
   DBMS_OUTPUT.PUT_LINE('Date of Birth: '||v_date_of_birth);
  END;
END;
END outer;


BEGIN <<outer>>
DECLARE
  v_sal      NUMBER(7,2) := 60000;
  v_comm     NUMBER(7,2) := v_sal * 0.20;
  v_message  VARCHAR2(255) := ' eligible for commission';
BEGIN 
  DECLARE
    	v_sal	    NUMBER(7,2) := 50000;
    	v_comm 	    NUMBER(7,2) := 0;
    	v_total_comp  NUMBER(7,2) := v_sal + v_comm;
         
  BEGIN 
    	 v_message := 'CLERK not'||v_message;   --CLERK not eligible for commission
         dbms_output.put_line  (v_message);
    	outer.v_comm := v_sal * 0.30; 
        DBMS_OUTPUT.PUT_LINE(v_comm);
        --print outer.v_comm  ?
  END;
 v_message := 'SALESMAN'||v_message;
 dbms_output.put_line  (v_message);
 --print v_comm  ?
END;
END outer;


DECLARE
v_number  number := &mo;

BEGIN
  IF v_number < 100 
       THEN  DBMS_OUTPUT.PUT_LINE('This number is below 100 treshold');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('This number is above 100 treshold');
  END IF;    
END;


accept character value   1 digit from end user
and check if it is V  then print YES
otherwise print NO


DECLARE
v_letter  char(1) := '&let';

BEGIN
  IF UPPER(v_letter) ='V'
       THEN  DBMS_OUTPUT.PUT_LINE('Yes');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('No');
  END IF;    
END;


/* dynamicly ask end user two information. 
1)end user to enter different number
2)  character value   1 digit from end user

and in your program check if this assigned number is below 100  and letter is V
Print YES
otherwise No

*/
DECLARE
    v_num_in number := &ni;
    v_char_in char(1) := '&ci';
    
BEGIN
    IF v_num_in < 100 AND UPPER(v_char_in) = 'V'
        THEN  DBMS_OUTPUT.PUT_LINE('Yes');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No');
    END IF;
END;
        

--1 explain this code    
DECLARE
  v_total SIMPLE_INTEGER := 0;
BEGIN
  FOR i IN 1..10 LOOP
    v_total := v_total + i;
    dbms_output.put_line
     ('Total is: '|| v_total);
    CONTINUE WHEN i > 5;
    v_total := v_total + i; 
    dbms_output.put_line
     ('Out of Loop Total is:
      '|| v_total);    
  END LOOP;
END;

--Practice 2: Ask the user their name and how many times they want to output their name (using a for loop).

--3) create multiplication table only for a specific given number ask end user to enter from 1 to 10 any number. 
--   If end user pick 6  then generate all possible multiolication chart  1x6  , 2x6  ....