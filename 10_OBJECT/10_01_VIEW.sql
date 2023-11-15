/*
    <VIEW>
    VIEW는 오라클에서 제공하는 객체로 가상의 테이블이다.
    데이터(테이블)를 직접 접촉시키지 않고 가상의 테이블을 만들어서 원하는 정보만 노출시킬 때 뷰를 사용하기도 한다.
*/
-- '한국'에서 근무하는 사원들의 사번, 직원명, 부서명, 급여, 근무 국가명을 조회
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, E.SALARY, N.NATIONAL_NAME
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
INNER JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
INNER JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE N.NATIONAL_NAME = '한국';

-- '러시아'에서 근무하는 사원들의 사번, 직원명, 부서명, 급여, 근무 국가명을 조회
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, E.SALARY, N.NATIONAL_NAME
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
INNER JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
INNER JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE N.NATIONAL_NAME = '러시아';

-- '일본'에서 근무하는 사원들의 사번, 직원명, 부서명, 급여, 근무 국가명을 조회
SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, E.SALARY, N.NATIONAL_NAME
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
INNER JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
INNER JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE N.NATIONAL_NAME = '일본';

/*
    1. VIEW 생성
        -- 서브 쿼리의 SELECT 절에 함수가 사용된 경우 반드시 별칭을 지정해야 한다.
        CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰명
        AS 서브 쿼리
        [WITH CHECK OPTION]
        [WITH READ ONLY];
*/
-- 처음 뷰를 생성시 관리자 계정으로 CREATE VIEW 권한을 주어야한다.
GRANT CREATE VIEW TO C##KH; -- SYS 계정으로 수행

CREATE OR REPLACE VIEW V_EMPLOYEE  -- OR REPLACE : 이미 같은 이름의 객체가 있으면 덮어씌워라
AS SELECT E.EMP_ID,
          E.EMP_NAME,
          D.DEPT_TITLE,
          E.SALARY,
          N.NATIONAL_NAME
    FROM EMPLOYEE E
    INNER JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
    INNER JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
    INNER JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE);

-- 가상 테이블로 실제 데이터가 담겨있는 것은 아니다.   
SELECT * FROM V_EMPLOYEE;

-- 접속한 계정이 가지고 있는 VIEW의 정보를 조회하는 뷰 테이블이다.
SELECT * FROM USER_VIEWS;

-- '한국'에서 근무하는 사원들의 정보를 조회
SELECT *
FROM V_EMPLOYEE
WHERE NATIONAL_NAME = '한국';

-- '러시아'에서 근무하는 사원들의 정보를 조회
SELECT *
FROM V_EMPLOYEE
WHERE NATIONAL_NAME = '러시아';

-- '일본'에서 근무하는 사원들의 정보를 조회
SELECT *
FROM V_EMPLOYEE
WHERE NATIONAL_NAME = '일본';


/*
    2. 뷰 컬럼에 별칭 부여
*/
-- 모든 사원들의 사번, 직원명, 성별 코드, 근무년수, 연봉을 조회할 수 있는 뷰 생성
-- 1) 서브 쿼리에 별칭을 부여하는 방법
CREATE OR REPLACE VIEW V_EMPLOYEE
AS SELECT EMP_ID AS "사번",
       EMP_NAME AS "직원명",
       SUBSTR(EMP_NO,8,1) AS "성별코드", -- 함수나 연산식을 사용하는 경우에는 별칭과 함께 지정해야 뷰가 생성된다.
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "근무년수",
       SALARY * 12 AS "연봉"
FROM EMPLOYEE;

-- 2) 뷰 생성 시 모든 컬럼에 별칭을 부여하는 방법
CREATE OR REPLACE VIEW V_EMPLOYEE("사번", "직원명", "성별코드", "근무년수", "연봉")
AS SELECT EMP_ID,
       EMP_NAME,
       SUBSTR(EMP_NO,8,1),
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE),
       SALARY * 12
FROM EMPLOYEE;

SELECT * FROM V_EMPLOYEE;
SELECT * FROM USER_VIEWS;

DROP VIEW V_EMPLOYEE; -- VIEW 삭제

/*
    3. VIEW 를 이용해서 DML(INSERT, UPDATE, DELETE) 사용
*/
CREATE VIEW V_JOB
AS SELECT *
    FROM JOB;
    
-- VIEW 를 SELECT(조회)
SELECT * FROM V_JOB;

-- VIEW에 INSERT(추가)
INSERT INTO V_JOB VALUES ('J8', '알바');

-- VIEW에 UPDATE(수정)
UPDATE V_JOB
SET JOB_NAME = '인턴'
WHERE JOB_CODE = 'J8';

-- VIEW에 DELETE(삭제)
DELETE
FROM V_JOB
WHERE JOB_CODE = 'J8';

SELECT * FROM V_JOB;
SELECT * FROM JOB; -- 뷰 테이블에서 추가, 수정, 삭제 한것도 실제 테이블에 INSERT, UPDATE DELETE 가 적용된다.


/*
    4. DML 구문으로 VIEW 조작이 불가능한 경우
      - 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
      - 뷰에 포함되지 않는 컬럼 중에 기본 테이블 상에 NOT NULL 제약조건이 지정된 경우
      - 산술 표현식으로 정의된 경우
      - 그룹 함수나 GROUP BY 절을 포함한 경우
      - DISTINCT를 포함한 경우
      - JOIN을 이용해 여러 테이블을 연결한 경우
*/

-- 1) 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
CREATE OR REPLACE VIEW V_JOB
AS SELECT JOB_CODE
   FROM JOB;

-- INSERT
INSERT INTO V_JOB VALUES ('J8', '인턴'); -- VIEW에 정의되지않은 JOB_NAME 컬럼까지 INSERT하려고하면 에러 발생.
INSERT INTO V_JOB VALUES ('J8'); -- 가능

-- UPDATE
UPDATE V_JOB
SET JOB_NAME = '인턴' -- VIEW에 정의되지않은 JOB_NAME 컬럼이기 때문에 값 변경 불가능
WHERE JOB_CODE = 'J8'; -- 에러 발생

UPDATE V_JOB
SET JOB_CODE = 'J0'
WHERE JOB_CODE = 'J8'; -- 정의된 JOB_CODE만 수정하기 때문에 수정 가능

-- DELETE
DELETE
FROM V_JOB 
WHERE JOB_NAME IS NULL; -- VIEW에 정의되지않은 JOB_NAME 컬럼이기 때문에 값 삭제 불가능. 에러 발생

DELETE
FROM V_JOB
WHERE JOB_CODE = 'J0';

-- 2) 뷰에 포함되지 않는 컬럼 중에 NOT NULL 제약조건이 지정된 경우
CREATE OR REPLACE VIEW V_JOB
AS SELECT JOB_NAME
   FROM JOB;
   
-- INSERT
INSERT INTO V_JOB VALUES ('인턴');\

SELECT * FROM V_JOB;
SELECT * FROM JOB;

-- 3) 산술 표현식으로 정의된 경우
-- 사원의 연봉 정보를 조회하는 뷰 
CREATE VIEW V_EMP_SAL
AS SELECT EMP_ID,
          EMP_NAME,
          EMP_NO,
          SALARY,
          SALARY * 12 AS "연봉"
   FROM EMPLOYEE;
  
-- INSERT
-- EMPLOYEE 테이블에 연봉이 없음 (산술연산식)
-- 산술 연산으로 정의된 데이터 삽입 불가능
INSERT INTO V_EMP_SAL VALUES('100', '홍길동', '231115-3333333',3000000,36000000); -- 에러 발생

-- 산술 연산과 무관한 데이터 삽입 가능
INSERT INTO V_EMP_SAL(EMP_ID, EMP_NAME, EMP_NO, SALARY ) VALUES ('100', '홍길동', '231115-3333333',3000000); -- 에러가 발생하지 않는다.

-- UPDATE
-- 산술연산으로 정의된 컬럼은 데이터 변경 불가능
UPDATE V_EMP_SAL
SET "연봉" = 50000000
WHERE EMP_ID = '100';

-- 산술 연산과 무관한 컬럼은 데이터 변경 가능
UPDATE V_EMP_SAL
SET SALARY = 5000000
WHERE EMP_ID = '100';

-- DELETE
-- 조건을 주고 DELETE는 가능하다.
DELETE
FROM V_EMP_SAL
WHERE "연봉" = 600000000;

SELECT * FROM V_EMP_SAL;

-- 4) 그룹 함수나 GROUP BY 절을 포함한 경우
-- 그룹이 되어있기 때문에 INSERT, UPDATE, DELETE를 모두 허용하지않는다.
-- 부서별 급여의 합계, 급여 평균을 조회하는 뷰를 생성
CREATE OR REPLACE VIEW V_EMP_SAL("부서코드", "합계", "평균")
AS SELECT DEPT_CODE,
          SUM(SALARY),
          FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT * FROM V_EMP_SAL;

-- INSERT
INSERT INTO V_EMP_SAL VALUES ('D0', 8000000, 40000000); -- GROUP을 했기때문에 에러발생

INSERT INTO V_EMP_SAL("부서코드") VALUES('D0'); -- GROUP을 했기때문에 에러발생

-- UPDATE
UPDATE V_EMP_SAL
SET "합계" = 12000000
WHERE "부서코드" = 'D1'; -- 에러발생

UPDATE V_EMP_SAL
SET "부서코드" = 'D0'
WHERE "부서코드" = 'D1'; -- 에러발생

-- DELETE
DELETE
FROM V_EMP_SAL
WHERE "부서코드" = 'D1'; -- 에러발생

-- 5) DISTINCT를 포함한 경우
-- 여러행들의 중복을 제거한 경우(DISTINCT) 중복된 데이터들을 전체 변경해줘야하기 때문에 INSERT, UPDATE, DELETE 모두 허용이 되지 않음.
CREATE VIEW V_EMP_JOB
AS SELECT DISTINCT JOB_CODE
    FROM EMPLOYEE;
    
-- INSERT
INSERT INTO V_EMP_JOB VALUES('J8'); -- 에러발생

-- UPDATE
UPDATE V_EMP_JOB
SET JOB_CODE = 'J8'
WHERE JOB_CODE = 'J7'; -- 에러발생

-- DELETE
DELETE
FROM V_EMP_JOB
WHERE JOB_CODE = 'J7'; -- 에러발생

-- 6) JOIN을 이용해 여러 테이블을 연결한 경우
-- 직원들의 사번, 직원명, 주민번호, 부서명 조회하는 뷰를 생성
CREATE OR REPLACE VIEW V_EMP_DEPT
AS SELECT E.EMP_ID,
       E.EMP_NAME,
       E.EMP_NO,
       D.DEPT_TITLE
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID);

SELECT * FROM V_EMP_DEPT;

-- INSERT
INSERT INTO V_EMP_DEPT VALUES('100', '홍길동', '941115-1111111', '인사부'); -- 에러 발생

INSERT INTO V_EMP_DEPT(EMP_ID,EMP_NAME,EMP_NO)
VALUES('100', '홍길동', '941115-1111111');

-- UPDATE
UPDATE V_EMP_DEPT
SET DEPT_TITLE = '개발팀'     
WHERE EMP_ID = '200';

UPDATE V_EMP_DEPT
SET EMP_NAME = '김청수'     
WHERE EMP_ID = '200';

-- 에러 발생
-- JOIN한 경우 여러 열을 지정해서 변경 불가능
UPDATE V_EMP_DEPT
SET EMP_NAME = '김청수',   
    DEPT_TITLE = '개발팀'
WHERE EMP_ID = '200';

ROLLBACK;

-- DELETE
-- 서브 쿼리의 FROM절에 기술한 테이블만 영향을 끼친다.
DELETE
FROM V_EMP_DEPT
WHERE EMP_ID = '200';

DELETE
FROM V_EMP_DEPT
WHERE DEPT_TITLE = '총무부';

ROLLBACK;

SELECT * FROM V_EMP_DEPT ORDER BY EMP_ID;
SELECT * FROM EMPLOYEE;


/*
    5. VIEW 옵션
        -- 서브 쿼리의 SELECT 절에 함수가 사용된 경우 반드시 별칭을 지정해야 한다.
        CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰명
        AS 서브 쿼리
        [WITH CHECK OPTION]
        [WITH READ ONLY];
*/
-- 1) OR REPLACE : 기존에 동일한 뷰가 있을 경우 덮어쓰고, 존재하지 않으면 뷰를 새로 생성한다.
SELECT * FROM USER_VIEWS; -- 현재까지 만든 VIEW 조회

CREATE VIEW V_EMP_SAL -- 이미 V_EMP_SAL이라는 뷰가 존재하기때문에 오류남
AS SELECT EMP_NAME, SALARY, HIRE_DATE
    FROM EMPLOYEE;
    
CREATE OR REPLACE VIEW V_EMP_SAL -- OR REPLACE : 덮어씌우기
AS SELECT EMP_NAME, SALARY, HIRE_DATE
    FROM EMPLOYEE; 
    
-- 2) NOFORCE / FORCE
-- NOFORCE : 서브 쿼리에 기술된 테이블이 존재해야만 뷰가 생성된다. (기본값)
-- FORECE : 서브 쿼리에 기술된 테이블이 존재하지 않는 테이블이어도 뷰가 생성된다.

-- TEST 테이블을 생성해야 VIEW를 생성할 수 있다.
CREATE /*NOFORCE*/ VIEW V_TEST_01
AS SELECT *
    FROM TEST;

-- TEST 테이블을 생성하지 않아도 VIEW를 생성할 수 있다.
CREATE FORCE VIEW V_TEST_02
AS SELECT *
   FROM TEST; 

SELECT * FROM USER_VIEWS;

-- 단, TEST 테이블을 생성한 이후부터 VIEW 조회 가능
SELECT * FROM V_TEST_02; -- 테이블이 존재하지 않기 때문에 실행되지 않음.

-- TEST 테이블을 생성함
-- V_TEST_02 조회 가능, V_TEST_01(NOFORCE) 뷰 생성 가능
CREATE TABLE TEST(
    TNO NUMBER,
    TNAME VARCHAR2(20)
);

-- 3) WITH CHECK OPTION : 서브 쿼리에 기술된 조건에 부합하지 않는 값으로 수정하는 경우 오류를 발생시킨다.
CREATE VIEW V_EMP
AS SELECT *
   FROM EMPLOYEE
   WHERE SALARY >= 3000000;
   
SELECT * FROM V_EMP;

-- 사번이 200인 사원의 급여를 200만원으로 변경
-- 서브쿼리의 조건에 부합하지 않아도 변경이 가능하다.
UPDATE V_EMP
SET SALARY = 2000000
WHERE EMP_ID = '200';

ROLLBACK;

CREATE OR REPLACE VIEW V_EMP
AS SELECT *
   FROM EMPLOYEE
   WHERE SALARY >= 3000000
WITH CHECK OPTION;

-- 사번이 200인 사원의 급여를 200만원으로 변경
-- 서브쿼리의 조건에 부합해야 변경 가능.
UPDATE V_EMP
SET SALARY = 2000000
WHERE EMP_ID = '200'; -- 에러 발생

-- 사번이 200인 사원의 급여를 400만원으로 변경
UPDATE V_EMP
SET SALARY = 4000000
WHERE EMP_ID = '200'; -- 서브쿼리의 조건에 부합하기 때문에 변경 가능

SELECT * FROM V_EMP;

-- 4) WITH READ ONLY : 뷰에 대해 조회만 가능하다. (DML 수행 불가)
CREATE VIEW V_DEPT
AS SELECT *
    FROM DEPARTMENT
WITH READ ONLY;

SELECT * FROM V_DEPT;

-- INSERT,UPDATE,DELETE 수행 불가.(읽기 전용)
-- INSERT
INSERT INTO V_DEPT VALUES('D0', '개발부', 'L2'); -- 에러 발생

-- UPDATE
UPDATE V_DEPT
SET DEPT_TITLE = '개발부'
WHERE DEPT_ID = 'D1'; -- 에러 발생

-- DELETE
DELETE 
FROM V_DEPT
WHERE DEPT_ID = 'D1'; -- 에러 발생

/*
    6. VIEW 삭제
*/
DROP VIEW V_DEPT;
DROP VIEW V_EMP;
DROP VIEW V_EMP_DEPT;
DROP VIEW V_EMP_JOB;
DROP VIEW V_EMP_SAL;
DROP VIEW V_JOB;
DROP VIEW V_TEST_01;
DROP VIEW V_TEST_02;