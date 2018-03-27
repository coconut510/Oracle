SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE CROSS JOIN DEPARTMENT
ORDER BY 1;

SELECT * FROM SAL_GRADE;

SELECT EMP_ID, EMP_NAME, SALARY, E.SAL_LEVEL, S.SAL_LEVEL
FROM EMPLOYEE E
JOIN SAL_GRADE S ON (E.SALARY BETWEEN 3000000 AND 4000000)
WHERE E.SAL_LEVEL = S.SAL_LEVEL
ORDER BY 1;

-- ���� ����� ���� ������ ID�� Ȯ���ϰ� �ʹٸ�?
SELECT EMP_ID, EMP_NAME, MANAGER_ID
FROM EMPLOYEE
WHERE EMP_ID = MANAGER_ID;

SELECT E.EMP_ID , E.EMP_NAME, E.MANAGER_ID,E2.EMP_ID AS �Ŵ���ID, E2.EMP_NAME AS �Ŵ����̸�
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE E2 ON (E.MANAGER_ID = E2.EMP_ID);

SELECT E.EMP_ID , E.EMP_NAME, E.MANAGER_ID,E2.EMP_ID AS �Ŵ���ID, E2.EMP_NAME AS �Ŵ����̸�
FROM EMPLOYEE E,EMPLOYEE E2
WHERE(E.MANAGER_ID = E2.EMP_ID);

-- �ǽ�����1
-- �ڽ��� �����ϰ� �ִ� ����� �޿� �� ������ ��� �Ǵ��� �˻��Ͽ���.
SELECT EM.EMP_NAME AS �Ŵ����̸�,ES.EMP_NAME AS ����̸�, ES.JOB_CODE AS ����ڵ�, ES.SALARY AS ����޿�
FROM EMPLOYEE EM
JOIN EMPLOYEE ES ON (ES.MANAGER_ID =  EM.EMP_ID)
ORDER BY �Ŵ����̸�;

SELECT EM.EMP_NAME AS �Ŵ����̸�,ES.EMP_NAME AS ����̸�,ES.SALARY AS ����޿�, ES.JOB_CODE AS ����ڵ�
FROM EMPLOYEE EM,EMPLOYEE ES
WHERE (ES.MANAGER_ID = EM.EMP_ID)
ORDER BY �Ŵ����̸�;

--1. EMPLOYEE ���̺��  DEPARTMENT ���̺��� �����ؼ�
--EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE�� ���� �ʹٸ�? 

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);


--2. DEPARTMENT ���̺�� LOCATION ���̺��� �����ؼ�
--DEPARTMENT �� LOCATION_ID�� ���� LOCAL_NAME�� ���� �ʹٸ�?

SELECT LOCATION_ID, LOCAL_NAME 
FROM DEPARTMENT JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);


-- 3. EMPOYEE , DEPARTMENT, LOCATIOON �� ���� JOIN �Ҷ�.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE,LOCATION_ID,LOCAL_NAME
FROM EMPLOYEE JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
              JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);



-- �ǽ����� 2
-- �� ������� �̸�, ����, �μ���, ��å���� ����Ͽ���
-- (�μ��ڵ�, ��å�ڵ尡 �ƴ� �μ���� ��å���� ����Ͽ��� ��)
SELECT EMP_NAME AS �̸�, EXTRACT(YEAR FROM SYSDATE) - (1900 + SUBSTR(EMP_NO,1,2)) AS ���� ,  
       NVL(DEPT_TITLE,'�μ�����')  AS �μ���, JOB_NAME AS ��å��
FROM EMPLOYEE E FULL JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
              JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
ORDER BY ���� DESC;
              
              
--## �߰� ���� �ǽ� ���� ##
--1. 2020�� 12�� 25���� ���� �������� ��ȸ�Ͻÿ�.
SELECT TO_CHAR(TO_DATE('20/12/25'),'DAY') AS ���� FROM DUAL;
--2. �ֹι�ȣ�� 1970��� ���̸鼭 ������ �����̰�, 
--���� ������ �������� �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�.
SELECT EMP_NAME AS �����, EMP_NO  AS �ֹι�ȣ, DEPT_CODE AS �μ���, JOB_CODE AS ���޸� FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,1,2) BETWEEN 70 AND 79 AND EMP_NO LIKE '______-2%' AND SUBSTR(EMP_NAME,1,1) LIKE '��';
--3. �̸��� '��'�ڰ� ���� �������� 
--���, �����, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_NO AS �����, EMP_NAME AS �����, DEPT_TITLE AS �μ���
FROM EMPLOYEE JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE EMP_NAME LIKE '%��%';
--4. �ؿܿ����ο� �ٹ��ϴ� 
--�����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_NAME AS �����, JOB_CODE AS ���޸�, DEPT_CODE AS �μ��ڵ�, DEPT_TITLE AS �μ���
FROM EMPLOYEE JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_CODE IN ('D6','D5');
--5. ���ʽ�����Ʈ�� �޴� �������� 
--�����, ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME AS �����, BONUS AS ���ʽ�, NVL(DEPT_TITLE,'�μ�����') AS �μ���, NVL(LOCAL_NAME,'�ٹ���������') AS �ٹ�����
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
              LEFT JOIN LOCATION  ON(LOCATION_ID = LOCAL_CODE)
WHERE BONUS IS NOT NULL;

--6. �μ��ڵ尡 D2�� �������� 
--�����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME AS �����, DEPT_CODE AS ���޸�, DEPT_TITLE AS �μ���, LOCAL_NAME AS �ٹ�������
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
              JOIN LOCATION  ON(LOCATION_ID = LOCAL_CODE)
WHERE DEPT_CODE LIKE 'D2';

--7. �޿�������̺��� �ִ�޿�(MAX_SAL)���� ���� �޴� �������� 
--�����, ���޸�, �޿�, ������ ��ȸ�Ͻÿ�.
SELECT EMP_NAME AS �����, JOB_NAME AS ���޸�, SALARY AS �޿�, SALARY*12 AS ����
FROM EMPLOYEE E JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
                JOIN SAL_GRADE S ON (E.SAL_LEVEL = S.SAL_LEVEL)
WHERE SALARY > S.MAX_SAL-500000;

-- (������̺�� �޿�������̺��� SAL_LEVEL�÷��������� ������ ��)
--8. �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� 
--�����, �μ���, ������, �������� ��ȸ�Ͻÿ�.
SELECT EMP_NAME AS �����, NVL(DEPT_TITLE,'�μ�����') AS �μ���, LOCAL_NAME  AS ������, NATIONAL_NAME AS ������
FROM EMPLOYEE E LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
                JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
                JOIN NATIONAL N ON(L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE N.NATIONAL_CODE IN ('KO','JP');
--9. ���� �μ��� �ٹ��ϴ� �������� �����, �μ���, �����̸��� 
--��ȸ�Ͻÿ�. (self join ���)
SELECT E.EMP_NAME AS �����, DEPT_TITLE AS �μ���, E2.EMP_NAME
FROM EMPLOYEE E JOIN EMPLOYEE E2 ON (E.DEPT_CODE = E2.DEPT_CODE)
                JOIN DEPARTMENT ON (E.DEPT_CODE = DEPT_ID)
WHERE E.EMP_NAME NOT LIKE E2.EMP_NAME;

--10. ���ʽ�����Ʈ�� ���� ������ �߿��� ������ ����� 
--����� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�.
--��, join�� IN ����� ��
SELECT EMP_NAME AS �����, JOB_NAME AS ���޸� , SALARY AS �޿�
FROM EMPLOYEE E JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE JOB_NAME IN ('����','���') AND BONUS IS NULL;


--11. �������� ������ ����� ������ ���� ��ȸ�Ͻÿ�.
SELECT DECODE(ENT_YN,'Y','����� ����','�������� ����') AS �������� , COUNT(*) AS ������ 
FROM EMPLOYEE
GROUP BY ENT_YN
ORDER BY ������;


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE DEPT_CODE LIKE 'D5';

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE SALARY>3000000;

--UNION ��� --
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE DEPT_CODE LIKE 'D5'
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE SALARY>3000000;

--UNION ALL ��� --
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE DEPT_CODE LIKE 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE SALARY>3000000;

--INTERSECT���--
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE DEPT_CODE LIKE 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE SALARY > 3000000;


--MINUS--
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE DEPT_CODE LIKE 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE SALARY >3000000;


-- �������� ������ �̸��� ��� --
SELECT MANAGER_ID
FROM EMPLOYEE
WHERE EMP_NAME = '������';

SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 214;

SELECT EMP_NAME AS �������̸�
FROM EMPLOYEE
WHERE EMP_ID = (SELECT MANAGER_ID FROM EMPLOYEE WHERE EMP_NAME = '������');

-- �� ������ ��� �޿����� ���� �޿��� �ް� �ִ� ������ ���, �̸�, �����ڵ�,
-- �޿��� ��ȸ�Ͻÿ�.
SELECT EMP_ID, EMP_NAME, JOB_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY > ( SELECT AVG(SALARY) FROM EMPLOYEE );

-- ����
-- �����ؿ� �޿��� ���� ����� �˻��Ͽ� 
-- ��� ��ȣ, ��� �̸�, �޿��� ����Ͽ���.
-- (��, �����ش� ������� �ʴ´�)

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT SALARY FROM EMPLOYEE WHERE EMP_NAME = '������') AND
      EMP_NAME NOT LIKE '������';

-- �ǽ� ���� 1
-- employee ���̺��� �⺻�޿��� ���� ���� ����� ���� ���� ����� ������ 
-- ���, �����, �⺻�޿��� ��Ÿ������.
SELECT EMP_ID AS ���, EMP_NAME  AS �����, SALARY AS �⺻�޿�
FROM EMPLOYEE
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE) OR
      SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);


-- �ǽ� ���� 2
-- D1, D2�μ��� �ٹ��ϴ� ����� �߿���
-- �⺻�޿��� D5 �μ� �������� '��տ���' ���� ���� ����鸸 
-- �μ���ȣ, �����ȣ, �����, ������ ��Ÿ������.
SELECT DEPT_CODE AS �μ���ȣ, EMP_ID AS �����ȣ, EMP_NAME AS �����, SALARY AS ����
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D1','D2') AND
    SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE WHERE DEPT_CODE LIKE 'D5');


SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IN (
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN ('������','�ڳ���'));


SELECT JOB_NAME, EMP_NAME
FROM EMPLOYEE E JOIN  JOB USING (JOB_CODE)--J ON (E.JOB_CODE = J.JOB_CODE)
WHERE E.SAL_LEVEL IN (SELECT SG2.SAL_LEVEL  FROM EMPLOYEE E2 
                    JOIN SAL_GRADE SG2 ON(E2.SAL_LEVEL = SG2.SAL_LEVEL)
                    WHERE EMP_NAME IN ('���¿�', '������')) AND
                    EMP_NAME NOT IN('���¿�', '������');
                    
-- �ǽ����� 2
-- 1. ������ ��ǥ, �λ����� �ƴ� ��� �����
-- �̸�, �μ���, �����ڵ带 ����ϰ� �μ����� ���.
SELECT * FROM JOB;

SELECT EMP_NAME, DEPT_TITLE, JOB_CODE
FROM EMPLOYEE JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE JOB_CODE NOT IN (SELECT JOB_CODE FROM EMPLOYEE WHERE JOB_CODE IN('J1','J2'))
ORDER BY DEPT_TITLE;





-------------����-----------------
--## ���� ���� �ǽ� ##

SELECT EMP_NAME AS �̸� , EXTRACT(YEAR FROM SYSDATE) -  (1900 +SUBSTR(EMP_NO,1,2)) AS ����,
        DEPT_TITLE AS �μ���, JOB_NAME AS ��å��
        FROM EMPLOYEE E JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
                      JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
        ORDER BY ���� DESC;

--## ���� �׸��� ���� 11������ Ǯ�� ������ �Ͽ���  ##
--1. 2020�� 12�� 25���� ���� �������� ��ȸ�Ͻÿ�.
SELECT TO_CHAR(TO_DATE('20/12/25'), 'DAY') AS ���� FROM DUAL;
--2. �ֹι�ȣ�� 1970��� ���̸鼭 ������ �����̰�, 
--���� ������ �������� �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�.
SELECT EMP_NAME AS �����, EMP_NO AS �ֹι�ȣ, DEPT_TITLE AS �μ���, JOB_NAME AS ���޸�
FROM EMPLOYEE E JOIN JOB USING(JOB_CODE)
              JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SUBSTR(EMP_NO,1,2) BETWEEN 70 AND 79 AND
      SUBSTR(EMP_NO,8,1) LIKE 2 AND EMP_NAME LIKE '��%';
--3. �̸��� '��'�ڰ� ���� �������� 
--���, �����, �μ����� ��ȸ�Ͻÿ�.
SELECT EMP_ID AS ���, EMP_NAME AS ����� AS S

--4. �ؿܿ����ο� �ٹ��ϴ� 
--�����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�.
--5. ���ʽ�����Ʈ�� �޴� �������� 
--�����, ���ʽ�����Ʈ, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
--6. �μ��ڵ尡 D2�� �������� 
--�����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�.
--7. �޿�������̺��� �ִ�޿�(MAX_SAL)���� -50�������� ���� �޴� �������� 
--�����, ���޸�, �޿�, ������ ��ȸ�Ͻÿ�.
-- (������̺�� �޿�������̺��� SAL_LEVEL�÷��������� ������ ��)
--8. �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �������� 
--�����, �μ���, ������, �������� ��ȸ�Ͻÿ�.
--9. ���� �μ��� �ٹ��ϴ� �������� �����, �μ���, �����̸��� 
--��ȸ�Ͻÿ�. (self join ���)
--10. ���ʽ�����Ʈ�� ���� ������ �߿��� ������ ����� 
--����� �������� �����, ���޸�, �޿��� ��ȸ�Ͻÿ�. 
--��, join�� IN ����� ��
--11. �������� ������ ����� ������ ���� ��ȸ�Ͻÿ�.



