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