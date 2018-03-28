SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY < ANY( 2000000, 5000000); 

-- EX) J3 �ڵ带 ���� ����� �޿����� ������ ��

SELECT SALARY FROM EMPLOYEE
WHERE JOB_CODE LIKE 'J3';


-- J3 �ڵ带 ���� ������� �޿��߿��� ���� ���� ������� ū �޿����� ���

SELECT EMP_NAME,SALARY FROM EMPLOYEE
WHERE SALARY > ANY(SELECT SALARY FROM EMPLOYEE
WHERE JOB_CODE LIKE 'J3');

-- 'D1' �Ǵ� 'D5' �μ��ڵ带 ������ �ִ� ������� 
-- �޿� �߿��� ���� ���� �޿����� ����

SELECT EMP_NAME AS �̸�, SALARY �޿�,DEPT_CODE �μ��ڵ� FROM EMPLOYEE
WHERE SALARY < ANY( SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE IN ('D1','D5'));

-- �ǽ����� 1
-- ('D1'�Ǵ�'D5' �μ��ڵ带 ������ �ִ� ��� ����
-- �޿� �߿��� ���� ���� �޿�) ���� ���� ��� ������� �̸�, �޿�, �μ��ڵ带 ����Ͽ���
SELECT EMP_NAME AS �̸�, SALARY AS �޿�, DEPT_CODE AS �μ��ڵ� 
FROM EMPLOYEE
WHERE SALARY < ANY(SELECT SALARY FROM EMPLOYEE WHERE  DEPT_CODE IN ('D1','D5'));

-- < ANY(OR..OR..OR)
-- ������������ ���� ����� �߿���
-- �ϳ��� �۴ٸ�.

-- �ǽ����� 2
-- �μ��� ��� �޿��� �����Ͽ����� ���� ���� �μ��� �޿�����
-- ���ų� ���� ��� ������� �̸� , �޿� , �μ����� ����Ͻÿ�

SELECT EMP_NAME AS �̸�, SALARY AS �޿�, NVL(DEPT_TITLE,'�μ�����') AS �μ���
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY >=
ANY(SELECT MIN(AVG(SALARY)) FROM EMPLOYEE GROUP BY DEPT_CODE);


SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY < ALL(2000000, 5000000);

-- �ǽ�1
-- D2 �μ��� ��� ������� �޿����� ���� �޿��� �޴� ����� ��ȸ.

SELECT EMP_NAME AS �̸�, SALARY �޿� FROM EMPLOYEE
WHERE SALARY < ALL(SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE LIKE 'D2');

-- ���ʽ� ����Ʈ 3.0 �̻��� ������� �ִٸ�
-- ��� ����� ������ ����� �־��.

SELECT EMP_NAME , BONUS 
FROM EMPLOYEE
WHERE EXISTS(
SELECT * FROM EMPLOYEE
WHERE NVL(BONUS,0) >=0.1);

-- ���ʽ����� 1 �̻��� ����� ���ٸ�
-- ��� ����� �̸�, �޿��� ����ϵ� 10% �λ�� ���ķ� ����Ͽ���.
-- ���ʽ����� 1�̻��� ����� �ִٸ�
-- ������� ���ƶ�

SELECT EMP_NAME, SALARY * 1.1 FROM EMPLOYEE
WHERE NOT EXISTS(SELECT NULL FROM EMPLOYEE WHERE BONUS>=1);


-- ȸ�翡�� ����� �������� ���� �μ� �� ������ 
-- ����� �˻��Ͻÿ� !(�̸�, ����, �μ�, �Ի����� ���)

SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE,JOB_CODE) IN (SELECT DEPT_CODE,JOB_CODE 
FROM EMPLOYEE 
                        WHERE ENT_DATE IS NOT NULL AND EMP_NO LIKE '______-2%');
                        
                        
-- @ �ǽ�����

-- ����������̸鼭 �޿��� 2,000,000 ��
-- ������ �̸�, �μ��ڵ� , �޿�, �μ��������� �� ����Ͻÿ�
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;

SELECT EMP_NAME AS �̸�, DEPT_CODE �μ��ڵ�, SALARY �޿�, LOCAL_NAME AS �����̸�
FROM EMPLOYEE JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
              JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE (SALARY, DEPT_CODE) IN (SELECT SALARY, DEPT_CODE FROM EMPLOYEE 
                              WHERE SALARY LIKE 2000000 AND DEPT_CODE = 'D8');

--  ORACLE ǥ���.
SELECT  EMP_NAME , DEPT_CODE, SALARY, LOCAL_NAME
FROM EMPLOYEE, LOCATION
WHERE (DEPT_CODE, LOCAL_CODE) IN 
(SELECT DEPT_ID, LOCATION_ID FROM DEPARTMENT
WHERE DEPT_TITLE = '���������')
AND SALARY LIKE 2000000;

-- ANSI ǥ���.

SELECT EMP_NAME, DEPT_CODE, SALARY, LOCAL_NAME
FROM EMPLOYEE
JOIN LOCATION ON (DEPT_CODE, LOCAL_CODE)
IN (SELECT DEPT_ID, LOCATION_ID FROM DEPARTMENT
    WHERE DEPT_TITLE ='���������') -- AND SALARY = 2000000;
WHERE SALARY =2000000; 


-- ���޺� �ּ� �޿��� �޴� ������ �̸�, ���, �μ��ڵ�, �Ի���, ������ ���

SELECT EMP_NAME , EMP_ID, DEPT_CODE, HIRE_DATE, SALARY * 12
FROM EMPLOYEE
WHERE(JOB_CODE, SALARY)
IN (SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE);

-- ��� ���� ����
-- �����ڰ� �ִ� ����� �� �������� ����� EMPLOYEE ���̺� �����ϴ� 
-- ������ ����� ���� �� ������ ���,�̸�, �ҼӺμ�, ������ ����� ��ȸ�Ͻÿ�.

SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID
FROM EMPLOYEE E
WHERE EXISTS(SELECT NULL
            FROM EMPLOYEE E2
            WHERE E.MANAGER_ID = E2.EMP_ID);


SELECT E.EMP_ID , E.EMP_NAME, E.MANAGER_ID,
	NVL((SELECT E2.EMP_NAME
		FROM EMPLOYEE E2
		WHERE E.MANAGER_ID = E2.EMP_ID), '����') AS "�����ڸ�"
FROM EMPLOYEE E
ORDER BY 1;

--@�ǽ�����
--1. �����, �μ��ڵ�, �μ��� ����ӱ��� ��Į�󼭺������� �̿��ؼ� ���.
SELECT E.EMP_NAME AS �����, NVL(E.DEPT_CODE,'�μ�����') AS �μ��ڵ� , 
                ( SELECT FLOOR(AVG(E2.SALARY)) 
                  FROM EMPLOYEE E2 
                  GROUP BY E2.DEPT_CODE
                  HAVING NVL(E.DEPT_CODE,'�μ�����') = NVL(E2.DEPT_CODE,'�μ�����')) AS �μ�������ӱ�
                FROM EMPLOYEE E
                ORDER BY �μ��ڵ�;

SELECT E.EMP_NAME, E.DEPT_CODE
FROM EMPLOYEE E JOIN EMPLOYEE E2 ON (E.EMP_NAME = E2.EMP_NAME)
WHERE AVG(E2.SALARY)<E.SALARY;


SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE E1
WHERE SALARY >= (SELECT AVG(SALARY)
		FROM EMPLOYEE E2
		WHERE E2.JOB_CODE = E1.JOB_CODE)
ORDER BY 2;

SELECT *
FROM(
SELECT *
FROM(
SELECT EMP_NAME, SALARY, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY >= 3000000)
WHERE DEPT_CODE IN('D9','D5')
);

SELECT ROWNUM, ��.*
FROM(
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC) ��
WHERE ROWNUM <=5;

SELECT ROWNUM,EMPLOYEE.* FROM EMPLOYEE;


WITH TOP_N_SAL AS (SELECT EMP_NAME, SALARY FROM EMPLOYEE ORDER BY SALARY DESC)

SELECT ROWNUM, TOP_N_SAL.*
FROM TOP_N_SAL
WHERE ROWNUM <=5;

WITH TOP_N AS (SELECT RANK() OVER(ORDER BY SALARY DESC) AS ����, EMP_NAME, SALARY
                FROM EMPLOYEE)
SELECT *
FROM TOP_N;


SELECT RANK() OVER(ORDER BY SALARY DESC) AS ����, EMP_NAME, SALARY
                FROM EMPLOYEE;

SELECT DENSE_RANK() OVER(ORDER BY SALARY DESC) AS ����, EMP_NAME, SALARY
                FROM EMPLOYEE;
                                
SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS ����, EMP_NAME, SALARY
                FROM EMPLOYEE;



--@ �ǽ� ����
--����1
--��������ο� ���� ������� ����� �̸�,�μ��ڵ�,�޿��� ����Ͻÿ�
SELECT EMP_NAME AS �̸� , DEPT_CODE AS �μ��ڵ�, SALARY AS �޿�
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE LIKE '���������'); 

--����2
--��������ο� ���� ����� �� ���� ������ ���� ����� �̸�,�μ��ڵ�,�޿��� ����Ͻÿ�
SELECT EMP_NAME AS �̸� , DEPT_CODE AS �μ��ڵ�, SALARY AS �޿�
FROM EMPLOYEE
WHERE  SALARY =  (SELECT MAX(SALARY) 
        FROM EMPLOYEE,DEPARTMENT 
        WHERE DEPT_TITLE = '���������'
            AND DEPT_CODE = DEPT_ID);
        
--����3
--�Ŵ����� �ִ� ����߿� ������ ��ü��� ����� �Ѱ� 
--���,�̸�,�Ŵ��� �̸�,����(������������)�� ���Ͻÿ�
-- * ��, JOIN�� �̿��Ͻÿ�

SELECT E1.EMP_ID AS ���, E1.EMP_NAME AS �̸�, NVL(E2.EMP_NAME,'����') �Ŵ���, E1.SALARY*0.0001||'����' AS ����
FROM EMPLOYEE E1 
LEFT JOIN EMPLOYEE E2 ON (E1.MANAGER_ID = E2.EMP_ID)
WHERE E1.SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE) AND E1.MANAGER_ID IS NOT NULL;

--����4
--�� ���޸��� �޿� ����� ���� ���� ������ �̸�, �����ڵ�, �޿�, �޿���� ��ȸ
SELECT E.EMP_NAME AS �̸� , E.JOB_CODE AS �����ڵ�, E.SALARY AS �޿�, E.SAL_LEVEL AS �޿����
FROM EMPLOYEE E JOIN SAL_GRADE SG ON (E.SAL_LEVEL = SG.SAL_LEVEL)
WHERE (SUBSTR(E.SAL_LEVEL,2,1)) = (SELECT MIN(SUBSTR(E2.SAL_LEVEL,2,1)) FROM EMPLOYEE E2
                                WHERE E2.JOB_CODE = E.JOB_CODE GROUP BY E2.JOB_CODE);
--����5
-- �μ��� ��� �޿��� 2200000 �̻��� �μ���, ��� �޿� ��ȸ
-- ��, ��� �޿��� �Ҽ��� ����

SELECT (SELECT DEPT_TITLE FROM DEPARTMENT WHERE DEPT_CODE  = DEPT_ID) AS �μ���, FLOOR(AVG(SALARY)) AS ��ձ޿�
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 2000000;

--����6
--������ ���� ��պ��� ���� �޴� ���ڻ����
--�����,�����ڵ�,�μ��ڵ�,������ �̸� ������������ ��ȸ�Ͻÿ�
--���� ��� => (�޿�+(�޿�*���ʽ�))*1

SELECT EMP_NAME AS �����, JOB_CODE AS �����ڵ� , NVL(DEPT_CODE,'�μ�����') AS �μ��ڵ�, (1+NVL(BONUS,0)) * SALARY * 12 AS ����
FROM EMPLOYEE E
WHERE SUBSTR(E.EMP_NO, 8,1) LIKE 2 AND 
      (1+NVL(BONUS,0)) * SALARY  < (SELECT AVG(SALARY) FROM EMPLOYEE E2
                WHERE E.JOB_CODE = E2.JOB_CODE
                GROUP BY JOB_CODE)
ORDER BY �����;



