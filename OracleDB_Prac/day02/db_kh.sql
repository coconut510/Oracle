--@ �ǽ� ����
--1. JOB���̺��� JOB_NAME�� ������ ��µǵ��� �Ͻÿ�
SELECT JOB_NAME FROM JOB;
--2. DEPARTMENT���̺��� ���� ��ü�� ����ϴ� SELECT���� �ۼ��Ͻÿ�
SELECT * FROM DEPARTMENT;
/*3. EMPLOYEE ���̺��� �̸�(EMP_NAME),�̸���(EMAIL),��ȭ��ȣ(PHONE),�����(HIRE_DATE)
�� ����Ͻÿ�*/
SELECT EMP_NAME,EMAIL,PHONE,HIRE_DATE FROM EMPLOYEE;

--4. EMPLOYEE ���̺��� �����(HIRE_DATE) �̸�(EMP_NAME),����(SALARY)�� ����Ͻÿ�
SELECT HIRE_DATE,EMP_NAME,SALARY FROM EMPLOYEE;

/*5. EMPLOYEE ���̺��� ����(SALARY)�� 2,500,000���̻��� �����
 EMP_NAME �� SAL_LEVEL�� ����Ͻÿ� (��Ʈ : >(ũ��) , <(�۴�) �� �̿�)*/
SELECT EMP_NAME,SAL_LEVEL FROM EMPLOYEE WHERE SALARY>=2500000;

/*6. EMPLOYEE ���̺��� ����(SALARY)�� 350���� �̻��̸鼭 
 JOB_CODE�� 'J3' �� ����� �̸�(EMP_NAME)�� ��ȭ��ȣ(PHONE)�� ����Ͻÿ�
 (��Ʈ : AND(�׸���) , OR (�Ǵ�))*/
SELECT EMP_NAME,PHONE FROM EMPLOYEE WHERE SALARY>=3500000 AND JOB_CODE='J3';

-- ���� (���� *12)Z`
SELECT EMP_NAME AS �̸�, SALARY*12 AS "����(��)" , '��' AS "����" FROM EMPLOYEE;

-- ���ʽ��ݾ�
SELECT SALARY * BONUS FROM EMPLOYEE;

-- ���� Ȯ��( ��, �Ŵ� �޴� ���ʽ��� ������ ����)
SELECT EMP_NAME, (SALARY  + (SALARY * BONUS))*12 FROM EMPLOYEE;

--@ �ǽ� ���� 2

--1. EMPLOYEE ���̺��� �̸�,����, �Ѽ��ɾ�(���ʽ�����), �Ǽ��ɾ�(�� ���ɾ�-(����*���� 3%))
--�� ��µǵ��� �Ͻÿ�
SELECT EMP_NAME AS "�̸�", SALARY*12 AS "����",
SALARY*(1+NVL(BONUS,0))*12 AS "�Ѽ��ɾ�(���ʽ�����)", 
(SALARY*(1+NVL(BONUS,0)-0.03)*12)  AS "�Ǽ��ɾ�"
FROM EMPLOYEE;

--2. EMPLOYEE ���̺��� �̸�, �ٹ� �ϼ��� ����غ��ÿ� (SYSDATE�� ����ϸ� ���� �ð� ���)
SELECT EMP_NAME AS "�̸�", CEIL((SYSDATE - HIRE_DATE)) AS "�ٹ� �ϼ�" FROM EMPLOYEE;

--3. EMPLOYEE ���̺��� 20�� �̻� �ټ����� �̸�,����,���ʽ����� ����Ͻÿ�
SELECT EMP_NAME AS "�̸�", SALARY AS "����",BONUS AS "���ʽ���" FROM EMPLOYEE
WHERE ((SYSDATE - HIRE_DATE)/365)>=20;










