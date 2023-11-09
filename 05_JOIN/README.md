## JOIN
### 1. JOIN
* JOIN은 하나 이상의 테이블에서 데이터를 조회하기 위해 사용되는 구문이다.
* ​JOIN은 각 테이블 간에 특정 조건을 만족하는 데이터를 합쳐서 하나의 결과(Result Set)로 조회한다.
### 2. INNER JOIN
* INNER JOIN은 조인하려는 테이블들에서 공통된 컬럼의 값이 일치되는 행들을 하나의 행으로 연결하여 결과(Result Set)를 조회한다.
* INNER JOIN은 공통된 컬럼에서 공통된 값이 없거나 컬럼에 값이 없는 행은 조회되지 않는다.
#### 2.1. 오라클 전용 구문
* FROM 절에 ","로 구분하여 조인에 사용할 테이블들을 기술하고 WHERE 절에 공통된 값을 가진 컬럼에 대한 조건을 작성한다.
  ```sql
  SELECT EMP_ID, 
         EMP_NAME, 
         DEPT_CODE, 
         DEPT_TITLE
  FROM EMPLOYEE, DEPARTMENT
  WHERE DEPT_CODE = DEPT_ID;
  ```
#### 2.2. ANSI 표준 구문
* FROM 절 다음에 JOIN 구문을 통해 조인에 사용할 테이블을 기술하고 ON 또는 USING 절에 공통된 값을 가진 컬럼에 대한 조건을 작성한다.
  ```sql
  SELECT EMP_ID, 
         EMP_NAME, 
         DEPT_CODE, 
         DEPT_TITLE
  FROM EMPLOYEE
  INNER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
  ```
### 3. OUTER JOIN
* OUTER JOIN은 INNER JOIN과 다르게 공통된 컬럼에서 공통된 값이 없거나 컬럼에 값이 없는 행들도 함께 조회하기 위해서 사용되는 구문이다.
#### 3.1. LEFT OUTER JOIN
* 조인에 사용한 두 테이블 중 왼쪽에 기술된 테이블의 컬럼을 기준으로 조회하려고 할 때 사용한다.
* 즉, 오른쪽 테이블과 매칭되는 데이터가 없어도 조회된다.
  ```sql
  -- ANSI 구문
  SELECT EMP_NAME, 
         DEPT_TITLE
  FROM EMPLOYEE
  LEFT /* OUTER */ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

  -- 오라클 전용 구문
  SELECT EMP_NAME, 
         DEPT_TITLE 
  FROM EMPLOYEE, DEPARTMENT
  WHERE DEPT_CODE = DEPT_ID(+);
  ```
#### 3.2. RIGHT OUTER JOIN
* 조인에 사용한 두 테이블 중 오른쪽에 기술된 테이블의 컬럼을 기준으로 조회하려고 할 때 사용한다.
* 즉, 왼쪽 테이블과 매칭되는 데이터가 없어도 조회된다.
  ```sql
  -- ANSI 구문
  SELECT EMP_NAME, 
         DEPT_TITLE
  FROM EMPLOYEE
  RIGHT /* OUTER */ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

  -- 오라클 전용 구문
  SELECT EMP_NAME, 
         DEPT_TITLE 
  FROM EMPLOYEE, DEPARTMENT
  WHERE DEPT_CODE(+) = DEPT_ID;
  ```
#### 3.3. FULL OUTER JOIN
* 조인에 사용한 두 테이블이 가진 모든 테이블의 컬럼을 기준으로 조회하려고 할 때 사용한다.
* 즉, 왼쪽과 오른쪽 테이블 모두 매칭되는 데이터가 없어도 조회된다.
  ```sql
  -- ANSI 구문
  SELECT EMP_NAME, 
         DEPT_TITLE
  FROM EMPLOYEE
  FULL /* OUTER */ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

  -- 오라클 전용 구문 (에러 발생)
  SELECT EMP_NAME, 
         DEPT_TITLE 
  FROM EMPLOYEE, DEPARTMENT
  WHERE DEPT_CODE(+) = DEPT_ID(+); -- (+)는 한 쪽에만 사용 가능
  ```
### 4. CROSS JOIN
* CROSS JOIN은 카테시안 곱(Cartesian Product)라고도 하며 조인되는 테이블의 모든 행들이 매핑된 데이터를 조회하기 위해 사용되는 구문이다.
  ```sql
  SELECT EMP_NAME, 
         DEPT_TITLE
  FROM EMPLOYEE
  CROSS JOIN DEPARTMENT;
  ```
### 5. NON EQUAL JOIN
* NON EQUAL JOIN은 조인 조건에 등호(=)를 사용하지 않고 데이터를 조회하기 위해 사용되는 구문이다.
  ```sql
  SELECT EMP_NAME, 
         SALARY, 
         E.SAL_LEVEL
  FROM EMPLOYEE E
  JOIN SAL_GRADE S ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);
  ```
### 6. SELF JOIN
* SELF JOIN은 동일한 테이블을 가지고 JOIN 하여 데이터를 조회하기 위해 사용되는 구문이다.
  ```sql
  SELECT E.EMP_ID, 
         E.EMP_NAME, 
         E.DEPT_CODE, 
         E.MANAGER_ID,
	     M.EMP_NAME
  FROM EMPLOYEE E, EMPLOYEE M
  WHERE E.MANAGER_ID = M.EMP_ID;
  ```
### 7. 다중 JOIN
* 다중 JOIN은 여러 개의 테이블을 JOIN 하여 데이터를 조회하기 위해 사용되는 구문이다.
  ```sql
  SELECT EMP_ID, 
         EMP_NAME,
         DEPT_CODE, 
         DEPT_TITLE, 
         LOCAL_NAME
  FROM EMPLOYEE 
  JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);
  ```