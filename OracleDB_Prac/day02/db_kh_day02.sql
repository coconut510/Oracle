--@ 실습 문제
--1. JOB테이블에서 JOB_NAME의 정보만 출력되도록 하시오
SELECT JOB_NAME FROM JOB;
--2. DEPARTMENT테이블의 내용 전체를 출력하는 SELECT문을 작성하시오
SELECT * FROM DEPARTMENT;
/*3. EMPLOYEE 테이블에서 이름(EMP_NAME),이메일(EMAIL),전화번호(PHONE),고용일(HIRE_DATE)
만 출력하시오*/
SELECT EMP_NAME,EMAIL,PHONE,HIRE_DATE FROM EMPLOYEE;

--4. EMPLOYEE 테이블에서 고용일(HIRE_DATE) 이름(EMP_NAME),월급(SALARY)를 출력하시오
SELECT HIRE_DATE,EMP_NAME,SALARY FROM EMPLOYEE;

/*5. EMPLOYEE 테이블에서 월급(SALARY)이 2,500,000원이상인 사람의
 EMP_NAME 과 SAL_LEVEL을 출력하시오 (힌트 : >(크다) , <(작다) 를 이용)*/
SELECT EMP_NAME,SAL_LEVEL FROM EMPLOYEE WHERE SALARY>=2500000;

/*6. EMPLOYEE 테이블에서 월급(SALARY)이 350만원 이상이면서 
 JOB_CODE가 'J3' 인 사람의 이름(EMP_NAME)과 전화번호(PHONE)를 출력하시오
 (힌트 : AND(그리고) , OR (또는))*/
SELECT EMP_NAME,PHONE FROM EMPLOYEE WHERE SALARY>=3500000 AND JOB_CODE='J3';

-- 연봉 (월급 *12)Z`
SELECT EMP_NAME AS 이름, SALARY*12 AS "연봉(원)" , '원' AS "단위" FROM EMPLOYEE;

-- 보너스금액
SELECT SALARY * BONUS FROM EMPLOYEE;

-- 연봉 확인( 단, 매달 받는 보너스를 포함한 연봉)
SELECT EMP_NAME, (SALARY  + (SALARY * BONUS))*12 FROM EMPLOYEE;

--@ 실습 문제 2

--1. EMPLOYEE 테이블에서 이름,연봉, 총수령액(보너스포함), 실수령액(총 수령액-(월급*세금 3%))
--가 출력되도록 하시오
SELECT EMP_NAME AS "이름", SALARY*12 AS "연봉",
SALARY*(1+NVL(BONUS,0))*12 AS "총수령액(보너스포함)", 
(SALARY*(1+NVL(BONUS,0)-0.03)*12)  AS "실수령액"
FROM EMPLOYEE;

--2. EMPLOYEE 테이블에서 이름, 근무 일수를 출력해보시오 (SYSDATE를 사용하면 현재 시간 출력)
SELECT EMP_NAME AS "이름", CEIL((SYSDATE - HIRE_DATE)) AS "근무 일수" FROM EMPLOYEE;
--FLOOR 뒤의 자리수를 버림.
SELECT EMP_NAME AS "이름", FLOOR((SYSDATE - HIRE_DATE)) AS "근무 일수", '일' AS 단위 FROM EMPLOYEE;

--3. EMPLOYEE 테이블에서 20년 이상 근속자의 이름,월급,보너스율를 출력하시오
SELECT EMP_NAME AS "이름", SALARY AS "월급",NVL(BONUS,0) AS "보너스율" FROM EMPLOYEE
WHERE (FLOOR(SYSDATE - HIRE_DATE)/365)>=20;

SELECT DISTINCT NVL(DEPT_CODE,'없음') FROM EMPLOYEE;

SELECT EMP_NAME, SALARY||'원' AS "월급" FROM EMPLOYEE;
SELECT EMP_NAME, '폰번호 : '||PHONE AS "휴대폰" FROM EMPLOYEE; 
SELECT EMP_NAME, '급여 : '|| SALARY||'/보너스율 : '|| NVL(BONUS,0)*100 ||'%' AS "급여및보너스율" FROM EMPLOYEE;

SELECT EMP_NAME, SALARY FROM EMPLOYEE  WHERE 350000<= SALARY AND SALARY<=6000000;
SELECT EMP_NAME,SALARY FROM EMPLOYEE WHERE SALARY BETWEEN 3500000 AND 6000000;

SELECT * FROM EMPLOYEE WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

SELECT SALARY AS "급여" FROM EMPLOYEE
WHERE EMP_NAME = '전지연';

SELECT * FROM EMPLOYEE
WHERE PHONE LIKE '%3%';

SELECT * FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '이%';


--@ 실습 문제 3

--1. EMPLOYEE 테이블에서 이름 끝이 연으로 끝나는 사원의 이름을 출력하시오

SELECT * FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

--2. EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를
--출력하시오
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


--3. EMPLOYEE 테이블에서 메일주소 '_'의 앞이 4자이면서, DEPT_CODE가 D9 또는 D6이고
--고용일이 90/01/01 ~ 00/12/01이면서, 월급이 270만원이상인 사원의 전체 정보를 출력하시오

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

-- 부서원 중 직급코드가 J7또는 J2이고, 급여가 2,000,000 원 초과인 사람의
-- 이름, 급여, 직급코드를 출력.
SELECT EMP_NAME,SALARY,JOB_CODE FROM EMPLOYEE
WHERE JOB_CODE IN('J7','J2') AND SALARY > 2000000;

SELECT * FROM EMPLOYEE ORDER BY 2;

SELECT BONUS * SALARY FROM EMPLOYEE
ORDER BY 1;

--@ 실습 문제 4
---- 문제1. 
---- 입사일이 5년 이상, 10년 이하인 직원의 이름,주민번호,급여,입사일을 검색하여라

SELECT EMP_NAME AS 이름,EMP_NO AS 주민번호, SALARY AS 급여,HIRE_DATE AS 입사일 FROM EMPLOYEE
WHERE (SYSDATE - HIRE_DATE)/365  BETWEEN 5 AND 10; 

-- 문제2.
-- 재직중이 아닌 직원의 이름,부서코드를 검색하여라 (퇴사 여부 : ENT_YN)
SELECT EMP_NAME AS 이름,DEPT_CODE AS 부서코드, HIRE_DATE AS 입사일,FLOOR(ENT_DATE-HIRE_DATE) ||'일' AS 근무기간 , ENT_DATE AS 퇴사일 
FROM EMPLOYEE
WHERE ENT_DATE IS NOT NULL ;

-- 문제3.
-- 근속년수가 10년 이상인 직원들을 검색하여
-- 출력 결과는 이름,급여,근속년수(소수점X)를 근속년수가 오름차순으로 정렬하여 출력하여라
-- 단, 급여는 50% 인상된 급여로 출력되도록 하여라.

SELECT EMP_NAME AS 이름, SALARY*1.5 AS 급여, FLOOR((SYSDATE - HIRE_DATE)/365) AS 근속년수
FROM EMPLOYEE
WHERE FLOOR((SYSDATE - HIRE_DATE)/365)>=10 
ORDER BY 3;

-- 문제4.
-- 입사일이 99/01/01 ~ 10/01/01 인 사람 중에서 급여가 2000000 원 이하인 사람의
-- 이름,주민번호,이메일,폰번호,급여를 검색 하시오

SELECT EMP_NAME AS 이름, EMP_NO AS 주민번호, EMAIL AS 이메일, PHONE AS 폰번호, SALARY AS 급여
FROM EMPLOYEE
WHERE (HIRE_DATE BETWEEN '99/01/01' AND '10/01/01') AND
SALARY<=2000000;

-- 문제5.
-- 급여가 2000000원 ~ 3000000원 인 여직원 중에서 4월 생일자를 검색하여 
-- 이름,주민번호,급여,부서코드를 주민번호 순으로(내림차순) 출력하여라
-- 단, 부서코드가 null인 사람은 부서코드가 '없음' 으로 출력 하여라.

SELECT EMP_NAME AS 이름, EMP_NO AS 주민번호,SALARY AS 급여, NVL(DEPT_CODE,'없음') AS 부서코드
FROM EMPLOYEE
WHERE (SALARY BETWEEN 2000000 AND 3000000)AND
EMP_NO LIKE '___4___2%' --AND EMP_NO LIKE '___4%'
ORDER BY EMP_NO DESC;

-- 문제6.
-- 남자 사원 중 보너스가 없는 사원의 오늘까지 근무일을 측정하여 
-- 1000일 마다(소수점 제외) 
-- 급여의 10% 보너스를 계산하여 이름,특별 보너스 (계산 금액) 결과를 출력하여라.
-- 단, 이름 순으로 오름 차순 정렬하여 출력하여라.
SELECT EMP_NAME AS 이름, FLOOR((SYSDATE - HIRE_DATE)/1000) * SALARY*0.1||'원' AS "특별 보너스"
FROM EMPLOYEE
WHERE BONUS IS NULL AND 
EMP_NO LIKE '_______1%'
ORDER BY EMP_NAME;

SELECT EMAIL, LENGTH(EMAIL) AS "이메일 길이"
FROM EMPLOYEE;





--------------------다시 풀어보기 ------------------------
--1-1번
--1. JOB테이블에서 JOB_NAME의 정보만 출력되도록 하시오
SELECT JOB_NAME FROM JOB;
--1-2번
--2. DEPARTMENT테이블의 내용 전체를 출력하는 SELECT문을 작성하시오
SELECT * FROM DEPARTMENT;
--1-3번
--3. EMPLOYEE 테이블에서 이름(EMP_NAME),이메일(EMAIL),전화번호(PHONE),고용일(HIRE_DATE)
--  만 출력하시오
SELECT EMP_NAME,EMAIL,PHONE,HIRE_DATE FROM EMPLOYEE;
--1-4번
--4. EMPLOYEE 테이블에서 고용일(HIRE_DATE) 이름(EMP_NAME),월급(SALARY)를 출력하시오
SELECT HIRE_DATE,EMP_NAME,SALARY FROM EMPLOYEE;

--1-5번
--5. EMPLOYEE 테이블에서 월급(SALARY)이 2,500,000원이상인 사람의
-- EMP_NAME 과 SAL_LEVEL을 출력하시오 (힌트 : >(크다) , <(작다) 를 이용)
SELECT EMP_NAME,SAL_LEVEL FROM EMPLOYEE
WHERE SALARY>=2500000;

--1-6번
--6. EMPLOYEE 테이블에서 월급(SALARY)이 350만원 이상이면서 
-- JOB_CODE가 'J3' 인 사람의 이름(EMP_NAME)과 전화번호(PHONE)를 출력하시오
-- (힌트 : AND(그리고) , OR (또는))
SELECT EMP_NAME, PHONE FROM EMPLOYEE
WHERE SALARY>=3500000 AND JOB_CODE = 'J3';

--2-1번
--1. EMPLOYEE 테이블에서 이름,연봉, 총수령액(보너스포함), 
--실수령액(총 수령액-(월급*세금 3%))가 출력되도록 하시오
SELECT EMP_NAME AS 이름, SALARY*12 AS 연봉, (SALARY * NVL(BONUS,0))*12  AS 총수령액(보너스포함),
SALARY*(1+NVL(BONUS,0)-0.03)*12 AS 실수령액
FROM EMPLOYEE;

--2-2번
--2. EMPLOYEE 테이블에서 이름, 근무 일수를 출력해보시오 
--(SYSDATE를 사용하면 현재 시간 출력)
SELECT EMP_NAME AS 이름, (SYSDATE - HIRE_DATE) AS 근무 일수 FROM EMPLOYEE;

--2-3번
--3. EMPLOYEE 테이블에서 20년 이상 근속자의 이름,월급,보너스율를 출력하시오
SELECT EMP_NAME AS 이름, SALARY AS 월급,NVL(BONUS,0) * 100 ||'%' AS 보너스율 FROM EMPLOYEE;

--3-1번
--1. EMPLOYEE 테이블에서 이름 끝이 연으로 끝나는 사원의 이름을 출력하시오
SELECT EMP_NAME AS 이름 FROM EMPLOYEE
WHERE EMP_NAME  LIKE '%연';

--3-2번
--2. EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를
--출력하시오
SELECT EMP_NAME AS 이름,PHONE AS 전화번호 FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--3-3번
--3. EMPLOYEE 테이블에서 메일주소의 's'가 들어가면서, DEPT_CODE가 D9 또는 D6이고
--고용일이 90/01/01 ~ 00/12/01이면서, 월급이 270만원이상인 사원의 전체 정보를 출력하시오
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '%s%' AND DEPT_CODE IN('D9','D6') AND
HIRE_DATE BETWEEN '90/01/01' AND '00/12/01' AND
SALARY >=2700000;

--4-1번
-- 문제1. 
-- 입사일이 5년 이상, 10년 이하인 직원의 이름,주민번호,급여,입사일을 검색하여라
SELECT EMP_NAME AS 이름,EMP_NO AS 주민번호,SALARY AS 급여,HIRE_DATE AS 입사일 FROM EMPLOYEE
WHERE (SYSDATE - HIRE_DATE)/365 BETWEEN 5 AND 10;

--4-2번
-- 문제2.
-- 재직중이 아닌 직원의 이름,부서코드를 검색하여라 (퇴사 여부 : ENT_YN)
SELECT EMP_NAME AS 이름,DEPT_CODE AS 부서코드 FROM EMPLOYEE
WHERE ENT_YN = 'N';

--4-3번
-- 문제3.
-- 근속년수가 10년 이상인 직원들을 검색하여
-- 출력 결과는 이름,급여,근속년수(소수점X)를 근속년수가 오름차순으로 정렬하여 출력하여라
-- 단, 급여는 50% 인상된 급여로 출력되도록 하여라.
SELECT EMP_NAME AS 이름,SALARY * 1.5 AS 급여,FLOOR((ENT_DATE - HIRE_DATE)/365) AS 근속년수 FROM EMPLOYEE
WHERE FLOOR((ENT_DATE - HIRE_DATE)/365)>=10;

--4-4번
-- 입사일이 99/01/01 ~ 10/01/01 인 사람 중에서 급여가 2000000 원 이하인 사람의
-- 이름,주민번호,이메일,폰번호,급여를 검색 하시오
SELECT EMP_NAME AS 이름,EMP_NO AS 주민번호,EMAIL AS 이메일,PHONE AS 폰번호,SALARY AS 급여 FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '99/01/01' AND '10/01/01' AND
SALARY<=2000000;

--4-5번
-- 문제5.
-- 급여가 2000000원 ~ 3000000원 인 여직원 중에서 4월 생일자를 검색하여 
-- 이름,주민번호,급여,부서코드를 주민번호 순으로(내림차순) 출력하여라
-- 단, 부서코드가 null인 사람은 부서코드가 '없음' 으로 출력 하여라.
SELECT EMP_NAME AS 이름,EMP_NO AS 주민번호,SALARY AS 급여,NVL(DEPT_CODE,'없음') AS 부서코드 FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000 AND
EMP_NO LIKE '___4___2%'
ORDER BY EMP_NO DESC;

--4-6번
-- 문제6.
-- 남자 사원 중 보너스가 없는 사원의 오늘까지 입사일을 측정하여 
-- 1000일 마다(소수점 제외) 
-- 급여의 10% 보너스를 계산하여 이름,특별 보너스 (계산 금액) 결과를 출력하여라.
-- 단, 이름 순으로 오름 차순 정렬하여 출력하여라.
SELECT EMP_NAME AS 이름, FLOOR((SYSDATE - HIRE_DATE)/1000)*SALARY * 0.1 AS 특별보너스 FROM EMPLOYEE
WHERE BONUS IS NULL
ORDER BY EMP_NAME;