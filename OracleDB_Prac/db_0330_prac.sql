SELECT * FROM TB_CLASS;
SELECT * FROM TB_CLASS_PROFESSOR;
SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_STUDENT;

--[BASIC SELECT]
--1.
SELECT DEPARTMENT_NAME AS 학과명, CATEGORY FROM TB_DEPARTMENT;

--2. 
SELECT DEPARTMENT_NAME || '의 정원은' || CAPACITY || '명입니다.' FROM TB_DEPARTMENT;
--SELECT DEPARTMENT_NAME  || '의 정원은'||
--(SELECT COUNT(*) FROM TB_STUDENT S WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO) || '명입니다.'
--AS 학과별정원
--FROM  TB_DEPARTMENT D;


--3.
SELECT STUDENT_NAME FROM TB_STUDENT S
WHERE S.DEPARTMENT_NO = 
                   (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT
                    WHERE DEPARTMENT_NAME = '국어국문학과')
      AND S.ABSENCE_YN LIKE 'Y';


--4.
SELECT STUDENT_NAME AS 도서관연체학생 FROM TB_STUDENT
WHERE STUDENT_NO IN('A513079', 'A513090', 'A513091', 'A513110', 'A513119');

--5.
SELECT DEPARTMENT_NAME AS 학과이름, CATEGORY AS 계열
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;


--(SELECT COUNT(*) FROM TB_STUDENT S  
--                WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO
--                GROUP BY S.DEPARTMENT_NO) = 10;
--       BETWEEN 20 AND 30;


--SELECT COUNT(*) FROM TB_STUDENT S 
--WHERE DEPARTMENT_NO = '001' GROUP BY DEPARTMENT_NO;

--6.
SELECT PROFESSOR_NAME AS 총장이름
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

--7.
SELECT STUDENT_NAME, DEPARTMENT_NO AS 학과없는학생
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

--8.
SELECT CLASS_NO AS 과목번호
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

--9.
SELECT CATEGORY AS 계열
FROM TB_DEPARTMENT
GROUP BY CATEGORY;

--10.
SELECT STUDENT_NO AS 학번, STUDENT_NAME AS 이름, STUDENT_SSN AS 주민번호,SUBSTR(STUDENT_NO,1,3)
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_NO,1,2) LIKE 'A2'
      AND ABSENCE_YN = 'Y';

--[Additional SELECT - 함수]

--1.
SELECT STUDENT_NO AS 학번 , STUDENT_NAME AS 이름, ENTRANCE_DATE AS 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO LIKE '002'
ORDER BY 입학년도;

--2.
SELECT PROFESSOR_NAME AS 이름, PROFESSOR_SSN AS 주민번호
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) !=3;

--3.
SELECT PROFESSOR_NAME AS 교수이름, EXTRACT(YEAR FROM SYSDATE)  - (1900 + SUBSTR(PROFESSOR_SSN,1,2)) AS 나이
FROM TB_PROFESSOR
ORDER BY 나이;

--4.
SELECT CASE WHEN LENGTH(PROFESSOR_NAME) = 4 THEN '없음' 
            ELSE SUBSTR(PROFESSOR_NAME,2,2) 
            END AS 이름
FROM TB_PROFESSOR;

--5.
SELECT STUDENT_NO AS 학번, STUDENT_NAME AS 이름
FROM TB_STUDENT
WHERE (EXTRACT(YEAR FROM ENTRANCE_DATE)  - (1900 + SUBSTR(STUDENT_SSN,1,2))) >19;

--6.
SELECT TO_CHAR(TO_DATE('20/12/25'),'DAY') AS "2020년크리스마스" FROM DUAL;

--7.
SELECT TO_CHAR(TO_DATE('99/10/11','YY/MM/DD'),'YY"년"MM"월"DD"일"') AS 년월일,
         TO_CHAR(TO_DATE('49/10/11','YY/MM/DD'),'YY"년"MM"월"DD"일"') AS 년월일1,
          TO_CHAR(TO_DATE('99/10/11','RR/MM/DD'),'YY"년"MM"월"DD"일"') AS 년월일2,
           TO_CHAR(TO_DATE('49/10/11','RR/MM/DD') ,'YY"년"MM"월"DD"일"') AS 년월일3
         FROM DUAL;
         
--8.
SELECT STUDENT_NO AS 학번, STUDENT_NAME AS 이름
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_NO,1,1) != 'A';

--9.
SELECT TO_CHAR(AVG(G.POINT),'999.9') AS 평점
FROM TB_GRADE G
WHERE G.STUDENT_NO = (SELECT STUDENT_NO FROM TB_STUDENT WHERE STUDENT_NO LIKE 'A517178');
         
--10.
SELECT DEPARTMENT_NO AS 학과번호,
               (SELECT COUNT(*) FROM TB_STUDENT S WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO) AS "학생수(명)"
FROM TB_DEPARTMENT D;

--11.
SELECT COUNT(*) AS 교수미배정학생
FROM TB_STUDENTA
WHERE COACH_PROFESSOR_NO IS NULL;
         
         
--12.
SELECT SUBSTR(TERM_NO,1,4) AS 년도, TO_CHAR(AVG(POINT),'999.9') AS 년도별평점
FROM TB_GRADE G
WHERE G.STUDENT_NO = (SELECT S.STUDENT_NO FROM TB_STUDENT S WHERE STUDENT_NO LIKE 'A112113')
GROUP BY SUBSTR(TERM_NO,1,4); 


--13.
SELECT S.DEPARTMENT_NO AS 학과코드명,  (SELECT COUNT(*) FROM TB_STUDENT S1
                                     WHERE S1.ABSENCE_YN LIKE 'Y'
                                    AND S1.DEPARTMENT_NO = S.DEPARTMENT_NO) AS 휴학생수
                                    --SUM(DECODE(S.ABSENCE_YN, 'Y',1,0))
FROM TB_STUDENT S
GROUP BY S.DEPARTMENT_NO
ORDER BY 학과코드명;
         
--14.
SELECT STUDENT_NAME AS 동일이름, COUNT(*) AS 동명인수
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*)>=2;

--15.
SELECT NVL(SUBSTR(TERM_NO,1,4),' ') AS 년도,NVL(SUBSTR(TERM_NO,5,2),' ') AS 학기,
        ROUND(AVG(POINT),1) AS 평점
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4),SUBSTR(TERM_NO,5,2)) ;
   
--[Additional SELECT - Option]         
--1.         
SELECT STUDENT_NAME AS 학생이름, STUDENT_ADDRESS AS 주소지
FROM TB_STUDENT
ORDER BY 학생이름;
         
--2.
SELECT STUDENT_NAME AS 학생이름, STUDENT_SSN AS 주민번호 
FROM TB_STUDENT
WHERE ABSENCE_YN LIKE 'Y'
ORDER BY SUBSTR(STUDENT_SSN,1,6) DESC;
         
--3.
SELECT STUDENT_NAME AS 학생이름, STUDENT_NO AS 학번,STUDENT_ADDRESS AS 거주지주소
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_ADDRESS, 1,3) IN ('경기도','강원도')
      AND SUBSTR(STUDENT_NO,1,1) LIKE 9
ORDER BY 학생이름;
         
--4.
SELECT PROFESSOR_NAME , PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = '법학과')
ORDER BY SUBSTR(PROFESSOR_SSN,1,6);

--5.
SELECT STUDENT_NO , POINT
FROM TB_GRADE
WHERE CLASS_NO = 'C3118100'
    AND SUBSTR(TERM_NO,1,6) = '200402'
    ORDER BY POINT DESC, STUDENT_NO;
         
--6.
SELECT STUDENT_NO, STUDENT_NAME, (SELECT DEPARTMENT_NAME
                                FROM TB_DEPARTMENT D WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO)
FROM TB_STUDENT S
ORDER BY STUDENT_NAME;
         
--7.
SELECT * FROM TB_CLASS;
SELECT CLASS_NAME,DEPARTMENT_NAME
FROM TB_CLASS C JOIN TB_DEPARTMENT D ON (C.DEPARTMENT_NO = D.DEPARTMENT_NO);
         
--8.

SELECT CLASS_NAME, (SELECT PROFESSOR_NAME 
                    FROM TB_PROFESSOR P 
                    WHERE C.CLASS_NO = CP.CLASS_NO AND P.PROFESSOR_NO = CP.PROFESSOR_NO) AS 교수이름
FROM TB_CLASS C JOIN TB_CLASS_PROFESSOR CP ON (C.CLASS_NO = CP.CLASS_NO)
ORDER BY CLASS_NAME;   

--9. 
SELECT CLASS_NAME, (SELECT PROFESSOR_NAME 
                    FROM TB_PROFESSOR P 
                    WHERE C.CLASS_NO = CP.CLASS_NO AND P.PROFESSOR_NO = CP.PROFESSOR_NO) AS 교수이름
FROM TB_CLASS C JOIN TB_CLASS_PROFESSOR CP ON (C.CLASS_NO = CP.CLASS_NO)
WHERE C.DEPARTMENT_NO IN (SELECT D.DEPARTMENT_NO FROM TB_DEPARTMENT D 
                            WHERE D.DEPARTMENT_NO = C.DEPARTMENT_NO
                            AND CATEGORY = '인문사회'
                            GROUP BY D.DEPARTMENT_NO)
ORDER BY CLASS_NAME;          

--10.

SELECT S.STUDENT_NO AS 학번,STUDENT_NAME AS 학생이름,  ROUND(AVG(POINT),1) AS 전체평점
FROM TB_GRADE G JOIN TB_STUDENT S ON(G.STUDENT_NO = S.STUDENT_NO)
WHERE S.DEPARTMENT_NO = (SELECT D.DEPARTMENT_NO FROM TB_DEPARTMENT D
                            WHERE D.DEPARTMENT_NAME = '음악학과')
      AND S.STUDENT_NO IS NOT NULL
GROUP BY S.STUDENT_NO, STUDENT_NAME
ORDER BY 학번;   

--11.
SELECT DEPARTMENT_NAME AS 학과이름, STUDENT_NAME AS 학생이름, PROFESSOR_NAME AS 지도교수이름
FROM TB_STUDENT S JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
                  JOIN TB_PROFESSOR P ON(S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
WHERE S.STUDENT_NO = 'A313047';
         
--12.
   
SELECT STUDENT_NAME, G.TERM_NO
FROM TB_STUDENT S JOIN TB_GRADE G ON(S.STUDENT_NO = G.STUDENT_NO)
WHERE G.CLASS_NO = (SELECT C.CLASS_NO FROM TB_CLASS  C
                    WHERE C.CLASS_NAME = '인간관계론')
                    AND SUBSTR(G.TERM_NO,1,4) = '2007' ;
         
--13.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C JOIN TB_DEPARTMENT D ON(C.DEPARTMENT_NO= D.DEPARTMENT_NO)
WHERE D.CATEGORY = '예체능' AND 
        C.CLASS_NO NOT IN(SELECT CP.CLASS_NO FROM TB_CLASS_PROFESSOR CP);
         
 --14.
SELECT STUDENT_NAME AS 학생이름, NVL(P.PROFESSOR_NAME,'지도교수 미지정')
FROM TB_STUDENT S LEFT JOIN TB_PROFESSOR P ON(S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
WHERE S.DEPARTMENT_NO = (SELECT D.DEPARTMENT_NO FROM TB_DEPARTMENT D
                            WHERE D.DEPARTMENT_NAME = '서반아어학과');    
                            
--15.
SELECT S.STUDENT_NO AS 학번, S.STUDENT_NAME AS 이름, D.DEPARTMENT_NAME AS 학과이름, ROUND(AVG(POINT),5) AS 평점
FROM TB_STUDENT S JOIN TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
                  JOIN TB_GRADE G ON (S.STUDENT_NO = G.STUDENT_NO)
WHERE S.ABSENCE_YN = 'N'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME, D.DEPARTMENT_NAME
HAVING AVG(G.POINT)>=4.0
ORDER BY 학번;

--16.
SELECT  C.CLASS_NO,C.CLASS_NAME, ROUND(AVG(G.POINT),5)
FROM TB_DEPARTMENT D JOIN TB_CLASS C ON (D.DEPARTMENT_NO = C.DEPARTMENT_NO)
                     JOIN TB_GRADE G ON (C.CLASS_NO = G.CLASS_NO) 
                     JOIN TB_STUDENT S ON (S.STUDENT_NO = G.STUDENT_NO)
WHERE D.DEPARTMENT_NAME = '환경조경학과' AND C.CLASS_TYPE LIKE '전공%'
GROUP BY C.CLASS_NAME, C.CLASS_NO;

--17.
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_STUDENT
                      WHERE STUDENT_NAME = '최경희');

--18.
WITH TOP AS (
SELECT S.STUDENT_NO, S.STUDENT_NAME,AVG(G.POINT)
FROM TB_STUDENT S JOIN TB_GRADE G ON(S.STUDENT_NO = G.STUDENT_NO)
WHERE S.DEPARTMENT_NO = (SELECT D.DEPARTMENT_NO FROM TB_DEPARTMENT D
                         WHERE D.DEPARTMENT_NAME = '국어국문학과')
GROUP BY S.STUDENT_NO, S.STUDENT_NAME
ORDER BY 3 DESC)

SELECT STUDENT_NO, STUDENT_NAME
FROM TOP
WHERE ROWNUM = 1;

--19.
SELECT  D.DEPARTMENT_NAME AS 계열학과명, ROUND(AVG(G.POINT),1) AS 전공평점
FROM TB_DEPARTMENT D JOIN TB_CLASS C ON (D.DEPARTMENT_NO = C.DEPARTMENT_NO)
                     JOIN TB_GRADE G ON (C.CLASS_NO = G.CLASS_NO) 
                     JOIN TB_STUDENT S ON (S.STUDENT_NO = G.STUDENT_NO)
WHERE D.CATEGORY = (SELECT CATEGORY FROM TB_DEPARTMENT
                            WHERE DEPARTMENT_NAME  = '환경조경학과')
GROUP BY D.DEPARTMENT_NAME;

--[DDL]

--1.
CREATE TABLE TB_CATEGORY
(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);

--2.
CREATE TABLE TB_CLASS_TYPE
(
    NO VARCHAR(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

--3.
ALTER TABLE TB_CATEGORY
ADD CONSTRAINT NAME_PRIMARY PRIMARY KEY( NAME);

--4.
ALTER TABLE TB_CLASS_TYPE
MODIFY NAME CONSTRAINT NAME_NN NOT NULL;

--5.
ALTER TABLE TB_CLASS_TYPE
MODIFY NO VARCHAR(10);

ALTER TABLE TB_CATEGORY
MODIFY NAME VARCHAR2(20);

ALTER TABLE TB_CLASS_TYPE
MODIFY NAME VARCHAR2(20);

--6.
ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NO TO CATEGORY_NO;

ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NAME TO CATEGORY_NAME;

ALTER TABLE TB_CATEGORY
RENAME COLUMN NAME TO CATEGORY_NAME;

--7.

ALTER TABLE TB_CLASS_TYPE
RENAME CONSTRAINT SYS_C007172 TO PK_CATEGORY_NAME;

ALTER TABLE TB_CATEGORY
RENAME CONSTRAINT NAME_PRIMARY TO PK_CATEGORY_NAME;

--8.
INSERT INTO TB_CATEGORY VALUES ('공학','Y');
INSERT INTO TB_CATEGORY VALUES ('자연과학','Y');
INSERT INTO TB_CATEGORY VALUES ('의학','Y');
INSERT INTO TB_CATEGORY VALUES ('예체능','Y');
INSERT INTO TB_CATEGORY VALUES ('인문사회','Y');


--9.
ALTER TABLE TB_DEPARTMENT ADD CONSTRAINT FK_DEPARTMENT_CATEGORY
FOREIGN KEY (CATEGORY) REFERENCES TB_CATEGORY (CATEGORY_NAME);

--10.

-- SYSTEM에서 GRANT CREATE VIEW TO [USER명]; 설정 필요함. 
CREATE VIEW VM_STUDENT_INFO(학번, 학생이름, 주소)
AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS 
FROM TB_STUDENT;

--11.
CREATE VIEW VM_지도면담 (학생이름, 학과이름, 지도교수이름)
AS SELECT STUDENT_NAME,DEPARTMENT_NAME, NVL(PROFESSOR_NAME,'없음')
FROM TB_STUDENT S  LEFT JOIN TB_PROFESSOR P ON(S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
                   JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO);
                 
DROP VIEW VM_지도면담;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM VM_지도면담;

--12.
CREATE VIEW VM_학과별학생수(DEPARTMENT_NAME, STUDENT_COUNT)
AS SELECT DEPARTMENT_NAME, CAPACITY
FROM TB_DEPARTMENT;


--13.
--14.
--15.
WITH TOP AS (
SELECT  G.CLASS_NO AS 과목번호, C.CLASS_NAME AS 과목이름, COUNT(*) AS  누적수강생수
FROM TB_CLASS C JOIN TB_GRADE G ON( C.CLASS_NO = G.CLASS_NO)
WHERE SUBSTR(TERM_NO,1,4) BETWEEN (SELECT MAX(SUBSTR(TERM_NO,1,4) -4) FROM TB_GRADE) 
                              AND  (SELECT MAX(SUBSTR(TERM_NO,1,4) ) FROM TB_GRADE)
GROUP BY G.CLASS_NO,C.CLASS_NAME
ORDER BY 누적수강생수 DESC)

SELECT 과목번호, 과목이름, 누적수강생수 FROM TOP
WHERE ROWNUM <= 3;


--[DML]
--1.
INSERT INTO TB_CLASS_TYPE VALUES(01,'전공필수');
INSERT INTO TB_CLASS_TYPE VALUES(02,'전공선택');
INSERT INTO TB_CLASS_TYPE VALUES(03,'교양필수');
INSERT INTO TB_CLASS_TYPE VALUES(04,'교양선택');
INSERT INTO TB_CLASS_TYPE VALUES(05,'논문지도');

--2.
CREATE TABLE TB_학생일반정보
AS SELECT STUDENT_NO AS 학번, STUDENT_NAME AS 학생이름, STUDENT_ADDRESS AS 주소
FROM TB_STUDENT;

--3.
CREATE TABLE TB_국어국문학과
AS SELECT STUDENT_NO AS 학번, STUDENT_NAME AS 학생이름, 
                LPAD(SUBSTR(STUDENT_SSN,1,2), 4,'19') AS 출생년도,NVL(P.PROFESSOR_NAME,'없음') AS 교수이름
                FROM TB_STUDENT S LEFT JOIN TB_PROFESSOR P ON (S.COACH_PROFESSOR_NO = P.PROFESSOR_NO)
                WHERE S.DEPARTMENT_NO = (SELECT D.DEPARTMENT_NO FROM TB_DEPARTMENT D
                                         WHERE DEPARTMENT_NAME = '국어국문학과');                               

--4.
SELECT DEPARTMENT_NAME, ROUND(CAPACITY*1.1,0) FROM TB_DEPARTMENT;

--5.
UPDATE TB_STUDENT
SET STUDENT_ADDRESS = '서울시 종로구 숭인동 181-21 '
WHERE STUDENT_NO='A413042';

--6.
UPDATE TB_STUDENT SET STUDENT_SSN = SUBSTR(STUDENT_SSN,1,6);

--7.
UPDATE TB_GRADE G
SET POINT = 3.5
WHERE G.STUDENT_NO = (SELECT S.STUDENT_NO FROM TB_STUDENT S JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
                      WHERE S.STUDENT_NAME = '김명훈' AND DEPARTMENT_NAME = '의학과')
      AND TERM_NO = '200501';

--8.
DELETE TB_GRADE
WHERE STUDENT_NO IN (SELECT STUDENT_NO FROM TB_STUDENT WHERE ABSENCE_YN = 'Y');






