--1. 직원명과 이메일 , 이메일 길이를 출력하시오
--		  이름	    이메일		이메일길이
--	ex) 	홍길동 , hong@kh.or.kr   	  13
SELECT EMP_NAME AS 이름, EMAIL AS 이메일 , LENGTH(EMAIL) AS 이메일길이
FROM EMPLOYEE;

--2. 직원의 이름과 이메일 주소중 아이디 부분만 출력하시오
--	ex) 노옹철	no_hc
--	ex) 정중하	jung_jh

SELECT EMP_NAME AS 이름, SUBSTR(EMAIL,1, INSTR(EMAIL, '@',-1,1)-1)  AS  이메일주소 FROM EMPLOYEE;

--3. 60년생의 직원명과 년생, 보너스 값을 출력하시오 
--	그때 보너스 값이 null인 경우에는 0 이라고 출력 되게 만드시오
--	    직원명    년생      보너스
--	ex) 선동일	62	0.3
--	ex) 송은희	63  	0
SELECT EMP_NAME AS 직원명, SUBSTR(EMP_NO,1,2) AS 년생 , NVL(BONUS,0) AS 보너스 FROM EMPLOYEE;

--4. '010' 핸드폰 번호를 쓰지 않는 사람의 수를 출력하시오 (뒤에 단위는 명을 붙이시오)
--	   인원
--	ex) 3명
SELECT COUNT(PHONE) FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--5. 직원명과 입사년월을 출력하시오 
--	단, 아래와 같이 출력되도록 만들어 보시오
--	    직원명		입사년월
--	ex) 전형돈		2012년12월
--	ex) 전지연		1997년 3월

SELECT EMP_NAME AS 직원명, TO_CHAR(HIRE_DATE,'YYYY"년"MM"월"') AS 입사년월 FROM EMPLOYEE;

--6. 직원명과 주민번호를 조회하시오
--	단, 주민번호 9번째 자리부터 끝까지는 '*' 문자로 채워서출력 하시오
--	ex) 홍길동 771120-1******

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,7),14,'*') FROM EMPLOYEE;

--7. 직원명, 직급코드, 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임

SELECT EMP_NAME AS 이름, JOB_CODE AS 직급코드, TO_CHAR( SALARY *(1+NVL(BONUS,0))*12,'L999,999,999') AS 연봉 FROM EMPLOYEE;

--8. 부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원의 
--   수 조회함.
--   사번 사원명 부서코드 입사일
-- SUBSTR(HIRE_DATE,1,2) BETWEEN 04 AND SUBSTR(SYSDATE,1,2)

SELECT EMP_ID, EMP_NAME, NVL(DEPT_CODE,'없음') FROM EMPLOYEE
WHERE  SUBSTR(HIRE_DATE,1,2)= '04' AND (DEPT_CODE = 'D5' OR DEPT_CODE = 'D9');

--9. 직원명, 입사일, 오늘까지의 근무일수 조회 
--	* 주말도 포함 , 소수점 아래는 버림
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE- HIRE_DATE) FROM EMPLOYEE;

--10. 모든 직원의 나이 중 가장 많은 나이와 가장 적은 나이를 출력 하여라. (나이만 출력)
SELECT MAX(SUBSTR(EXTRACT(YEAR FROM SYSDATE),3,2) +100 - SUBSTR(EMP_NO,1,2)+1) AS 최연장자, 
       MIN(SUBSTR(EXTRACT(YEAR FROM SYSDATE),3,2) +100 - SUBSTR(EMP_NO,1,2)+1) AS 최연소자 FROM EMPLOYEE;
       
SELECT MAX(EXTRACT(YEAR FROM SYSDATE) - (1900+ SUBSTR(EMP_NO,1,2))) AS 최연장자,
       MIN(EXTRACT(YEAR FROM SYSDATE) - (1900 + SUBSTR(EMP_NO,1,2))) AS 최연소자
        FROM EMPLOYEE;
--11.  회사에서 야근을 해야 되는 부서를 발표하여야 한다.
-- 부서코드가 D5,D6,D9  야근, 그외는 야근없음 으로 출력되도록 하여라. 
-- 출력 값은 이름,부서코드,야근유무 (부서코드 기준 오름차순 정렬함.)
--   (부서코드가 null인 사람도 야근없음 임)
SELECT EMP_NAME AS 직원이름, NVL(DEPT_CODE,'없음') AS 부서코드, 
                 CASE WHEN DEPT_CODE IN ('D9' ,'D6' ,'D5') THEN '야근'
                 ELSE '야근없음'
                 END AS 야근유무
                 FROM EMPLOYEE
                 ORDER BY 부서코드;


SELECT EMP_NAME AS 직원이름, NVL(DEPT_CODE,'없음') AS 부서코드, 
                 CASE WHEN (DEPT_CODE LIKE 'D9' OR DEPT_CODE LIKE 'D6' OR DEPT_CODE LIKE 'D5') THEN '야근'
                 ELSE '야근없음'
                 END AS 야근유무
                 FROM EMPLOYEE
                 ORDER BY 부서코드;
                 

                 
SELECT EMP_NAME AS 직원이름, NVL(DEPT_CODE,'없음') AS 부서코드,
                DECODE(DEPT_CODE, 'D9', '야근','D6','야근','D5','야근','야근없음') AS 야근유무
                FROM EMPLOYEE
                ORDER BY 부서코드;

SELECT NVL(DEPT_CODE,'없음') AS 부서, SUM(SALARY) AS 월급합산,FLOOR(AVG(SALARY)) AS 부서별평균
FROM EMPLOYEE GROUP BY DEPT_CODE
ORDER BY 월급합산 DESC;

-- GROUP BY 실습문제 1
SELECT JOB_CODE AS 직급, SUM(SALARY) AS 월급합계, SUM(SALARY * 12) AS 연봉합계 FROM EMPLOYEE
GROUP BY JOB_CODE;

-- GROUP BY 실습문제 2
SELECT NVL(DEPT_CODE,'없음') AS 부서코드, SUM(SALARY) AS 급여합계, FLOOR(AVG(SALARY)) AS 급여평균,
COUNT(NVL(DEPT_CODE,'없음'))||'명' AS 부서인원 FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- GROUP BY 실습문제 3
SELECT NVL(DEPT_CODE,'없음') AS 부서코드, COUNT(*) AS 보너스받는사원수 FROM EMPLOYEE
WHERE BONUS IS NOT NULL
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- GROUP BY 실습문제 4
SELECT JOB_CODE, COUNT(JOB_CODE), FLOOR(AVG(SALARY))
FROM EMPLOYEE
WHERE JOB_CODE NOT LIKE 'J1'--NOT IN('J1')
GROUP BY JOB_CODE;

-- GROUP BY 실습문제 5
SELECT NVL(DEPT_CODE,'없음') AS 부서코드, DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여') AS 성별, COUNT(*) AS 인원
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

--실습문제 1

SELECT DEPT_CODE AS 부서코드,SUM(SALARY) AS 급여합계 FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE)
ORDER BY 1;

--실습문제 2
SELECT JOB_CODE AS 직급코드,SUM(SALARY) AS 급여합계 FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)
ORDER BY 1;

--실습문제 3
SELECT DEPT_CODE AS 직급코드,AVG(SALARY) AS 급여합계, COUNT(*) AS 합계 FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE)
HAVING AVG(SALARY) >=3000000 
ORDER BY 1;

----------------
--기존에는 부서별 혹은 직급별로 정보를 출력 하였음
-- 이번에는 부서내 직급별 인원 정보를 출력하고 싶다면?
SELECT DECODE(GROUPING(DEPT_CODE),1,'총계',DEPT_CODE) 부서코드, DECODE(GROUPING(JOB_CODE),1,'소계',JOB_CODE) 직급코드 ,COUNT(*) AS  직급별인원 FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE,JOB_CODE;

SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
ORDER BY 2;


-- 만약 부섭려이 아닌 직급별 집계와 총 집계를 보고 싶다면??
-- JOB_CODE 위치와 DEPT_CODE 위치를 바꿔주면 됨

SELECT JOB_CODE, DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE, DEPT_CODE;

--부서별 집계와 직급별 집계및 총 집계
SELECT JOB_CODE, DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE,DEPT_CODE)
ORDER BY 1 ;

-- CUBE는 그룹으로 지정된 모든 그룹에 대한 집계와 총 집게를 구함
-- 즉, 위에 코드를 보면 부서별 집계 이후에 직급별 집계를 진행하고 마지막으로
-- 총 집계를 구하게 됨

-- 직관적으로 이야기 하면!
-- ROLLUP 과 CUBE는 집계용 함수.
-- ROLLUP 은 가장 먼저 지정한 그룹별 집계 및 총 집계
-- CUBE 는 그룹으로 지정된 모든 그룹에 대한 집계 및 총 집계


-- 문제1
-- 부서내 직급별 급여 정보 출력 및 각 부서별 집계
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY) FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE,JOB_CODE)
ORDER BY DEPT_CODE;

-- 문제2
-- 부서내 직급별 급여 정보 출력 및 각 부서별 집계 및 직급별 집계
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY) FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1,2;


SELECT DECODE(GROUPING(DEPT_CODE),1,'총집계',NVL(DEPT_CODE,'없음')) AS 부서코드, COUNT(*) || '명' AS 인원 FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE)
ORDER BY 1;

SELECT DEPT_CODE, JOB_CODE,COUNT(*), GROUPING(DEPT_CODE), GROUPING(JOB_CODE)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1,2;

SELECT DECODE(GROUPING(DEPT_CODE),1,'직급별집계', NVL(DEPT_CODE,'부서없음'))AS 부서코드,
       DECODE(GROUPING(JOB_CODE),1,'부서별 집계',JOB_CODE) AS 직급코드, COUNT(*)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY 1,2;

SELECT CASE WHEN GROUPING(DEPT_CODE)=1 AND GROUPING(JOB_CODE) = 0 THEN '직급별 집계'
            WHEN GROUPING(DEPT_CODE) =1 AND GROUPING(JOB_CODE) = 1 THEN '총 집계'
            ELSE NVL(DEPT_CODE, '부서없음')
            END AS "부서코드",
       CASE WHEN GROUPING(DEPT_CODE)=0 AND GROUPING(JOB_CODE) = 1 THEN '부서별 집계'
            WHEN GROUPING(DEPT_CODE) =1 AND GROUPING(JOB_CODE) = 1 THEN '-'
            ELSE JOB_CODE
            END AS "직급코드",
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


