/*
    < DCL(DATA CONTROL LANGUAGE) >
        - 데이터를 제어하는 구문이다.
        - 계정에게 시스템 권한 또는 객체에 대한 접근 권한을 '부여(GRANT)'하거나 '회수(REVOKE)'하는 구문이다.
          (단, 관리자 계정으로 진행해야 함!!)
        
        * 시스템 권한
          : 데이터베이스에 접근하는 권한, 오라클에서 제공하는 객체를 생성/삭제할 수 있는 권한
        
        * 객체 접근 권한
          : 특정 객체를 조작할 수 있는 권한
*/ 

/*
    < 시스템 권한 >
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
*/
-- 1. SAMPLE 계정 생성
--    (유저명: SAMPLE, 비밀번호: SAMPLE)
CREATE USER C##SAMPLE IDENTIFIED BY SAMPLE; -- 접두어 'C##' 붙여주어야함

-- 2. 계정에 접속하기 위해서 CREATE SESSION 권한 부여
GRANT CREATE SESSION TO C##SAMPLE;

-- 3. SAMPLE 계정에서 테이블을 생성할 수 있도록 CREATE TABLE 권한 부여
GRANT CREATE TABLE TO C##SAMPLE;

-- 4. SAMPLE 계정에 테이블 스페이스 할당(테이블, 뷰, 인덱스 등 객체들이 저장되는 공간)
ALTER USER C##SAMPLE QUOTA 2M ON USERS; -- 2 MEGA BYTE 만큼의 스페이스를 유저에게 할당
ALTER USER C##KH DEFAULT TABLESPACE SYSTEM QUOTA UNLIMITED ON SYSTEM; -- SYSTEM만큼의 테이블스페이스를 무한으로 제공한다.


/*
    < 객체 접근 권한 >
        -- SELECT : TABLE, VIEW, SEQUENCE
        -- INSERT : TABLE, VIEW
        -- UPDATE : TABLE, VIEW
        -- DELETE : TABLE, VIEW
        -- ALTER  : TABLE, SEQUENCE
        -- REFERENCES : TABLE
        -- ...
        
        GRANT 권한[, 권한, 권한, ...] ON 객체 TO 계정명;
        REVOKE 권한[, 권한, 권한, ...] ON 객체 FROM 계정명;  
*/

-- 5. SAMPLE 계정에서 KH 계정의 EMPLOYEE 테이블을 조회할 수 있는 권한 부여
GRANT SELECT ON C##KH.EMPLOYEE TO C##SAMPLE;

-- 6. SAMPLE 계정에서 C##KH.DEPARTMENT 테이블을 조회할 수 있는 권한 부여
GRANT SELECT ON C##KH.DEPARTMENT TO C##SAMPLE;

-- 7. SAMPLE 계정에서 KH 계정의 DEPARTMENT 테이블에 데이터 추가할 수 있는 권한 부여
GRANT INSERT ON C##KH.DEPARTMENT TO C##SAMPLE;

-- 8. SAMPLE 계정에서 KH 계정의 DEPARTMENT 테이블에 데이터 조회 및 추가 하는 권한을 회수
REVOKE SELECT, INSERT ON C##KH.DEPARTMENT FROM C##SAMPLE;


/*
    < 롤(ROLE) >
    특정 권한들을 하나의 집합으로 모아놓은 것을 롤(ROLE)이라 한다.
        -- CONNECT : 데이터베이스에 접속할 수 있는 권한 (CREATE SESSION)
        -- RESOURCE : 특정 객체들을 생성할 수 있는 권한 (CREATE TABLE, CREATE SEQUENCE , ....)
        
        GRANT RESOURCE, CONNECT TO 계정명;
*/
SELECT *
FROM ROLE_SYS_PRIVS
-- WHERE ROLE = 'CONNECT';
--WHERE ROLE = 'RESOURCE';
WHERE ROLE = 'DBA' AND PRIVILEGE LIKE 'CREATE%';

-- https://blog.naver.com/hj_kim97/222430045367