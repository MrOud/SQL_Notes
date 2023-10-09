CREATE TABLE PRODUCTS (
    PROD_ID NUMBER(6) PRIMARY KEY,
    PROD_NAME VARCHAR(50) NOT NULL,
    PROD_DESC VARCHAR(100),
    PROD_PRICE NUMBER (18,2),
    PROD_CATAGORY VARCHAR(30)
);

CREATE TABLE TORDER (
    ORDER_ID NUMBER(6) PRIMARY KEY,
    ORDER_DATE DATE DEFAULT SYSDATE,
    PROD_DESCR VARCHAR(100),
    PROD_PRICE NUMBER(18,2),
    PROD_ID NUMBER(6)
);

DROP TABLE TORDER

ALTER TABLE TORDER ADD CONSTRAINT FK_WK6_PRAC3 FOREIGN KEY (PROD_ID) REFERENCES PRODUCTS (PROD_ID)

ALTER TABLE TORDER DROP COLUMN PROD_PRICE

ALTER TABLE PRODUCTS DROP COLUMN PROD_CATAGORY 