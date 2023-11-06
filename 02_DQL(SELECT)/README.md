## SELECT
### 1. SELECT
* SELECT 문은 테이블에서 데이터를 조회하기 위한 SQL 구문이다.
* SELECT 문을 사용하여 테이블의 특정 컬럼, 특정 행 또는 여러 테이블의 특정 컬럼과 행을 조회할 수 있다.
* 데이터를 조회한 결과를 Result Set이라고 한다.
* Result Set은 테이블 형태로 값을 반환하고 0개 이상의 행이 포함될 수 있다.
  ``` sql
  -- 모든 컬럼 조회 시 컬럼 명 대신 '*' 기호 사용 가능
  SELECT 컬럼 명 [, 컬럼명, ...]  
  FROM 테이블 명 
  WHERE 조건식
  ORDER BY 컬럼명 | 별칭 | 컬럼 순번 [ASC/DESC] [NULLS FIRST | LAST];
  ```
#### 1.1. 컬럼의 산술 연산
* 컬럼 값에 대해 산술 연산한 결과를 조회할 수 있다.
  ``` sql
  SELECT EMP_NAME, 
         SALARY * 12, 
         (SALARY + (SALARY * BONUS)) * 12
  FROM EMPLOYEE;
  ```
#### 1.2. 컬럼 별칭
* 조회된 컬럼명에 별칭을 지정할 수 있다.
  ``` sql
  SELECT EMP_NAME AS 이름, 
         SALARY * 12 AS "연봉(원)", 
         (SALARY + (SALARY * BONUS)) * 12 "총 소득(원)"
  FROM EMPLOYEE;
  ```
#### 1.3. 리터럴
* 쿼리문에서 직접 데이터를 표기하는 방법을 리터럴이라 한다.
* 리터럴은 정해진 표기법대로 작성해야 하는데 문자나 날짜 리터럴은 ' ' 기호를 사용한다.
* 리터럴을 SELECT 절에 사용하면 테이블에 존재하는 데이터처럼 Result Set의 모든 행에 반복해서 표시된다.
  ```sql
  SELECT EMP_ID,
	     SALARY,
	     '원' AS 단위
  FROM EMPLOYEE;
  ```
### 2. DISTINCT
* 컬럼에 포함된 데이터 중 중복 값을 제외하고 한 번씩만 표시하고자 할 때 사용한다.
  ```sql
  -- SELECT 절에 한 번만 기술할 수 있다.
  SELECT DISTINCT JOB_CODE
  FROM EMPLOYEE;
  ```
### 3. WHERE
* 테이블에서 데이터를 검색할 때 컬럼의 조건을 설정하여 조건을 만족하는 값을 가진 행을 조회할 수 있다.
  ``` SQL
  SELECT EMP_NAME, 
         DEPT_CODE,
         SALARY
  FROM EMPLOYEE
  WHERE DEPT_CODE = 'D6';
  ```
* 다양한 연산자를 함께 사용하여 다양한 조건을 만족하는 행을 조회할 수 있다.
  ``` SQL
  SELECT EMP_NAME, 
         DEPT_CODE,
         SALARY
  FROM EMPLOYEE
  WHERE DEPT_CODE = 'D6' AND SALARY > 2000000;
  ```
### 4. ORDER BY
* SELECT 문으로 조회된 데이터를 정렬을 할 때 작성하는 구문이다.
* SELECT 구문의 가장 마지막에 작성하며 가장 마지막에 실행된다.
  ```sql
  SELECT *
  FROM EMPLOYEE
  ORDER BY BONUS;

  SELECT *
  FROM EMPLOYEE
  ORDER BY BONUS DESC;
  ```        
## 연산자
### 1. 연결 연산자
* ||를 사용하여 여러 컬럼을 하나의 컬럼인 것처럼 연결하거나 컬럼과 리터럴을 연결할 수 있다.
  ``` sql
  SELECT EMP_ID || EMP_NAME || SALARY 
  FROM EMPLOYEE;

  SELECT EMP_NAME || '의 월급은 ' || SALARY || '원 입니다.' 
  FROM EMPLOYEE;
  ```
### 2. 논리 연산자
* 여러 개의 제한 조건 결과를 하나의 논리 결과로 만들어준다.
* AND는 여러 조건이 동시에 TRUE 일 경우에 TRUE를 반환한다.
  ||TRUE|FALSE|NULL|
  |:--:|:--:|:--:|:--:|
  |TRUE|TRUE|FALSE|NULL|
  |FALSE|FALSE|FALSE|FALSE|
  |NULL|NULL|FALSE|NULL|
* OR는 여러 조건들 중에 하나의 조건만 TRUE 이면 TRUE를 반환한다.
  ||TRUE|FALSE|NULL|
  |:--:|:--:|:--:|:--:|
  |TRUE|TRUE|TRUE|TRUE|
  |FALSE|TRUE|FALSE|NULL|
  |NULL|TRUE|NULL|NULL|
* NOT은 조건에 대한 반대 값으로 반환한다. (NULL 제외)
### 3. 비교 연산자
* 값 또는 표현식 사이의 관계를 비교하기 위해 사용하는 연산자이다.
* 비교하는 값 또는 표현식은 동일한 데이터 타입이어야 하고 비교 결과는 논리 결과(TRUE/FALSE/NULL) 중 하나가 된다.
#### 3.1. 대소/동등 비교 연산자
* 비교하려는 값의 대소, 동등 비교를 하는 연산자이다.
  |연산자|설명|
  |:--:|:--:|
  |=|같다|
  |<>, !=, ^=|같지 않다|
  |>, <|크다 / 작다|
  |>=, <=|크거나 같다 / 작거나 같다|
#### 3.2. BETWEEN AND
* 비교하려는 값이 지정한 범위에 포함되는지 확인하는 연산자이다.
```sql
SELECT EMP_NAME, 
       SALARY
FROM EMPLOYEE
-- WHERE SALARY >= 3500000 AND SALARY <= 6000000;
WHERE SALARY BETWEEN 3500000 AND 6000000;
```
#### 3.3. LIKE
* 비교하려는 값이 지정한 특정 패턴을 만족하는지 확인하는 연산자이다. 
* %와 _를 와일드카드로 사용하여 패턴을 지정한다.
  ```sql
  SELECT EMP_NAME, 
         SALARY
  FROM EMPLOYEE
  WHERE EMP_NAME LIKE '전%';

  SELECT EMP_NAME, 
         SALARY
  FROM EMPLOYEE
  WHERE EMP_NAME LIKE '전_연';
  ```
* 와일드카드 문자를 특수문자로 사용해야 하는 경우 데이터로 처리할 와일드카드 문자 앞에 임의의 특수문자를 사용하고 ESCAPE로 등록하여 처리한다.
  ```sql
  SELECT EMP_NAME, 
         EMAIL
  FROM EMPLOYEE
  WHERE EMAIL LIKE '_ _ _#_%' ESCAPE '#';
  ```
#### 3.4. IS NULL
* 비교하려는 값의 NULL 여부를 확인하는 연산자이다. 
  ```sql
  SELECT EMP_NAME, 
         MANAGER_ID, 
         DEPT_CODE
  FROM EMPLOYEE
  WHERE MANAGER_ID IS NULL 
  ```
#### 3.5. IN
* 비교하려는 값과 일치하는 값이 목록에 있는지 확인하는 연산자이다.
  ```sql
  SELECT EMP_NAME, 
         DEPT_CODE, 
         SALARY
  FROM EMPLOYEE
  WHERE DEPT_CODE IN ('D6', 'D8');
  ```
### 4. 연산자 우선순위
* 연산자의 우선순위는 아래의 표와 같다.
* 논리 연산자의 경우 연산자마다 우선순위가 다르기 때문에 SQL 작성 시 주의해야 한다.
  |우선순위|연산자|
  |:--:|:--:|
  |1|산술 연산자|
  |2|연결 연산자|
  |3|비교 연산자|
  |4|IS NULL, LIKE, IN|
  |5|BETWEEN AND|
  |6|NOT(논리 연산자)|
  |7|AND(논리 연산자)|
  |8|OR(논리 연산자)|