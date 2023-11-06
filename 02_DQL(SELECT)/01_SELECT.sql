/*
    <SELECT>
    표현법
        SELECT 컬럼[,컬럼명...]
        FROM 테이블명;
        
        - 테이블에서 데이터를 조회할 때 사용하는 SQL 구문이다.
        - SELECT를 통해서 조회된 결과를 RESULT SET 이라고 한다.
        - 조회하고자 하는 컬럼들은 반드시 FROM 절에 기술한 테이블에 존재하는 컬럼이어야한댜.
        - 모든 컬럼의 데이터를 조회할 경우에는 컬럼명 대신 * 를 사용한다.
*/
-- EMPLOYEE 테이블에서 전체 사원의 사변, 이름 급여만 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

-- 쿼리는 대소문자를 가리지 않지만 관례상 대문자로 작성한다.
select emp_id, emp_name, salary
from employee;

-- EMPLOYEE 테이블에서 전체 사원의 모든 컬럼(전체는 *으로 표시) 정보 조회
SELECT * FROM EMPLOYEE;


-------------------- 실습 문제 --------------------

-- 1. JOB 테이블의 직급명 컬럼만 조회
SELECT JOB_NAME
FROM JOB;

-- 2. JOB 테이블의 모든 컬럼 정보 조회
SELECT * FROM JOB;

-- 3. DEPARTMENT 테이블의 모든 컬럼 정보 조회
SELECT * FROM DEPARTMENT;

-- 4. EMPLOYEE  테이블의 직원명, 이메일, 전화번호, 입사일 정보만 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

------------------------------------------------------------
/*
    <컬럼의 산술 연산>
        SELECT 절에 컬럼명 입력 부분에서 산술 연산자를 사용하여 결과를 조회할 수 있다.
*/

-- EMPLOYEE 테이블에서 직원명, 급여, 연봉(급여 * 12) 조회
SELECT EMP_NAME, SALARY * 12 FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원명, 급여, 연봉(급여 * 12),
-- 보너스가 포함된 연봉((급여 + (급여 * 보너스율)) * 12) 조회
-- 산술 연산 중 NULL 값이 존재할 경우 산술 연산의 결과는 무조건 NULL 이다.
SELECT EMP_NAME,
       SALARY,
       SALARY * 12,
       BONUS,
       (SALARY + (SALARY *NVL(BONUS, 0))) * 12
FROM EMPLOYEE;

SELECT NVL(3000000, 0), NVL(NULL, 0) FROM DUAL;

-- EMPLOYEE 테이블에서 직원명, 입사일, 근무일수(오늘 날짜 - 입사일)
-- SYSDATE는 현재 날짜를 출력한다.
SELECT SYSDATE FROM DUAL; -- 현재 날짜 출력

-- DATE 타입도 연산이 가능하다.
SELECT EMP_NAME,
       HIRE_DATE,
       -- SYSDATE - HIRE_DATE  그냥 계산 할 시 소수점으로 노출
       FLOOR(SYSDATE - HIRE_DATE)
FROM EMPLOYEE;

-- FLOOR 함수는 매개값으로 전달되는 수를 버림하는 함수이다.
SELECT CEIL(123.456) FROM DUAL; -- CEIL : 올림 함수
                                -- ROUND: 반올림 함수
                                -- FLOOR : 버림 함수


 /*< 컬럼 별칭 >
        - 표현식
            1) 컬럼 AS 별칭  
            2) 컬럼 AS "별칭" 
            3) 컬럼 별칭 
            4) 컬럼 "별칭"
        - 컬럼명 바로 뒤에 작성(콤마 뒤에 작성하지 않도록 주의!!)
        - 공백이 포함된 경우, 큰 따옴표("")로 감싸서 하나의 별칭임을 나타내주어야 한다.
*/

-- EMPLOYEE 테이블에서 직원명, 급여, 연봉, 보너스가 포함된 연봉 조회
SELECT EMP_NAME AS 직원명,
       SALARY AS "급여",
       SALARY * 12 연봉,
       (SALARY + (SALARY * NVL(BONUS,0))) * 12 "총 소득"  
FROM EMPLOYEE;


/*
    <리터럴>
        쿼리문에서 직접 데이터를 표기하는 방법을 리터럴이라 한다.
        문자나 날짜 리터럴은 ' ' 기호를 사용한다.
        SELECT절에 리터럴을 사용하면 테이블에 존재하는 데이터처럼 조회가 가능하다.
        리터럴도 또한 별칭을 넣을 수 있다.
*/
-- EMPLOYEE 테이블에서 사번, 직원명, 급여, 단위(원) 조회
SELECT EMP_ID AS "사번",
       EMP_NAME AS "직원명",
       SALARY AS "급여",
       '원' AS "단위(원)"
FROM EMPLOYEE;
-- 리터럴은 문자 한개 던 여러개 던 ''로 표시하면 된다.


/*
    <DISTINCT>
        컬럼에 포함된 중복 값을 한 번씩만 표시하고자 할 때 사용한다.
        SELECT 절에 한번만 기술 할 수 있다,.
        조회하는 컬럼이 여러 개이면 컬럼 값들이 모두 동일해야 중복으로 판단되어 중복이 제거된다.
*/
-- EMPLOYEE 테이블에서 직급 코드(중복 제거) 조회
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE
ORDER BY JOB_CODE;
-- ORDER BY : 오름차순
-- ORDER BY [] DESC : 내림차순

-- EMPLOYEE 테이블에서 부서 코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE;

-- EMLOYEE 테이블에서 부서 코드(중복 제거) 조회
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE
ORDER BY DEPT_CODE DESC;

-- DISTINCT는 SELECT 절에 한 번만 기술 할 수 있다.
-- SELECT DISTINCT JOB_CODE, DISTINCT DEPT_CODE
SELECT DISTINCT JOB_CODE, DEPT_CODE  -- 여러개를 넣을 경우 공통분모만 삭제된다.
FROM EMPLOYEE
ORDER BY JOB_CODE;


/*
    <WHERE>
        [표현법]
            SELECT 컬럼[,컬럼명...]
            FROM 테이블명
            WHERE 조건식;
        <비교 연산자>
        >, >=, <, <= : 대소 비교
        =, !=, ^=, <> : 동등 비교
*/
-- EMPLOYEE 테이블에서 부서 코드가 D9와 일치하는 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9'; -- 비교 연산자

-- EMPLOYEE 테이블에서 부서 코드가 D9와 일치하지 않는 사원들의 사번, 직원명, 부서 코드 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D9' OR DEPT_CODE IS NULL  -- OR : 또는 -> DEPT코드가 NULL이거나 D9가 아닌경우  / AND : 그리고 -> 두 조건 다 만족하는 경우
ORDER BY DEPT_CODE;
-- WHERE DEPT_CODE IS NULL : NULL 인경우에는 이렇게 조회
-- IS NOT NULL : NULL이 아닌경우

-- EMPLOYEE 테이블에서 직급 코드가 J1과 일치하는 사원들의 직원명, 부서 코드 조회(별칭 붙이기)
SELECT EMP_NAME AS "직원명",
       DEPT_CODE AS "부서 코드"
FROM EMPLOYEE
WHERE JOB_CODE = 'J1';
-- 순서 : FROM -> WHERE -> SELECT

-- EMPLOYEE 테이블에서 급여가 400만원 이상인 사원들의 직원명, 부서 코드 급여 조회(별칭 붙이기)
SELECT EMP_NAME AS "직원명",
       DEPT_CODE AS "부서 코드",
       SALARY AS "급여"
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE 테이블에서 재직 중인 사원들의 사번, 직원명, 입사일 조회
SELECT EMP_ID AS "사번",
       EMP_NAME AS "직원명",
       HIRE_DATE AS "입사일"
FROM EMPLOYEE
WHERE ENT_YN = 'N';
-- WHERE ENT_DATE IS NULL;

-- EMPLOYEE 테이블에서 급여가 300만원 이상인 직원 사원들의 직원명, 급여, 입사일 조회
SELECT EMP_NAME AS "직원명",
       SALARY AS "급여",
       HIRE_DATE AS "입사일"
FROM EMPLOYEE
WHERE SALARY >= 3000000
ORDER BY SALARY DESC;

-- EMPLOYEE 테이블에서 연봉이 5000만원 이상인 사원들의 직원명, 급여, 연봉, 입사일 조회
SELECT EMP_NAME AS "직원명",
       SALARY AS "급여",
       SALARY * 12 AS "연봉",
       HIRE_DATE AS "입사일"
FROM EMPLOYEE
WHERE SALARY * 12 >= 50000000
ORDER BY "연봉";
-- ORDER BY는 별칭으로 가능 : 순서가 맨 끝이기 때문 (FROM -> WHERE -> SELECT -> ORDER)
-- WHERE에서는 별칭 불가능 (SELECT보다 먼저 실행되기 때문)


/*
    <ORDER BY>
        [표현법]
            SELECT 컬럼[,컬럼,...]
            FROM 테이블명
            WHERE 조건식
            ORDER BY 컬럼명 | 별칭 | 컬럼순번[ASC|DESC] [NULLS FIRST | NULLS LAST];
            
    <SELECT 구문이 실행(해석)되는 순서>
        1. FROM 절
        2. WHERE 절
        3. SELECT 절
        4. ORDER BY 절
*/
-- EMPLOYEE 테이블에서 BONUS로 오름차순 정렬
SELECT EMP_NAME, BONUS
FROM EMPLOYEE;
-- ORDER BY BONUS; 별도로 기재 안하면 기본적으로 오름차순 정렬
-- ORDER BY BONUS ASC;  -- 오름차순 정렬은 기본적으로 NULLS LAST(NULL이 맨 마지막)
-- ORDER BY BONUS ASC NULLS FIRST; -- NULL을 먼저 출력한 후, 오름차순 정렬

-- EMPLOYEE 테이블에서 BONUS로 내림차순 정렬
-- 단, BONUS 값이 일치하는 경우에는 SALARY 가지고 오름차순 정렬
SELECT EMP_NAME, BONUS, SALARY
FROM EMPLOYEE;
-- ORDER BY BONUS DESC;  -- 내림차순의 정렬은 기본적으로 NULLS FIRST
-- ORDER BY BONUS DESC NULL LAST;  
-- ORDER BY BONUS DESC, SALARY;  -- 정렬 기준을 여러개를 제시 할 수 있다. (DESC로 내림차순후, 그안에서 SALARY로 내림차순)
-- ORDER BY BONUS DESC NULL LAST, SALARY; --위에서 NULL을 마지막으로 노출할 때

-- EMPLOYEE 테이블에서 연봉별 내림차순으로 정렬된 직원들의 직원명, 연봉 조회
SELECT EMP_NAME AS "직원명",
       SALARY * 12 AS "연봉"
FROM EMPLOYEE
--ORDER BY SALARY*12 DESC;
-- ORDER BY 2 DESC; -- 컬럼 순번 사용 -> 숫자 2 : 컬럼 숫자(현재는 직원명이 1번, 연봉이 2번)
-- ORDER BY "연봉" DESC; -- 별칭 사용 : SALARY 기준으로 내림차순