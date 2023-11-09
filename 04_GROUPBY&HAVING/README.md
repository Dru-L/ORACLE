## GROUP BY & HAVING
### 1. GROUP BY
* 그룹 함수는 전체 데이터를 대상으로 작업하기 때문에 단 한 개의 결과 값만 리턴한다.
* 그룹 함수와 여러 개의 컬럼과 함께 사용하면 출력하는 데이터의 개수가 맞지 않아 오류 발생한다.
<br>![image](https://user-images.githubusercontent.com/26870393/164883378-03c60e59-8e57-4605-b48c-450a5c97cd60.png)
* 여러 개의 그룹을 설정하고 그룹 별로 그룹 함수의 결과 값을 산출하기 위해서는 그룹 함수가 적용될 그룹의 기준을 GROUP BY 절에 기술하여 사용한다.
<br>![image](https://user-images.githubusercontent.com/26870393/164883384-45f3af19-66f1-4d87-bbdb-f0fa7d6d4d06.png)

* GROUP BY 절은 WHERE와 ORDER BY 절 사이에 위치한다.
* GROUP BY 절에는 별칭을 사용할 수 없고 반드시 컬럼명을 적어 주어야 한다.
  ```sql
  SELECT DEPT_CODE AS "부서코드", 
         COUNT(BONUS) AS "인원수"
  FROM EMPLOYEE
  GROUP BY DEPT_CODE
  ORDER BY DEPT_CODE ASC;
  ```
### 2. HAVING
* HAVING 절은 그룹 함수로 값을 구해올 그룹에 대해 조건을 설정할 때 사용한다. (WHERE 절은 SELECT에 대한 조건이다.)
* HAVING 절은 GROUP BY 절 이전이든 이후이든 어느 곳에 위치해도 상관없다.
  ```sql
  SELECT DEPT_CODE, 
         FLOOR(AVG(SALARY))
  FROM EMPLOYEE
  -- WHERE FLOOR(AVG(SALARY)) >= 3000000 에러 발생
  GROUP BY DEPT_CODE
  HAVING FLOOR(AVG(SALARY)) >= 3000000;
  ```
### 3. ROLLUP & CUBE 함수
* 쿼리 작업 시 소계나 합계 등의 작업을 할 경우 유용하게 사용된다.
* ROLLUP과 CUBE 함수는 그룹 별 산출한 결과 값의 집계를 계산하는 함수이다.
* ROLLUP 함수는 주어진 데이터 그룹의 소계를 구해준다.
  ```sql
  SELECT JOB_CODE, 
         SUM(SALARY)
  FROM EMPLOYEE
  GROUP BY ROLLUP(JOB_CODE)
  ORDER BY 1;
  ```
* CUBE 함수는 주어진 데이터 그룹의 소계와 전체 총계까지 구해준다.
  ```sql
  SELECT JOB_CODE, 
         SUM(SALARY)
  FROM EMPLOYEE
  GROUP BY CUBE(JOB_CODE)
  ORDER BY 1;
  ```
## 집합 연산자
### 1. 집합 연산자
* 여러 개의 쿼리문을 가지고 하나의 쿼리문으로 만드는 연산자이다.
### 2. UNION
* 여러 개의 쿼리 결과를 합치는 연산자로 중복된 영역은 제거한다.
  ```sql
  SELECT *
  FROM EMPLOYEE
  WHERE DEPT_CODE = 'D5'

  UNION

  SELECT *
  FROM EMPLOYEE
  WHERE SALARY > 3000000;
  ```
### 3. UNION ALL
* 여러 개의 쿼리 결과를 합치는 연산자로 중복된 영역 모두 포함한다.
  ```sql
  SELECT *
  FROM EMPLOYEE
  WHERE DEPT_CODE = 'D5'

  UNION ALL
  
  SELECT *
  FROM EMPLOYEE
  WHERE SALARY > 3000000;
  ```
### 4. INTERSECT
* 여러 개의 쿼리 결과에서 공통된 부분만 결과로 추출한다.
  ```sql
  SELECT *
  FROM EMPLOYEE
  WHERE DEPT_CODE = 'D5'

  INTERSECT
  
  SELECT *
  FROM EMPLOYEE
  WHERE SALARY > 3000000;
  ```
### 5. MINUS
* 선행 쿼리문의 결과값에서 후행 쿼리문의 결과값을 제외한 나머지 부분 추출한다.
  ```sql
  SELECT *
  FROM EMPLOYEE
  WHERE DEPT_CODE = 'D5'

  MINUS
  
  SELECT *
  FROM EMPLOYEE
  WHERE SALARY > 3000000;
  ```
### 6. GROUPING SETS
* 그룹 별로 처리된 여러 개의 쿼리 결과를 한 번에 합친 결과로 추출한다.
  ```sql
  SELECT DEPT_CODE, 
         COUNT(*)
  FROM EMPLOYEE
  GROUP BY DEPT_CODE;
  
  SELECT JOB_CODE, 
         COUNT(*)
  FROM EMPLOYEE
  GROUP BY JOB_CODE;

  -- 위 두 개의 쿼리 결과를 한 번에 출력한다.
  SELECT DEPT_CODE, 
         JOB_CODE, 
         COUNT(*)
  FROM EMPLOYEE
  GROUP BY GROUPING SETS(DEPT_CODE, JOB_CODE);
  ```
