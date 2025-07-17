-- 2025.7.14 2장 SQL 기본

-- 실습 1-2 . NUMBER 자료형 이해

CREATE TABLE TYPE_TEST_NUMBER(
    num1 NUMBER,
    num2 NUMBER(2),
    num3 NUMBER(3,1),
    num4 NUMBER(4,2),
    num5 NUMBER(5,6),
    num6 NUMBER(6,-1)
);

// num1 NUMBER
insert into TYPE_TEST_NUMBER (num1) values (1);
insert into TYPE_TEST_NUMBER (num1) values (123);
insert into TYPE_TEST_NUMBER (num1) values (123.74);
insert into TYPE_TEST_NUMBER (num1) values (123.12345);

// num2 NUMBER(2)
insert into TYPE_TEST_NUMBER (num2) values (12);
insert into TYPE_TEST_NUMBER (num2) values (123);
insert into TYPE_TEST_NUMBER (num2) values (1.2);
insert into TYPE_TEST_NUMBER (num2) values (1.23);
insert into TYPE_TEST_NUMBER (num2) values (12.34567);
insert into TYPE_TEST_NUMBER (num2) values (12.56789);
insert into TYPE_TEST_NUMBER (num2) values (123.56789);


// num3 NUMBER(3,1)
insert into TYPE_TEST_NUMBER (num3) values (12);
insert into TYPE_TEST_NUMBER (num3) values (123);
insert into TYPE_TEST_NUMBER (num3) values (1.2);
insert into TYPE_TEST_NUMBER (num3) values (1.23);
insert into TYPE_TEST_NUMBER (num3) values (12.34567);
insert into TYPE_TEST_NUMBER (num3) values (12.56789);
insert into TYPE_TEST_NUMBER (num3) values (123.56789);

SELECT * FROM TYPE_TEST_NUMBER;

// delete from TYPE_TEST_NUMBER WHERE num1 = 1;
// insert into TYPE_TEST_NUMBER (num1) values (1);
// DROP TABLE TYPE_TEST_NUMBER;

--------- 문자형 테이블 생성


CREATE TABLE TYPE_TEST_CHAR(
    char1 CHAR(1),
    char2 CHAR(2),
    char3 CHAR(3),
    vchar1 VARCHAR2(1),
    vchar2 VARCHAR2(2),
    vchar3 VARCHAR2(3),
    nvchar1 NVARCHAR2(1),
    nvchar2 NVARCHAR2(2),
    nvchar3 NVARCHAR2(3)
    );
    
    DROP TABLE TYPE_TEST_CHAR;
    
    // CHAR
    insert into TYPE_TEST_CHAR (char1) values ('A');
    insert into TYPE_TEST_CHAR (char1) values ('가');
    
    // VARCHAR2
    insert into TYPE_TEST_CHAR (vchar1) values ('A');
    insert into TYPE_TEST_CHAR (vchar2) values ('AB');
    insert into TYPE_TEST_CHAR (vchar3) values ('가');
    
    // NVARCHAR2
    insert into TYPE_TEST_CHAR (nvchar1) values ('A');
    insert into TYPE_TEST_CHAR (nvchar2) values ('AB');
    insert into TYPE_TEST_CHAR (nvchar3) values ('가나다');
    
    select * from TYPE_TEST_CHAR;
    
    DESC TYPE_TEST_CHAR;
    
    --------------------------------------------
    
    CREATE TABLE USER1(
    USER_ID VARCHAR2(20),
    NAME VARCHAR2(20),
    HP CHAR(13),
    AGE NUMBER
    );
    
    INSERT INTO USER1 VALUES('A101','김유신','010-1234-1111',25);
    INSERT INTO USER1 VALUES('A102','김춘추','010-1234-2222',23);
    INSERT INTO USER1 VALUES('A103','장보고','010-1234-3333',32);
    INSERT INTO USER1 (USER_ID,NAME,AGE) VALUES('A104','강감찬',45);
    INSERT INTO USER1 (USER_ID,NAME,HP) VALUES ('A105','이순신','010-1234-5555');
    
    SELECT * FROM USER1;
    DESC USER1;
    
    SELECT USER_ID FROM USER1;
    
    SELECT * FROM USER1 WHERE USER_ID = 'A101';
    SELECT * FROM USER1 WHERE NAME = '김춘추';
    SELECT * FROM USER1 WHERE AGE>30;
    SELECT USER_ID, NAME, AGE FROM USER1;
    
    
    // UPDATE
    UPDATE USER1 SET HP='010-1234-4444' WHERE USER_ID = 'A104';
    // SELECT * FROM USER1;
    UPDATE USER1 SET AGE=51 WHERE USER_ID = 'A105';
    
    UPDATE USER1 SET HP = '010-1234-1001', 
    AGE = 27 WHERE USER_ID = 'A101';
    
    SELECT * FROM USER1;
    
    // DELETE
    DELETE FROM USER1 WHERE USER_ID = 'A101';
    SELECT * FROM USER1;
    DELETE FROM USER1 WHERE USER_ID = 'A102' AND AGE = 25;
    DELETE FROM USER1 WHERE AGE>=30;
    SELECT * FROM USER1;
    
    
    -------------------------------------------------------------------------
    // 2. 제약조건
    
    -- 실습하기 2-1
    CREATE TABLE USER2(
    USER_ID VARCHAR2(20) PRIMARY KEY,
    NAME VARCHAR2(20),
    HP CHAR(13),
    AGE NUMBER(2)
    );
    
    DESC USER2;
    
    // 기본키(PK) 컬럼은 중복 허용 안함
    INSERT INTO USER2 VALUES('A101','김유신','010-1234-1111',23);
    INSERT INTO USER2 VALUES('A102','김춘추','010-1234-2222',21);
    
    SELECT * FROM USER2;
    
    
    -- 실습하기 2-2
    CREATE TABLE USER3(
    USER_ID VARCHAR2(20) PRIMARY KEY,
    NAME VARCHAR2(20),
    HP CHAR(13) UNIQUE,
    AGE NUMBER(3)
    );
    
    INSERT INTO USER3 VALUES('A101','김유신','010-1234-1111',23);
    INSERT INTO USER3 VALUES('A102','김춘추','010-1234-1111',24); // 무결성 제약조건 위배, UNIQUE는 중복 허용 안함, NULL값 허용
    INSERT INTO USER3 (USER_ID,NAME,AGE) VALUES ('A102','김춘추',3);
    SELECT * FROM USER3
    INSERT INTO USER3 VALUES('A103','이순신','',25);
    SELECT * FROM USER3;
    
    
    
    // 실습하기 2-3
    
    CREATE TABLE PARENT (
        pid varchar2(20) primary key,
        name varchar2(20),
        hp char(13) unique
        );
        
    CREATE TABLE child(
        CID VARCHAR2(20) PRIMARY KEY,
        NAME VARCHAR2(20),
        HP CHAR(13) UNIQUE,
        PARENT VARCHAR2(20),
        FOREIGN KEY(PARENT) REFERENCES PARENT(PID)
        );
        
        
    INSERT INTO PARENT VALUES('P101','김서현','010-1234-1001');
    INSERT INTO PARENT VALUES('P102','이성계','010-1234-1002');
    INSERT INTO PARENT VALUES('P103','신사임당','010-1234-1003');
    
    
    INSERT INTO child VALUES('C101','김유신','010-1234-2001','P101');
    INSERT INTO child VALUES('C102','이방우','010-1234-2002','P102');
    INSERT INTO child VALUES('C103','이방원','010-1234-2003','P102');
    INSERT INTO child VALUES('C104','이이','010-1234-2004','P103');
    --
    INSERT INTO child values('C105','김철수','010-1234-2005','P104');
    -- 무결성 제약조건 위배 
    
    
    -- 실습하기 2-4
    CREATE TABLE USER4(
        NAME VARCHAR2(20) NOT NULL,
        GENDER CHAR(1) NOT NULL,
        AGE INT DEFAULT 1,
        ADDR VARCHAR2(255)
        );
        
    DROP TABLE USER4;
    
    INSERT INTO USER4 VALUES('김유신','M',23,'김해시');
    INSERT INTO USER4 VALUES('김춘추','M',21,'경주시');
    INSERT INTO USER4 (NAME,GENDER,ADDR) VALUES ('신사임당','F','강릉시');
    INSERT INTO USER4 (NAME, GENDER) VALUES('이순신','M');
    INSERT INTO USER4 (NAME,AGE) VALUES('정약용',33);
    
    -- 실습하기 2-4
    
    CREATE TABLE USER5(
        NAME VARCHAR2(20) NOT NULL,
        GENDER CHAR(1) NOT NULL CHECK(GENDER IN('M','F')),
        AGE INT DEFAULT 1 CHECK(AGE>0 AND AGE<100),
        ADDR VARCHAR2(255)
        );
        
    INSERT INTO USER5 VALUES('김유신','M',23,'김해시');
    INSERT INTO USER5 VALUES('김춘추','M',21,'경주시');
    INSERT INTO USER5 (NAME,GENDER,ADDR) VALUES ('신사임당','F','강릉시');
    INSERT INTO USER5 (NAME, GENDER) VALUES('이순신','M');
    INSERT INTO USER5 (NAME,AGE) VALUES('정약용',33);
    
    
    -- 실습하기 2-5 : IDENTITY
    
    CREATE TABLE USER7(
    ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    NAME VARCHAR2(20),
    AGE NUMBER,
    EMAIL VARCHAR2(100)
    );
    
    INSERT INTO USER7 (NAME,AGE,EMAIL) VALUES ('김유신',25,'kim@gmail.com');
    INSERT INTO USER7 (NAME,AGE,EMAIL) VALUES ('장보고',35,'jang@gmail.com');
    INSERT INTO USER7 (NAME,AGE,EMAIL) VALUES ('이순신',45,'lee@gmail.com');
    
    select * from user7;
    
    