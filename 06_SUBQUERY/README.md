## SUBQUERY
### 1. 서브 쿼리(SUBQUERY)
* SQL 문장 안에 포함되어 있는 또 다른 SQL 문장을 서브 쿼리라 한다.
* 서브 쿼리는 반드시 괄호 () 안에 넣어 표현해야 하고 메인 쿼리가 실행되기 전 한 번만 실행된다.
### 2. 단일행 서브 쿼리
* 단일행 서브 쿼리는 서브 쿼리의 결과가 한 개의 행, 한 개의 열인 서브 쿼리이다. (결과 값이 한 개인 서브 쿼리)
  ```sql
  SELECT EMP_NAME, 
         JOB_CODE, 
         DEPT_CODE, 
         SALARY
  FROM EMPLOYEE E
  WHERE SALARY >= (
      SELECT AVG(SALARY) 
      FROM EMPLOYEE
  )
  ```
### 3. 다중행 서브 쿼리
* 다중행 서브 쿼리는 서브 쿼리의 결과가 여러 개의 행, 한 개의 열인 서브 쿼리이다.
  ```sql
  SELECT EMP_NAME, 
         JOB_CODE, 
         DEPT_CODE, 
         SALARY
  FROM EMPLOYEE
  WHERE SALARY IN (
      SELECT MAX(SALARY) 
      FROM EMPLOYEE 
      GROUP BY DEPT_CODE
  )
  ```
### 4. 다중열 서브 쿼리
* 다중열 서브 쿼리는 서브 쿼리의 결과가 한 개의 행, 여러 개의 열인 서브 쿼리이다.
  ```sql
  SELECT EMP_NAME, 
         JOB_CODE, 
         DEPT_CODE, 
         HIRE_DATE
  FROM EMPLOYEE
  WHERE (DEPT_CODE, JOB_CODE) IN (
      SELECT DEPT_CODE, 
             JOB_CODE 
      FROM EMPLOYEE 
      WHERE SUBSTR(EMP_NO, 8, 1) = 2 AND ENT_YN = 'Y'
  );
  ```
### 5. 다중행 다중열 서브 쿼리
* 다중행 다중열 서브 쿼리는 서브 쿼리의 결과가 여러 개의 행, 여러 개의 열인 서브 쿼리이다.
  ```sql
  SELECT EMP_ID, 
         EMP_NAME, 
         JOB_CODE, 
         SALARY
  FROM EMPLOYEE
  WHERE (JOB_CODE, SALARY) IN (
      SELECT JOB_CODE, 
             MIN(SALARY) 
      FROM EMPLOYEE 
      GROUP BY JOB_CODE
  )
  ```
### 6. 인라인 뷰(INLINE-VIEW)
* 메인 쿼리의 FROM 절에 서브 쿼리를 사용하는 것을 인라인 뷰라 한다.
* 서브 쿼리를 수행한 결과를 가상 테이블로 생성해서 테이블 대신에 사용한다.
  ```sql
  SELECT ROWNUM, 
         EMP_NAME, 
         SALARY
  FROM (
      SELECT * 
      FROM EMPLOYEE
      ORDER BY SALARY DESC
  )
  WHERE ROWNUM <= 5; 
  ```
### 7. WITH
* 서브 쿼리에 이름을 붙여주고 인라인 뷰 대신 사용하는 것을 WITH라 한다.
* 동일한 서브 쿼리가 여러 번 사용될 경우 중복 작성을 피할 수 있고 실행 속도도 빨라진다는 장점이 있다.
  ```sql
  WITH TOPN_SAL AS (
      SELECT EMP_NAME, 
             SALARY
      FROM EMPLOYEE
      ORDER BY SALARY DESC
  )

  SELECT ROWNUM, 
         EMP_NAME, 
         SALARY
  FROM TOPN_SAL;
  ```
### 8. RANK 함수
* 데이터의 순위를 알아내는 함수이다.
* RANK() OVER 함수는 동일한 순위가 있는 경우 다음 등수를 건너뛰고 순위를 계산한다.
  ```sql
  SELECT RANK() OVER(ORDER BY SALARY DESC) AS "RANK" ,
         EMP_NAME, 
         SALARY
  FROM EMPLOYEE;
  ```
* DENSE_RANK() OVER 함수는 동일한 순위가 있어도 다음 등수를 건너뛰지 않고 순위를 계산한다.
  ```sql
  SELECT DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "RANK" ,
         EMP_NAME, 
         SALARY
  FROM EMPLOYEE; 
  ```
