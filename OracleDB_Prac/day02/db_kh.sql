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

--3. EMPLOYEE 테이블에서 20년 이상 근속자의 이름,월급,보너스율를 출력하시오
SELECT EMP_NAME AS "이름", SALARY AS "월급",BONUS AS "보너스율" FROM EMPLOYEE
WHERE ((SYSDATE - HIRE_DATE)/365)>=20;










