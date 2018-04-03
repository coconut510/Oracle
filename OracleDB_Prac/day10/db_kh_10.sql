BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/

SET SERVEROUTPUT ON;


DECLARE
    ID NUMBER;
BEGIN
    SELECT EMP_ID
    INTO ID
    FROM EMPLOYEE
    WHERE EMP_NAME = '������';
    DBMS_OUTPUT.PUT_LINE(ID);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �����ϴ�.!');
END;
/

DECLARE
    ID NUMBER;
BEGIN
    SELECT EMP_ID
    INTO ID
    FROM EMPLOYEE
    WHERE EMP_NAME = '&�̸�';
    DBMS_OUTPUT.PUT_LINE(ID);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �����ϴ�.!');
END;
/

DECLARE
    ID NUMBER;
    NAME VARCHAR2(20);
    NO VARCHAR2(30);
BEGIN
    SELECT EMP_ID,EMP_NAME, EMP_NO
    INTO ID,NAME, NO
    FROM EMPLOYEE
    WHERE EMP_NAME = '&�̸�';
    DBMS_OUTPUT.PUT_LINE(ID);
    DBMS_OUTPUT.PUT_LINE(NAME);
    DBMS_OUTPUT.PUT_LINE(NO);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �����ϴ�.!');
END;
/
-- �ش� ����� �����ȣ�� �Է½�
-- �̸�, �μ���, ���޸��� ��� �ǵ��� PL/SQL�� ����� ���ÿ�.

DECLARE
    NAME VARCHAR2(20);
    DEPT_NAME VARCHAR2(30);
    JOB_NAME VARCHAR2(20);
BEGIN
    SELECT EMP_NAME,DEPT_TITLE, JOB_NAME
    INTO NAME,DEPT_NAME,JOB_NAME
    FROM EMPLOYEE E JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
                    JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
    WHERE EMP_ID  = '&�����ȣ';
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' ||DEPT_NAME);
    DBMS_OUTPUT.PUT_LINE('���޸� : ' ||JOB_NAME);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �����ϴ�.');
END;
/

-- �ش� ����� �����ȣ�� �Է½�
-- �̸�, �μ��ڵ�, ���� �ڵ尡 ��µǵ��� PL/SQL�� ����� ���ÿ�.
DECLARE
    NAME VARCHAR2(20);
    DEPT_NAME VARCHAR2(30);
    JOB_NAME VARCHAR2(20);
BEGIN
    SELECT EMP_NAME,DEPT_CODE, JOB_CODE
    INTO NAME,DEPT_NAME,JOB_NAME
    FROM EMPLOYEE 
    WHERE EMP_ID  = '&�����ȣ';
    DBMS_OUTPUT.PUT_LINE(NAME);
    DBMS_OUTPUT.PUT_LINE(DEPT_NAME);
    DBMS_OUTPUT.PUT_LINE(JOB_NAME);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �����ϴ�.');
END;
/


DECLARE
	DATA1 NUMBER;
	DATA2 NUMBER := 200;
BEGIN
	DATA1 := 100;
	DBMS_OUTPUT.PUT_LINE(DATA1);
	DBMS_OUTPUT.PUT_LINE(DATA2);
END;
/

DECLARE
    ID VARCHAR2(20);
    NAME VARCHAR2(20);
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO ID, NAME
    FROM EMPLOYEE
    WHERE EMP_NAME = '������';
    
    DBMS_OUTPUT.PUT_LINE('ID : ' || ID);
    DBMS_OUTPUT.PUT_LINE('NAME : ' || NAME);
END;
/

DECLARE
    ID EMPLOYEE.EMP_ID%TYPE;
    NAME EMPLOYEE.EMP_NAME%TYPE;
    NO EMPLOYEE.EMP_NO%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    HIRE_DATE EMPLOYEE.HIRE_DATE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, EMP_NO, SALARY, HIRE_DATE
    INTO ID, NAME, NO, SALARY, HIRE_DATE
    FROM EMPLOYEE
    WHERE EMP_NAME = '&�̸�';
    DBMS_OUTPUT.PUT_LINE('�����ȣ : '||ID);
    DBMS_OUTPUT.PUT_LINE('����̸� : '||NAME);
    DBMS_OUTPUT.PUT_LINE('�ֹι�ȣ : '||NO);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||SALARY);
    DBMS_OUTPUT.PUT_LINE('�Ի��� : '||HIRE_DATE);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �����ϴ�');
END;
/

DECLARE
    EMP EMPLOYEE%ROWTYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, EMP_NO 
    INTO EMP.EMP_ID,EMP.EMP_NAME, EMP.EMP_NO
    FROM EMPLOYEE
    WHERE EMP_ID = '200';
    DBMS_OUTPUT.PUT_LINE('�����ȣ : ' ||EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('����� : ' ||EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�ֹι�ȣ : ' ||EMP.EMP_NO);
    
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �����ϴ�!');
END;
/

DECLARE
    TYPE MY_ROWTYPE IS RECORD(
        ID EMPLOYEE.EMP_ID%TYPE,
        NAME VARCHAR2(20),
        SALARY EMPLOYEE.SALARY%TYPE
    );
    EMP MY_ROWTYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EMP.ID, EMP.NAME, EMP.SALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '200';
    
    DBMS_OUTPUT.PUT_LINE(EMP.ID);
    DBMS_OUTPUT.PUT_LINE(EMP.NAME);
    DBMS_OUTPUT.PUT_LINE(EMP.SALARY);
EXCEPTION 
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �����ϴ�.!');
END;
/





--@�ǽ�����1
--���, �����, �����ڵ�, �޿��� ������ �ִ� ���������� ���ؼ� (%TYPE)
--���������� ���, �����, �����ڵ�,�޿��� �͸���� ���� ��ũ��Ʈ ����ϼ���.
DECLARE
    ID EMPLOYEE.EMP_ID%TYPE;
    NAME EMPLOYEE.EMP_NAME%TYPE;
    J_CODE EMPLOYEE.JOB_CODE%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
    INTO ID, NAME, J_CODE, SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME = '&�̸�';
    DBMS_OUTPUT.PUT_LINE('��� : ' || ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('�����ڵ� : ' || J_CODE);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �����ϴ�!');
END;
/
--@�ǽ�����2
--���, �����, ���޸��� ������ �ִ� ���������� ���ؼ� (record)
-- ������� �˻��Ͽ� �ش� ����� ���, �����, �μ���,���޸��� 
-- �͸���� ���� ��ũ��Ʈ ����ϼ���.
DECLARE
     TYPE EMP_RECORD IS RECORD(
        ID EMPLOYEE.EMP_ID%TYPE,
        NAME EMPLOYEE.EMP_NAME%TYPE,
        D_TITLE DEPARTMENT.DEPT_TITLE%TYPE,
        JOB_NAME JOB.JOB_NAME%TYPE
    );
    EMP EMP_RECORD;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
    INTO EMP.ID, EMP.NAME,EMP.D_TITLE, EMP.JOB_NAME
    FROM EMPLOYEE E JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
                    LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
    WHERE EMP_NAME = '&�̸�';
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP.ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP.NAME);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || NVL(EMP.D_TITLE,'����'));
    DBMS_OUTPUT.PUT_LINE('���޸� : ' || EMP.JOB_NAME);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �����ϴ�!');
END;
/


--@�ǽ�����3
-- �����ȣ�� �Է��Ͽ� �ش� ����� ã��  (%ROWTYPE�� ���)
-- �����, �ֹι�ȣ, �Ի���, �μ����� 
-- �͸���� ���� ��ũ��Ʈ ����ϼ���.

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DEP DEPARTMENT%ROWTYPE;
BEGIN
    SELECT EMP_NAME,EMP_NO, HIRE_DATE, DEPT_TITLE
    INTO EMP.EMP_NAME, EMP.EMP_NO, EMP.HIRE_DATE, DEP.DEPT_TITLE
    FROM EMPLOYEE LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = '&�����ȣ';
    DBMS_OUTPUT.PUT_LINE('����� : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�ֹι�ȣ : ' || EMP.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('�Ի��� : ' || EMP.HIRE_DATE);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || NVL(DEP.DEPT_TITLE,'����'));
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �����ϴ�!');
END;
/

--��� ��ȣ�� ������ ����� ���, �̸�, �޿�, ���ʽ����� ����ϰ�
-- ���ʽ����� ������ '���ʽ��� ���޹��� �ʴ� ����Դϴ�.' �� ��� �Ϸ���?
-- 1. �����ȣ�� ������ �ش� ����� ���, �̸�, �޿�, ���ʽ����� ���
-- 2. ���ʽ����� 0% ���?
--      -> ���ʽ��� ���޹��� �ʴ� ����Դϴ�.

DECLARE
    EMP EMPLOYEE%ROWTYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO EMP.EMP_ID, EMP.EMP_NAME, EMP.SALARY, EMP.BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&�����ȣ';
    DBMS_OUTPUT.PUT_LINE('��� : ' ||EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' ||EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' ||EMP.SALARY);
    DBMS_OUTPUT.PUT_LINE('���ʽ� : ' ||EMP.BONUS * 100 ||'%');
    IF(EMP.BONUS = 0)
    THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;
END;
/

--��� ��ȣ�� ������ ����� ���, �̸�, �޿�, ���ʽ����� ��� ��
	-- �̶� ,  ���ʽ����� ������ '���ʽ��� ���޹��� �ʴ� ����Դϴ�.' �� 
 	-- ����ϰ� ���ʽ����� �ִٸ� ���ʽ����� �����
	-- (��, ���ʽ����� 0%��� ���ʽ����� ������� ����)

DECLARE
    EMP EMPLOYEE%ROWTYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO EMP.EMP_ID, EMP.EMP_NAME, EMP.SALARY, EMP.BONUS
    FROM EMPLOYEE
     WHERE EMP_ID = '&�����ȣ';
    DBMS_OUTPUT.PUT_LINE('��� : ' ||EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' ||EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' ||EMP.SALARY);
    DBMS_OUTPUT.PUT_LINE('���ʽ� : ' ||EMP.BONUS * 100 ||'%');
    IF(EMP.BONUS = 0)
    THEN  DBMS_OUTPUT.PUT_LINE('���ʽ��� ���� �ʴ� ����Դϴ�.');
    ELSE  DBMS_OUTPUT.PUT_LINE('���ʽ� : ' ||EMP.BONUS * 100 ||'%');
    END IF;
END;
/


-- �����ȣ�� ������ �ش� ����� ��ȸ
-- �̶� �����, �μ����� ����Ͽ���.
-- ���� �μ��� ���ٸ� �μ����� ������� �ʰ�,
-- '�μ��� ���� ����Դϴ�' �� ����ϰ�
-- �μ��� �ִٸ� �μ����� ����Ͽ���
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DEP DEPARTMENT%ROWTYPE;
BEGIN
    SELECT EMP_NAME, DEPT_TITLE
    INTO EMP.EMP_NAME, DEP.DEPT_TITLE
    FROM EMPLOYEE LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = '&�����ȣ';
    DBMS_OUTPUT.PUT_LINE('����� : ' || EMP.EMP_NAME);
    IF(DEP.DEPT_TITLE IS NULL)
    THEN DBMS_OUTPUT.PUT_LINE('�μ��� ���� ����Դϴ�.');
    ELSE DBMS_OUTPUT.PUT_LINE('�μ��� : ' || DEP.DEPT_TITLE);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �����ϴ�!');
END;
/


--  ���� 2
-- ��� �ڵ带 �Է� �޾����� ���, �̸�, �μ��ڵ�, �μ���, �Ҽ� ���� ����Ͻÿ�
-- �׶�, �ҼӰ��� J1, J2 �� �ӿ���, �׿ܿ��� �Ϲ��������� ��µǰ� �Ͻÿ�

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DEP DEPARTMENT%ROWTYPE;
    TEAM VARCHAR2(20);
BEGIN
    SELECT EMP_NO, EMP_NAME, DEPT_CODE, DEPT_TITLE, JOB_CODE
    INTO EMP.EMP_NO, EMP.EMP_NAME, EMP.DEPT_CODE, DEP.DEPT_TITLE, EMP.JOB_CODE
    FROM EMPLOYEE LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = '&����ڵ�';
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ� : ' || NVL(EMP.DEPT_CODE,'����')); 
    DBMS_OUTPUT.PUT_LINE('�μ��̸� : ' || NVL(DEP.DEPT_TITLE,'����'));
    IF(EMP.JOB_CODE IN ('J1','J2'))
    THEN DBMS_OUTPUT.PUT_LINE('�ҼӰ� : �ӿ���');
    ELSE DBMS_OUTPUT.PUT_LINE('�ҼӰ� : �Ϲ�����');
    END IF;
END;
/
--�ǽ�2��
--�����ȣ�� ����� ��ȸ�Ͽ�����
--	�޿����� S1, S2 �� ���� ���ӱ�
--	�޿����� S3,S4 �� ��쿡�� ����ӱ�
--	�޿����� S5,S6�� ��쿡�� ���ӱ�
--	�� ��� �� �� �ֵ��� �Ͽ���.  
DECLARE
    SALLEVEL EMPLOYEE.SAL_LEVEL%TYPE;
BEGIN
    SELECT SAL_LEVEL 
    INTO SALLEVEL
    FROM EMPLOYEE
    WHERE EMP_ID = '&�����ȣ';
    
    IF(SALLEVEL IN ('S1','S2')) THEN DBMS_OUTPUT.PUT_LINE('���ӱ�');
    ELSIF(SALLEVEL IN ('S3','S4')) THEN DBMS_OUTPUT.PUT_LINE('����ӱ�');
    ELSIF(SALLEVEL IN ('S5','S6')) THEN DBMS_OUTPUT.PUT_LINE('���ӱ�');
    ELSE DBMS_OUTPUT.PUT_LINE('��������...');
    END IF;
END;
/

--## �ǽ� 3 ##
--����� �Է� ���� �� �޿��� ���� ����� ������ ����ϵ��� �Ͻÿ� 
--�׶� ��� ���� ���,�̸�,�޿�,�޿������ ����Ͻÿ�
--
--0���� ~ 99���� : F
--100���� ~ 199���� : E
--200���� ~ 299���� : D
--300���� ~ 399���� : C
--400���� ~ 499���� : B
--500���� �̻�(�׿�) : A
--
--ex) 200
--��� : 200
--�̸� : ������
--�޿� : 8000000
--��� : A



DECLARE
    EMP EMPLOYEE%ROWTYPE;
    SGRADE VARCHAR2(1);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EMP.EMP_ID, EMP.EMP_NAME, EMP.SALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&����Է�';
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || EMP.SALARY);
    
    IF(EMP.SALARY BETWEEN 0 AND 990000) THEN SGRADE :='F';
    ELSIF(EMP.SALARY BETWEEN 1000000 AND 1990000) THEN SGRADE :='E';
    ELSIF(EMP.SALARY BETWEEN 2000000 AND 2990000) THEN SGRADE :='D';
    ELSIF(EMP.SALARY BETWEEN 3000000 AND 3990000) THEN SGRADE :='C';
    ELSIF(EMP.SALARY BETWEEN 4000000 AND 4990000) THEN SGRADE :='B';
    ELSE SGRADE := 'A';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || SGRADE);
END;
/

DECLARE
    DATA NUMBER;
BEGIN
    DATA:= '&DATA��';
    CASE DATA
        WHEN 1 THEN
            DBMS_OUTPUT.PUT_LINE('�ȳ��ϼ���');
        WHEN 2 THEN
            DBMS_OUTPUT.PUT_LINE('�ݰ����ϴ�');
        WHEN 3 THEN
            DBMS_OUTPUT.PUT_LINE('�ູ�ϼ���');
        ELSE
            DBMS_OUTPUT.PUT_LINE('�߸� �Է��ϼ̽��ϴ�.');
        END CASE;
END;
/


--## �ǽ����� 4��
--����� �Է� ���� �� �޿��� ���� ����� ������ ����ϵ��� �Ͻÿ� 
--�׶� ��� ���� ���,�̸�,�޿�,�޿������ ����Ͻÿ�(CASE ���)
--
--0���� ~ 99���� : F
--100���� ~ 199���� : E
--200���� ~ 299���� : D
--300���� ~ 399���� : C
--400���� ~ 499���� : B
--500���� �̻�(�׿�) : A
--
--ex) 200
--��� : 200
--�̸� : ������
--�޿� : 8000000
--��� : A

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    SGRADE VARCHAR2(1);
    DATA NUMBER;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EMP.EMP_ID, EMP.EMP_NAME, EMP.SALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&����Է�';
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || EMP.SALARY);
    DATA := CEIL(EMP.SALARY/1000000);
      CASE  DATA
        WHEN 1 THEN SGRADE :='F';
        WHEN 2 THEN SGRADE :='E';
        WHEN 3 THEN SGRADE :='D';
        WHEN 4 THEN SGRADE :='C';
        WHEN 5 THEN SGRADE :='B';
        ELSE SGRADE := 'A';
        END CASE;     
    DBMS_OUTPUT.PUT_LINE('��� : ' || SGRADE);
END;
/

SELECT * FROM EMPLOYEE;


-----------------------�ٽ��ϱ� ����-----------------------
--@�ǽ�����1
--���, �����, �����ڵ�, �޿��� ������ �ִ� ���������� ���ؼ� (%TYPE)
--���������� ���, �����, �����ڵ�,�޿��� �͸���� ���� ��ũ��Ʈ ����ϼ���.
DECLARE
    ID EMPLOYEE.EMP_ID%TYPE;
    NAME EMPLOYEE.EMP_NAME%TYPE;
    J_CODE EMPLOYEE.JOB_CODE%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
    INTO ID, NAME, J_CODE, SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME = '&�̸�';
    DBMS_OUTPUT.PUT_LINE('��� : ' || ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('�����ڵ� : ' || J_CODE);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �����ϴ�!');
END;
/
--@�ǽ�����2
--���, �����, �μ���,���޸��� ������ �ִ� ���������� ���ؼ� (record)
-- ������� �˻��Ͽ� �ش� ����� ���, �����, �μ���,���޸��� 
-- �͸���� ���� ��ũ��Ʈ ����ϼ���.
DECLARE
     TYPE EMP_RECORD IS RECORD(
        ID EMPLOYEE.EMP_ID%TYPE,
        NAME EMPLOYEE.EMP_NAME%TYPE,
        D_TITLE DEPARTMENT.DEPT_TITLE%TYPE,
        JOB_NAME JOB.JOB_NAME%TYPE
    );
    EMP EMP_RECORD;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
    INTO EMP.ID, EMP.NAME,EMP.D_TITLE, EMP.JOB_NAME
    FROM EMPLOYEE E JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
                    LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
    WHERE EMP_NAME = '&�̸�';
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP.ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP.NAME);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || NVL(EMP.D_TITLE,'����'));
    DBMS_OUTPUT.PUT_LINE('���޸� : ' || EMP.JOB_NAME);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �����ϴ�!');
END;
/
--@�ǽ�����3
-- �����ȣ�� �Է��Ͽ� �ش� ����� ã��  (%ROWTYPE�� ���)
-- �����, �ֹι�ȣ, �Ի���, �μ����� 
-- �͸���� ���� ��ũ��Ʈ ����ϼ���.

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DEP DEPARTMENT%ROWTYPE;
BEGIN
    SELECT EMP_NAME,EMP_NO, HIRE_DATE, DEPT_TITLE
    INTO EMP.EMP_NAME, EMP.EMP_NO, EMP.HIRE_DATE, DEP.DEPT_TITLE
    FROM EMPLOYEE LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = '&�����ȣ';
    DBMS_OUTPUT.PUT_LINE('����� : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�ֹι�ȣ : ' || EMP.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('�Ի��� : ' || EMP.HIRE_DATE);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || NVL(DEP.DEPT_TITLE,'����'));
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �����ϴ�!');
END;
/

## �ǽ� 1 ##


-- ��� ��ȣ�� ������ �ش� ����� ��ȸ
-- �̶� �����,�μ��� �� ����Ͽ���.
-- ���� �μ��� ���ٸ� �μ����� ������� �ʰ�,
-- '�μ��� ���� ��� �Դϴ�' �� ����ϰ�
-- �μ��� �ִٸ� �μ����� ����Ͽ���.


----IF----
--## �ǽ� 2 ##
--
--��� �ڵ带 �Է� �޾����� ���,�̸�,�μ��ڵ�,�μ���,�Ҽ� ���� ����Ͻÿ�
--�׶�, �ҼӰ��� J1,J2 �� �ӿ���, �׿ܿ��� �Ϲ��������� ��µǰ� �Ͻÿ�

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DEP DEPARTMENT%ROWTYPE;
    TEAM VARCHAR2(20);
BEGIN
    SELECT EMP_NO, EMP_NAME, DEPT_CODE, DEPT_TITLE, JOB_CODE
    INTO EMP.EMP_NO, EMP.EMP_NAME, EMP.DEPT_CODE, DEP.DEPT_TITLE, EMP.JOB_CODE
    FROM EMPLOYEE LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = '&����ڵ�';
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ� : ' || NVL(EMP.DEPT_CODE,'����')); 
    DBMS_OUTPUT.PUT_LINE('�μ��̸� : ' || NVL(DEP.DEPT_TITLE,'����'));
    IF(EMP.JOB_CODE IN ('J1','J2'))
    THEN DBMS_OUTPUT.PUT_LINE('�ҼӰ� : �ӿ���');
    ELSE DBMS_OUTPUT.PUT_LINE('�ҼӰ� : �Ϲ�����');
    END IF;
END;
/



--## �ǽ� 3 ##
--����� �Է� ���� �� �޿��� ���� ����� ������ ����ϵ��� �Ͻÿ� 
--�׶� ��� ���� ���,�̸�,�޿�,�޿������ ����Ͻÿ�
--
--0���� ~ 99���� : F
--100���� ~ 199���� : E
--200���� ~ 299���� : D
--300���� ~ 399���� : C
--400���� ~ 499���� : B
--500���� �̻�(�׿�) : A
--
--ex) 200
--��� : 200
--�̸� : ������
--�޿� : 8000000
--��� : A


DECLARE
    EMP EMPLOYEE%ROWTYPE;
    SGRADE VARCHAR2(1);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EMP.EMP_ID, EMP.EMP_NAME, EMP.SALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&����Է�';
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || EMP.SALARY);
    
    IF(EMP.SALARY BETWEEN 0 AND 990000) THEN SGRADE :='F';
    ELSIF(EMP.SALARY BETWEEN 1000000 AND 1990000) THEN SGRADE :='E';
    ELSIF(EMP.SALARY BETWEEN 2000000 AND 2990000) THEN SGRADE :='D';
    ELSIF(EMP.SALARY BETWEEN 3000000 AND 3990000) THEN SGRADE :='C';
    ELSIF(EMP.SALARY BETWEEN 4000000 AND 4990000) THEN SGRADE :='B';
    ELSE SGRADE := 'A';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || SGRADE);
END;
/

--## �ǽ����� 1 ##
-- �����ȣ�� �Է¹޾Ƽ� ����� ���,�̸�,�޿�,���ʽ����� �������.
-- (�߰�)��ǥ���� ���, '����ȸ�� ��ǥ���̽ʴϴ�.'�� ���. (�����ڵ庯�� �߰�.)
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    GRADE VARCHAR2(10);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, BONUS, JOB_NAME
    INTO EMP.EMP_ID, EMP.EMP_NAME, EMP.SALARY, EMP.BONUS,GRADE
    FROM EMPLOYEE E JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
    WHERE EMP_ID = '&�����ȣ';  
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || EMP.SALARY);
    DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || EMP.BONUS * 100 ||'%');
    IF(GRADE = '��ǥ')
    THEN DBMS_OUTPUT.PUT_LINE('����ȸ�� ��ǥ���̽ʴϴ�.');
    END IF;
END;
/
--## �ǽ����� 2 ##
-- �ش� ��� ��ȣ�� �Է¹޾� �ش� ����� �Ҽӵ� �μ����� 
-- ���� ���� �޿��� �ް� �ִ� ����� ����Ͽ���
-- ��� ���� 
-- �˻��� �����, �˻��� ��� �μ�, 
-- �ҼӺμ����� ���� ���� �޿��� ���� ����� �� �޿�,�μ� ������ ��� �Ͽ���.
--ex) 
--�����ȣ '207'���� �Է½�
--### �˻��� ��� ���� ###
--�˻��� ����� : ������
--�Ҽӵ� �μ��� : �ؿܿ���1��
---------------------------------
--### �ؿܿ���1�ο��� �޿��� ���� ���� ��� ���� ###
--����� : ���ȥ
--�޿� : 3760000 ��
--�Ҽӵ� �μ� : �ؿܿ���1��

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DEP DEPARTMENT%ROWTYPE;
    NAME VARCHAR2(20);
    SALARY NUMBER;
    DEPT VARCHAR2(20);
BEGIN
    SELECT EMP_NAME, DEPT_TITLE
    INTO EMP.EMP_NAME, DEP.DEPT_TITLE
    FROM EMPLOYEE E JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
    WHERE EMP_ID = '&�����ȣ';   
    
    DBMS_OUTPUT.PUT_LINE('����� : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || DEP.DEPT_TITLE);

    SELECT EMP_NAME, SALARY, DEPT_TITLE
    INTO NAME, SALARY, DEPT
    FROM EMPLOYEE E LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
    WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE E1
                        WHERE NVL(E.DEPT_CODE,'����') = NVL(E1.DEPT_CODE,'����')
                        GROUP BY DEPT_CODE)
         AND DEPT_TITLE = DEP.DEPT_TITLE;
    
    DBMS_OUTPUT.PUT_LINE('����� : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY);
    DBMS_OUTPUT.PUT_LINE('�ҼӺμ� : ' || DEPT);
  
END;
/
 
SELECT EMP_NAME, SALARY, DEPT_TITLE
    FROM EMPLOYEE E LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
    WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE E1
                        WHERE NVL(E.DEPT_CODE,'����') = NVL(E1.DEPT_CODE,'����')
                        GROUP BY DEPT_CODE);
         AND DEPT_TITLE = DEP.DEPT_TITLE;


SELECT EMP_NAME, SALARY, DEPT_TITLE
    FROM EMPLOYEE E LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
    WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE E1
                        WHERE NVL(E.DEPT_CODE,'����') = NVL(E1.DEPT_CODE,'����')
                        GROUP BY DEPT_CODE);

SELECT MAX(SALARY) FROM EMPLOYEE E2 
                        GROUP BY E2.DEPT_CODE;