/*
    < DDL(DATA DEFINITION LANGUAGE) >
      데이터 정의 언어로 오라클에서 제공하는 객체(OBJECT)를 생성하고(CREATE), 수정하고(ALTER), 삭제(DROP)하는 구문이다.
    
    <CREATE>
      오라클 데이터베이스 객체(테이블, 뷰, 인덱스 등)를 생성하는 구문이다.
      
    <테이블 생성>
      [표현법]
        CREATE TABLE 테이블명 (
            컬럼명 자료형(크기) [DEFAULT 기본값] [제약조건],
            컬럼명 자료형(크기) [DEFAULT 기본값] [제약조건],
            ...   
        );
        
    <자료형>
        1. NUMBER
          숫자를 나타내기 위한 데이터 타입이다.
          NUMBER([P, S])
            P : 표현할 수 있는 전체 숫자 자릿수(1 ~ 38)
            S : 소수점 이하 자릿수(-84 ~ 127)
            NUMBER		   -- 1234.678
            NUMBER(7)	    -- 1235
            NUMBER(7, 1)	-- 1234.7
            NUMBER(5, -2)	-- 1200
            
        2. CHAR
          고정 길이 문자 데이터 타입이다. (최대 2000 BYTE)
          CHAR(SIZE [BYTE|CHAR]) => SIZE : 저장 공간의 크기
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
            
        3. VARCHAR2
          가변 길이 문자 데이터 타입이다. (최대 4000 BYTE)
          VARCHAR2(SIZE [BYTE|CHAR]) => SIZE : 저장 공간의 크기
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
            
        4. DATE
          날짜와 시간을 저장하는 데이터 타입이다.
*/
-- 회원에 대한 데이터를 담을 수 있는 MEMBER 테이블 생성
CREATE TABLE MEMBER(
    NO NUMBER,
    ID VARCHAR2(20),
    PASSWORD VARCHAR2(20),
    NAME VARCHAR2(15),
    ENROLL_DATE DATE DEFAULT SYSDATE
);

DROP TABLE MEMBER; -- TABLE 삭제

DESC MEMBER; -- 테이블의 구조를 표시해주는 구문이다.

/*
    데이터 딕셔너리
        자원을 효율적으로 관리하기 위해 다양한 객체들의 정보를 저장하는 시스템 테이블이다.
        데이터에 관한 데이터가 저장되어 있다고 해서 "메타 데이터" 라고도 한다.
*/

-- USER_TABLES : 사용자가 가지고 있는 테이블들의 구조를 확인하는 뷰 테이블이다.
SELECT *
FROM USER_TABLES -- 현재 사용자가 가지고 있는 테이블들에 대한 정보
WHERE TABLE_NAME = 'MEMBER';

-- USER_TAB_COLUMNS : 사용자가 가지고 있는 테이블, 컬럼과 관련된 정보를 조회하는 뷰 테이블이다.
SELECT *
FROM USER_TAB_COLUMNS; -- 현재 사용자가 가지고 있는 테이블 내 컬럼 데이터에 대한 정보


/*
    <컬럼 주석>
        테이블의 컬럼에 대한 설명을 작성 할 수 있는 구문이다.
*/
COMMENT ON COLUMN MEMBER.NO IS '회원 번호';
COMMENT ON COLUMN MEMBER.ID IS '회원 아이디';
COMMENT ON COLUMN MEMBER.PASSWORD IS '회원 비밀번호';
COMMENT ON COLUMN MEMBER.NAME IS '회원 이름';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '회원 가입일';

-- 테이블에 샘플 데이터 추가(INSERT)
-- INSERT INTO 테이블명[(컬럼명, ..., 컬럼명)]
INSERT INTO MEMBER VALUES (1, 'USER1', '1234', '홍길동', '2023-11-09');

INSERT INTO MEMBER
VALUES (2, 'USER2', '1234', '이몽룡', SYSDATE);

INSERT INTO MEMBER(NO, ID, PASSWORD, NAME, ENROLL_DATE)
VALUES (3, 'USER3', '1234', '성춘향', DEFAULT); -- 데이터 생성할때 지정되어있는 DEFAULT값을 넘겨줘

INSERT INTO MEMBER(ID, PASSWORD) -- 데이터 저장할 값들만 지정
VALUES ('USER4', '1234'); -- 위에 지정한 데이터만 입력.
-- 지정하지않은 데이터들은 DEFAULT값을 지정했다면 DEFAULT값, 지정안했다면 NULL로 처리 된다.

INSERT INTO MEMBER(ID, PASSWORD)
VALUES ('USER4USER4USER4USER4USER4USER4USER4USER4USER4', '1234');
-- SQL 오류: ORA-12899: "C##KH"."MEMBER"."ID" 열에 대한 값이 너무 큼(실제: 45, 최대값: 20)
-- 지정한 값보다 더 큰 값을 입력시, 오류가 난다.

-- COMMIT : 메모리 버퍼에 임시 저장된 데이터를 실제 테이블에 반영한다.
COMMIT; -- 커밋(저장)
-- COMMIT : 메모리 버퍼에 임시 저장된 데이터를 반영하지않고 삭제한다. 커밋이 완료된 상태에서 롤백을 하면 롤백 X.
ROLLBACK; -- 롤백(취소)
SHOW AUTOCOMMIT; -- AUTOCOMMIT : 데이터 변경이나 입력시 자동으로 커밋되게 만듬. (보통 사용 X)
-- SET AUTOCOMMIT OFF / ON


/*
    < 제약 조건 >
        테이블 작성 시 각 컬럼에 대해 저장될 데이터에 대한 제약조건을 설정할 수 있다.
        제약조건은 데이터 무결성 보장을 목적으로 한다.
        (데이터의 정확성과 일관성을 유지시키는 것)
        
        * 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
        
        [표현법]
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
*/

/*
    1. NOT NULL 제약 조건
       해당 컬럼에 반드시 값이 있어야만 하는 경우에 사용한다.
       NOT NULL 제약 조건은 컬럼 레벨에서만 설정이 가능하다.
*/
-- 기존 MEMBER 테이블은 값에 NULL이 있어도 행의 삽입이 가능하다.
INSERT INTO MEMBER VALUES (NULL, NULL, NULL, NULL, NULL);

-- NOT NULL 제약조건을 설정한 테이블 생성
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    NO NUMBER NOT NULL,
    ID VARCHAR2(20) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15) NOT NULL,
    ENROLL_DATE DATE DEFAULT SYSDATE
);

-- NOT NULL 제약조건에 위배되어 오류발생.
INSERT INTO MEMBER VALUES (1, 'USER1', NULL, NULL, NULL); -- 오류

-- NOT NULL 제약조건이 걸려있는 컬럼에는 반드시 값이 있어야한다.
INSERT INTO MEMBER VALUES (1, 'USER1', '1234', '홍길동' ,NULL);
INSERT INTO MEMBER VALUES (2, 'USER2', '1234', '이몽룡', DEFAULT);
INSERT INTO MEMBER(NO, ID, PASSWORD, NAME) VALUES(3, 'USER3', '5678', '성춘향');

-- 테이블의 데이터를 수정하는 구문
UPDATE MEMBER
SET ID = NULL
WHERE NAME = '홍길동';

SELECT * FROM MEMBER;

-- 사용자가 작성한 제약 조건을 확인하는 뷰 테이블
SELECT *
FROM USER_CONSTRAINTS; --> 현재 가지고 있는 제약 조건들 보여줌

-- 사용자가 작성한 제약 조건이 걸려있는 컬럼을 확인하는 뷰 테이블이다.
SELECT UC.CONSTRAINT_NAME,
       UC.TABLE_NAME,
       UCC.COLUMN_NAME,
       UC.CONSTRAINT_TYPE,
       UC.SEARCH_CONDITION
FROM USER_CONSTRAINTS UC
INNER JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.TABLE_NAME = 'MEMBER';


/*
    2. UNIQUE 제약 조건
       컬럼에 중복된 값을 저장하거나 중복된 값으로 수정할 수 없도록 한다.
       UNIQUE 제약조건은 컬럼 레벨, 테이블 레벨 방식 모두 설정이 가능하다.
*/
-- 아이디가 중복되어도 성공적으로 데이터가 삽입된다.
INSERT INTO MEMBER VALUES (1, 'USER1', '1234', '임꺽정', DEFAULT);
INSERT INTO MEMBER VALUES (1, 'USER1', '1234', '임꺽정', DEFAULT);

--UNIQUE 제약조건을 설정한 테이블 생성
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    NO NUMBER NOT NULL UNIQUE,
    ID VARCHAR2(20) NOT NULL UNIQUE,
    PASSWORD VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15) NOT NULL,
    ENROLL_DATE DATE DEFAULT SYSDATE
);

INSERT INTO MEMBER VALUES (1, 'USER1', '1234', '홍길동', DEFAULT);
--INSERT INTO MEMBER VALUES (2, 'USER1', '5678', '임꺽정', DEFAULT); -- UNIQUE가 걸려있는 컬럼에 동일한 값이 들어갔기 때문에 에러
INSERT INTO MEMBER VALUES (2, 'USER2', '5678', '임꺽정', DEFAULT);


/*
    테이블 레벨 방식
*/
--UNIQUE 제약조건을 설정한 테이블 생성(테이블 레벨 방식)
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
         --  CONSTRAINT 제약조건명 : 테이블명_컬럼명_제약조건
    NO NUMBER CONSTRAINT MEMBER_NO_NN NOT NULL, -- NN : NOT NULL 제약조건
    ID VARCHAR2(20) CONSTRAINT MEMBER_ID_NN NOT NULL,
    PASSWORD VARCHAR2(20) CONSTRAINT MEMBER_PASSWORD_NN NOT NULL,
    NAME VARCHAR2(15) CONSTRAINT MEMBER_NAME_NN NOT NULL,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_UQ UNIQUE(NO), -- MEMBER 내에 NO 파트에 UNIQUE 제약조건을 넣겠다.(테이블 내) : 테이블 레벨링
    CONSTRAINT MEMBER_ID_UQ UNIQUE(ID)
);

INSERT INTO MEMBER VALUES (1, 'USER1', '1234', '홍길동', DEFAULT);
--INSERT INTO MEMBER VALUES (2, 'USER1', '5678', '임꺽정', DEFAULT);  -- UNIQUE가 걸려있는 컬럼에 동일한 값이 들어갔기 때문에 에러
INSERT INTO MEMBER VALUES (2, 'USER2', '5678', '임꺽정', DEFAULT);


-- 여러 개의 컬럼을 묶어서 하나의 UNIQUE 제약조건을 설정한 테이블 생성.
-- 단, 반드시 테이블 레벨로만 설정이 가능하다.
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
         --  CONSTRAINT 제약조건명 : 테이블명_컬럼명_제약조건
    NO NUMBER CONSTRAINT MEMBER_NO_NN NOT NULL, -- NN : NOT NULL 제약조건
    ID VARCHAR2(20) CONSTRAINT MEMBER_ID_NN NOT NULL,
    PASSWORD VARCHAR2(20) CONSTRAINT MEMBER_PASSWORD_NN NOT NULL,
    NAME VARCHAR2(15) CONSTRAINT MEMBER_NAME_NN NOT NULL,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_ID_UQ UNIQUE(NO, ID) -- MEMBER 내에 NO,ID 파트에 UNIQUE 제약조건을 넣겠다.(테이블 내) => 2개가 동시에 제약되어야 오류
);

-- 여러 개의 컬럼을 묶어서 하나의 UNIQUE 제약조건이 설정되어 있으면
-- 제약 조건이 설정되어 있는 컬럼 값이 모두 중복되는 경우에만 오류 발생한다.
INSERT INTO MEMBER VALUES (1, 'USER1', '1234', '홍길동', DEFAULT);
INSERT INTO MEMBER VALUES (2, 'USER1', '5678', '임꺽정', DEFAULT); -- NO, ID 둘다 동시에 UNIQUE가 걸려야 오류가 나기 때문에 실행이 됨
INSERT INTO MEMBER VALUES (2, 'USER1', '5678', '홍길동', DEFAULT); --  NO, ID 둘다 동시에 중복이 되었기 때문에 에러
INSERT INTO MEMBER VALUES (2, 'USER2', '5678', '홍길동', DEFAULT); -- NO는 중복되나 ID가 중복이 안되기 때문에 실행

/* 멤버 데이터 확인하기 */
SELECT * FROM MEMBER;
/* 데이터 제약조건 확인하기 */
SELECT UC.CONSTRAINT_NAME,
       UC.TABLE_NAME,
       UCC.COLUMN_NAME,
       UC.CONSTRAINT_TYPE,
       UC.SEARCH_CONDITION
FROM USER_CONSTRAINTS UC
INNER JOIN USER_CONS_COLUMNS UCC ON (UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
WHERE UC.TABLE_NAME = 'MEMBER';


/*
    CHECK 제약조건
      컬럼에 기록되는 값에 조건을 설정하고 조건을 만족하는 값만 저장하거나 수정하도록 한다.
      CHECK 제약조건은 컬럼 레벨, 테이블 레벨에서 모두 설정이 가능하다.
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    NO NUMBER NOT NULL,
    ID VARCHAR2(20) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15) NOT NULL,
    GENDER CHAR(3),
    AGE NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_UQ UNIQUE(NO), -- MEMBER 내에 NO 파트에 UNIQUE 제약조건을 넣겠다.(테이블 내) : 테이블 레벨링
    CONSTRAINT MEMBER_ID_UQ UNIQUE(ID)
);

-- 성별, 나이에 유효한 값이 아닌 값들도 INSERT 된다.
INSERT INTO MEMBER
VALUES(1,'USER1', '1234', '홍길동', '남', 25, DEFAULT);
INSERT INTO MEMBER
VALUES(2,'USER2', '1234', '성춘향', '여', 20, DEFAULT);
INSERT INTO MEMBER
VALUES(3,'USER3', '1234', '임꺽정', '강', -30, DEFAULT);

-- CHECK 제약조건을 설정한 테이블 생성
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    NO NUMBER NOT NULL,
    ID VARCHAR2(20) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15) NOT NULL,
    GENDER CHAR(3) CONSTRAINT MEMBER_GENDER_CK CHECK(GENDER IN ('남','여')),  -- 컬럼 레벨 방식
    AGE NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_UQ UNIQUE(NO),
    CONSTRAINT MEMBER_ID_UQ UNIQUE(ID),
    CONSTRAINT MEMBER_AGE_CK CHECK(AGE >= 0)  -- 테이블 레벨 방식
);

INSERT INTO MEMBER
VALUES(1,'USER1', '1234', '홍길동', '남', 25, DEFAULT);
INSERT INTO MEMBER
VALUES(2,'USER2', '1234', '성춘향', '여', 20, DEFAULT);
INSERT INTO MEMBER
--VALUES(3,'USER3', '1234', '임꺽정', '강', 30, DEFAULT); -- 성별이 '강'으로 체크제약조건 위배
-- GENDER 컬럼에 '남' 또는 '여'만 입력 가능하도록 설정이 되었기 때문에 에러가 발생한다.
VALUES(3,'USER3', '1234', '임꺽정', '남', 30, DEFAULT);
--VALUES(4,'USER4', '1234', '이몽룡', '남', -22, DEFAULT);
-- AGE 컬럼에 0보다 크거나 같은 값만 입력 가능하도록 설정이 되었기 때문에 에러가 발생한다.

/*
    수정(업데이트)
*/
UPDATE MEMBER
SET PASSWORD = '5678'
WHERE NO = 1; -- SET절 다음에는 반드시 WHERE절을 줘서 지정한 데이터만 변경할 수 있도록 한다.(지정한 데이터만 노출될수있는 조건으로)

UPDATE MEMBER
--SET GENDER = '강'
/SET AGE = -100
WHERE NO = 1; -- 수정할때도 체크 제약조건은 따라야한다.


-----------------------------

SELECT QUERY
  FROM (
    SELECT TABLE_NAME
         , '1' AS NUM
         , 'SELECT'  AS QUERY
      FROM USER_COL_COMMENTS
     UNION
    SELECT TABLE_NAME
         , '2' AS NUM
         , RPAD('     , ' || COLUMN_NAME, 22) || ' AS "' || COMMENTS || '"' AS QUERY
      FROM USER_COL_COMMENTS
     UNION
    SELECT TABLE_NAME
          , '3' AS NUM
         , '  FROM ' || RPAD(TABLE_NAME || ';' , 15)|| ' -- ' || COMMENTS  AS  QUERY
      FROM USER_TAB_COMMENTS
)
-- WHERE TABLE_NAME = 'MEMBER'
 ORDER BY TABLE_NAME, NUM
;