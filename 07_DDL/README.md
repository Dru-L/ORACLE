## DDL(Data Definition Language)
### 1. DDL
* 데이터 정의 언어로 객체(OBJECT)를 생성하고(CREATE), 수정하고(ALTER), 삭제(DROP)하는 구문이다.
* 오라클 객체 종류에는 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE), 인덱스(INDEX), 패키지(PACKAGE), 프로시저(PROCEDUAL), 함수(FUNCTION), 트리거(TRIGGER), 동의어(SYNONYM), 사용자(USER) 등이 있다.
### 2. CREATE
* 오라클 데이터베이스의 객체를 생성하는 구문이다.
#### 2.1. 테이블 생성
* 테이블은 행과 열로 구성되는 가장 기본적인 데이터베이스 객체로 데이터베이스 내에서 모든 데이터는 테이블에 저장된다.
  ```sql
  CREATE TABLE 테이블명 (
      컬럼명 자료형(크기) [DEFAULT 기본값] [제약조건],
      컬럼명 자료형(크기) [DEFAULT 기본값] [제약조건],
      ...   
  );
  ```
#### 2.2. SUBQUERY를 이용한 테이블 생성
* 서브 쿼리를 이용해서 SELECT의 조회 결과로 테이블을 생성하는 구문이다.
* 컬럼명과 데이터 타입, 값이 복사되고, 제약조건은 NOT NULL만 복사된다.
  ```sql
  CREATE TABLE 테이블명
  AS 서브 쿼리;
  ```
#### 2.3. 컬럼 주석
* 테이블의 컬럼에 대한 설명을 작성할 수 있는 구문이다.
  ```sql
  COMMENT ON COLUMN 테이블명.컬럼명 IS '주석 내용';
  ```
### 3. 자료형
#### 3.1 NUMBER 타입
* 숫자를 나타내기 위한 데이터 타입이다.
* NUMBER([P, S])
  * P : 표현할 수 있는 전체 숫자 자릿수(1 ~ 38)
  * S : 소수점 이하 자릿수(-84 ~ 127)
  ``` SQL
  -- 1234.678 데이터 입력 시 각 데이터 타입 저장되는 값
  NUMBER		    1234.678
  NUMBER(7)	    1235
  NUMBER(7, 1)	1234.7
  NUMBER(7, 3)	1234.678
  NUMBER(5, -2)	1200
  ```
#### 3.2. CHAR 타입
* 고정 길이 문자 데이터 타입이다. (최대 2000 BYTE)
* CHAR(SIZE [BYTE|CHAR])
  * SIZE : 저장 공간의 크기
  ``` SQL
  -- 'ORACLE' 데이터 입력
  CHAR(6)		ORACLE
  CHAR(9)		ORACLE(공백 3 BYTE)
  CHAR(3)		에러
  
  -- '한국' 데이터 입력
  CHAR(6)		한국
  CHAR(9)		한국(공백 3 BYTE)
  CHAR(3)		에러

  -- NCAHR는 문자 개수로 크기를 지정한다.
  -- '한국' 데이터 입력
  NCHAR(6)	한국(공백 4칸)
  NCHAR(9)	한국(공백 7칸)
  NCHAR(3)	한국(공백 1칸)
  ```
#### 3.3 VARCHAR2 타입
* 가변 길이 문자 데이터 타입이다. (최대 4000 BYTE)
* VARCHAR2(SIZE [BYTE|CHAR])
  * SIZE : 저장 공간의 크기
  ``` SQL
  -- 'ORACLE' 데이터 입력
  VARCHAR2(6)	ORACLE
  VARCHAR2(9)	ORACLE

  -- '한글' 데이터 입력
  VARCHAR2(6)	한글
  VARCHAR2(9)	한글

  -- NVARCHAR2는 문자 개수로 크기를 지정한다.
  -- '한글' 데이터 입력
  NVARCHAR2(2) 한글
  NVARCHAR2(4) 한글
  NVARCHAR2(6) 한글
  ```
#### 3.4. DATE
* 날짜와 시간을 저장하는 데이터 타입이다.
* 날짜의 연산 및 비교가 가능하다.
  * ex) SYSDATE - HIRE_DATE (두 날짜의 차이(일수))
### 3. 제약조건(CONSTRAINTS) 
* 테이블 작성 시 각 컬럼에 대해 저장될 데이터에 대한 제약조건을 설정할 수 있다.
* 입력되는 데이터에 문제가 없는지 자동으로 검사하고 데이터의 수정/삭제 가능 여부 검사 등을 위해 사용한다.
* 제약조건은 테이블 생성 시 제약조건을 설정할 수 있고 ALTER 구문을 통해서 제약조건을 설정하고, 변경, 삭제할 수 있다.
* 제약조건은 NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY 제약조건이 있다.
  ```sql
  -- 1) 컬럼 레벨
  CREATE TABLE 테이블명 (
      컬럼명 자료형(크기) [CONSTRAINT 제약조건명] 제약조건,
      ...
  );
      
  -- 2) 테이블 레벨
  CREATE TABLE 테이블명 (
      컬럼명 자료형(크기),
      ...
      [CONSTRAINT 제약조건명] 제약조건 (컬럼명)
  );
  ```
#### 3.1. NOT NULL 제약조건
* 컬럼에 NULL 값을 저장하거나 NULL 값으로 수정할 수 없도록 한다.
* NOT NULL 제약조건은 컬럼 레벨에서만 설정이 가능하다.
#### 3.2. UNIQUE 제약조건
* 컬럼에 중복된 값을 저장하거나 중복된 값으로 수정할 수 없도록 한다.
* UNIQUE 제약조건은 컬럼 레벨, 테이블 레벨에서 모두 설정이 가능하다.
#### 3.3. CHECK 제약조건
* 컬럼에 기록되는 값에 조건을 설정하고 조건을 만족하는 값만 저장하거나 수정하도록 한다.
* 비교 연산자를 이용하여 조건을 설정하며 비교 값을 리터럴만 사용 가능하고 변하는 값이나 함수 사용할 수 없다.
* CHECK 제약조건은 컬럼 레벨, 테이블 레벨에서 모두 설정이 가능하다.
#### 3.4. PRIMARY KEY 제약조건
* 기본 키(Primary Key)는 하나의 행을 대표하는 컬럼으로 한 행의 정보를 구분하기 위한 고유 식별자(Identifier) 역할을 한다.
* PRIMARY KEY 제약조건은 기본 키로 사용할 컬럼에 부여하는 제약조건이다.
* PRIMARY KEY 제약조건을 설정하게 되면 자동으로 해당 컬럼에 NOT NULL, UNIQUE 제약조건이 걸린다.
* PRIMARY KEY 제약조건은 컬럼 레벨, 테이블 레벨에서 모두 설정이 가능하다.
#### 3.5. FOREIGN KEY 제약조건
* 외래 키(Foreign Key)는 두 개의 테이블을 연결해 주는 역할을 한다. 
* 외래 키가 정의된 테이블을 자식 테이블, 외래 키가 참조하는 테이블을 부모 테이블이라고 한다.
* 외래 키가 참조하는 컬럼은 부모 테이블의 기본 키 컬럼이거나 중복된 값이 없는 컬럼만 가능하다. 
* FOREIGN KEY 제약조건은 외래 키(Foreign Key)로 사용할 컬럼에 부여하는 제약 조건이다.
* FOREIGN KEY 제약조건은 컬럼 레벨, 테이블 레벨에서 모두 설정이 가능하다.
* 부모 테이블의 데이터가 삭제될 때 자식 테이블의 데이터 처리에 대한 옵션을 지정할 수 있다.
  * ON DELETE RESTRICT : 자식 테이블의 참조 키가 부모 테이블의 키값을 참조하는 경우 부모 테이블의 행을 삭제할 수 없다. (기본)  
  * ON DELETE SET NULL : 부모 테이블의 데이터가 삭제 시 참조하고 있는 자식 테이블의 컬럼 값이 NULL로 변경된다.
  * ON DELETE CASCADE  : 부모 테이블의 데이터가 삭제 시 참조하고 있는 자식 테이블의 컬럼 값이 존재하는 행 전체가 삭제된다.
### 5. ALTER
* 오라클에서 제공하는 객체를 수정하는 구문이다.
* 테이블에 정의된 컬럼과 제약조건의 추가(ADD), 삭제(DROP), 변경(MODIFY), 이름 변경(RENAME) 등을 할 수 있다. 
#### 5.1. 컬럼의 추가 / 수정 / 삭제 / 이름 변경
* ALTER와 ADD 구문을 이용해서 컬럼을 추가할 수 있다.
* 컬럼 추가 시에는 테이블 맨 마지막에 추가되고 원하는 위치를 지정할 수 없다. 
* 데이터가 존재하는 행에는 추가된 컬럼의 값이 NULL로 채워지는데 아래와 같이 DEFAULT 값을 설정하면 DEFAULT로 설정된 값으로 채워진다.
  ```sql
  ALTER TABLE 테이블명 ADD 컬럼명 데이터타입 [DEFAULT 기본값];
  ```
* ALTER와 MODIFY 구문을 이용해서 컬럼의 데이터 타입, DEFAULT 값을 변경할 수 있다.
  ```sql
  -- 데이터 타입 변경
  ALTER TABLE 테이블명 MODIFY 컬럼명 데이터타입;
  -- 기본값 변경
  ALTER TABLE 테이블명 MODIFY 컬럼명 DEFAULT 기본값;
  ```
* ALTER와 DROP 구문을 이용해서 컬럼을 삭제할 수 있다.
* 데이터 값이 기록되어 있어도 같이 삭제된다. (삭제된 컬럼 복구는 불가능)
* 테이블에는 최소 한 개의 컬럼은 존재해야 한다.
  ```sql
  ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
  ```
* ALTER와 RENAME 구문을 이용해서 컬럼의 이름을 변경할 수 있다.
  ```sql
  ALTER TABLE 테이블명 RENAME COLUMN 기존 컬럼명 TO 변경할 컬럼명;
  ```
#### 5.2. 제약조건 추가 / 삭제 / 이름 변경
* ALTER와 ADD 구문을 이용해서 제약조건을 추가할 수 있다.
* NOT NULL 제약조건의 경우 ALTER와 MODIFY 구문을 이용해서 제약조건을 추가해야 한다.
  ```sql
  -- 제약조건 추가 (PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK)
  ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] 제약조건(컬럼명);

  -- NOT NULL 제약조건 추가
  ALTER TABLE 테이블명 MODIFY 컬럼명 [CONSTRAINT 제약조건명] NOT NULL;
  ```
* ALTER와 DROP 구문을 이용해서 제약조건을 삭제할 수 있다.
* NOT NULL 제약조건의 경우 ALTER와 MODIFY 구문을 이용해서 제약조건을 삭제해야 한다.
* 제약조건의 수정은 불가능하기 때문에 삭제 후 다시 제약조건을 추가해야 한다.
  ``` sql
  -- 제약조건 삭제 (PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK)
  ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명;

  -- NOT NULL 제약조건 삭제
  ALTER TABLE 테이블명 MODIFY 컬럼명 NULL;
  ```
* ALTER와 RENAME 구문을 이용해서 제약조건의 이름을 변경할 수 있다.
  ```sql
  ALTER TABLE 테이블명 RENAME CONSTRAINT 기존 제약조건명 TO 변경할 제약조건명;
  ```
#### 5.3. 테이블 이름 변경
* ALTER와 RENAME 구문을 이용해서 테이블의 이름을 변경할 수 있다.
  ```sql
  ALTER TABLE 테이블명 RENAME TO 변경할 테이블명;
  
  RENAME 기존 테이블명 TO 변경할 테이블명;
  ```
### 6. DROP
* 오라클에서 제공하는 객체를 삭제하는 구문이다.
  ``` sql
  DROP TABLE 테이블명;
  ```


