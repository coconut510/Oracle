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
--FLOOR ���� �ڸ����� ����.
SELECT EMP_NAME AS "�̸�", FLOOR((SYSDATE - HIRE_DATE)) AS "�ٹ� �ϼ�", '��' AS ���� FROM EMPLOYEE;

--3. EMPLOYEE ���̺��� 20�� �̻� �ټ����� �̸�,����,���ʽ����� ����Ͻÿ�
SELECT EMP_NAME AS "�̸�", SALARY AS "����",NVL(BONUS,0) AS "���ʽ���" FROM EMPLOYEE
WHERE (FLOOR(SYSDATE - HIRE_DATE)/365)>=20;

SELECT DISTINCT NVL(DEPT_CODE,'����') FROM EMPLOYEE;

SELECT EMP_NAME, SALARY||'��' AS "����" FROM EMPLOYEE;
SELECT EMP_NAME, '����ȣ : '||PHONE AS "�޴���" FROM EMPLOYEE; 
SELECT EMP_NAME, '�޿� : '|| SALARY||'/���ʽ��� : '|| NVL(BONUS,0)*100 ||'%' AS "�޿��׺��ʽ���" FROM EMPLOYEE;

SELECT EMP_NAME, SALARY FROM EMPLOYEE  WHERE 350000<= SALARY AND SALARY<=6000000;
SELECT EMP_NAME,SALARY FROM EMPLOYEE WHERE SALARY BETWEEN 3500000 AND 6000000;

SELECT * FROM EMPLOYEE WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

SELECT SALARY AS "�޿�" FROM EMPLOYEE
WHERE EMP_NAME = '������';

SELECT * FROM EMPLOYEE
WHERE PHONE LIKE '%3%';

SELECT * FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '��%';


--@ �ǽ� ���� 3

--1. EMPLOYEE ���̺��� �̸� ���� ������ ������ ����� �̸��� ����Ͻÿ�

SELECT * FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

--2. EMPLOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ��
--����Ͻÿ�
SELECT EMP_NAME, PHONE FROM EMPLOYEE
WHERE  PHONE NOT LIKE '010%';

SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '____#_%' ESCAPE '#' AND 
(DEPT_CODE LIKE 'D9' OR DEPT_CODE LIKE 'D6') AND
HIRE_DATE BETWEEN '90/01/01' AND
'00/12/01' AND SALARY >= 2700000;

SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '______@%' AND
DEPT_CODE LIKE 'D6' OR DEPT_CODE LIKE 'D6' AND
HIRE_DATE BETWEEN '90/01/01' AND
'00/12/01' AND SALARY >= 270;


--3. EMPLOYEE ���̺��� �����ּ� '_'�� ���� 4���̸鼭, DEPT_CODE�� D9 �Ǵ� D6�̰�
--������� 90/01/01 ~ 00/12/01�̸鼭, ������ 270�����̻��� ����� ��ü ������ ����Ͻÿ�

SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '%s%' AND
(DEPT_CODE LIKE 'D6' OR DEPT_CODE LIKE 'D9') AND
(HIRE_DATE BETWEEN '90/01/01' AND'00/12/01') AND 
SALARY >= 2700000; 

SELECT *  FROM EMPLOYEE
WHERE BONUS IS NOT NULL;


SELECT EMP_NAME FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

SELECT EMP_NAME FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

SELECT * FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6','D9');

-- �μ��� �� �����ڵ尡 J7�Ǵ� J2�̰�, �޿��� 2,000,000 �� �ʰ��� �����
-- �̸�, �޿�, �����ڵ带 ���.
SELECT EMP_NAME,SALARY,JOB_CODE FROM EMPLOYEE
WHERE JOB_CODE IN('J7','J2') AND SALARY > 2000000;

SELECT * FROM EMPLOYEE ORDER BY 2;

SELECT BONUS * SALARY FROM EMPLOYEE
ORDER BY 1;

--@ �ǽ� ���� 4
---- ����1. 
---- �Ի����� 5�� �̻�, 10�� ������ ������ �̸�,�ֹι�ȣ,�޿�,�Ի����� �˻��Ͽ���

SELECT EMP_NAME AS �̸�,EMP_NO AS �ֹι�ȣ, SALARY AS �޿�,HIRE_DATE AS �Ի��� FROM EMPLOYEE
WHERE (SYSDATE - HIRE_DATE)/365  BETWEEN 5 AND 10; 

-- ����2.
-- �������� �ƴ� ������ �̸�,�μ��ڵ带 �˻��Ͽ��� (��� ���� : ENT_YN)
SELECT EMP_NAME AS �̸�,DEPT_CODE AS �μ��ڵ�, HIRE_DATE AS �Ի���,FLOOR(ENT_DATE-HIRE_DATE) ||'��' AS �ٹ��Ⱓ , ENT_DATE AS ����� 
FROM EMPLOYEE
WHERE ENT_DATE IS NOT NULL ;

-- ����3.
-- �ټӳ���� 10�� �̻��� �������� �˻��Ͽ�
-- ��� ����� �̸�,�޿�,�ټӳ��(�Ҽ���X)�� �ټӳ���� ������������ �����Ͽ� ����Ͽ���
-- ��, �޿��� 50% �λ�� �޿��� ��µǵ��� �Ͽ���.

SELECT EMP_NAME AS �̸�, SALARY*1.5 AS �޿�, FLOOR((SYSDATE - HIRE_DATE)/365) AS �ټӳ��
FROM EMPLOYEE
WHERE FLOOR((SYSDATE - HIRE_DATE)/365)>=10 
ORDER BY 3;

-- ����4.
-- �Ի����� 99/01/01 ~ 10/01/01 �� ��� �߿��� �޿��� 2000000 �� ������ �����
-- �̸�,�ֹι�ȣ,�̸���,����ȣ,�޿��� �˻� �Ͻÿ�

SELECT EMP_NAME AS �̸�, EMP_NO AS �ֹι�ȣ, EMAIL AS �̸���, PHONE AS ����ȣ, SALARY AS �޿�
FROM EMPLOYEE
WHERE (HIRE_DATE BETWEEN '99/01/01' AND '10/01/01') AND
SALARY<=2000000;

-- ����5.
-- �޿��� 2000000�� ~ 3000000�� �� ������ �߿��� 4�� �����ڸ� �˻��Ͽ� 
-- �̸�,�ֹι�ȣ,�޿�,�μ��ڵ带 �ֹι�ȣ ������(��������) ����Ͽ���
-- ��, �μ��ڵ尡 null�� ����� �μ��ڵ尡 '����' ���� ��� �Ͽ���.

SELECT EMP_NAME AS �̸�, EMP_NO AS �ֹι�ȣ,SALARY AS �޿�, NVL(DEPT_CODE,'����') AS �μ��ڵ�
FROM EMPLOYEE
WHERE (SALARY BETWEEN 2000000 AND 3000000)AND
EMP_NO LIKE '___4___2%' --AND EMP_NO LIKE '___4%'
ORDER BY EMP_NO DESC;

-- ����6.
-- ���� ��� �� ���ʽ��� ���� ����� ���ñ��� �ٹ����� �����Ͽ� 
-- 1000�� ����(�Ҽ��� ����) 
-- �޿��� 10% ���ʽ��� ����Ͽ� �̸�,Ư�� ���ʽ� (��� �ݾ�) ����� ����Ͽ���.
-- ��, �̸� ������ ���� ���� �����Ͽ� ����Ͽ���.
SELECT EMP_NAME AS �̸�, FLOOR((SYSDATE - HIRE_DATE)/1000) * SALARY*0.1||'��' AS "Ư�� ���ʽ�"
FROM EMPLOYEE
WHERE BONUS IS NULL AND 
EMP_NO LIKE '_______1%'
ORDER BY EMP_NAME;

SELECT EMAIL, LENGTH(EMAIL) AS "�̸��� ����"
FROM EMPLOYEE;





--------------------�ٽ� Ǯ��� ------------------------
--1-1��
--1. JOB���̺��� JOB_NAME�� ������ ��µǵ��� �Ͻÿ�
SELECT JOB_NAME FROM JOB;
--1-2��
--2. DEPARTMENT���̺��� ���� ��ü�� ����ϴ� SELECT���� �ۼ��Ͻÿ�
SELECT * FROM DEPARTMENT;
--1-3��
--3. EMPLOYEE ���̺��� �̸�(EMP_NAME),�̸���(EMAIL),��ȭ��ȣ(PHONE),�����(HIRE_DATE)
--  �� ����Ͻÿ�
SELECT EMP_NAME,EMAIL,PHONE,HIRE_DATE FROM EMPLOYEE;
--1-4��
--4. EMPLOYEE ���̺��� �����(HIRE_DATE) �̸�(EMP_NAME),����(SALARY)�� ����Ͻÿ�
SELECT HIRE_DATE,EMP_NAME,SALARY FROM EMPLOYEE;

--1-5��
--5. EMPLOYEE ���̺��� ����(SALARY)�� 2,500,000���̻��� �����
-- EMP_NAME �� SAL_LEVEL�� ����Ͻÿ� (��Ʈ : >(ũ��) , <(�۴�) �� �̿�)
SELECT EMP_NAME,SAL_LEVEL FROM EMPLOYEE
WHERE SALARY>=2500000;

--1-6��
--6. EMPLOYEE ���̺��� ����(SALARY)�� 350���� �̻��̸鼭 
-- JOB_CODE�� 'J3' �� ����� �̸�(EMP_NAME)�� ��ȭ��ȣ(PHONE)�� ����Ͻÿ�
-- (��Ʈ : AND(�׸���) , OR (�Ǵ�))
SELECT EMP_NAME, PHONE FROM EMPLOYEE
WHERE SALARY>=3500000 AND JOB_CODE = 'J3';

--2-1��
--1. EMPLOYEE ���̺��� �̸�,����, �Ѽ��ɾ�(���ʽ�����), 
--�Ǽ��ɾ�(�� ���ɾ�-(����*���� 3%))�� ��µǵ��� �Ͻÿ�
SELECT EMP_NAME AS �̸�, SALARY*12 AS ����, (SALARY * NVL(BONUS,0))*12  AS �Ѽ��ɾ�(���ʽ�����),
SALARY*(1+NVL(BONUS,0)-0.03)*12 AS �Ǽ��ɾ�
FROM EMPLOYEE;

--2-2��
--2. EMPLOYEE ���̺��� �̸�, �ٹ� �ϼ��� ����غ��ÿ� 
--(SYSDATE�� ����ϸ� ���� �ð� ���)
SELECT EMP_NAME AS �̸�, (SYSDATE - HIRE_DATE) AS �ٹ� �ϼ� FROM EMPLOYEE;

--2-3��
--3. EMPLOYEE ���̺��� 20�� �̻� �ټ����� �̸�,����,���ʽ����� ����Ͻÿ�
SELECT EMP_NAME AS �̸�, SALARY AS ����,NVL(BONUS,0) * 100 ||'%' AS ���ʽ��� FROM EMPLOYEE;

--3-1��
--1. EMPLOYEE ���̺��� �̸� ���� ������ ������ ����� �̸��� ����Ͻÿ�
SELECT EMP_NAME AS �̸� FROM EMPLOYEE
WHERE EMP_NAME  LIKE '%��';

--3-2��
--2. EMPLOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ��
--����Ͻÿ�
SELECT EMP_NAME AS �̸�,PHONE AS ��ȭ��ȣ FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--3-3��
--3. EMPLOYEE ���̺��� �����ּ��� 's'�� ���鼭, DEPT_CODE�� D9 �Ǵ� D6�̰�
--������� 90/01/01 ~ 00/12/01�̸鼭, ������ 270�����̻��� ����� ��ü ������ ����Ͻÿ�
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '%s%' AND DEPT_CODE IN('D9','D6') AND
HIRE_DATE BETWEEN '90/01/01' AND '00/12/01' AND
SALARY >=2700000;

--4-1��
-- ����1. 
-- �Ի����� 5�� �̻�, 10�� ������ ������ �̸�,�ֹι�ȣ,�޿�,�Ի����� �˻��Ͽ���
SELECT EMP_NAME AS �̸�,EMP_NO AS �ֹι�ȣ,SALARY AS �޿�,HIRE_DATE AS �Ի��� FROM EMPLOYEE
WHERE (SYSDATE - HIRE_DATE)/365 BETWEEN 5 AND 10;

--4-2��
-- ����2.
-- �������� �ƴ� ������ �̸�,�μ��ڵ带 �˻��Ͽ��� (��� ���� : ENT_YN)
SELECT EMP_NAME AS �̸�,DEPT_CODE AS �μ��ڵ� FROM EMPLOYEE
WHERE ENT_YN = 'N';

--4-3��
-- ����3.
-- �ټӳ���� 10�� �̻��� �������� �˻��Ͽ�
-- ��� ����� �̸�,�޿�,�ټӳ��(�Ҽ���X)�� �ټӳ���� ������������ �����Ͽ� ����Ͽ���
-- ��, �޿��� 50% �λ�� �޿��� ��µǵ��� �Ͽ���.
SELECT EMP_NAME AS �̸�,SALARY * 1.5 AS �޿�,FLOOR((ENT_DATE - HIRE_DATE)/365) AS �ټӳ�� FROM EMPLOYEE
WHERE FLOOR((ENT_DATE - HIRE_DATE)/365)>=10;

--4-4��
-- �Ի����� 99/01/01 ~ 10/01/01 �� ��� �߿��� �޿��� 2000000 �� ������ �����
-- �̸�,�ֹι�ȣ,�̸���,����ȣ,�޿��� �˻� �Ͻÿ�
SELECT EMP_NAME AS �̸�,EMP_NO AS �ֹι�ȣ,EMAIL AS �̸���,PHONE AS ����ȣ,SALARY AS �޿� FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '99/01/01' AND '10/01/01' AND
SALARY<=2000000;

--4-5��
-- ����5.
-- �޿��� 2000000�� ~ 3000000�� �� ������ �߿��� 4�� �����ڸ� �˻��Ͽ� 
-- �̸�,�ֹι�ȣ,�޿�,�μ��ڵ带 �ֹι�ȣ ������(��������) ����Ͽ���
-- ��, �μ��ڵ尡 null�� ����� �μ��ڵ尡 '����' ���� ��� �Ͽ���.
SELECT EMP_NAME AS �̸�,EMP_NO AS �ֹι�ȣ,SALARY AS �޿�,NVL(DEPT_CODE,'����') AS �μ��ڵ� FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000 AND
EMP_NO LIKE '___4___2%'
ORDER BY EMP_NO DESC;

--4-6��
-- ����6.
-- ���� ��� �� ���ʽ��� ���� ����� ���ñ��� �Ի����� �����Ͽ� 
-- 1000�� ����(�Ҽ��� ����) 
-- �޿��� 10% ���ʽ��� ����Ͽ� �̸�,Ư�� ���ʽ� (��� �ݾ�) ����� ����Ͽ���.
-- ��, �̸� ������ ���� ���� �����Ͽ� ����Ͽ���.
SELECT EMP_NAME AS �̸�, FLOOR((SYSDATE - HIRE_DATE)/1000)*SALARY * 0.1 AS Ư�����ʽ� FROM EMPLOYEE
WHERE BONUS IS NULL
ORDER BY EMP_NAME;