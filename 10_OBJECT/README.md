## VIEW
### 1. VIEW
* VIEW는 오라클에서 제공하는 객체로 가상의 테이블이다.
* 테이블과는 다르게 데이터를 저장하고 있진 않지만 사용자는 테이블을 사용하는 것과 동일하게 사용이 가능하다.
* 뷰는 데이터를 저장하고 있지 않은 가상 테이블이지만 DML(INSERT, UPDATE, DELETE) 작업이 가능하다. 
### 2. VIEW 생성
* VIEW는 CREATE 구문을 사용해서 생성한다.
* 서브 쿼리의 SELECT 절에 함수가 사용된 경우 반드시 별칭을 지정해야 한다.
  ``` SQL
  CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰명
  AS 서브 쿼리
  [WITH CHECK OPTION]
  [WITH READ ONLY];
  ```
* VIEW 옵션
  |옵션|설명|
  |:--:|:--:|
  |OR REPLACE|기존에 동일한 뷰가 있을 경우 덮어쓰고, 존재하지 않으면 뷰를 새로 생성한다.|
  |FORCE|서브 쿼리에 기술된 테이블이 존재하지 않는 테이블이어도 뷰가 생성된다.|
  |NOFORCE|서브 쿼리에 기술된 테이블이 존재해야만 뷰가 생성된다. (기본값)|
  |WITH CHECK OPTION|서브 쿼리에 기술된 조건에 부합하지 않는 값으로 수정하는 경우 오류를 발생시킨다.|
  |WITH READ ONLY|뷰에 대해 조회만 가능하다. (DML 수행 불가)|
### 3. VIEW 사용
* VIEW는 FROM 절에서 테이블 대신 사용할 수 있다.
  ``` SQL
  SELECT * FROM 뷰명;
  ```
* VIEW는 SELECT뿐만 아니라 DML(INSERT, UPDATE, DELETE)의 사용도 가능하다.
* 이때 VIEW에 요청된 DML은 기본 테이블에 적용된다.
  ``` SQL
  -- 뷰에 INSERT 실행
  INSERT INTO 뷰명 VALUES(값, 값, 값, ..., 값);

  -- 뷰에 UPDATE 실행
  UPDATE 뷰명 SET 컬럼명 = 변경하려는 값 WHERE 조건;

  -- 뷰에 DELETE 실행
  DELETE FROM 뷰명 WHERE 조건식;
  ```
* 아래와 같은 경우에는 VIEW를 통해 데이터 변경이 불가능하다.
  * 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
  * 뷰에 포함되지 않는 컬럼 중에 기본 테이블 상에 NOT NULL 제약조건이 지정된 경우
  * 산술 표현식으로 정의된 경우
  * 그룹 함수나 GROUP BY 절을 포함한 경우
  * DISTINCT를 포함한 경우
  * JOIN을 이용해 여러 테이블을 연결한 경우
### 4. VIEW 삭제
* VIEW 삭제 시 DROP 구문을 사용해서 삭제한다.
  ```SQL
  DROP VIEW 뷰명;
  ```
## SEQUENCE
### 1. SEQUENCE
* SEQUENCE는 오라클에서 제공하는 객체로 순차적으로 정수 값을 자동으로 생성한다.
### 2. SEQUENCE 생성
* SEQUENCE는 CREATE 구문을 사용해서 생성한다.
  ```sql
  CREATE SEQUENCE 시퀀스명
      [START WITH 숫자]	
      [INCREMENT BY 숫자]
      [MAXVALUE 숫자]
      [MINVALUE 숫자]
      [CYCLE | NOCYCLE]	
      [CACHE | NOCACHE]	
  ```
* SEQUENCE 옵션
  |옵션|설명|
  |:--:|:--:|
  |START WITH|처음 발생시킬 시작 값을 지정한다. (기본값: 1)|
  |INCREMENT BY|다음 값에 대한 증가치를 지정한다. (기본값: 1)|
  |MAXVALUE|SEQUENCE에서 발생시킬 최대값을 지정한다.|
  |MINVALUE|SEQUENCE에서 발생시킬 최소값을 지정한다.|
  |CYCLE \| NOCYCLE|값의 순환 여부를 지정한다.|
  |CACHE \| NOCACHE|캐시메모리 사용 여부를 지정한다.|
### 3. SEQUENCE 사용
* NEXTVAL는 시퀀스 값을 증가시키고 증가된 시퀀스 값을 리턴한다.
* CURRVAL는 현재 시퀀스의 값을 리턴한다. 
  ```sql
  시퀀스명.NEXTVAL;

  시퀀스명.CURRVAL;
  ```
* NEXTVAL/CURRVAL 사용 가능 여부
  |사용 가능|사용 불가|
  |--|--|
  |서브 쿼리가 아닌 SELECT 문|VIEW의 SELECT 문|
  |INSERT 문의 SELECT 절|DISTINCT 키워드가 있는 SELECT 문|
  |INSERT 문의 VALUES 절|GROUP BY, HAVING, ORDER BY 절이 있는 SELECT 문|
  |UPDATE 문의 SET 절|SELECT, DELETE, UPDATE의 서브 쿼리|
  ||CREATE TABLE, ALTER TABLE 명령의 DEFAULT 값|
### 4. SEQUENCE 수정
* SEQUENCE 수정 시 ALTER 구문을 사용해서 수정한다.
* 단, START WITH 값 변경은 불가하기 때문에 변경하려면 삭제 후 다시 생성해야 한다.
  ```sql
  ALTER SEQUENCE 시퀀스명
      [INCREMENT BY 숫자]
      [MAXVALUE 숫자]
      [MINVALUE 숫자]
      [CYCLE | NOCYCLE]	
      [CACHE | NOCACHE]	
  ```
### 4. SEQUENCE 삭제
* SEQUENCE 삭제 시 DROP 구문을 사용해서 삭제한다.
  ```SQL
  DROP SEQUENCE 시퀀스명;
  ```
## INDEX
### 1. INDEX
* INDEX는 오라클에서 제공하는 객체로 SQL 명령문의 처리 속도를 향상시키기 위해서 행들의 위치 정보를 가지고 있다. (내부 구조는 B-트리 형식으로 구성)
* 검색 속도가 빨라지고 시스템에 걸리는 부하를 줄여 시스템 전체 성능을 향상시킨다.
* 인덱스 구조
  * ROWID는 데이터베이스에 저장되어 있는 데이터의 주소이다. 
    ```SQL
    SELECT ROWID, 
           EMP_ID, 
           EMP_NAME
    FROM EMPLOYEE;
    ```
  * 인덱스는 KEY와 ROWID를 가지고 있는데 KEY는 인덱스를 생성할 때 지정한 컬럼의 값이고 ROWID는 KEY에 해당하는 데이터의 주소이다.
  <br>
  <img src="https://user-images.githubusercontent.com/26870393/168463588-20aa4d02-5c58-4c04-bf1c-51885c7c9560.png" />
  <img src="https://user-images.githubusercontent.com/26870393/168463596-66394206-8bcd-4dc5-92c1-61f0770905b3.png" />
  <br>
* 인덱스 종류
  |종류|설명|
  |:--:|:--:|
  |고유 인덱스(UNIQUE INDEX)|중복되지 않는 데이터를 인덱스의 키값으로 지정하는 인덱스이다.|
  |비고유 인덱스(NONUNIQUE INDEX)|중복되는 데이터를 인덱스의 키값으로 지정하는 인덱스로 빈번하게 사용되는 일반 컬럼을 대상으로 성능 향상을 위한 목적으로 생성한다.|
  |단일 인덱스(SINGLE INDEX)|한 개의 컬럼으로 구성한 인덱스이다.|
  |결합 인덱스 (COMPOSITE INDEX)|두 개 이상의 컬럼으로 하나의 인덱스로 순서에 의해서 성능이 차이가 있을 수 있다.|
  |함수 기반 인덱스(FUNCTION-BASED INDEX)|계산식이나 함수 사용식으로 구성한 인덱스이다.|
### 2. INDEX 생성
* INDEX는 CREATE 구문을 사용해서 생성한다.
  ```SQL
  CREATE [UNIQUE] INDEX 인덱스 명
  ON 테이블명(컬럼명[, 컬럼명]| 함수명, 함수 계산식);

  -- 고유 인덱스(UNIQUE INDEX)
  -- 중복되는 값이 있는 컬럼을 지정하면 에러가 발생한다.
  CREATE UNIQUE INDEX IDX_EMPNO
  ON EMPLOYEE(EMP_NO);

  -- 비고유 인덱스(NONUNIQUE INDEX)
  -- 중복 값이 있는 컬럼에도 생성이 가능하다. (WHERE 절에 빈번하게 사용되는 컬럼을 지정)
  CREATE INDEX IDX_DEPTCODE
  ON EMPLOYEE(DEPT_CODE);

  -- 결합 인덱스 (COMPOSITE INDEX)
  -- 두 개 이상의 컬럼을 하나의 인덱스로 생성이 가능하고 순서의 의해 성능의 차이가 날 수 있다.
  CREATE INDEX IDX_DEPT
  ON DEPARTMENT(DEPT_ID, DEPT_TITLE);

  -- 함수 기반 인덱스(FUNCTION-BASED INDEX)
  CREATE INDEX IDX_SALCALC
  ON EMP_SAL ((SALARY + SALARY*NVL(BONUS, 0)))*12);
  ```
### 3. INDEX 재생성
* 빈번한 DML 작업을 수행한 경우 제거된 인덱스가 필요 없는 공간을 차지하고 있지 않도록
인덱스를 재생성한다.
  ```SQL
  ALTER INDEX 인덱스명 REBUILD;
  ```
### 4. INDEX 삭제
* INDEX 삭제 시 DROP 구문을 사용해서 삭제한다.
  ```SQL
  DROP INDEX 인덱스명;
  ```
## SYNONYM
### 1. SYNONYM
* SYNONYM은 오라클에서 제공하는 객체로 데이터베이스 객체에 별칭을 생성한다.
* SYNONYM을 사용하면 다른 사용자가 제공하는 객체를 참조할 때 간단하게 사용할 수 있다.
### 2. SYNONYM 생성
* SYNONYM은 CREATE 구문을 사용해서 생성한다.
#### 2.1. 비공개 SYNONYM
* 객체에 대한 접근 권한을 부여받은 사용자가 정의한 동의어로 해당 사용자만 사용이 가능하다.
  ```SQL
  -- 사용자 계정에서 실행한다.
  CREATE SYNONYM EMP FOR EMPLOYEE;
  ```
#### 2.2. 공개 SYNONYM
* 관리자 권한을 가진 사용자(DBA)가 정의한 동의어로 모든 사용자가 사용이 가능하다. (ex. DUAL)
  ```SQL
  -- 관리자 계정에서 실행한다.
  CREATE PUBLIC SYNONYM DEPT FOR KH.DEPARTMENT;
  ```
### 3. SYNONYM 사용
* 테이블명 대신에 동의어를 통해서 테이블의 사용이 가능하다.
  ```SQL
  -- 동일한 결과를 수행한다.
  SELECT * FROM EMPLOYEE;
  SELECT * FROM EMP;

  SELECT * FROM DEPARTMENT;
  SELECT * FROM DEPT
  ```
### 4. SYNONYM 삭제
* SYNONYM 삭제 시 DROP 구문을 사용해서 삭제한다.
  ```SQL
  DROP [PUBLIC] SYNONYM 동의어;
  ```


