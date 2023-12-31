CREATE TABLE TEST_CUSTOMERS2
( C_ID NUMBER(7,0),
C_FNAME VARCHAR2(40 BYTE),
C_LNAME CHAR(40 BYTE),
C_BALANCE NUMBER(9,2) DEFAULT 0,
C_PROVINCE VARCHAR2(2 BYTE) DEFAULT 'ON',
C_REGDATE DATE DEFAULT SYSDATE,
C_EMAIL VARCHAR2(50 BYTE)
)

INSERT INTO TEST_CUSTOMERS2 VALUES ( 1, 'Ersan','Cam',100, 'ON',SYSDATE,'ec@gmail.com' )

INSERT INTO TEST_CUSTOMERS2 VALUES ( 2, 'Jason','Hatfieldson',200, 'ON',SYSDATE,'js@gmail.com' )

INSERT INTO TEST_CUSTOMERS2 VALUES ( 3, 'Blake','H',300.56, 'BC',SYSDATE,'bh@gmail.com' )



ALTER TABLE TEST_CUSTOMERS2 MODIFY C_FNAME VARCHAR(40)
ALTER TABLE TEST_CUSTOMERS2 MODIFY C_LNAME VARCHAR(5)
ALTER TABLE TEST_CUSTOMERS2 MODIFY C_BALANCE NUMBER(9,2)
ALTER TABLE TEST_CUSTOMERS2 MODIFY C_EMAIL VARCHAR(40)
ALTER TABLE TEST_CUSTOMERS2 ADD C_CITY VARCHAR(40)

ALTER TABLE TEST_CUSTOMERS2 SET UNUSED COLUMN C_REGDATE
ALTER TABLE TEST_CUSTOMERS2 DROP UNUSED COLUMNS
ALTER TABLE TEST_CUSTOMERS2 RENAME COLUMN C_EMAIL TO C_MAILADDRESS

ALTER TABLE TEST_CUSTOMERS2 READ ONLY --CAN STILL USE SELECT, BUT NOT ENTER RECORDS
ALTER TABLE TEST_CUSTOMERS2 READ WRITE

CREATE TABLE TEST_CUSTOMER2_BKUP021523 AS SELECT * FROM TEST_CUSTOMERS2

UPDATE TEST_CUSTOMERS2 SET C_BALANCE=200 WHERE C_ID=1

select * from TEST_CUSTOMERS2;
SELECT * FROM TEST_CUSTOMER2_BKUP021523

TRUNCATE TABLE TEST_CUSTOMERS2
INSERT INTO TEST_CUSTOMERS2 SELECT * FROM TEST_CUSTOMER2_BKUP021523
ROLLBACK --ROLL BACK TO STATE OF LAST COMMIT
COMMIT --SET ROLLBACK POINT, MAY BE AUTO-COMMIT BY SETUP

--BACKUP
    --CREATE BACKUP TABLE 
CREATE TABLE TEST_CUSTOMER2_BKUP021523 AS SELECT * FROM TEST_CUSTOMERS2
--RESTORE BACKUP
    --TRUNCATE ORIGINAL TABLE
    --INSERT VALUES FROM BKUP TO NEW EMPTY TABLE
TRUNCATE TABLE TEST_CUSTOMERS2
INSERT INTO TEST_CUSTOMERS2 SELECT * FROM TEST_CUSTOMER2_BKUP021523


CREATE TABLE TEST_CUSTOMERS_KO
( C_ID NUMBER(7) ,
C_FNAME VARCHAR2(40 BYTE),
C_LNAME CHAR(40 BYTE),
C_BALANCE NUMBER(9,2) ,
C_PROVINCE VARCHAR2(2 BYTE) ,
C_REGDATE DATE DEFAULT SYSDATE,
C_EMAIL VARCHAR2(50 BYTE)

)


CREATE TABLE TEST_ORDERS_KO
(O_ID number (5),
O_amount number(7),
O_date date,
o_shipdate date,
o_channel varchar(20),
c_id number(7)
)

--1
ALTER TABLE TEST_CUSTOMERS_KO ADD CONSTRAINT PK_CUST_TC2KO PRIMARY KEY (C_ID)
--2
ALTER TABLE TEST_ORDERS_KO ADD CONSTRAINT PK_ORD_TO2KO PRIMARY KEY (O_ID)
--3
ALTER TABLE TEST_CUSTOMERS_KO MODIFY C_LNAME NOT NULL
--4
ALTER TABLE TEST_CUSTOMERS_KO MODIFY C_BALANCE DEFAULT 0
--5
ALTER TABLE TEST_CUSTOMERS_KO MODIFY C_BALANCE CHECK (C_BALANCE > 0)
--6
ALTER TABLE TEST_CUSTOMERS_KO MODIFY C_PROVINCE DEFAULT 'ON'
--7
ALTER TABLE TEST_ORDERS_KO ADD CONSTRAINT FK_ORD_CID2C_ID FOREIGN KEY (C_ID) REFERENCES TEST_CUSTOMERS_KO (C_ID)
--8
ALTER TABLE TEST_CUSTOMERS_KO MODIFY C_EMAIL UNIQUE