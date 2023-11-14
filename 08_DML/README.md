## DML(Data Manipulation Language)
### 1. DML(Data Manipulation Language)
* 데이터 조작 언어로 테이블에 값을 삽입(INSERT), 수정(UPDATE), 삭제(DELETE)하는 구문이다.
### 2. INSERT
* 테이블에 새로운 행을 추가하는 구문이다.
  ```sql
  -- 모든 컬럼에 값을 INSERT 한다.
  INSERT INTO 테이블명 VALUES(값, 값, 값, ..., 값);

  -- 선택한 컬럼에 값을 INSERT 한다.
  INSERT INTO 테이블명(컬럼명, 컬럼명, ..., 컬럼명) VALUES(값, 값, ..., 값);

  -- 서브 쿼리로 조회한 결과값을 통째로 INSERT 한다.
  INSERT INTO 테이블명 (서브 쿼리);
  ```
### 3. INSERT ALL
* 두 개 이상의 테이블에 각각 INSERT 하는데 동일한 서브 쿼리가 사용되는 경우 INSERT ALL을 이용해서 여러 테이블에 한 번에 데이터 삽입이 가능하다.       
  ```sql
  -- 서브 쿼리의 조회 결과를 테이블1, 테이블2에 각각 INSERT 한다. 
  INSERT ALL
  INTO 테이블1[(컬럼, 컬럼, ...)] VALUES(값, 값, ...)
  INTO 테이블2[(컬럼, 컬럼, 컬럼, ...)] VALUES(값, 값, 값, ...)
  서브 쿼리;

  -- 서브 쿼리의 조회 결과에서 
  -- 조건 1을 만족하는 행들은 테이블1에 INSERT 하고
  -- 조건 2를 만족하는 행들은 테이블2에 INSERT 한다.
  INSERT ALL
  WHEN 조건1 THEN 
      INTO 테이블1[(컬럼, 컬럼, ...)] VALUES(값, 값, ...)
  WHEN 조건2 THEN     
      INTO 테이블2[(컬럼, 컬럼, ...)] VALUES(값, 값, ...)
  서브 쿼리;
  ```
### 4. UPDATE
* 테이블의 행의 값을 수정하는 구문이다.
* SET 절에서 여러 개의 컬럼을 콤마(,)로 나열해서 값을 동시에 변경할 수 있다.
* WHERE 절을 생략하면 모든 행의 데이터가 변경된다.
  ```SQL
  UPDATE 테이블명
  SET 컬럼명 = 변경하려는 값,
      컬럼명 = 변경하려는 값, 
      ...
  [WHERE 조건];
  ```
### 5. DELETE
* 테이블의 행을 삭제하는 구문이다.
* WHERE 절을 생략하면 모든 행의 데이터가 삭제된다.
  ```SQL
  DELETE FROM 테이블명
  [WHERE 조건식];
  ``` 
### 6. TRUNCATE
* 테이블의 전체 행을 삭제하는 구문이다.
* DELETE보다 수행 속도가 빠르고 ROLLBACK을 통해 복구 불가능하다.
  ```SQL
  TRUNCATE TABLE 테이블명;
  ``` 
