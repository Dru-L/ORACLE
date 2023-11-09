/*
    <JOIN>
     1. INNER JOIN
        1) 오라클 전용 구문
           SELECT 컬럼, ...
           FROM 테이블1, 테이블2
           WHERE 테이블1.컬럼 = 테이블2.컬럼;
           컬럼 데이터가 동일해야 한다.
        2) ANSI 표준 구문
*/
-- 1-1) 연결할 두 컬럼명이 다른 경우
-- EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인하여 각 사원들의 사번, 직원명, 부서 코드, 부서명을 조회
-- 일치하는 값이 없는 행은 조회에서 제외된다.
--  DEPT_CODE가 NULL인 사원
--  DEPT_ID가 D3,D4,D7인 부서
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
ORDER BY DEPT_ID;

-- 1-2) 연결할 두 컬럼명이 같은 경우
-- EMPLOYEE 테이블과 JOB 테이블을 조인하여 사번, 직원명, 직급 코드, 직급명을 조회
-- 방법 1) 테이블명을 이용하는 방법
SELECT EMPLOYEE.EMP_ID,
       EMPLOYEE.EMP_NAME,
       JOB.JOB_CODE, 
       JOB.JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

-- 방법 2) 테이블의 별칭을 이용하는 방법 (FROM에서 별칭을 정해주기)
SELECT E.EMP_ID,
       E.EMP_NAME,
       J.JOB_CODE, 
       J.JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

SELECT E.EMP_ID,
       E.EMP_NAME,
       J.*
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;


/*
    2) ANSI 표준구문
       SELECT 컬럼, ...
       FROM 테이블1
       [INNER|OUTER] JOIN 테이블2 ON (테이블1.컬럼명 = 테이블2.컬럼명)
*/
-- 2-1) 연결할 두 컬럼명이 다른 경우
-- EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인하여 사번, 직원명, 부서코드, 부서명을 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
/* INNER */ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
ORDER BY DEPT_ID;

-- 2-2) 연결할 두 컬럼명이 같은 경우
-- EMPLOYEE 테이블과 JOB 테이블을 조인하여 사번, 직원명, 직급 코드, 직급명을 조회
-- 방법 1) 테이블명을 이용하는 방법
SELECT EMPLOYEE.EMP_ID,
       EMPLOYEE.EMP_NAME,
       JOB.JOB_CODE, 
       JOB.JOB_NAME
FROM EMPLOYEE
INNER JOIN JOB ON (EMPLOYEE.JOB_CODE = JOB.JOB_CODE);

-- 방법 2) 테이블의 별칭을 이용하는 방법 (FROM에서 별칭을 정해주기)
SELECT E.EMP_ID,
       E.EMP_NAME,
       J.*
FROM EMPLOYEE E
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
ORDER BY J.JOB_CODE;

-- 방법 3) USING 구문을 이용하는 방법
SELECT EMP_ID,
       EMP_NAME,
       JOB_CODE, -- USING 구문을 이용하면 같은 컬럼으로 인식해서 에러가 발생하지 않는다.
       JOB_NAME
FROM EMPLOYEE
INNER JOIN JOB USING (JOB_CODE);

-- 방법 4) NATURAL JOIN을 이용하는 방법(참고만 하기) 
SELECT EMP_ID,
       EMP_NAME,
       JOB_CODE,
       JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;

-- EMPLOYEE 테이블과 JOB 테이블을 조인하여 직급이 대리인 사원의 사번, 직원명, 직급명, 급여를 조회
-- 오라클
SELECT E.EMP_ID,
       E.EMP_NAME,
       J.JOB_CODE,
       E.SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE -- ㅡJOIN 조건
 AND J.JOB_NAME = '대리'
ORDER BY E.EMP_NAME; -- 검색 조건

-- ANSI
SELECT E.EMP_ID,
       E.EMP_NAME,
       J.JOB_CODE,
       E.SALARY
FROM EMPLOYEE E
INNER JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE J.JOB_NAME = '대리';


-- DEPARTMENT 테이블과 LOCATION  테이블을 조인하여 부서 코드, 부서명, 지역 코드, 지역명을 조회
-- 오라클
SELECT D.DEPT_ID AS "부서코드",
       D.DEPT_TITLE AS "부서명",
       L.LOCAL_CODE AS "지역코드",
       L.LOCAL_NAME AS "지역명"
FROM DEPARTMENT D, LOCATION L
WHERE D.LOCATION_ID = L.LOCAL_CODE
ORDER BY D.LOCATION_ID;

-- ANSI
SELECT D.DEPT_ID AS "부서코드",
       D.DEPT_TITLE AS "부서명",
       L.LOCAL_CODE AS "지역코드",
       L.LOCAL_NAME AS "지역명"
FROM DEPARTMENT D
INNER JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
ORDER BY D.LOCATION_ID;

-- EMPOLYEE 테이블과 DEPARTMENT 테이블을 조인해서 보너스를 받는 사원들의 사번, 직원명, 보너스, 부서명을 조회
-- 오라클
SELECT EMPLOYEE.EMP_ID AS "사번",
       EMPLOYEE.EMP_NAME AS "직원명",
       EMPLOYEE.BONUS AS "보너스",
       DEPARTMENT.DEPT_TITLE AS "부서명"
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND BONUS IS NOT NULL
-- AND NVL(BONUS,0) >0;
ORDER BY EMP_ID; 

-- ANSI
SELECT EMPLOYEE.EMP_ID AS "사번",
       EMPLOYEE.EMP_NAME AS "직원명",
       EMPLOYEE.BONUS AS "보너스",
       DEPARTMENT.DEPT_TITLE AS "부서명"
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL
ORDER BY EMP_ID;

-- EMPOLYEE 테이블과 DEPARTMENT 테이블을 조인해서 인사관리부가 아닌 사원들의 직원명, 부서명, 급여를 조회
-- 오라클
SELECT E.EMP_NAME AS "직원명",
       D.DEPT_TITLE AS "부서명",
       TO_CHAR(E.SALARY,'$999,999,999') AS "급여"
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
AND D.DEPT_TITLE != '인사관리부'
ORDER BY E.DEPT_CODE;

-- ANSI
SELECT E.EMP_NAME AS "직원명",
       D.DEPT_TITLE AS "부서명",
       TO_CHAR(E.SALARY,'$999,999,999') AS "급여"
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
WHERE D.DEPT_TITLE != '인사관리부'
ORDER BY E.DEPT_CODE;

-- EMPOLYEE 테이블, DEPARTMENT 테이블, JOB 테이블을 조인해서 사번, 직원명, 부서명, 직급명 조회
-- 오라클
SELECT E.EMP_ID AS "사번",
       E.EMP_NAME AS "직원명",
       D.DEPT_TITLE AS "부서명",
       J.JOB_NAME AS "직급명"
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
AND E.JOB_CODE = J.JOB_CODE
ORDER BY E.DEPT_CODE, E.JOB_CODE DESC;

-- ANSI -> JOIN 순서 중요
SELECT E.EMP_ID AS "사번",
       E.EMP_NAME AS "직원명",
       D.DEPT_TITLE AS "부서명",
       J.JOB_NAME AS "직급명"
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
INNER JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
ORDER BY E.DEPT_CODE, E.JOB_CODE DESC;


/*
    2. OUTER JOIN
       조인 조건을 만족하지 않는 행들을 조회하기 위한 구문이다.
       단, 반드시 기준이 되는 테이블(컬럼)을 지정해야 한다.
       (LEFT, RIGHT, FULL, (+))
*/
-- OUTER JOIN 과 비교할 INNTER JOIN 구문
-- EMPLOYEE 테이블과 DEPARTMENT 테이블을 조인해서 사원들의 사원명, 부서명, 급여, 연봉 조회
-- 부서가 지정되지 않은 사원 2명에 대한 정보가 조회되지 않는다.
-- 부서가 지정되어 있어도 DEPARTMENT에 부서에 대한 정보가 없으면 조회되지않는다
SELECT E.EMP_NAME,
       D.DEPT_TITLE,
       E.SALARY,
       E.SALARY *12
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID);

/*
   1 ) LEFT OUTER JOIN
       - 두 테이블 중 왼쪽에 기술된 테이블의 컬럼을 기준으로 조회하려고 할 때 사용한다.
*/
-- ANSI
-- 부서 코드가 없던 사원(이오리, 하동운)의 정보가 출력된다.
SELECT E.EMP_NAME,
       D.DEPT_TITLE,
       E.SALARY, 
       E.SALARY *12
FROM EMPLOYEE E
LEFT /*OUTER*/ JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)  
ORDER BY DEPT_CODE DESC;

-- 오라클 : (+) 이용
-- LEFT OUTER JOIN : WHERE 테이블1.컬럼 = 테이블2.컬럼(+);
-- RIGHT OUTER JOIN : WHERE 테이블1.컬럼(+) = 테이블2.컬럼;
SELECT E.EMP_NAME,
       D.DEPT_TITLE,
       E.SALARY, 
       E.SALARY *12
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID(+) -- 오른쪽 테이블 컬럼에 (+)표시
ORDER BY E.DEPT_CODE DESC;

/*
   2 ) RIGHT OUTER JOIN
       - 두 테이블 중 오른쪽에 기술된 테이블의 컬럼을 기준으로 조회하려고 할 때 사용한다.
*/
-- ANSI
SELECT E.EMP_NAME,
       D.DEPT_TITLE,
       E.SALARY, 
       E.SALARY *12
FROM EMPLOYEE E
RIGHT /*OUTER*/ JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)  
ORDER BY DEPT_CODE DESC;

-- 오라클 : (+) 이용
SELECT E.EMP_NAME,
       D.DEPT_TITLE,
       E.SALARY, 
       E.SALARY *12
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE(+) = D.DEPT_ID -- 왼쪽 테이블 컬럼에 (+)표시
ORDER BY E.DEPT_CODE DESC;

/*
   3 ) FULL OUTER JOIN
       - 두 테이블이 가진 모든 행을 조회할 때 사용한다.
       오라클 구문에서는 FULL을 지원하지않음
*/
-- ANSI
SELECT E.EMP_NAME,
       D.DEPT_TITLE,
       E.SALARY, 
       E.SALARY *12
FROM EMPLOYEE E
FULL /*OUTER*/ JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)  
ORDER BY DEPT_CODE DESC;

-- 오라클 : (+) 이용 => 에러발생
SELECT E.EMP_NAME,
       D.DEPT_TITLE,
       E.SALARY, 
       E.SALARY *12
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE(+) = D.DEPT_ID(+) -- 에러발생
ORDER BY E.DEPT_CODE DESC;

/*
    3. CROSS JOIN
       조인되는 모든 테이블의 행들이 서로서로 매핑된 데이터가 검색된다.
*/
-- ANSI
SELECT E.EMP_NAME, D.DEPT_TITLE
FROM EMPLOYEE E -- EMPLOYEE를 기준으로 DEPARTMENT에 있는 정보를 각각 매핑(보여지는 정보로 예시 : 이름별로 각 부서에 매핑)
CROSS JOIN DEPARTMENT D -- 23 * 9 = 207
ORDER BY E.EMP_NAME, D.DEPT_ID;

-- 오라클
SELECT E.EMP_NAME, D.DEPT_TITLE
FROM EMPLOYEE E, DEPARTMENT D;


/*
    < 4. NON EQUAL JOIN (비등가 조인)>
        - 조인 조건에 등호(=)를 사용하지 않는 조인문을 '비등가 조인'이라고 한다
        - USING 사용 불가 , ON절만 사용 가능
*/
-- EMPLOYEE 테이블과 SAL_GRADE 테이블을 비등가 조인하여 직원명, 급여, 급여 등급 조회
-- ANSI
SELECT E.EMP_NAME,
       E.SALARY,
       S.*
FROM EMPLOYEE E
LEFT OUTER JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL); --OUTER
--INNER JOIN SAL_GRADE S ON (E.SALARY >= S.MIN_SAL AND E.SALARY <= S.MAX_SAL); -- INNER
--INNER JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);

SELECT E.EMP_NAME,
       E.SALARY,
       S.*
FROM EMPLOYEE E, SAL_GRADE S
WHERE E.SALARY BETWEEN S.MIN_SAL(+) AND S.MAX_SAL(+); -- OUTER
--WHERE E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL; -- INNER

/*
    < 5. SELF JOIN >
        - 동일한 테이블을 가지고(자기자신이 2개) 데이터를 JOIN하여 조회하기 위해 사용되는 구문이다.
*/
SELECT E.EMP_ID,
       E.EMP_NAME,
       MANAGER_ID
FROM EMPLOYEE E;

-- EMPLOYEE 테이블을 SELF JOIN 하여 사번, 직원명, 부서 코드, 사수 사번, 사수 이름 조회
-- ANSI
SELECT E.EMP_ID AS "사번",
       E.EMP_NAME AS "사원 이름",
       E.DEPT_CODE AS "부서코드",
--       E.MANAGER_ID AS "사수 사번",
       M.EMP_ID AS "사수 사번",
       M.EMP_NAME AS "사수 이름"
FROM EMPLOYEE E
INNER JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

-- 오라클 구문
SELECT E.EMP_ID AS "사번",
       E.EMP_NAME AS "사원 이름",
       E.DEPT_CODE AS "부서코드",
       M.EMP_ID AS "사수 사번",
       M.EMP_NAME AS "사수 이름"
FROM EMPLOYEE E, EMPLOYEE M
--WHERE E.MANAGER_ID = M.EMP_ID;
WHERE E.MANAGER_ID = M.EMP_ID(+);

/*
    < 6. 다중 JOIN >
        - 여러 개의 테이블을 조인하는 경우에 사용한다.
*/
-- EMPLOYEE, DEPARTMENT, LOCATION 테이블을 다중 JOIN 하여 사번, 직원명, 지역명을 조회
SELECT * FROM EMPLOYEE;   -- DEPT_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID    LOCATION_ID
SELECT * FROM LOCATION;   --            LOCAL_CODE

-- ANSI
SELECT E.EMP_ID,
       E.EMP_NAME,
       D.DEPT_TITLE,
       L.LOCAL_NAME
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
INNER JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);  -- 순서가 중요(처음 JOIN한 전체 테이블에서 LOCATION이랑 JOIN)

-- ANSI OUTER JOIN 
SELECT E.EMP_ID,
       E.EMP_NAME,
       D.DEPT_TITLE,
       L.LOCAL_NAME
FROM EMPLOYEE E
LEFT OUTER JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT OUTER JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE);

-- 오라클
SELECT E.EMP_ID,
       E.EMP_NAME,
       D.DEPT_TITLE,
       L.LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
--WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE;
WHERE E.DEPT_CODE = D.DEPT_ID(+) AND D.LOCATION_ID = L.LOCAL_CODE(+);


------------------------------- 다중 조인 실습 문제 ----------------------------
SELECT * FROM EMPLOYEE;     -- DEPT_CODE                                    SALARY
SELECT * FROM DEPARTMENT;   -- DEPT_ID      LOCATION_ID
SELECT * FROM LOCATION;     --              LOCAL_CODE      NATIONAL_CODE
SELECT * FROM NATIONAL;     --                              NATIONAL_CODE
SELECT * FROM SAL_GRADE;    --                                              MIN_SAL, MAX_SAL

-- 1. 사번(EMP_ID), 직원명(EMP_NAME), 부서명(DEPT_TITLE), 지역명(LOCAL_NAME), 국가명(NATIONAL_NAME), 조회
-- ANSI 표준 구문
SELECT E.EMP_ID AS "사번",
       E.EMP_NAME AS "직원명",
       D.DEPT_TITLE AS "부서명",
       L.LOCAL_NAME AS "지역명",
       N.NATIONAL_NAME AS "국가명"
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
ORDER BY DEPT_CODE;

-- 오라클 구문
SELECT E.EMP_ID AS "사번",
       E.EMP_NAME AS "직원명",
       D.DEPT_TITLE AS "부서명",
       L.LOCAL_NAME AS "지역명",
       N.NATIONAL_NAME AS "국가명"
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE AND L.NATIONAL_CODE = N.NATIONAL_CODE
ORDER BY DEPT_CODE;

-- 2. 사번(EMP_ID), 직원명(EMP_NAME), 부서명(DEPT_TITLE), 지역명(LOCAL_NAME), 국가명(NATIONAL_NAME), 급여 등급(SAL_LEVEL) 조회
-- ANSI 표준 구문
SELECT E.EMP_ID AS "사번",
       E.EMP_NAME AS "직원명",
       D.DEPT_TITLE AS "부서명",
       L.LOCAL_NAME AS "지역명",
       N.NATIONAL_NAME AS "국가명",
       S.SAL_LEVEL AS "급여 등급"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
LEFT JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
LEFT JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL)
ORDER BY DEPT_CODE, SAL_LEVEL;

-- 오라클 구문
SELECT E.EMP_ID AS "사번",
       E.EMP_NAME AS "직원명",
       D.DEPT_TITLE AS "부서명",
       L.LOCAL_NAME AS "지역명",
       N.NATIONAL_NAME AS "국가명",
       S.SAL_LEVEL AS "급여 등급"
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N, SAL_GRADE S
WHERE E.DEPT_CODE = D.DEPT_ID(+)
  AND D.LOCATION_ID = L.LOCAL_CODE(+)
  AND L.NATIONAL_CODE = N.NATIONAL_CODE(+)
  AND E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL
ORDER BY DEPT_CODE, SAL_LEVEL;

------------------------------- 조인 종합 실습 문제 ----------------------------
-- 1. 직급이 대리이면서 ASIA 지역에서 근무하는 직원들의 사번, 직원명, 직급명, 부서명, 근무지역, 급여를 조회하세요.
-- ANSI 구문
SELECT E.EMP_ID AS "사번",
       E.EMP_NAME AS "직원명",
       J.JOB_NAME AS "직급명",
       D.DEPT_TITLE AS "부서명",
       L.LOCAL_NAME AS "근무 지역",
       TO_CHAR(E.SALARY,'FML9,999,999') AS "급여"
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
INNER JOIN JOB J USING (JOB_CODE)
INNER JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE J.JOB_NAME = '대리' AND L.LOCAL_NAME LIKE 'ASIA%'
ORDER BY L.LOCAL_CODE, J.JOB_NAME;

-- 오라클 구문
SELECT E.EMP_ID AS "사번",
       E.EMP_NAME AS "직원명",
       J.JOB_NAME AS "직급명",
       D.DEPT_TITLE AS "부서명",
       L.LOCAL_NAME AS "근무 지역",
       TO_CHAR(E.SALARY,'FML9,999,999') AS "급여"
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID
  AND E.JOB_CODE = J.JOB_CODE
  AND D.LOCATION_ID = L.LOCAL_CODE
  AND J.JOB_NAME = '대리' AND L.LOCAL_NAME LIKE 'ASIA%'
ORDER BY L.LOCAL_CODE, J.JOB_NAME;

-- 2. 70년대생 이면서 여자이고, 성이 전 씨인 직원들의 직원명, 주민번호, 부서명, 직급명을 조회하세요.
-- ANSI 구문
SELECT E.EMP_NAME AS "직원명",
       E.EMP_NO AS "주민번호",
       D.DEPT_TITLE AS "부서명",
       J.JOB_NAME AS "직급명"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE E.EMP_NO LIKE '7%' AND SUBSTR(E.EMP_NO,8,1)=2 AND EMP_NAME LIKE '전%';

-- 오라클 구문
SELECT E.EMP_NAME AS "직원명",
       E.EMP_NO AS "주민번호",
       D.DEPT_TITLE AS "부서명",
       J.JOB_NAME AS "직급명"
FROM EMPLOYEE E, DEPARTMENT D, JOB J 
WHERE E.DEPT_CODE = D.DEPT_ID AND E.JOB_CODE = J.JOB_CODE
  AND SUBSTR(E.EMP_NO,1,2) >= 70 AND SUBSTR(E.EMP_NO,1,2) < 80 AND SUBSTR(E.EMP_NO,8,1)=2 AND EMP_NAME LIKE '전%';

-- 3. 보너스를 받는 직원들의 직원명, 보너스, 연봉, 부서명, 근무지역을 조회하세요.
--    단, 부서 코드가 없는 사원도 출력될 수 있게 OUTER JOIN 사용
-- ANSI 구문
SELECT E.EMP_NAME AS "직원명",
       E.BONUS AS "보너스",
       TO_CHAR(E.SALARY * 12,'FML999,999,999') AS "연봉",
       NVL(D.DEPT_TITLE, '부서 없음') AS "부서명",
       NVL(L.LOCAL_NAME, '지역 없음') AS "근무 지역"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
WHERE E.BONUS IS NOT NULL
ORDER BY D.DEPT_ID, E.SALARY;

-- 오라클 구문
SELECT E.EMP_NAME AS "직원명",
       E.BONUS AS "보너스",
       TO_CHAR(E.SALARY * 12,'FML999,999,999') AS "연봉",
       NVL(D.DEPT_TITLE, '부서 없음') AS "부서명",
       NVL(L.LOCAL_NAME, '지역 없음') AS "근무 지역"
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID(+)
  AND D.LOCATION_ID = L.LOCAL_CODE(+)
  AND E.BONUS IS NOT NULL
ORDER BY D.DEPT_ID, E.SALARY;

-- 4. 한국과 일본에서 근무하는 직원들의 직원명, 부서명, 근무지역, 근무 국가를 조회하세요.
-- ANSI 구문
SELECT E.EMP_NAME AS "직원명",
       D.DEPT_TITLE AS "부서명",
       L.LOCAL_NAME AS "근무 지역",
       N.NATIONAL_NAME AS "근무 국가"
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
INNER JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
INNER JOIN NATIONAL N ON (L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE N.NATIONAL_NAME IN('한국','일본')
ORDER BY N.NATIONAL_CODE, D.DEPT_ID;

-- 오라클 구문
SELECT E.EMP_NAME AS "직원명",
       D.DEPT_TITLE AS "부서명",
       L.LOCAL_NAME AS "근무 지역",
       N.NATIONAL_NAME AS "근무 국가"
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID
    AND D.LOCATION_ID = L.LOCAL_CODE
    AND L.NATIONAL_CODE = N.NATIONAL_CODE
    AND N.NATIONAL_NAME IN('한국','일본')
ORDER BY N.NATIONAL_CODE, D.DEPT_ID;

-- 5. 각 부서별 평균 급여를 조회하여 부서명, 평균 급여(정수 처리)를 조회하세요.
--    단, 부서 배치가 안된 사원들의 평균도 같이 나오게끔 해주세요^^
-- ANSI 구문
SELECT NVL(D.DEPT_TITLE,'부서 없음') AS "부서명",
       TO_CHAR(FLOOR(AVG(NVL(E.SALARY,0))),'FML999,999,999') AS "평균 급여"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
GROUP BY D.DEPT_TITLE;

-- 오라클 구문
SELECT NVL(D.DEPT_TITLE,'부서 없음') AS "부서명",
       TO_CHAR(FLOOR(AVG(NVL(E.SALARY,0))),'FML999,999,999') AS "평균 급여"
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID(+)
GROUP BY D.DEPT_TITLE;

-- 6. 각 부서별 총 급여의 합이 1000만원 이상인 부서명, 급여의 합을 조회하시오.
-- ANSI 구문
SELECT NVL(D.DEPT_TITLE,'부서 없음') AS "부서명",
       TO_CHAR(SUM(NVL(E.SALARY,0)),'FML999,999,999') AS "급여 합계"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
GROUP BY D.DEPT_TITLE
HAVING SUM(NVL(E.SALARY,0)) >= 10000000
ORDER BY "부서명";

-- 오라클 구문
SELECT NVL(D.DEPT_TITLE,'부서 없음') AS "부서명",
       TO_CHAR(SUM(NVL(E.SALARY,0)),'FML999,999,999') AS "급여 합계"
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID
GROUP BY D.DEPT_TITLE
HAVING SUM(NVL(E.SALARY,0)) >= 10000000
ORDER BY "부서명";

-- 7. 사번, 직원명, 직급명, 급여 등급, 구분을 조회
--    이때 구분에 해당하는 값은 아래와 같이 조회 되도록 하시오.
--    급여 등급이 S1, S2인 경우 '고급'
--    급여 등급이 S3, S4인 경우 '중급'
--    급여 등급이 S5, S6인 경우 '초급'
-- ANSI 구문
SELECT E.EMP_ID AS "사번",
       E.EMP_NAME AS "직원명",
       J.JOB_NAME AS "직급명",
       S.SAL_LEVEL AS "급여 등급",
       CASE WHEN S.SAL_LEVEL IN ('S1','S2') THEN '고급'
            WHEN S.SAL_LEVEL IN ('S3','S4') THEN '중급'
            WHEN S.SAL_LEVEL IN ('S5','S6') THEN '초급'
       END AS "구분"
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
LEFT JOIN SAL_GRADE S ON (E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL)
ORDER BY "구분", J.JOB_CODE;

-- 오라클 구문
SELECT E.EMP_ID AS "사번",
       E.EMP_NAME AS "직원명",
       J.JOB_NAME AS "직급명",
       S.SAL_LEVEL AS "급여 등급",
       CASE WHEN S.SAL_LEVEL IN ('S1','S2') THEN '고급'
            WHEN S.SAL_LEVEL IN ('S3','S4') THEN '중급'
            WHEN S.SAL_LEVEL IN ('S5','S6') THEN '초급'
       END AS "구분"
FROM EMPLOYEE E, JOB J, SAL_GRADE S
WHERE E.JOB_CODE = J.JOB_CODE
    AND E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL
ORDER BY "구분", J.JOB_CODE;  

-- 8. 보너스를 받지 않는 직원들 중 직급 코드가 J4 또는 J7인 직원들의 직원명, 직급명, 급여를 조회하시오.
-- ANSI 구문
SELECT E.EMP_NAME AS "직원명",
       J.JOB_NAME AS "직급명",
       E.SALARY AS "급여"
FROM EMPLOYEE E
INNER JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE E.BONUS IS NULL AND E.JOB_CODE IN ('J4','J7')
ORDER BY J.JOB_CODE DESC;

-- 오라클 구문
SELECT E.EMP_NAME AS "직원명",
       J.JOB_NAME AS "직급명",
       E.SALARY AS "급여"
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
    AND E.BONUS IS NULL
    AND E.JOB_CODE IN ('J4','J7')
ORDER BY J.JOB_CODE DESC;

-- 9. 부서가 있는 직원들의 직원명, 직급명, 부서명, 근무 지역을 조회하시오.
-- ANSI 구문
SELECT E.EMP_NAME AS "직원명",
       J.JOB_NAME AS "직급명",
       D.DEPT_TITLE AS "부서명",
       L.LOCAL_NAME AS "근무 지역"
FROM EMPLOYEE E
INNER JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
INNER JOIN JOB J USING (JOB_CODE)
INNER JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
ORDER BY L.LOCAL_CODE, J.JOB_NAME;

-- 오라클 구문
SELECT E.EMP_NAME AS "직원명",
       J.JOB_NAME AS "직급명",
       D.DEPT_TITLE AS "부서명",
       L.LOCAL_NAME AS "근무 지역"
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID
    AND E.JOB_CODE = J.JOB_CODE
    AND D.LOCATION_ID = L.LOCAL_CODE
ORDER BY L.LOCAL_CODE, J.JOB_NAME;

-- 10. 해외영업팀에 근무하는 직원들의 직원명, 직급명, 부서 코드, 부서명을 조회하시오.
-- ANSI 구문
SELECT E.EMP_NAME AS "직원명",
       J.JOB_NAME AS "직급명",
       E.DEPT_CODE AS "부서 코드",
       D.DEPT_TITLE AS "부서명"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE D.DEPT_TITLE LIKE '해외영업%'
ORDER BY "부서명", J.JOB_CODE DESC;

-- 오라클 구문
SELECT E.EMP_NAME AS "직원명",
       J.JOB_NAME AS "직급명",
       E.DEPT_CODE AS "부서 코드",
       D.DEPT_TITLE AS "부서명"
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
    AND E.JOB_CODE = J.JOB_CODE
    AND D.DEPT_TITLE LIKE '해외영업%'
ORDER BY "부서명", J.JOB_CODE DESC;

-- 11. 이름에 '형'자가 들어있는 직원들의 사번, 직원명, 직급명을 조회하시오.
-- ANSI 구문
SELECT E.EMP_ID AS "사번",
       E.EMP_NAME AS "직원명",
       J.JOB_NAME AS "직급명"
FROM EMPLOYEE E
LEFT JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE E.EMP_NAME LIKE '%형%'
ORDER BY J.JOB_CODE;

-- 오라클 구문
SELECT E.EMP_ID AS "사번",
       E.EMP_NAME AS "직원명",
       J.JOB_NAME AS "직급명"
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
    AND E.EMP_NAME LIKE '%형%'
ORDER BY J.JOB_CODE;