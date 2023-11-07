/*
    <집합 연산자>
     여러 개의 쿼리문을 하나의 쿼리문으로 만드는 연산자이다.
     여러 개의 쿼리문에서 조회하려고하는 컬럼의 개수와 이름이 같아야한다.
*/
-- EMPLOYEE 테이블에서 부서 코드가 D5인 사원들의 사번, 직원명, 부서코드 급여를 조회 (6명 조회)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- EMPLOYEE 테이블에서 급여가 300만원 초과인 사원들의 사번, 직원명, 부서코드, 급여를 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

/*
    1) UNION
       두 쿼리문을 수행한 결과값을 하나로 합쳐서 추출한다.
       중복된 행은 제거된다.
*/
-- EMPLOYEE 테이블에서 부서 코드가 D5인 사원 또는 급여가 300만원 초과인 사원들의 사번, 직원명, 부서코드, 급여를 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'

UNION

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- 위 쿼리문은 WHERE절에 OR 연산자를 사용해서 조회가 가능하다.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;


/*
    2) UNION ALL
       두 쿼리문을 수행한 결과값을 하나로 합쳐서 추출한다.
       중복되는 행을 제거하지 않는다.
*/
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'

UNION ALL

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;


/*
    3) INTERSECT
       두 쿼리문을 실행한 결과값의 중복된 결과값만 조회한다.
*/
-- EMPLOYEE 테이블에서 부서 코드가 D5이면서 급여가 300만원 초과인 사원들의 사번, 직원명, 부서코드, 급여를 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'

INTERSECT

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

--위 쿼리문 대신에 WHERE에 AND 연산자를 사용해서 조회 가능하다.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;


/*
    4) MINUS
       선행 쿼리문의 결과값에서 후행 쿼리문의 결과값을 뺀 나머지 결과값만 조회한다.
*/
-- EMPLOYEE 테이블에서 부서 코드가 D5인 사원들 중에 급여가 300만원 초과인 사원들을 제외해서 사번, 직원명, 부서코드, 급여를 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'

MINUS

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY <= 3000000;


/*
    <GROUPING SET>
     그룹 별로 처리된 여러 개의 SELECT 문을 하나로 합친 결과를 만들 때 사용한다.
*/
-- 부서별 사원수
SELECT DEPT_CODE,
       COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 직급별 사원수
SELECT JOB_CODE,
       COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 1) UNION ALL 연산자를 사용하는 방법
SELECT DEPT_CODE, 
       COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE


UNION ALL              -- 컬럼의 데이터 타입이 같아서 합쳐진다.

SELECT JOB_CODE, 
       COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY DEPT_CODE  -- 마지막 쿼리문 젤 마지막에 한번만 사용한다!! 컬럼명은 위에있는 컬럼명을 적는다. 
;

-- 2) GROUPING SETS 함수 사용
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY GROUPING SETS(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE, JOB_CODE;