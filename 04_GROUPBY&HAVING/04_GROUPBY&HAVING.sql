/*
    <GROUP BY>
     그룹 기분을 제시할 수 있는 구문이다.
     여러 개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용한다.
*/
-- EMPLOYEE 테이블에서 부서별 급여의 합계를 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE 테이블에서 직급별 급여의 합계를 조회(단, 직급별 내림차순 정렬)
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE DESC;

-- EMPLOYEE 테이블에서 부서별 사원의 수를 조회
SELECT NVL(DEPT_CODE,'부서없음'), COUNT(*) 
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE 테이블에서 직급별 사원의 수를 조회 (단, 직급별 내림차순 정렬)
SELECT JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE DESC;

-- EMPLOYEE 테이블에서 부서별 보너스를 받는 사원의 수를 조회
SELECT NVL(DEPT_CODE,'부서없음'), COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE 테이블에서 직급별 보너스를 받는 사원의 수를 조회 (단, 직급별 내림차순 정렬
SELECT JOB_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE DESC;

-- EMPLOYEE 테이블에서 직급별 급여의 평균을 조회
SELECT JOB_CODE AS "직급",
       TO_CHAR(ROUND(AVG(NVL(SALARY,0))),'FML999,999,999') AS "급여 평균"
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- EMPLOYEE 테이블에서 부서별 사원의 수, 보너스를 받는 사원의 수, 급여의 합, 평균 급여, 최고 급여, 최저 급여를 조회(부서별 내림차순)
SELECT NVL(DEPT_CODE,'부서없음') AS "부서",
       COUNT(*) || '명' AS "사원의 수",
       COUNT(BONUS) || '명' AS "보너스 받는 사원 수",
       TO_CHAR(SUM(SALARY),'FML99,999,999') AS "부서별 급여 합계",
       TO_CHAR(ROUND(AVG(NVL(SALARY,0))),'FML9,999,999') AS "부서별 평균 급여",
       TO_CHAR(MAX(SALARY),'FML9,999,999') AS "부서별 최고 급여",
       TO_CHAR(MIN(SALARY),'FML9,999,999') AS "부서별 최저 급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE DESC;

-- EMPLOYEE 테이블에서 성별 별 사원의 수를 조회
SELECT DECODE(SUBSTR(EMP_NO,8,1), '1', '남자', '2', '여자') AS "성별",
       COUNT(*) AS "사원의 수"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1)  -- 컬럼 순서나 별칭은 사용 못함.
ORDER BY "성별";

SELECT CASE WHEN SUBSTR(EMP_NO,8,1) = '1' THEN '남자'
            WHEN SUBSTR(EMP_NO,8,1) = '2' THEN '여자'
       END AS "성별",
       COUNT(*) AS "사원의 수"
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1)  -- 컬럼 순서나 별칭은 사용 못함.
ORDER BY "성별";

-- EMPLOYEE테이블에서 부서 코드와 직급 코드가 같은 사원의 수, 급여의 합
-- 그룹은 여러개 가능
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY DEPT_CODE, JOB_CODE;


---------------------------------------------------------

/*
    <HAVING>
    그룹에 대한 조건을 제시할때 사용하는 구문  (WHERE은 조건에 그룹함수 사용 X)
    HAVING 조건식 ;
    위치는 GROUP BY 절 전 후 상관없음
    
    <실행순서>
    SELECT    -- 5
    FROM      -- 1
    WHERE     -- 2
    GROUP BY  -- 3
    HAVING    -- 4
    ORDER BY  -- 6
    FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
*/
-- EMPLOYEE 테이블에서 부서별로 급여가 300만원 이상인 직원의 평균 급여를 조회
SELECT DEPT_CODE, AVG(NVL(SALARY,0))
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE 테이블에서 부서별 평균 급여가 300만원 이상인 부서의 부서 코드와 평균 급여를 조회
SELECT DEPT_CODE, TRUNC(AVG(NVL(SALARY,0)), -1)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000
ORDER BY DEPT_CODE;

-- EMPLOYEE 테이블에서 직급별 총 급여의 합이 10,000,000 이상인 직급의 직급 코드, 급여의 합을 조회
SELECT NVL(JOB_CODE,'직급 없음') AS "직급",
       TO_CHAR(SUM(NVL(SALARY,0)),'FML999,999,999') AS "총 급여 합"
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(NVL(SALARY,0)) >= 10000000
ORDER BY JOB_CODE;

-- EMPLOYEE 테이블에서 부서별 보너스를 받는 사원이 없는 부서의 부서코드를 조회
SELECT NVL(DEPT_CODE,'부서없음') AS "부서"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;


/*
    <ROLLUP & CUBE>
     그룹 별 산출한 결과 값의 집계를 계산하는 함수
     ROLLUP 함수는 주어진 데이터 그룹의 소계를 구해준다.
     CUBE 함수는 주어진 데이터 그룹의 소계와 전체 총계까지 구해준다;
*/
-- EMPLOYEE 테이블에서 직급별 급여의 합계를 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
-- GROUP BY DEPT_CODE
-- 마지막 행에 전체 공 급여의 합계까지 조회
-- GROUP BY ROLLUP(DEPT_CODE)
GROUP BY CUBE(DEPT_CODE)
ORDER BY DEPT_CODE;

-- EMPLOYEE 테이블에서 직급 코드와 부서 코드가 같은 사원들의 급여 합계를 조회
SELECT JOB_CODE, DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL
--GROUP BY DEPT_CODE, JOB_CODE
-- ROLLUP ( 컬럼 1, 컬럼 2, 컬럼 3 ,...) -> 컬럼 1을 가지고 중간 집계를 내는 함수 
--GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
-- CUBE( 컬럼 1, 컬럼 2, 컬럼 3 ,...)  -> 전달되는 모든 컬럼을 가지고 중간 집계는 내는 함수 
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE, JOB_CODE;