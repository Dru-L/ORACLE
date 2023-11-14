## TCL(TRANSACTION CONTROL LANGUAGE)
### 1. TCL
* 트랜잭션을 제어하는 언어이다.
* 하나의 논리적인 작업 단위를 트랜잭션이라고 한다.
  ```
  예) ATM에서 현금 출금
    1. 카드 삽입
    2. 메뉴 선택
    3. 금액 확인 및 인증
    4. 실제 계좌에서 금액만금 인출
    5. 현금 인출
    6. 완료
  ```
* 각각의 업무들을 묶어서 하나의 작업 단위로 만드는 것을 트랜잭션이라고 한다.
* 하나의 트랜잭션으로 묶인 작업들은 반드시 모두 완료가 되어야 하며, 그렇지 않은 경우에는 모두 취소되어야 한다.
* 데이터베이스는 데이터의 변경 사항(INSERT, UPDATE, DELETE)들을 묶어서 하나의 트랜잭션에 담아서 처리한다.
### 2. COMMIT
* 모든 작업들이 정상적으로 처리하겠다고 확정하는 구문이다.
  ```SQL
  COMMIT;
  ```
### 3. ROLLBACK
* 모든 작업들을 취소 처리하겠다고 확정하는 구문이다.
  ```SQL
  ROLLBACK;
  ```
### 4. SAVEPOINT
* 저장점을 지정하고 ROLLBACK 진행 시 전체 작업을 ROLLBACK 하는 것이 아닌 SAVEPOINT까지 롤백 한다.
  ```SQL
  SAVEPOINT 포인트명; 

  ...

  ROLLBACK TO 포인트명;
  ```
## DCL(DATA CONTROL LANGUAGE)
### 1. DCL
* 데이터를 제어하는 구문으로 계정에게 시스템 권한 또는 객체에 대한 접근 권한을 부여(GRANT)하거나 회수(REVOKE)하는 구문이다.
### 2. 시스템 권한
* 데이터베이스에 접근하는 권한, 오라클에서 제공하는 객체를 생성/삭제할 수 있는 권한이다.
  ```SQL
  -- CREATE SESSION : 데이터베이스 접속할 수 있는 권한 (계정 접속)
  -- CREATE TABLE : 테이블을 생성할 수 있는 권한 
  -- CREATE VIEW : 뷰를 생성할 수 있는 권한
  -- CREATE SEQUENCE : 시퀀스를 생성할 수 있는 권한
  -- CREATE PROCEDURE : 프로시져를 생성할 수 있는 권한
  -- CREATE USER : 계정을 생성할 수 있는 권한 
  -- DROP USER : 계정 삭제 권한
  -- DROP ANY TABLE : 임의 테이블 삭제 권한
  -- ...

  GRANT 권한[, 권한, 권한, ...] TO 계정명;
  REVOKE 권한[, 권한, 권한, ...] FROM 계정명;  
  ```
### 3. 객체 접근 권한
* 특정 객체를 조작할 수 있는 권한이다.
  ```sql
  -- SELECT : TABLE, VIEW, SEQUENCE
  -- INSERT : TABLE, VIEW
  -- UPDATE : TABLE, VIEW
  -- DELETE : TABLE, VIEW
  -- ALTER  : TABLE, SEQUENCE
  -- REFERENCES : TABLE
  -- ...

  GRANT 권한[, 권한, 권한, ...] ON 객체 TO 계정명;
  REVOKE 권한[, 권한, 권한, ...] ON 객체 FROM 계정명;  
  ```
### 4. 롤(ROLE)
* 특정 권한들을 하나의 집합으로 모아놓은 것을 롤(ROLE)이라 한다.
  ```SQL
  -- CONNECT : 데이터베이스에 접속할 수 있는 권한 (CREATE SESSION)
  -- RESOURCE : 특정 객체들을 생성할 수 있는 권한 (CREATE TABLE, CREATE SEQUENCE , ....)

  GRANT RESOURCE, CONNECT TO 계정명;
  ```
