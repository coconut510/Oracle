--1. ������� �̸��� , �̸��� ���̸� ����Ͻÿ�
--		  �̸�	    �̸���		�̸��ϱ���
--	ex) 	ȫ�浿 , hong@kh.or.kr   	  13
SELECT EMP_NAME AS �̸�, EMAIL AS �̸��� , LENGTH(EMAIL) AS �̸��ϱ���
FROM EMPLOYEE;

--2. ������ �̸��� �̸��� �ּ��� ���̵� �κи� ����Ͻÿ�
--	ex) ���ö	no_hc
--	ex) ������	jung_jh

SELECT EMP_NAME AS �̸�, SUBSTR(EMAIL,1, INSTR(EMAIL, '@',-1,1)-1)  AS  �̸����ּ� FROM EMPLOYEE;

--3. 60����� ������� ���, ���ʽ� ���� ����Ͻÿ� 
--	�׶� ���ʽ� ���� null�� ��쿡�� 0 �̶�� ��� �ǰ� ����ÿ�
--	    ������    ���      ���ʽ�
--	ex) ������	62	0.3
--	ex) ������	63  	0
SELECT EMP_NAME AS ������, SUBSTR(EMP_NO,1,2) AS ��� , NVL(BONUS,0) AS ���ʽ� FROM EMPLOYEE;

--4. '010' �ڵ��� ��ȣ�� ���� �ʴ� ����� ���� ����Ͻÿ� (�ڿ� ������ ���� ���̽ÿ�)
--	   �ο�
--	ex) 3��
SELECT COUNT(PHONE) FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--5. ������� �Ի����� ����Ͻÿ� 
--	��, �Ʒ��� ���� ��µǵ��� ����� ���ÿ�
--	    ������		�Ի���
--	ex) ������		2012��12��
--	ex) ������		1997�� 3��

SELECT EMP_NAME AS ������, TO_CHAR(HIRE_DATE,'YYYY"��"MM"��"') AS �Ի��� FROM EMPLOYEE;

--6. ������� �ֹι�ȣ�� ��ȸ�Ͻÿ�
--	��, �ֹι�ȣ 9��° �ڸ����� �������� '*' ���ڷ� ä������� �Ͻÿ�
--	ex) ȫ�浿 771120-1******

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,7),14,'*') FROM EMPLOYEE;

--7. ������, �����ڵ�, ����(��) ��ȸ
--  ��, ������ ��57,000,000 ���� ǥ�õǰ� ��
--     ������ ���ʽ�����Ʈ�� ����� 1��ġ �޿���

SELECT EMP_NAME AS �̸�, JOB_CODE AS �����ڵ�, TO_CHAR( SALARY *(1+NVL(BONUS,0))*12,'L999,999,999') AS ���� FROM EMPLOYEE;

--8. �μ��ڵ尡 D5, D9�� ������ �߿��� 2004�⵵�� �Ի��� ������ 
--   �� ��ȸ��.
--   ��� ����� �μ��ڵ� �Ի���
-- SUBSTR(HIRE_DATE,1,2) BETWEEN 04 AND SUBSTR(SYSDATE,1,2)

SELECT EMP_ID, EMP_NAME, NVL(DEPT_CODE,'����') FROM EMPLOYEE
WHERE  SUBSTR(HIRE_DATE,1,2)= '04' AND (DEPT_CODE = 'D5' OR DEPT_CODE = 'D9');

--9. ������, �Ի���, ���ñ����� �ٹ��ϼ� ��ȸ 
--	* �ָ��� ���� , �Ҽ��� �Ʒ��� ����
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE- HIRE_DATE) FROM EMPLOYEE;

--10. ��� ������ ���� �� ���� ���� ���̿� ���� ���� ���̸� ��� �Ͽ���. (���̸� ���)
SELECT MAX(SUBSTR(EXTRACT(YEAR FROM SYSDATE),3,2) +100 - SUBSTR(EMP_NO,1,2)+1) AS �ֿ�����, 
       MIN(SUBSTR(EXTRACT(YEAR FROM SYSDATE),3,2) +100 - SUBSTR(EMP_NO,1,2)+1) AS �ֿ����� FROM EMPLOYEE;
       
SELECT MAX(EXTRACT(YEAR FROM SYSDATE) - (1900+ SUBSTR(EMP_NO,1,2))) AS �ֿ�����,
       MIN(EXTRACT(YEAR FROM SYSDATE) - (1900 + SUBSTR(EMP_NO,1,2))) AS �ֿ�����
        FROM EMPLOYEE;
--11.  ȸ�翡�� �߱��� �ؾ� �Ǵ� �μ��� ��ǥ�Ͽ��� �Ѵ�.
-- �μ��ڵ尡 D5,D6,D9  �߱�, �׿ܴ� �߱پ��� ���� ��µǵ��� �Ͽ���. 
-- ��� ���� �̸�,�μ��ڵ�,�߱����� (�μ��ڵ� ���� �������� ������.)
--   (�μ��ڵ尡 null�� ����� �߱پ��� ��)
SELECT EMP_NAME AS �����̸�, NVL(DEPT_CODE,'����') AS �μ��ڵ�, 
                 CASE WHEN DEPT_CODE IN ('D9' ,'D6' ,'D5') THEN '�߱�'
                 ELSE '�߱پ���'
                 END AS �߱�����
                 FROM EMPLOYEE
                 ORDER BY �μ��ڵ�;


SELECT EMP_NAME AS �����̸�, NVL(DEPT_CODE,'����') AS �μ��ڵ�, 
                 CASE WHEN (DEPT_CODE LIKE 'D9' OR DEPT_CODE LIKE 'D6' OR DEPT_CODE LIKE 'D5') THEN '�߱�'
                 ELSE '�߱پ���'
                 END AS �߱�����
                 FROM EMPLOYEE
                 ORDER BY �μ��ڵ�;
                 

                 
SELECT EMP_NAME AS �����̸�, NVL(DEPT_CODE,'����') AS �μ��ڵ�,
                DECODE(DEPT_CODE, 'D9', '�߱�','D6','�߱�','D5','�߱�','�߱پ���') AS �߱�����
                FROM EMPLOYEE
                ORDER BY �μ��ڵ�;

SELECT NVL(DEPT_CODE,'����') AS �μ�, SUM(SALARY) AS �����ջ�,FLOOR(AVG(SALARY)) AS �μ������
FROM EMPLOYEE GROUP BY DEPT_CODE
ORDER BY �����ջ� DESC;

-- GROUP BY �ǽ����� 1
SELECT JOB_CODE AS ����, SUM(SALARY) AS �����հ�, SUM(SALARY * 12) AS �����հ� FROM EMPLOYEE
GROUP BY JOB_CODE;

-- GROUP BY �ǽ����� 2
SELECT NVL(DEPT_CODE,'����') AS �μ��ڵ�, SUM(SALARY) AS �޿��հ�, FLOOR(AVG(SALARY)) AS �޿����,
COUNT(NVL(DEPT_CODE,'����'))||'��' AS �μ��ο� FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- GROUP BY �ǽ����� 3
SELECT NVL(DEPT_CODE,'����') AS �μ��ڵ�, COUNT(*) AS ���ʽ��޴»���� FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- GROUP BY �ǽ����� 4
SELECT JOB_CODE, COUNT(JOB_CODE), FLOOR(AVG(SALARY))
FROM EMPLOYEE
WHERE JOB_CODE NOT LIKE 'J1'--NOT IN('J1')
GROUP BY JOB_CODE;

-- GROUP BY �ǽ����� 5
SELECT NVL(DEPT_CODE,'����') AS �μ��ڵ�, DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��') AS ����, COUNT(*) AS �ο�
FROM EMPLOYEE
GROUP BY DEPT_CODE, SUBSTR(EMP_NO,8,1)
ORDER BY DEPT_CODE;


SELECT DEPT_CODE, AVG(SALARY) FROM EMPLOYEE
GROUP BY DEPT_CODE 
HAVING AVG(SALARY)>=3000000;

SELECT DEPT_CODE, COUNT(*) FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE)
ORDER BY 1;

SELECT DEPT_CODE, COUNT(*) FROM EMPLOYEE
GROUP BY  CUBE(DEPT_CODE)
ORDER BY 1;

--�ǽ����� 1

SELECT DEPT_CODE AS �μ��ڵ�,SUM(SALARY) AS �޿��հ� FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE)
ORDER BY 1;

--�ǽ����� 2
SELECT JOB_CODE AS �����ڵ�,SUM(SALARY) AS �޿��հ� FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)
ORDER BY 1;

--�ǽ����� 3
SELECT DEPT_CODE AS �����ڵ�,AVG(SALARY) AS �޿��հ�, COUNT(*) AS �հ� FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE)
HAVING AVG(SALARY) >=3000000 
ORDER BY 1;

----------------
--�������� �μ��� Ȥ�� ���޺��� ������ ��� �Ͽ���
-- �̹����� �μ��� ���޺� �ο� ������ ����ϰ� �ʹٸ�?
SELECT DECODE(GROUPING(DEPT_CODE),1,'�Ѱ�',DEPT_CODE) �μ��ڵ�, DECODE(GROUPING(JOB_CODE),1,'�Ұ�',JOB_CODE) �����ڵ� ,COUNT(*) AS  ���޺��ο� FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE,JOB_CODE;

SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
ORDER BY 2;


-- ���� �μ����� �ƴ� ���޺� ����� �� ���踦 ���� �ʹٸ�??
-- JOB_CODE ��ġ�� DEPT_CODE ��ġ�� �ٲ��ָ� ��

SELECT JOB_CODE, DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE, DEPT_CODE;

--�μ��� ����� ���޺� ����� �� ����
SELECT JOB_CODE, DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE,DEPT_CODE)
ORDER BY 1 ;

-- CUBE�� �׷����� ������ ��� �׷쿡 ���� ����� �� ���Ը� ����
-- ��, ���� �ڵ带 ���� �μ��� ���� ���Ŀ� ���޺� ���踦 �����ϰ� ����������
-- �� ���踦 ���ϰ� ��

-- ���������� �̾߱� �ϸ�!
-- ROLLUP �� CUBE�� ����� �Լ�.
-- ROLLUP �� ���� ���� ������ �׷캰 ���� �� �� ����
-- CUBE �� �׷����� ������ ��� �׷쿡 ���� ���� �� �� ����


-- ����1
-- �μ��� ���޺� �޿� ���� ��� �� �� �μ��� ����
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY) FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE,JOB_CODE)
ORDER BY DEPT_CODE;

-- ����2
-- �μ��� ���޺� �޿� ���� ��� �� �� �μ��� ���� �� ���޺� ����
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY) FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1,2;


SELECT DECODE(GROUPING(DEPT_CODE),1,'������',NVL(DEPT_CODE,'����')) AS �μ��ڵ�, COUNT(*) || '��' AS �ο� FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE)
ORDER BY 1;

SELECT DEPT_CODE, JOB_CODE,COUNT(*), GROUPING(DEPT_CODE), GROUPING(JOB_CODE)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1,2;

SELECT DECODE(GROUPING(DEPT_CODE),1,'���޺�����', NVL(DEPT_CODE,'�μ�����'))AS �μ��ڵ�,
       DECODE(GROUPING(JOB_CODE),1,'�μ��� ����',JOB_CODE) AS �����ڵ�, COUNT(*)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1,2;

SELECT CASE WHEN GROUPING(DEPT_CODE)=1 AND GROUPING(JOB_CODE) = 0 THEN '���޺� ����'
            WHEN GROUPING(DEPT_CODE) =1 AND GROUPING(JOB_CODE) = 1 THEN '�� ����'
            ELSE NVL(DEPT_CODE, '�μ�����')
            END AS "�μ��ڵ�",
       CASE WHEN GROUPING(DEPT_CODE)=0 AND GROUPING(JOB_CODE) = 1 THEN '�μ��� ����'
            WHEN GROUPING(DEPT_CODE) =1 AND GROUPING(JOB_CODE) = 1 THEN '-'
            ELSE JOB_CODE
            END AS "�����ڵ�",
       COUNT(*)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1,2;

SELECT EMP_ID, E.EMP_NAME, J.JOB_CODE
FROM EMPLOYEE E , JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

SELECT EMP_ID, JOB_NAME
FROM EMPLOYEE JOIN JOB USING(JOB_CODE);

SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

SELECT EMP_NAME, DEPT_TITLE, DEPT_CODE, DEPT_ID
FROM EMPLOYEE INNER JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

SELECT EMP_NAME, DEPT_TITLE, DEPT_CODE, DEPT_ID
FROM EMPLOYEE LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);


