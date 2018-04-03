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
    WHERE EMP_NAME = '하이유';
    DBMS_OUTPUT.PUT_LINE(ID);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다.!');
END;
/

DECLARE
    ID NUMBER;
BEGIN
    SELECT EMP_ID
    INTO ID
    FROM EMPLOYEE
    WHERE EMP_NAME = '&이름';
    DBMS_OUTPUT.PUT_LINE(ID);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다.!');
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
    WHERE EMP_NAME = '&이름';
    DBMS_OUTPUT.PUT_LINE(ID);
    DBMS_OUTPUT.PUT_LINE(NAME);
    DBMS_OUTPUT.PUT_LINE(NO);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다.!');
END;
/
-- 해당 사원의 사원번호를 입력시
-- 이름, 부서명, 직급명이 출력 되도록 PL/SQL로 만들어 보시오.

DECLARE
    NAME VARCHAR2(20);
    DEPT_NAME VARCHAR2(30);
    JOB_NAME VARCHAR2(20);
BEGIN
    SELECT EMP_NAME,DEPT_TITLE, JOB_NAME
    INTO NAME,DEPT_NAME,JOB_NAME
    FROM EMPLOYEE E JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
                    JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
    WHERE EMP_ID  = '&사원번호';
    DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' ||DEPT_NAME);
    DBMS_OUTPUT.PUT_LINE('직급명 : ' ||JOB_NAME);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다.');
END;
/

-- 해당 사원의 사원번호를 입력시
-- 이름, 부서코드, 직급 코드가 출력되도록 PL/SQL로 만들어 보시오.
DECLARE
    NAME VARCHAR2(20);
    DEPT_NAME VARCHAR2(30);
    JOB_NAME VARCHAR2(20);
BEGIN
    SELECT EMP_NAME,DEPT_CODE, JOB_CODE
    INTO NAME,DEPT_NAME,JOB_NAME
    FROM EMPLOYEE 
    WHERE EMP_ID  = '&사원번호';
    DBMS_OUTPUT.PUT_LINE(NAME);
    DBMS_OUTPUT.PUT_LINE(DEPT_NAME);
    DBMS_OUTPUT.PUT_LINE(JOB_NAME);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다.');
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
    WHERE EMP_NAME = '선동일';
    
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
    WHERE EMP_NAME = '&이름';
    DBMS_OUTPUT.PUT_LINE('사원번호 : '||ID);
    DBMS_OUTPUT.PUT_LINE('사원이름 : '||NAME);
    DBMS_OUTPUT.PUT_LINE('주민번호 : '||NO);
    DBMS_OUTPUT.PUT_LINE('급여 : '||SALARY);
    DBMS_OUTPUT.PUT_LINE('입사일 : '||HIRE_DATE);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다');
END;
/

DECLARE
    EMP EMPLOYEE%ROWTYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, EMP_NO 
    INTO EMP.EMP_ID,EMP.EMP_NAME, EMP.EMP_NO
    FROM EMPLOYEE
    WHERE EMP_ID = '200';
    DBMS_OUTPUT.PUT_LINE('사원번호 : ' ||EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('사원명 : ' ||EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('주민번호 : ' ||EMP.EMP_NO);
    
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다!');
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
    THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다.!');
END;
/





--@실습문제1
--사번, 사원명, 직급코드, 급여를 담을수 있는 참조변수를 통해서 (%TYPE)
--송종기사원의 사번, 사원명, 직급코드,급여를 익명블럭을 통해 스크립트 출력하세요.
DECLARE
    ID EMPLOYEE.EMP_ID%TYPE;
    NAME EMPLOYEE.EMP_NAME%TYPE;
    J_CODE EMPLOYEE.JOB_CODE%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
    INTO ID, NAME, J_CODE, SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME = '&이름';
    DBMS_OUTPUT.PUT_LINE('사번 : ' || ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('직급코드 : ' || J_CODE);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다!');
END;
/
--@실습문제2
--사번, 사원명, 직급명을 담을수 있는 참조변수를 통해서 (record)
-- 사원명을 검색하여 해당 사원의 사번, 사원명, 부서명,직급명을 
-- 익명블럭을 통해 스크립트 출력하세요.
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
    WHERE EMP_NAME = '&이름';
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP.ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP.NAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || NVL(EMP.D_TITLE,'없음'));
    DBMS_OUTPUT.PUT_LINE('직급명 : ' || EMP.JOB_NAME);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다!');
END;
/


--@실습문제3
-- 사원번호를 입력하여 해당 사원을 찾아  (%ROWTYPE을 사용)
-- 사원명, 주민번호, 입사일, 부서명을 
-- 익명블럭을 통해 스크립트 출력하세요.

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DEP DEPARTMENT%ROWTYPE;
BEGIN
    SELECT EMP_NAME,EMP_NO, HIRE_DATE, DEPT_TITLE
    INTO EMP.EMP_NAME, EMP.EMP_NO, EMP.HIRE_DATE, DEP.DEPT_TITLE
    FROM EMPLOYEE LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = '&사원번호';
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('주민번호 : ' || EMP.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('입사일 : ' || EMP.HIRE_DATE);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || NVL(DEP.DEPT_TITLE,'없음'));
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다!');
END;
/

--사원 번호를 가지고 사원의 사번, 이름, 급여, 보너스율을 출력하고
-- 보너스율이 없으면 '보너스를 지급받지 않는 사원입니다.' 를 출력 하려면?
-- 1. 사원번호를 가지고 해당 사원의 사번, 이름, 급여, 보너스율을 출력
-- 2. 보너스율이 0% 라면?
--      -> 보너스를 지급받지 않는 사원입니다.

DECLARE
    EMP EMPLOYEE%ROWTYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO EMP.EMP_ID, EMP.EMP_NAME, EMP.SALARY, EMP.BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = '&사원번호';
    DBMS_OUTPUT.PUT_LINE('사번 : ' ||EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' ||EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' ||EMP.SALARY);
    DBMS_OUTPUT.PUT_LINE('보너스 : ' ||EMP.BONUS * 100 ||'%');
    IF(EMP.BONUS = 0)
    THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    END IF;
END;
/

--사원 번호를 가지고 사원의 사번, 이름, 급여, 보너스율을 출력 함
	-- 이때 ,  보너스율이 없으면 '보너스를 지급받지 않는 사원입니다.' 를 
 	-- 출력하고 보너스율이 있다면 보너스율을 출력함
	-- (즉, 보너스율이 0%라면 보너스율을 출력하지 않음)

DECLARE
    EMP EMPLOYEE%ROWTYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO EMP.EMP_ID, EMP.EMP_NAME, EMP.SALARY, EMP.BONUS
    FROM EMPLOYEE
     WHERE EMP_ID = '&사원번호';
    DBMS_OUTPUT.PUT_LINE('사번 : ' ||EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' ||EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' ||EMP.SALARY);
    DBMS_OUTPUT.PUT_LINE('보너스 : ' ||EMP.BONUS * 100 ||'%');
    IF(EMP.BONUS = 0)
    THEN  DBMS_OUTPUT.PUT_LINE('보너스를 받지 않는 사원입니다.');
    ELSE  DBMS_OUTPUT.PUT_LINE('보너스 : ' ||EMP.BONUS * 100 ||'%');
    END IF;
END;
/


-- 사원번호를 가지고 해당 사원을 조회
-- 이때 사원명, 부서명을 출력하여라.
-- 만약 부서가 없다면 부서명을 출력하지 않고,
-- '부서가 없는 사원입니다' 를 출력하고
-- 부서가 있다면 부서명을 출력하여라
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DEP DEPARTMENT%ROWTYPE;
BEGIN
    SELECT EMP_NAME, DEPT_TITLE
    INTO EMP.EMP_NAME, DEP.DEPT_TITLE
    FROM EMPLOYEE LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = '&사원번호';
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || EMP.EMP_NAME);
    IF(DEP.DEPT_TITLE IS NULL)
    THEN DBMS_OUTPUT.PUT_LINE('부서가 없는 사원입니다.');
    ELSE DBMS_OUTPUT.PUT_LINE('부서명 : ' || DEP.DEPT_TITLE);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다!');
END;
/


--  문제 2
-- 사원 코드를 입력 받았을때 사번, 이름, 부서코드, 부서명, 소속 값을 출력하시오
-- 그때, 소속값은 J1, J2 는 임원진, 그외에는 일반직원으로 출력되게 하시오

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DEP DEPARTMENT%ROWTYPE;
    TEAM VARCHAR2(20);
BEGIN
    SELECT EMP_NO, EMP_NAME, DEPT_CODE, DEPT_TITLE, JOB_CODE
    INTO EMP.EMP_NO, EMP.EMP_NAME, EMP.DEPT_CODE, DEP.DEPT_TITLE, EMP.JOB_CODE
    FROM EMPLOYEE LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = '&사원코드';
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서코드 : ' || NVL(EMP.DEPT_CODE,'없음')); 
    DBMS_OUTPUT.PUT_LINE('부서이름 : ' || NVL(DEP.DEPT_TITLE,'없음'));
    IF(EMP.JOB_CODE IN ('J1','J2'))
    THEN DBMS_OUTPUT.PUT_LINE('소속값 : 임원진');
    ELSE DBMS_OUTPUT.PUT_LINE('소속값 : 일반직원');
    END IF;
END;
/
--실습2번
--사원번호로 사원을 조회하였을때
--	급여레벨 S1, S2 인 경우는 고임금
--	급여레벨 S3,S4 인 경우에는 평균임금
--	급여레벨 S5,S6인 경우에는 저임금
--	로 출력 될 수 있도록 하여라.  
DECLARE
    SALLEVEL EMPLOYEE.SAL_LEVEL%TYPE;
BEGIN
    SELECT SAL_LEVEL 
    INTO SALLEVEL
    FROM EMPLOYEE
    WHERE EMP_ID = '&사원번호';
    
    IF(SALLEVEL IN ('S1','S2')) THEN DBMS_OUTPUT.PUT_LINE('고임금');
    ELSIF(SALLEVEL IN ('S3','S4')) THEN DBMS_OUTPUT.PUT_LINE('평균임금');
    ELSIF(SALLEVEL IN ('S5','S6')) THEN DBMS_OUTPUT.PUT_LINE('저임금');
    ELSE DBMS_OUTPUT.PUT_LINE('열정페이...');
    END IF;
END;
/

--## 실습 3 ##
--사번을 입력 받은 후 급여에 따라 등급을 나누어 출력하도록 하시오 
--그때 출력 값은 사번,이름,급여,급여등급을 출력하시오
--
--0만원 ~ 99만원 : F
--100만원 ~ 199만원 : E
--200만원 ~ 299만원 : D
--300만원 ~ 399만원 : C
--400만원 ~ 499만원 : B
--500만원 이상(그외) : A
--
--ex) 200
--사번 : 200
--이름 : 선동일
--급여 : 8000000
--등급 : A



DECLARE
    EMP EMPLOYEE%ROWTYPE;
    SGRADE VARCHAR2(1);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EMP.EMP_ID, EMP.EMP_NAME, EMP.SALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번입력';
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || EMP.SALARY);
    
    IF(EMP.SALARY BETWEEN 0 AND 990000) THEN SGRADE :='F';
    ELSIF(EMP.SALARY BETWEEN 1000000 AND 1990000) THEN SGRADE :='E';
    ELSIF(EMP.SALARY BETWEEN 2000000 AND 2990000) THEN SGRADE :='D';
    ELSIF(EMP.SALARY BETWEEN 3000000 AND 3990000) THEN SGRADE :='C';
    ELSIF(EMP.SALARY BETWEEN 4000000 AND 4990000) THEN SGRADE :='B';
    ELSE SGRADE := 'A';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || SGRADE);
END;
/

DECLARE
    DATA NUMBER;
BEGIN
    DATA:= '&DATA값';
    CASE DATA
        WHEN 1 THEN
            DBMS_OUTPUT.PUT_LINE('안녕하세요');
        WHEN 2 THEN
            DBMS_OUTPUT.PUT_LINE('반갑습니다');
        WHEN 3 THEN
            DBMS_OUTPUT.PUT_LINE('행복하세요');
        ELSE
            DBMS_OUTPUT.PUT_LINE('잘못 입력하셨습니다.');
        END CASE;
END;
/


--## 실습문제 4번
--사번을 입력 받은 후 급여에 따라 등급을 나누어 출력하도록 하시오 
--그때 출력 값은 사번,이름,급여,급여등급을 출력하시오(CASE 사용)
--
--0만원 ~ 99만원 : F
--100만원 ~ 199만원 : E
--200만원 ~ 299만원 : D
--300만원 ~ 399만원 : C
--400만원 ~ 499만원 : B
--500만원 이상(그외) : A
--
--ex) 200
--사번 : 200
--이름 : 선동일
--급여 : 8000000
--등급 : A

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    SGRADE VARCHAR2(1);
    DATA NUMBER;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EMP.EMP_ID, EMP.EMP_NAME, EMP.SALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번입력';
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || EMP.SALARY);
    DATA := CEIL(EMP.SALARY/1000000);
      CASE  DATA
        WHEN 1 THEN SGRADE :='F';
        WHEN 2 THEN SGRADE :='E';
        WHEN 3 THEN SGRADE :='D';
        WHEN 4 THEN SGRADE :='C';
        WHEN 5 THEN SGRADE :='B';
        ELSE SGRADE := 'A';
        END CASE;     
    DBMS_OUTPUT.PUT_LINE('사번 : ' || SGRADE);
END;
/

SELECT * FROM EMPLOYEE;


-----------------------다시하기 숙제-----------------------
--@실습문제1
--사번, 사원명, 직급코드, 급여를 담을수 있는 참조변수를 통해서 (%TYPE)
--송종기사원의 사번, 사원명, 직급코드,급여를 익명블럭을 통해 스크립트 출력하세요.
DECLARE
    ID EMPLOYEE.EMP_ID%TYPE;
    NAME EMPLOYEE.EMP_NAME%TYPE;
    J_CODE EMPLOYEE.JOB_CODE%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
    INTO ID, NAME, J_CODE, SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME = '&이름';
    DBMS_OUTPUT.PUT_LINE('사번 : ' || ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('직급코드 : ' || J_CODE);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다!');
END;
/
--@실습문제2
--사번, 사원명, 부서명,직급명을 담을수 있는 참조변수를 통해서 (record)
-- 사원명을 검색하여 해당 사원의 사번, 사원명, 부서명,직급명을 
-- 익명블럭을 통해 스크립트 출력하세요.
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
    WHERE EMP_NAME = '&이름';
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP.ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP.NAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || NVL(EMP.D_TITLE,'없음'));
    DBMS_OUTPUT.PUT_LINE('직급명 : ' || EMP.JOB_NAME);
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다!');
END;
/
--@실습문제3
-- 사원번호를 입력하여 해당 사원을 찾아  (%ROWTYPE을 사용)
-- 사원명, 주민번호, 입사일, 부서명을 
-- 익명블럭을 통해 스크립트 출력하세요.

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DEP DEPARTMENT%ROWTYPE;
BEGIN
    SELECT EMP_NAME,EMP_NO, HIRE_DATE, DEPT_TITLE
    INTO EMP.EMP_NAME, EMP.EMP_NO, EMP.HIRE_DATE, DEP.DEPT_TITLE
    FROM EMPLOYEE LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = '&사원번호';
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('주민번호 : ' || EMP.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('입사일 : ' || EMP.HIRE_DATE);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || NVL(DEP.DEPT_TITLE,'없음'));
EXCEPTION
    WHEN NO_DATA_FOUND
    THEN DBMS_OUTPUT.PUT_LINE('데이터가 없습니다!');
END;
/

## 실습 1 ##


-- 사원 번호를 가지고 해당 사원을 조회
-- 이때 사원명,부서명 을 출력하여라.
-- 만약 부서가 없다면 부서명을 출력하지 않고,
-- '부서가 없는 사원 입니다' 를 출력하고
-- 부서가 있다면 부서명을 출력하여라.


----IF----
--## 실습 2 ##
--
--사원 코드를 입력 받았을때 사번,이름,부서코드,부서명,소속 값을 출력하시오
--그때, 소속값은 J1,J2 는 임원진, 그외에는 일반직원으로 출력되게 하시오

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DEP DEPARTMENT%ROWTYPE;
    TEAM VARCHAR2(20);
BEGIN
    SELECT EMP_NO, EMP_NAME, DEPT_CODE, DEPT_TITLE, JOB_CODE
    INTO EMP.EMP_NO, EMP.EMP_NAME, EMP.DEPT_CODE, DEP.DEPT_TITLE, EMP.JOB_CODE
    FROM EMPLOYEE LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = '&사원코드';
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서코드 : ' || NVL(EMP.DEPT_CODE,'없음')); 
    DBMS_OUTPUT.PUT_LINE('부서이름 : ' || NVL(DEP.DEPT_TITLE,'없음'));
    IF(EMP.JOB_CODE IN ('J1','J2'))
    THEN DBMS_OUTPUT.PUT_LINE('소속값 : 임원진');
    ELSE DBMS_OUTPUT.PUT_LINE('소속값 : 일반직원');
    END IF;
END;
/



--## 실습 3 ##
--사번을 입력 받은 후 급여에 따라 등급을 나누어 출력하도록 하시오 
--그때 출력 값은 사번,이름,급여,급여등급을 출력하시오
--
--0만원 ~ 99만원 : F
--100만원 ~ 199만원 : E
--200만원 ~ 299만원 : D
--300만원 ~ 399만원 : C
--400만원 ~ 499만원 : B
--500만원 이상(그외) : A
--
--ex) 200
--사번 : 200
--이름 : 선동일
--급여 : 8000000
--등급 : A


DECLARE
    EMP EMPLOYEE%ROWTYPE;
    SGRADE VARCHAR2(1);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EMP.EMP_ID, EMP.EMP_NAME, EMP.SALARY
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번입력';
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || EMP.SALARY);
    
    IF(EMP.SALARY BETWEEN 0 AND 990000) THEN SGRADE :='F';
    ELSIF(EMP.SALARY BETWEEN 1000000 AND 1990000) THEN SGRADE :='E';
    ELSIF(EMP.SALARY BETWEEN 2000000 AND 2990000) THEN SGRADE :='D';
    ELSIF(EMP.SALARY BETWEEN 3000000 AND 3990000) THEN SGRADE :='C';
    ELSIF(EMP.SALARY BETWEEN 4000000 AND 4990000) THEN SGRADE :='B';
    ELSE SGRADE := 'A';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || SGRADE);
END;
/

--## 실습문제 1 ##
-- 사원번호를 입력받아서 사원의 사번,이름,급여,보너스율을 출력히자.
-- (추가)대표님인 경우, '저희회사 대표님이십니다.'를 출력. (직급코드변수 추가.)
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    GRADE VARCHAR2(10);
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, BONUS, JOB_NAME
    INTO EMP.EMP_ID, EMP.EMP_NAME, EMP.SALARY, EMP.BONUS,GRADE
    FROM EMPLOYEE E JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
    WHERE EMP_ID = '&사원번호';  
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || EMP.SALARY);
    DBMS_OUTPUT.PUT_LINE('보너스율 : ' || EMP.BONUS * 100 ||'%');
    IF(GRADE = '대표')
    THEN DBMS_OUTPUT.PUT_LINE('저희회사 대표님이십니다.');
    END IF;
END;
/
--## 실습문제 2 ##
-- 해당 사원 번호를 입력받아 해당 사원이 소속된 부서에서 
-- 가장 높은 급여를 받고 있는 사원을 출력하여라
-- 출력 값은 
-- 검색된 사원명, 검색된 사원 부서, 
-- 소속부서에서 가장 높은 급여를 받은 사원명 및 급여,부서 정보를 출력 하여라.
--ex) 
--사원번호 '207'번을 입력시
--### 검색된 사원 정보 ###
--검색된 사원명 : 하이유
--소속된 부서명 : 해외영업1부
---------------------------------
--### 해외영업1부에서 급여가 가장 높은 사원 정보 ###
--사원명 : 대북혼
--급여 : 3760000 원
--소속된 부서 : 해외영업1부

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
    WHERE EMP_ID = '&사원번호';   
    
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || DEP.DEPT_TITLE);

    SELECT EMP_NAME, SALARY, DEPT_TITLE
    INTO NAME, SALARY, DEPT
    FROM EMPLOYEE E LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
    WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE E1
                        WHERE NVL(E.DEPT_CODE,'없음') = NVL(E1.DEPT_CODE,'없음')
                        GROUP BY DEPT_CODE)
         AND DEPT_TITLE = DEP.DEPT_TITLE;
    
    DBMS_OUTPUT.PUT_LINE('사원명 : ' || NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY);
    DBMS_OUTPUT.PUT_LINE('소속부서 : ' || DEPT);
  
END;
/
 
SELECT EMP_NAME, SALARY, DEPT_TITLE
    FROM EMPLOYEE E LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
    WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE E1
                        WHERE NVL(E.DEPT_CODE,'없음') = NVL(E1.DEPT_CODE,'없음')
                        GROUP BY DEPT_CODE);
         AND DEPT_TITLE = DEP.DEPT_TITLE;


SELECT EMP_NAME, SALARY, DEPT_TITLE
    FROM EMPLOYEE E LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
    WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE E1
                        WHERE NVL(E.DEPT_CODE,'없음') = NVL(E1.DEPT_CODE,'없음')
                        GROUP BY DEPT_CODE);

SELECT MAX(SALARY) FROM EMPLOYEE E2 
                        GROUP BY E2.DEPT_CODE;