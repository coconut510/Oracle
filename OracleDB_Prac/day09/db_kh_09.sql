CREATE TABLE USERTBL
(
    USERNO NUMBER UNIQUE,
    ID VARCHAR2(20) PRIMARY KEY,
    PASSWORD CHAR(20) NOT NULL
);

INSERT INTO USERTBL VALUES(1,'test1','password11');
INSERT INTO USERTBL VALUES(2,'test2','password22');
INSERT INTO USERTBL VALUES(3,'test3','password33');

drop table usertbl;

COMMIT;

SELECT * FROM USERTBL;

UPDATE USERTBL
SET PASSWORD = 'pass11'
WHERE ID = 'test1';

SAVEPOINT SP1;

ROLLBACK TO SP1;

UPDATE USERTBL
SET PASSWORD = 'pass22'
WHERE ID = 'test2';

rollback;

SELECT * FROM ALL_TABLES
WHERE OWNER LIKE 'KH';

-- 뷰 생성하기 전
-- 회사와 협력한 헬스장
-- EMPLYOEE 테이블을 편집한 정보를
-- 가지고 있는 별도의 테이블 생성

CREATE TABLE EMPLOYEE_HEALTH
AS SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE;

SELECT * FROM EMPLOYEE;
SELECT * FROM EMPLOYEE_HEALTH;
COMMIT;
ROLLBACK;
INSERT INTO EMPLOYEE VALUES('223','정수지','920101-1001010',
                            'junggisoo@kh.or.kr','01011112222',
                            'D1','J6','S4',4000000,
                            0.1,217,SYSDATE,NULL,'N');
--뷰 생성
CREATE VIEW EMP_HEALTH_VIEW
AS SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE;

SELECT * FROM EMP_HEALTH_VIEW;

DROP VIEW EMP_INFO_VIEW;

CREATE VIEW EMP_INFO_VIEW
AS SELECT E.EMP_ID AS 부서아이디, EMP_NAME AS 이름, NVL(DEPT_TITLE,'없음') AS 부서이름
FROM EMPLOYEE E LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
ORDER BY 부서아이디;

SELECT * FROM USERTBL;

INSERT INTO USERTBL
VALUES(4,'test4','pass44');

CREATE SEQUENCE USERTBL_NO_SEQ 	-- USERTBL_NO_SEQ 라는 시퀀스 객체 생성
START WITH 1			-- 시작번호는 1번 부터
INCREMENT BY 1			-- 1씩 증가
MAXVALUE 100			-- 최대 100 까지	
NOCYCLE				-- 100 이후에는증가하지 말고 에러 발생 하여라
NOCACHE;			-- 캐쉬 방식은 사용하지 않겠음.


SELECT * FROM USER_SEQUENCES;
COMMIT;


SELECT USERTBL_NO_SEQ.NEXTVAL FROM DUAL;

SELECT USERTBL_NO_SEQ.CURRVAL FROM DUAL;

INSERT INTO USERTBL VALUES(USERTBL_NO_SEQ.NEXTVAL,
                            'user7','pass77');

SELECT * FROM USER_SEQUENCES;

SELECT * FROM USERTBL;

CREATE TABLE KH_MEMBER
(
    MEMBER_ID NUMBER PRIMARY KEY,
    MEMBER_NAME VARCHAR2(20),
    MEMBER_AGE NUMBER,
    MEMBER_JOIN_COM NUMBER
);

INSERT INTO KH_MEMBER VALUES(MEMBER_ID_SEQ.NEXTVAL, '홍길동',20,JOIN_COM_SEQ.NEXTVAL);
INSERT INTO KH_MEMBER VALUES(MEMBER_ID_SEQ.NEXTVAL, '김말똥',30,JOIN_COM_SEQ.NEXTVAL);
INSERT INTO KH_MEMBER VALUES(MEMBER_ID_SEQ.NEXTVAL, '삼식이',40,JOIN_COM_SEQ.NEXTVAL);
INSERT INTO KH_MEMBER VALUES(MEMBER_ID_SEQ.NEXTVAL, '고길똥',24,JOIN_COM_SEQ.NEXTVAL);

SELECT * FROM KH_MEMBER;

SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE MEMBER_ID_SEQ
START WITH 500
INCREMENT BY 10
MAXVALUE 10000	
NOCYCLE			
NOCACHE;	

CREATE SEQUENCE JOIN_COM_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 10000
NOCYCLE
NOCACHE;

SELECT * FROM USER_IND_COLUMNS
WHERE INDEX_NAME = 'EMP_INDEX';

CREATE INDEX EMP_INDEX ON EMPLOYEE(EMP_ID,EMP_NAME, SALARY);

DROP INDEX EMP_INDEX;

SELECT EMP_NAME
FROM EMPLOYEE;

CREATE SYNONYM EMP FOR EMPLOYEE;

DROP SYNONYM EMP;

SELECT * FROM EMP;

SELECT * FROM DEPT;















































