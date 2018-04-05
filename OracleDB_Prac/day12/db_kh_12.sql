-- 1.ID(���) ���� �Է��ϸ�Ư�� ����(���, �̸�, �ֹι�ȣ, ����ȣ)�� ����ϴ� 
-- ���ν����� ����,
-- 2. ID(���) ���� �Է��ϸ� ���ʽ����� �����ϴ� 
-- �Լ��� ����
-- �̶� ���ν����� �Լ��� ���� ��Ű���� ������.!!

-- ��Ű�� ����
CREATE PACKAGE EMP_PACK
IS
	PROCEDURE SELECT_USER(ID EMP.EMP_ID%TYPE);
	FUNCTION BONUS_RETURN(ID EMP.EMP_ID%TYPE) RETURN NUMBER;
END;
/

DROP PACKAGE EMP_PACK;

CREATE PACKAGE BODY EMP_PACK
IS
    PROCEDURE SELECT_USER(ID EMP.EMP_ID%TYPE)
IS
    E_ID EMP.EMP_ID%TYPE;
    E_NAME EMP.EMP_NAME%TYPE;
    E_NO EMP.EMP_NO%TYPE;
    E_PHONE EMP.PHONE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, EMP_NO, PHONE
    INTO E_ID, E_NAME, E_NO, E_PHONE
    FROM EMP
    WHERE EMP_ID = ID;
    DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || E_ID);
    DBMS_OUTPUT.PUT_LINE('����̸� : ' || E_NAME);
    DBMS_OUTPUT.PUT_LINE('�ֹι�ȣ : ' || E_NO);
    DBMS_OUTPUT.PUT_LINE('��ȭ��ȣ : ' || E_PHONE);
END;
FUNCTION BONUS_RETURN(ID EMP.EMP_ID%TYPE)
RETURN NUMBER
IS
    E_BONUS EMP.BONUS%TYPE;
    E_SALARY EMP.SALARY%TYPE;
    SAL NUMBER;
BEGIN
    SELECT SALARY, NVL(BONUS,0)
    INTO E_SALARY, E_BONUS
    FROM EMP
    WHERE EMP_ID = ID;
    SAL := E_SALARY * E_BONUS;
    RETURN SAL;
END;
END;    -- ��Ű�� BODY ���� END
/

EXEC EMP_PACK.SELECT_USER(201);
SELECT EMP_PACK.BONUS_RETURN(203) FROM DUAL;

SET SERVEROUTPUT ON;

-- Ʈ���� �ǽ��� ���̺� 2�� ����
-- ȸ�� ���̺�, Ż�� ȸ�� ���̺�

CREATE TABLE M_TBL
(
    USERID VARCHAR2(20) PRIMARY KEY,
    USERPWD VARCHAR2(20) NOT NULL,
    USERNAME VARCHAR2(20) NOT NULL,    
    ENROLL_DATE DATE
);

CREATE TABLE DEL_M_TBL
(
    USERID VARCHAR2(20) PRIMARY KEY,
    USERNAME VARCHAR2(20),
    ENROLL_DATE DATE,
    DEL_DATE DATE
  --  FOREIGN KEY USERID REFERENCES M_TBL(USERID);
);

DROP TABLE M_TBL;
INSERT INTO M_TBL
VALUES('user11','pass11','��μ�','16/05/23');

INSERT INTO M_TBL
VALUES('user22','pass22','�ѾƸ�','17/05/03');

INSERT INTO M_TBL
VALUES('user33','pass33','Ȳ����','17/04/13');

INSERT INTO M_TBL
VALUES('user44','pas44','�ѿ���','15/04/27');



DECLARE  
   M M_TBL%ROWTYPE;
BEGIN
    SELECT USERID,USERNAME,ENROLL_DATE  
    INTO M.USERID, M.USERNAME, M.ENROLL_DATE
    FROM M_TBL
    WHERE USERID = 'user22';
    
    INSERT INTO DEL_M_TBL VALUES( M.USERID, M.USERNAME, M.ENROLL_DATE,SYSDATE);
    DELETE FROM M_TBL WHERE USERID = 'user22';
END;
/


ROLLBACK;
CREATE OR REPLACE TRIGGER M_TBL_TRG
AFTER DELETE ON M_TBL
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('�����Ϸ�');
    INSERT INTO DEL_M_TBL VALUES(:OLD.USERID,:OLD.USERNAME,:OLD.ENROLL_DATE,SYSDATE);
END;
/
DROP TRIGGER M_TBL_TRG;

SELECT * FROM M_TBL;
SELECT * FROM DEL_M_TBL;
COMMIT;
ROLLBACK;
DELETE FROM DEL_M_TBL 
WHERE USERID = 'KH';

DELETE FROM M_TBL 
WHERE USERID = 'kh';

SELECT * FROM ALL_ERRORS;


INSERT INTO DEL_M_TBL 
        VALUES(SELECT USERID, USERNAME, ENROLL_DATE,SYSDATE
        FROM M_TBL
        WHERE USERID ='user22');

INSERT INTO M_TBL VALUES('kh','kh11','����','16/09/09');
INSERT INTO M_TBL VALUES('MS','kh11','����','16/02/28');
INSERT INTO M_TBL VALUES('BABO','kh11','õ��','16/03/02');
INSERT INTO M_TBL VALUES('TTTT','kh11','Ʈ���̽�','16/10/03');
COMMIT;
ROLLBACK;
CREATE OR REPLACE TRIGGER M_TBL_INSERT_TRG
AFTER INSERT
ON M_TBL
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE(:NEW.USERNAME ||'���� �ű� �����ϼ̽��ϴ�.');
END;
/
CREATE TABLE LOG_TBL
(
    USERID VARCHAR2(20),
    CONTENT VARCHAR2(30),
    MODIFY_DATE DATE
);

DROP TRIGGER LOG_TRG;

CREATE OR REPLACE TRIGGER LOG_TRG
AFTER UPDATE 
ON M_TBL
FOR EACH ROW
BEGIN
    INSERT INTO LOG_TBL VALUES(:OLD.USERID, :OLD.USERNAME || '->' || :NEW.USERNAME , SYSDATE);
END;
/

UPDATE M_TBL
SET USERNAME = '�Ѹ�'
WHERE USERID = 'TTTT';
COMMIT;

SELECT * FROM M_TBL;
SELECT * FROM DEL_M_TBL;
SELECT * FROM LOG_TBL;

-- ��ǰ �� ��� ���̺�
CREATE TABLE PRODUCT
(
    PCODE NUMBER PRIMARY KEY,
    PNAME VARCHAR2(30),
    BRAND VARCHAR2(30),
    PRICE NUMBER,
    STOCK NUMBER DEFAULT 0
);

-- ��ǰ ����� ���̺�
CREATE TABLE PRO_DETAIL
(
    DCODE NUMBER PRIMARY KEY,
    PCODE NUMBER,
    PDATE DATE,
    AMOUNT NUMBER,
    STATUS VARCHAR2(10) CHECK(STATUS IN('�԰�','���')),
    FOREIGN KEY (PCODE) REFERENCES PRODUCT(PCODE)
);

INSERT INTO PRODUCT VALUES
(1111,'ĭ��', '�Ե�',1500, DEFAULT);

INSERT INTO PRODUCT VALUES
(2222,'�ø���', '�Ե�',3000, DEFAULT);

INSERT INTO PRODUCT VALUES
(3333,'��Ϲ���', '����',10000, DEFAULT);

INSERT INTO PRODUCT VALUES
(4444,'����Ĩ', '������',100, DEFAULT);

SELECT * FROM PRODUCT;
SELECT * FROM PRO_DETAIL;

COMMIT;

INSERT INTO PRO_DETAIL VALUES
(1,1111,SYSDATE,5,'�԰�');

INSERT INTO PRO_DETAIL VALUES
(2,1111,SYSDATE,2,'�԰�');

INSERT INTO PRO_DETAIL VALUES
(3,1111,SYSDATE,3,'���');

UPDATE PRODUCT
SET STOCK = STOCK +5
WHERE PCODE = 1111;


-- �ϳ��ϳ� �۾��ϰ� �Ǹ� ������ ������
-- Ʈ���Ÿ� �̿��Ͽ� ��, ��� ������ ���� ��� ������ �ڵ����� ����ǵ���
-- ���鵵�� ����.
CREATE OR REPLACE TRIGGER PRO_TRG
AFTER INSERT
ON PRO_DETAIL
FOR EACH ROW
BEGIN
    IF(:NEW.STATUS = '�԰�')
    THEN
        UPDATE PRODUCT 
        SET STOCK = STOCK + :NEW.AMOUNT
        WHERE PCODE = :NEW.PCODE;
    ELSIF (:NEW.STATUS ='���')
    THEN
        UPDATE PRODUCT
        SET STOCK = STOCK - :NEW.AMOUNT
        WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/















