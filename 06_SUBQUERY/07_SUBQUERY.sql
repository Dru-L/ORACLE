/*
    < SUBQUERY >
        하나의 SQL 문 안에 포함된 또 다른 SQL문을 SUBQUERY라고 한다.
*/
-- SUBQUERY 예시
-- 1. 노옹철 사원과 같은 부서원들을 조회
--  1) 노옹철 사원의 부서 코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';

--  2) 부서 코드가 노옹철 사원의 부서 코드와 동일한 사원들을 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

--  3) SUBQUERY를 사용하여 하나의 쿼리문으로 작성
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = (
    SELECT DEPT_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME = '노옹철'
);

-- 2. 전 직원의 평균 급여보다 더 많은 급여를 받고있는 사원들의 사번, 직원명, 직급 코드, 급여를 조회
--  1) 전 직원의 평균 급여 조회
SELECT AVG(NVL(SALARY,0))
FROM EMPLOYEE;

--  2) 평균 급여보다 더 많은 급여를 받고있는 직원들을 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047662.60869565217391304347826086956522;

--  3) SUBQUERY를 사용하여 하나의 쿼리문으로 작성
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (
    SELECT AVG(NVL(SALARY,0))
    FROM EMPLOYEE
);


/*
    <SUBQUERY 구분>
      SUBQUERY는 SUBQUERY를 수행한 결과값의 행과 열의 개수에 따라서 분류할 수 있다.
      
      1.단일행 서브쿼리
        서브쿼리의 조회 결과 값의 개수가 1개일 때
*/
-- 최저 급여를 받는 직원의 사번, 직원명, 직급 코드, 급여, 입사일 조회
--  1) 최저 급여 조회
SELECT MIN(SALARY)
FROM EMPLOYEE;

--  2) 최저 급여를 받는 직원을 조회 
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = 1380000;

--  3) SUBQUERY를 사용하여 하나의 쿼리문으로 작성
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY =(
    SELECT MIN(SALARY)
    FROM EMPLOYEE
);

-- 노옹철 사원의 급여보다 더 많이 받는 사원의 사번, 직원명, 부서명, 급여 조회
SELECT E.EMP_ID AS "사번",
       E.EMP_NAME AS "직원명",
       D.DEPT_TITLE AS "부서명",
       TO_CHAR(E.SALARY,'FML9,999,999') AS "급여"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE SALARY > (
    SELECT SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME = '노옹철'
);

-- 오라클
SELECT E.EMP_ID AS "사번",
       E.EMP_NAME AS "직원명",
       D.DEPT_TITLE AS "부서명",
       TO_CHAR(E.SALARY,'FML9,999,999') AS "급여"
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID(+)
  AND SALARY > (
    SELECT SALARY
    FROM EMPLOYEE
    WHERE EMP_NAME = '노옹철'
);

-- 전지연 사원이 속해있는 부서의 부서원들의 사번, 직원명, 전화번호, 직급명, 부서명, 입사일 조회(단, 전지연 사원 제외)
-- ANSI
SELECT E.EMP_ID AS "사번",
       E.EMP_NAME AS "직원명",
       E.PHONE AS "전화번호",
       J.JOB_NAME AS "직급명",
       D.DEPT_TITLE AS "부서명",
       E.HIRE_DATE AS "입사일"
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
INNER JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE E.EMP_NAME != '전지연'
AND E.DEPT_CODE = (
        SELECT DEPT_CODE
        FROM EMPLOYEE
        WHERE EMP_NAME = '전지연'
);

-- 오라클
SELECT E.EMP_ID AS "사번",
       E.EMP_NAME AS "직원명",
       E.PHONE AS "전화번호",
       J.JOB_NAME AS "직급명",
       D.DEPT_TITLE AS "부서명",
       E.HIRE_DATE AS "입사일"
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
    AND E.JOB_CODE = J.JOB_CODE
    AND E.EMP_NAME != '전지연'
    AND E.DEPT_CODE = (
        SELECT DEPT_CODE
        FROM EMPLOYEE
        WHERE EMP_NAME = '전지연'
);

-- 부서별 급여의 합이 가장 큰 부서의 부서 코드, 급여의 합 조회
--  1) 부서별 급여의 합
SELECT SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--  2) 부서별 급여의 합 중 가장 큰 값
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 3) 부서별 급여의 합이 가장 큰 부서의 부서 코드, 급여의 합 조회
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (
    SELECT MAX(SUM(SALARY))
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
);


/*
    2. 다중행 서브쿼리
      서브 쿼리의 조회 결과 값의 개수가 여러 행일 때
      
      ANY : 여러 개의 값들 중에서 조건을 한개라도 만족하면 TRUE 리턴한다.
            SALARY > ANY(...) : 최소값보다 크면 TRUE 리턴한다.
            SALARY < ANY(...) : 최댓값보다 작으면 TRUE 리턴한다.
      
      ALL : 여러 개의 값들 중에서 조건을 모두 만족하면 TRUE 리턴한다.
            SALARY > ALL(...) : 최댓값보다 크면 TRUE 리턴한다.
            SALARY < ALL(...) : 최솟값보다 작으면 TRUE 리턴한다.
*/
-- 각 부서별 최고 급여를 받는 직원의 사원명, 직급 코드, 부서코드, 급여 조회
--  1) 각 부서별 최고 급여 조회
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
    
--  2) 위 급여를 받는 사원들을 조회
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN(8000000, 3900000, 3760000, 3660000, 2890000, 2550000, 2490000)
ORDER BY DEPT_CODE;

--  3) SUBQUERY를 사용하여 쿼리문으로 작성
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN(
    SELECT MAX(SALARY)
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
)
ORDER BY DEPT_CODE;

-- 전체 직원에 대해 사번, 이름, 부서코드, 구분(사수/사원) 조회
--  1) 사수에 해당하는 사번 조회(200, 201, 204, 207, 211, 214, 100)
SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL;

-- 사번이 위와 같은 사원들의 사번, 이름, 부서코드, 구분(사수)
SELECT EMP_ID AS "사번",
       EMP_NAME AS "이름",
       DEPT_CODE AS "부서 코드",
       '사수' AS "구분"
FROM EMPLOYEE
WHERE EMP_ID IN(
    SELECT DISTINCT MANAGER_ID
    FROM EMPLOYEE
    WHERE MANAGER_ID IS NOT NULL
);

-- 일반 사원에 해당하는 직원들의 사번, 이름, 부서코드, 구분(사원)
SELECT EMP_ID AS "사번",
       EMP_NAME AS "이름",
       DEPT_CODE AS "부서 코드",
       '사원' AS "구분"
FROM EMPLOYEE
WHERE EMP_ID NOT IN(
    SELECT DISTINCT MANAGER_ID
    FROM EMPLOYEE
    WHERE MANAGER_ID IS NOT NULL
);

--  위의 결과들을 하나의 결과로 확인하기(UNION)
SELECT EMP_ID AS "사번",
       EMP_NAME AS "이름",
       DEPT_CODE AS "부서 코드",
       '사수' AS "구분"
FROM EMPLOYEE
WHERE EMP_ID IN(
    SELECT DISTINCT MANAGER_ID
    FROM EMPLOYEE
    WHERE MANAGER_ID IS NOT NULL
)

UNION

SELECT EMP_ID AS "사번",
       EMP_NAME AS "이름",
       DEPT_CODE AS "부서 코드",
       '사원' AS "구분"
FROM EMPLOYEE
WHERE EMP_ID NOT IN(
    SELECT DISTINCT MANAGER_ID
    FROM EMPLOYEE
    WHERE MANAGER_ID IS NOT NULL
);

-- SELECT 절에 서브 쿼리 사용하는 방법
SELECT EMP_ID AS "사번",
       EMP_NAME AS "이름",
       DEPT_CODE AS "부서 코드",
       CASE WHEN EMP_ID IN(
           SELECT DISTINCT MANAGER_ID
           FROM EMPLOYEE
           WHERE MANAGER_ID IS NOT NULL
        ) THEN '사수'
        ELSE '사원'
        END AS "구분"
FROM EMPLOYEE
ORDER BY "구분", EMP_ID;

-- 대리 직급임에도 과장 직급들의 최소 급여보다 많이 받는 직원의 사번, 직원명, 직급 코드, 급여 조회
-- 과장 직급들의 최소 급여 조회 (2200000, 2500000, 3760000)
SELECT SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J5';

-- 직급이 대리인 직원들 중에서 위의 목록 값 중에 하나라도 큰 경우
SELECT EMP_ID AS "사번",
       EMP_NAME AS "이름",
       JOB_CODE AS "직급 코드",
       SALARY AS "급여"
FROM EMPLOYEE
WHERE JOB_CODE = 'J6'
-- SALARY > 220만 OR SALARY > 250만 OR SALARY > 376만
  AND SALARY > ANY(2200000, 2500000, 3760000);

-- 위의 쿼리문을 합쳐서 하나의 쿼리문으로 작성
SELECT EMP_ID AS "사번",
       EMP_NAME AS "이름",
       JOB_CODE AS "직급 코드",
       SALARY AS "급여"
FROM EMPLOYEE
WHERE JOB_CODE = 'J6'
  AND SALARY > ANY(
    SELECT SALARY
    FROM EMPLOYEE
    WHERE JOB_CODE = 'J5'
);

-- 과장 직급임에도 차장 직급의 최대 급여보다 더 많이 받는 사원들의 사번, 직원명, 직급 코드, 급여 조회
-- 차장 직급들의 급여 조회 (2800000,1550000,2490000,2480000)
SELECT SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J4';

-- 과장 직급임에도 차장 직급의 최대 급여보다 더 많이 받는 직원 조회
SELECT EMP_ID AS "사번",
       EMP_NAME AS "이름",
       JOB_CODE AS "직급 코드",
       SALARY AS "급여"
FROM EMPLOYEE
WHERE JOB_CODE = 'J6'
-- SALARY > 280만 AND SALARY > 155만 AND SALARY > 249만 AND SALARY > 248만
  AND SALARY > ALL(2800000,1550000,2490000,2480000);

-- 위의 쿼리문을 합쳐서 하나의 쿼리문으로 작성
SELECT EMP_ID AS "사번",
       EMP_NAME AS "이름",
       JOB_CODE AS "직급 코드",
       SALARY AS "급여"
FROM EMPLOYEE
WHERE JOB_CODE ='J5'
    AND SALARY > ALL (
    SELECT SALARY
    FROM EMPLOYEE
    WHERE JOB_CODE = 'J4'
    );
    
-- 위 쿼리와 같은 결과를 만들어낸다.
SELECT EMP_ID AS "사번",
       EMP_NAME AS "이름",
       JOB_CODE AS "직급 코드",
       SALARY AS "급여"
FROM EMPLOYEE
WHERE JOB_CODE ='J5'
    AND SALARY > (
        SELECT MAX(SALARY)
        FROM EMPLOYEE
        WHERE JOB_CODE = 'J4'
    );


/*
    3. 다중열 서브쿼리
      서브 쿼리의 조회 결과 값은 한 행이지만, 컬럼의 수가 여러 개일 때
*/
-- 하이유 사원과 같은 부서 코드, 같은 직급 코드에 해당하는 사원들을 조회
-- 하이유 사원의 부서 코드와 직급 코드 조회
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '하이유';

-- 부서 코드가 D5이면서 직급 코드가 J5인 사원들을 조회
SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND JOB_CODE = 'J5';

-- 다중열 서브 쿼리를 사용해서 작성하는 방법
--  1) 비교 연산자 사용하는 방법
SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (('D5', 'J5'));

SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE)= (
    SELECT DEPT_CODE, JOB_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME = '하이유'
);

--  2) IN 연산자 사용하는 방법
SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) IN (('D5', 'J5'));

SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) IN (
    SELECT DEPT_CODE, JOB_CODE
    FROM EMPLOYEE
    WHERE EMP_NAME = '하이유'
);

-- 박나라 사원과 직급 코드가 일치하면서 같은 사수를 가지고 있는 사원의 사번, 직원명, 직급 코드, 사수 사번 조회
-- 박나라 사원의 직급 코드, 사수 사번을 조회
SELECT JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE EMP_NAME = '박나라';

-- 박나라 사원과 직급 코드가 일치하면서 같은 사수를 가지고 있는 사원 조회
SELECT EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (
    SELECT JOB_CODE, MANAGER_ID
    FROM EMPLOYEE
    WHERE EMP_NAME = '박나라'
);


/*
    4. 다중행 다중열 서브쿼리
      서브 쿼리의 조회 결과값이 여러 행, 여러 열일 경우
*/
-- 각 직급별로 최소 급여를 받는 사원들의 사번, 직원명, 직급 코드, 급여 조회
-- 각 직급별 최소 급여 조회(('J1', 8000000), ('J2', 3700000), ('J3', 3400000), ('J4', 1550000),('J5', 2200000),('J6', 2000000),('J7', 1380000))
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 각 직급별로 최소 급여를 받는 사원 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (('J1', 8000000), ('J2', 3700000), ('J3', 3400000), ('J4', 1550000),('J5', 2200000),('J6', 2000000),('J7', 1380000));

-- 다중행 다중열 서브쿼리 사용
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (
    SELECT JOB_CODE, MIN(SALARY)
    FROM EMPLOYEE
    GROUP BY JOB_CODE
)
ORDER BY JOB_CODE;

-- 각 부서별로 최소 급여를 받는 사원들의 사번, 직원명, 부서 코드, 급여 조회
-- 각 부서별 최소 급여 조회
SELECT NVL(DEPT_CODE,'부서 없음'), MIN(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- 각 부서별 최소 급여를 받는 사원 조회
SELECT EMP_ID, EMP_NAME, NVL(DEPT_CODE,'부서 없음'), SALARY
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE,'부서 없음'), SALARY) IN (('D1', 1380000), ('D2', 1550000), ('D5', 1800000), ('D6', 2800000),('D8', 2000000),('D9', 3700000),('부서 없음', 2320000))
ORDER BY DEPT_CODE;

-- 다중행 다중열 서브 쿼리를 사용해서 조회
SELECT EMP_ID, EMP_NAME, NVL(DEPT_CODE,'부서 없음'), SALARY
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE,'부서 없음'), SALARY) IN (
    SELECT NVL(DEPT_CODE,'부서 없음'), MIN(SALARY)
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
)
ORDER BY DEPT_CODE;


/*
    <인라인 뷰>
      FROM 절에 서브쿼리를 제시하고, 서브 쿼리를 수행한 결과를 테이블 대신에 사용한다.
*/
-- 전 직원 중 급여가 가장 높은 상위 5명 순위, 이름, 급여 조회
-- ROWNUM : 오라클에서 제공하는 컬럼, 조회된 순서대로 1부터 순번을 부여하는 칼럼이다.
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;
-- 이미 순번이 정해진 다음에 정렬이 되었다.
-- FROM -> SELECT(순번이 정해진다.ROWNUM) -> ORDER BY

SELECT ROWNUM, EMP_NAME, SALARY
FROM(
    SELECT EMP_NAME, SALARY
    FROM EMPLOYEE
    ORDER BY SALARY DESC  -- FROM절 안에 서브쿼리를 사용함(인라인 뷰)으로써 EMP_NAME, SALARY만 접근 가능한 가상의 컬럼 생성
)
WHERE ROWNUM <= 5;

SELECT ROWNUM, E.EMP_NAME, E.SALARY
--SELECT ROWNUM, E.*  -- 별칭 가능
FROM(
    SELECT EMP_NAME, SALARY
    FROM EMPLOYEE
    ORDER BY SALARY DESC  -- FROM절 안에 서브쿼리를 사용함(인라인 뷰)으로써 EMP_NAME, SALARY만 접근 가능한 가상의 컬럼 생성
) E
WHERE ROWNUM <= 5;

-- 부서별 평균 급여가 높은 3개의 부서의 부서 코드, 평균 급여 조회
-- 인라인 뷰를 사용하는 방법
SELECT ROWNUM, "부서 코드", "평균 급여"
--SELECT ROWNUM, E.*
FROM(
    SELECT NVL(DEPT_CODE,'부서 없음') AS "부서 코드",
           FLOOR(AVG(NVL(SALARY,0))) AS "평균 급여"
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
    ORDER BY  AVG(NVL(SALARY,0)) DESC
) E
WHERE ROWNUM <= 3;

-- WITH를 사용하는 방법 (WITH는 ;전까지 사용 가능)
WITH TOPN_SAL AS (
    SELECT NVL(DEPT_CODE,'부서 없음') AS "부서 코드",
           FLOOR(AVG(NVL(SALARY,0))) AS "평균 급여"
    FROM EMPLOYEE
    GROUP BY DEPT_CODE
    ORDER BY  AVG(NVL(SALARY,0)) DESC
)

SELECT ROWNUM, "부서 코드", "평균 급여"
FROM TOPN_SAL
WHERE ROWNUM <= 3;


/*
    <RANK 함수>
      데이터의 순위를 알아내는 함수이다.
      RANK() OVER(정렬기준) / DENSE RANK() OVER(정렬기준)
*/
-- 사원별 급여가 높은 순서대로 순위 매겨서 순위, 직원명, 급여 조회
-- RANK() OVER 함수는 동일한 순위가 있는 경우 다음 등수를 건너뛰고 순위를 계산한다.
-- 공동 19위 2명 뒤에 순위는 21위
SELECT RANK() OVER(ORDER BY SALARY DESC)AS "순위",
       EMP_NAME AS "직원명",
       SALARY AS "급여"
FROM EMPLOYEE;

-- DENSE_RANK() OVER 함수는 동일한 순위가 있어도 다음 등수를 건너뛰지 않고 순위를 계산한다.
-- 공동 19위 2명 뒤에 순위는 20위
SELECT DENSE_RANK() OVER(ORDER BY SALARY DESC)AS "순위",
       EMP_NAME AS "직원명",
       SALARY AS "급여"
FROM EMPLOYEE;

-- 상위 5명만 조회
SELECT RANK() OVER(ORDER BY SALARY DESC)AS "순위",
       EMP_NAME AS "직원명",
       SALARY AS "급여"
FROM EMPLOYEE
-- RANK 함수는 WHERE 절에서 사용할 수 없다.
WHERE RANK() OVER(ORDER BY SALARY DESC) <= 5;

-- 이때 인라인뷰를 사용한다.
SELECT "순위", "직원명", "급여"
FROM (
    SELECT RANK() OVER(ORDER BY SALARY DESC)AS "순위",
           EMP_NAME AS "직원명",
           SALARY AS "급여"
    FROM EMPLOYEE
)
WHERE "순위" <= 5;