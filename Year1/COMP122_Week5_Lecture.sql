CREATE TABLE TEST_CUSTOMERS ( 
    C_ID NUMBER(7) PRIMARY KEY, 
    C_FNAME VARCHAR(40), 
    C_LNAME CHAR(40) NOT NULL, 
    C_BALANCE NUMBER(9,2) DEFAULT 0 CHECK (C_BALANCE > 0), 
    C_PROVINCE VARCHAR(2) DEFAULT 'ON',
    C_REGDATE DATE DEFAULT SYSDATE,
    C_EMAIL VARCHAR(50) UNIQUE NOT NULL
)

--or
--
--CREATE TABLE TEST_CUSTOMERS ( 
--    C_ID NUMBER(7), 
--    C_FNAME VARCHAR(40), 
--    C_LNAME CHAR(40) NOT NULL, 
--    C_BALANCE NUMBER(9,2), 
--    C_PROVINCE VARCHAR(2) DEFAULT 'ON',
--    C_REGDATE DATE DEFAULT SYSDATE,
--    C_EMAIL VARCHAR(50),
--    CONSTRAINT PK_CUST PRIMARY KEY (C_ID),
--    CONSTRAINT UK_CUST UNIQUE (C_EMAIL),
--    CONSTRIANT CK_CUST CHECK (C_BALANCE > 0)
--)

INSERT INTO TEST_CUSTOMERS VALUES (1, 'Kris', 'Oud', 50000, 'ON', SYSDATE, 'oudster@gmail.com');
INSERT INTO TEST_CUSTOMERS (C_ID, C_FNAME, C_LNAME, C_BALANCE, C_EMAIL) VALUES (2, 'Jim', 'Hendrix', 20.05, 'hendrix@hazemail.com');
SELECT * FROM TEST_CUSTOMERS;

--drop table test_customers

--=================

--FOREIGN KEY
CREATE TABLE TEST_ORDERS (
    O_ID NUMBER(7) PRIMARY KEY,
    O_CHANNEL VARCHAR(40),
    O_DATE DATE DEFAULT SYSDATE,
    O_SHIPDATE DATE DEFAULT (SYSDATE+5),
    C_ID NUMBER(7),
    CONSTRAINT FK_ORD2CUST FOREIGN KEY (C_ID) REFERENCES TEST_CUSTOMERS (C_ID)
)                              

--CREATE TABLE TEST_ORDERS
--( o_id number(6) PRIMARY KEY,
--o_channel varchar(40),
--o_date DATE DEFAULT SYSDATE,
--o_shipdate DATE DEFAULT SYSDATE+5,
--c_id number(7) ,
--CONSTRAINT FK_ORD2CUST FOREIGN KEY (c_id ) REFERENCES TEST_CUSTOMERS (c_id)
--)

INSERT INTO TEST_ORDERS VALUES (1, 'Online', sysdate, sysdate+5, 1);
SELECT * FROM TEST_orders

drop table test_customers