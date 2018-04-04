

DECLARE
	i NUMBER := 1;
BEGIN
	LOOP
		DBMS_OUTPUT.PUT_LINE(i);
		i :=i+1;
		IF i>5 THEN EXIT;
		END IF;
	END LOOP;
END;
/


BEGIN
	FOR i IN 1..5 LOOP
		DBMS_OUTPUT.PUT_LINE(i);
	END LOOP;
END;
/

BEGIN
	FOR i IN REVERSE 1..10 LOOP
        FOR j IN REVERSE 1..5 LOOP
            DBMS_OUTPUT.PUT_LINE(i*j);
        END LOOP;
	END LOOP;
END;
/


-- PL/SQL �ݺ����� �̿��Ͽ� ����� �Է� �Ͽ�����
-- �Է��� ������� ����� 1�� �����Ͽ� 5���� ����Ͽ���
-- EX) 200 �� �Է½� 200~204������ ���

DECLARE
    START_ID NUMBER;
    EMP EMPLOYEE%ROWTYPE;
BEGIN
    START_ID := '&���ۻ����ȣ';
    FOR i IN 0..4 LOOP
        SELECT EMP_ID, EMP_NAME, HIRE_DATE
        INTO EMP.EMP_ID, EMP.EMP_NAME, EMP.HIRE_DATE
        FROM EMPLOYEE
        WHERE EMP_ID = TO_CHAR(START_ID + i);
        DBMS_OUTPUT.PUT_LINE('=====================');
        DBMS_OUTPUT.PUT_LINE('��� : ' || EMP.EMP_ID);
        DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP.EMP_NAME);
        DBMS_OUTPUT.PUT_LINE('�Ի��� : ' || EMP.HIRE_DATE);
        DBMS_OUTPUT.PUT_LINE('=====================');
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('�ش� ��� ��ȣ�� �����ϴ�.');
END;
/

/*
 ����1) 1~10���� �ݺ��Ͽ� TEST1���̺� �����Ͱ� ����ǰ� �Ͻÿ�
    KH �������� TEST1 ���̺� ����
    -> CREATE TABLE TEST1(BUNHO NUMBER(3)
*/
CREATE TABLE TEST1(BUNHO NUMBER(3), IRUM VARCHAR2(10));
DROP TABLE TEST1;
BEGIN
	FOR i IN 1..10 LOOP
		INSERT INTO TEST1 VALUES(i,SYSDATE);
	END LOOP;
END;
/
SELECT * FROM TEST1;


/*
  ����2) TOP N �м��� ���� PL/SQL �� ������
  '�޿�'/ '���ʽ�' / '�Ի���'
  ������ 1��~5�� ������ ����ϴ� PL/SQL�� ������
*/

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    TYPE_CHR VARCHAR2(20);
    RANKNUM NUMBER;
BEGIN
    TYPE_CHR := '&�׸�';
    
    IF(TYPE_CHR = '�޿�')
    THEN
        FOR i IN 1..5 LOOP
             SELECT RANKORDER,EMP_NAME,SALARY 
             INTO RANKNUM,EMP.EMP_NAME,EMP.SALARY
             FROM(SELECT  EMP_NAME, SALARY,ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS RANKORDER FROM EMPLOYEE)
             WHERE RANKORDER = i;
             DBMS_OUTPUT.PUT_LINE('��ŷ : ' || RANKNUM || '/�̸� : ' || EMP.EMP_NAME || '/�޿� : ' || EMP.SALARY);
        END LOOP;
  
    ELSIF(TYPE_CHR = '���ʽ�')
    THEN
        FOR i IN 1..5 LOOP
             SELECT * INTO RANKNUM, EMP.EMP_NAME, EMP.BONUS
             FROM(SELECT ROW_NUMBER() OVER(ORDER BY NVL(BONUS*100,0) DESC) AS RANKORDER,
             EMP_NAME, NVL(BONUS*100,0) FROM EMPLOYEE)
             WHERE RANKORDER = i;
             DBMS_OUTPUT.PUT_LINE('��ŷ : ' || RANKNUM || '/�̸� : ' || EMP.EMP_NAME || '/���ʽ��� : ' || EMP.BONUS || '%');
        END LOOP;
 
    ELSIF(TYPE_CHR = '�Ի���')
    THEN
        FOR i IN 1..5 LOOP
             SELECT RANKORDER,EMP_NAME,HIRE_DATE 
             INTO RANKNUM,EMP.EMP_NAME,EMP.HIRE_DATE
             FROM(SELECT  EMP_NAME, HIRE_DATE,ROW_NUMBER() OVER(ORDER BY HIRE_DATE) AS RANKORDER FROM EMPLOYEE)
             WHERE RANKORDER = i;
             DBMS_OUTPUT.PUT_LINE('��ŷ : ' || RANKNUM || '/�̸� : ' || EMP.EMP_NAME || '/�Ի��� : ' || EMP.HIRE_DATE);
        END LOOP;
     END IF;
END;
/



DECLARE
	N NUMBER :=1;
BEGIN
	WHILE N  <=5 LOOP
	DBMS_OUTPUT.PUT_LINE(N);
	N:= N+1;
END LOOP;
END;
/

--������ ���̺� ����

CREATE TABLE EMP AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMP;

COMMIT;
ROLLBACK;

DROP PROCEDURE EMP_ID_DEL;

CREATE PROCEDURE EMP_ID_DEL(ID EMP.EMP_ID%TYPE)
IS 
BEGIN
    DELETE FROM EMP WHERE EMP_ID = ID;
END;
/

EXEC EMP_ID_DEL('&���');

DROP PROCEDURE EMP_SEARCH;
CREATE PROCEDURE EMP_SEARCH
            (D_CODE EMP.DEPT_CODE%TYPE :='D1',
             J_CODE EMP.JOB_CODE%TYPE :='J6')
IS
    ID EMP.EMP_ID%TYPE;
    NAME EMP.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO ID,NAME
    FROM EMP
    WHERE DEPT_CODE = D_CODE AND JOB_CODE = J_CODE
    AND ROWNUM = 1;
    DBMS_OUTPUT.PUT_LINE('��� : ' || ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || NAME);
    
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �����ϴ�.');
END;
/

EXEC EMP_SEARCH('D9','J2');
EXEC EMP_SEARCH('D8');
EXEC EMP_SEARCH();

DROP PROCEDURE EMP_SEARCH;

---�Ʒ��� ���� ���ν����� ����� �ش� ID�� ���� ������ �޿��� 3000000������
-- ����ǵ��� ������.
-- ����� ��� ��� (���� EMP���̺��� ���� �����)
-- ������ ����� �޿� ����
-- 6000000-> 3000000

CREATE OR REPLACE PROCEDURE EMP_MODIFY_SALARY
            (D_CODE EMP.DEPT_CODE%TYPE,
             E_SAL EMP.SALARY%TYPE)
IS
    ID EMP.EMP_ID%TYPE;
    SAL EMP.SALARY%TYPE;
    NAME EMP.EMP_NAME%TYPE;
    ORIGIN_SAL EMP.SALARY%TYPE;
    J_NAME DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, E_SAL, SALARY, EMP_NAME, (SELECT JOB_NAME FROM JOB J WHERE E.JOB_CODE = J.JOB_CODE)
    INTO ID, SAL, ORIGIN_SAL,NAME,J_NAME
    FROM EMP E
    WHERE E.EMP_ID = D_CODE;
    
    UPDATE EMP SET SALARY = SAL
    WHERE EMP_ID = ID;
    
    DBMS_OUTPUT.PUT_LINE(NAME ||' '|| J_NAME ||'�� �޿�����');
    DBMS_OUTPUT.PUT_LINE(ORIGIN_SAL ||'->' || SAL);
    
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �����ϴ�.');
END;
/
DROP PROCEDURE EMP_MODIFY_SALARY;

EXEC EMP_MODIFY_SALARY('202',3000000);

SELECT * FROM EMP;

SELECT* FROM JOB;

---- ����� �Է¹޾� �ش� ������ �̸��� �����ϴ� �Լ��� ����

CREATE FUNCTION R_NAME(ID EMP.EMP_ID%TYPE)
RETURN EMP.EMP_NAME%TYPE
IS
    NAME EMP.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_NAME
    INTO NAME
    FROM EMP
    WHERE EMP_ID = ID;
    RETURN NAME;
END;
/

SELECT R_NAME('210') FROM DUAL;

SELECT* FROM ALL_ERRORS;


-- �ǽ�����1
-- ����� �Է� �޾� �ش� ����� ������ ����Ͽ� �����ϴ� �����Լ��� ����� ����Ͻÿ�
-- PL/SQL ���� BONUS_CALC('&���'); ó���� ������ �����Ͽ� ����� �� �ֵ���
-- ������.
CREATE FUNCTION BONUS_CALC(ID EMP.EMP_ID%TYPE)
RETURN EMP.SALARY%TYPE
IS
    Y_SALARY EMP.SALARY%TYPE;
BEGIN
    SELECT SALARY*12
    INTO Y_SALARY
    FROM EMP
    WHERE EMP_ID = ID;
    RETURN Y_SALARY;
END;
/

DECLARE
    EMP EMPLOYEE%ROWTYPE;
BEGIN 
    SELECT EMP_ID,EMP_NAME
    INTO EMP.EMP_ID, EMP.EMP_NAME
    FROM EMPLOYEE
    WHERE EMP_ID = '&���';
    
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME ||'�� ���� ' || BONUS_CALC(EMP.EMP_ID)); 
END;
/
-- �ǽ����� 2
-- ����� ���޹޾� ������� Ư�� ���ʽ��� �����Ϸ��� ��
-- SALARY_BONUS('&���','&���ʽ���');
-- ���ʽ����� % ������ �Է��Ͽ� ó�� �� �� �ֵ��� ������ (ex. 30% �Է½� -> 0.3)
-- PL/SQL���� SALARY_BONUS �Լ��� ȣ���Ͽ� ���� �ѱ�� �Ǹ�
-- ���޵Ǵ� ���ʽ� ���� ������ ��µǵ��� �Ͻÿ�( �޿� * ���ʽ���)

DROP FUNCTION SALARY_BONUS;
CREATE FUNCTION SALARY_BONUS(ID EMP.EMP_ID%TYPE, B_RATE EMP.BONUS%TYPE)
RETURN EMP.SALARY%TYPE
IS
    SAL EMP.SALARY%TYPE;
BEGIN
    SELECT SALARY 
    INTO SAL
    FROM EMP
    WHERE EMP_ID = ID;
    
    RETURN SAL*B_RATE*0.01;
END;
/

DECLARE
    ID EMPLOYEE.EMP_ID%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    NAME EMPLOYEE.EMP_NAME%TYPE;
    B_RATE EMPLOYEE.BONUS%TYPE;
BEGIN
    ID := '&���';
    B_RATE :='&Ư�����ʽ���';
    SAL := SALARY_BONUS(ID,B_RATE);
    SELECT EMP_NAME INTO NAME
    FROM EMPLOYEE
    WHERE EMP_ID = ID;
    
    DBMS_OUTPUT.PUT_LINE(NAME || '����� �޴� ���ʽ��� ' || SAL);
END;
/































