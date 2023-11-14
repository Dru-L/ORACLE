/*
      <DELETE>
       - 테이블의 행을 삭제하는 구문이다.  
       DELETE FROM 테이블명
       [WHERE 조건식];
*/
-- EMPLOYEE 테이블에서 사번이 200인 사원의 데이터를 지우기
DELETE
FROM EMPLOYEE
WHERE EMP_ID = '200';

-- EMPOLYEE 테이블에서 DEPT_CODE가 'D5'인 직원들을 삭제
DELETE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- DEPARTMENT 테이블에서 DEPT_ID가 D1인 부서를 삭제
DELETE
FROM DEPARTMENT
WHERE DEPT_ID = 'D1'; -- D1 값을 참조하는 데이터가 있기 때문에 삭제 불가능

-- DEPARTMENT 테이블에서 DEPT_ID가 D3인 부서를 삭제
DELETE
FROM DEPARTMENT
WHERE DEPT_ID = 'D3'; -- D3값을 참조하는 데이터가 없기 때문에 삭제 가능

ROLLBACK;


/*
    <TRUNCATE>
        - 테이블의 전체 행을 삭제하는 구문이다.
        - DELETE보다 수행 속도가 빠르고 ROLLBACK을 통해 복구 불가능하다.
        TRUNCATE TABLE 테이블명;
*/
CREATE TABLE DEPT_COPY
AS SELECT *
    FROM DEPARTMENT;

TRUNCATE TABLE DEPT_COPY;

SELECT * FROM DEPT_COPY;

ROLLBACK; -- 롤백 불가능