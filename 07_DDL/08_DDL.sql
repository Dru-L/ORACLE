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
    3. CHECK 제약조건
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
SET AGE = -100
WHERE NO = 1; -- 수정할때도 체크 제약조건은 따라야한다.


/*
    4. PRIMARY KEY 제약 조건
       테이블에서 한 행의 정보를 식별하기 위해 사용할 컬럼에 부여하는 제약조건이다. (기본 키)
       PRIMARY KEY 제약조건은 컬럼 레벨, 테이블 레벨에서 모두 설정이 가능하다.
       PRIMARY KEY 제약조건을 설정하게 되면 자동으로 해당 컬럼에 NOT NULL, UNIQUE 제약조건이 걸린다.
*/
-- CHECK 제약조건을 설정한 테이블 생성
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
--    NO NUMBER CONSTRAINT MEMBER_NO_PK PRIMARY KEY, -- PRIMARY KEY 는 자동으로 해당 컬럼에 NOT NULL, UNIQUE 제약조건이 걸린다.
    NO NUMBER, -- 테이블 레벨 방식
--    ID VARCHAR2(20) PRIMARY KEY, -- 테이블에는 하나의 기본키만 가질수 있다는 에러가 뜸.(PRIMARY KEY는 1번만 가능)
    ID VARCHAR2(20) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15) NOT NULL,
    GENDER CHAR(3),  -- 컬럼 레벨 방식
    AGE NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_PK PRIMARY KEY(NO),  -- 테이블 레벨 방식
    CONSTRAINT MEMBER_ID_UQ UNIQUE(ID),
    CONSTRAINT MEMBER_GENDER_CK CHECK(GENDER IN ('남','여')), 
    CONSTRAINT MEMBER_AGE_CK CHECK(AGE >= 0)
);

INSERT INTO MEMBER
VALUES(1, 'USER1', '1234', '홍길동', '남', '22', DEFAULT);

INSERT INTO MEMBER
VALUES(2, 'USER2', '5678', '성춘향', '여', '22', DEFAULT);

-- 기본 키 중복으로 에러 발생
INSERT INTO MEMBER
VALUES(2, 'USER3', '5678', '이몽룡', '남', '26', DEFAULT);

-- 기본 키 NULL이므로 에러 발생
INSERT INTO MEMBER
VALUES(NULL, 'USER3', '5678', '이몽룡', '남', '26', DEFAULT);

-- 여러 컬럼을 묶어서 하나의 기본 키를 생성(복합키라고 한다.)
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    NO NUMBER, -- 테이블 레벨 방식
    ID VARCHAR2(20),
    PASSWORD VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15) NOT NULL,
    GENDER CHAR(3),  -- 컬럼 레벨 방식
    AGE NUMBER,
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_PK PRIMARY KEY(NO, ID),  -- 복합키 (NO,ID가 둘다 중복되어야 에러가 난다)
    CONSTRAINT MEMBER_GENDER_CK CHECK(GENDER IN ('남','여')), 
    CONSTRAINT MEMBER_AGE_CK CHECK(AGE >= 0)
);

INSERT INTO MEMBER
VALUES(2, 'USER3', '5678', '이몽룡', '남', '26', DEFAULT);

-- 회원번호, 아이디가 둘다 동일한 값이 이미 존재하기 때문에 (UNIQUE) 에러가 발생.
INSERT INTO MEMBER
VALUES(2, 'USER3', '5678', '임꺽정', '남', '30', DEFAULT);

-- 기본키로 지정한 컬럼의 NULL값이 있으면 에러가 발생. (1개가 NULL값이어도 에러남)
INSERT INTO MEMBER
VALUES(NULL, 'USER4', '5678', '이몽룡', '남', '26', DEFAULT);
INSERT INTO MEMBER
VALUES(4, NULL, '5678', '이몽룡', '남', '26', DEFAULT);
INSERT INTO MEMBER
VALUES(NULL, NULL, '5678', '이몽룡', '남', '26', DEFAULT);


/*
    5. FOREIGN KEY 제약 조건
       외래 키 역할을 하는 컬럼에 부여하는 제약조건이다.
       외래 키가 참조하는 컬럼은 부모 테이블의 기본 키 컬럼이거나 중복된 값이 없는 컬럼만 가능하다. (PRIMARY KEY | UNIQUE)
       컬럼 레벨, 테이블 레벨에서 모두 설정이 가능하다.
       
       [표현법]
        1) 컬럼 레벨
            컬럼명 자료형(크기) [CONSTRAINT 제약조건명] REFERENCES 참조할테이블명 [(컬럼명)] [삭제룰]
            
        2) 테이블 레벨
            [CONSTRAINT 제약조건명] FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명 [(컬럼명)] [삭제룰]
*/
-- 회원 등급에 대한 데이터를 저장하는 테이블 (부모 테이블)
CREATE TABLE MEMBER_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);

INSERT INTO MEMBER_GRADE VALUES(10, '일반회원');
INSERT INTO MEMBER_GRADE VALUES(20, '우수회원');
INSERT INTO MEMBER_GRADE VALUES(30, '특별회원');

SELECT * FROM MEMBER_GRADE;

-- FOREIGN KEY 제약조건을 설정한 테이블 생성
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    NO NUMBER, -- 테이블 레벨 방식
    ID VARCHAR2(20) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15) NOT NULL,
    GENDER CHAR(3),  -- 컬럼 레벨 방식
    AGE NUMBER,
    GRADE_ID NUMBER REFERENCES MEMBER_GRADE, -- 부모 테이블 컬럼과 데이터형태가 같아야함. (기본키 참조할때는 컬럼명 생략 가능)
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_PK PRIMARY KEY(NO),  -- 테이블 레벨 방식
    CONSTRAINT MEMBER_ID_UQ UNIQUE(ID),
    CONSTRAINT MEMBER_GENDER_CK CHECK(GENDER IN ('남','여')), 
    CONSTRAINT MEMBER_AGE_CK CHECK(AGE >= 0)
);

INSERT INTO MEMBER
VALUES(1, 'USER1', '1234', '홍길동', '남', '22', 10, DEFAULT);

-- 50이라는 값이 MEMBER_GRADE 테이블에 GRADE_CODE 컬럼에서 제공하는 값이 아니므로 외래 키 제약 조건에 위배되어 에러가 발생한다.
INSERT INTO MEMBER
VALUES(2, 'USER2', '5678', '성춘향', '여', '22', 50, DEFAULT);

-- NULL 값은 허용한다.
INSERT INTO MEMBER
VALUES(2, 'USER2', '5678', '성춘향', '여', '22', NULL, DEFAULT);

-- MEMBER 테이블과 MEMBER_GRADE 테이블을 조인하여 ID, NAME, GRADE_NAME 조회
-- ANSI
SELECT M.ID, M.NAME, G.GRADE_NAME
FROM MEMBER M
LEFT OUTER JOIN MEMBER_GRADE G ON (M.GRADE_ID = G.GRADE_CODE);

-- 오라클
SELECT M.ID, M.NAME, G.GRADE_NAME
FROM MEMBER M, MEMBER_GRADE G
WHERE M.GRADE_ID = G.GRADE_CODE(+);

-- MEMBER_GRADE 테이블에서 GRADE_CODE가 10인 데이터를 지우기
-- 자식 테이블의 행들 중에 GRADE_ID가 10인 행이 존재하기 떄문에 삭제할 수 없다.
DELETE FROM MEMBER_GRADE WHERE GRADE_CODE = 10;

-- MEMBER_GRADE 테이블에서 GRADE_CODE가 30인 데이터를 지우기
-- 자식 테이블의 행들 중에서 GRADE_ID가 30인 행이 존재하지 않기 때문에 삭제할 수 있다.
DELETE FROM MEMBER_GRADE WHERE GRADE_CODE = 30;

/*
    < 삭제룰 >
        ON DELETE RESTRICT : 자식 테이블의 참조 키가 부모 테이블의 키값을 참조하는 경우 부모 테이블의 행을 삭제할 수 없다. (기본)
        ON DELETE SET NULL : 부모 테이블의 데이터가 삭제 시 참조하고 있는 자식 테이블의 컬럼 값이 NULL로 변경된다.
        ON DELETE CASCADE : 부모 테이블의 데이터가 삭제 시 참조하고 있는 자식 테이블의 컬럼 값이 존재하는 행 전체가 삭제된다.
*/
-- ON DELETE SET NULL 옵션이 추가된 자식 테이블 생성
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    NO NUMBER, -- 테이블 레벨 방식
    ID VARCHAR2(20) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15) NOT NULL,
    GENDER CHAR(3),  -- 컬럼 레벨 방식
    AGE NUMBER,
    GRADE_ID NUMBER, -- 부모 테이블 컬럼과 데이터형태가 같아야함. (기본키 참조할때는 컬럼명 생략 가능)
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_PK PRIMARY KEY(NO),  -- 테이블 레벨 방식
    CONSTRAINT MEMBER_ID_UQ UNIQUE(ID),
    CONSTRAINT MEMBER_GENDER_CK CHECK(GENDER IN ('남','여')), 
    CONSTRAINT MEMBER_AGE_CK CHECK(AGE >= 0),
    CONSTRAINT MEMBER_GRADE_ID_FK FOREIGN KEY(GRADE_ID) REFERENCES MEMBER_GRADE(GRADE_CODE) ON DELETE SET NULL
);

INSERT INTO MEMBER
VALUES(1, 'USER1', '1234', '홍길동', '남', '22', 10, DEFAULT);

INSERT INTO MEMBER
VALUES(2, 'USER2', '5678', '성춘향', '여', '22', NULL, DEFAULT);

-- MEMBER_GRADE 테이블에서 GRADE_CODE가 10인 데이터를 지우기
DELETE FROM MEMBER_GRADE WHERE GRADE_CODE = 10; -- 부모클래스 데이터만 삭제됨

ROLLBACK; -- 삭제한 데이터 롤백


-- ON DELETE CASCADE 옵션이 추가된 자식 테이블 생성 
DROP TABLE MEMBER;

CREATE TABLE MEMBER (
    NO NUMBER, -- 테이블 레벨 방식
    ID VARCHAR2(20) NOT NULL,
    PASSWORD VARCHAR2(20) NOT NULL,
    NAME VARCHAR2(15) NOT NULL,
    GENDER CHAR(3),  -- 컬럼 레벨 방식
    AGE NUMBER,
    GRADE_ID NUMBER, -- 부모 테이블 컬럼과 데이터형태가 같아야함. (기본키 참조할때는 컬럼명 생략 가능)
    ENROLL_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEMBER_NO_PK PRIMARY KEY(NO),  -- 테이블 레벨 방식
    CONSTRAINT MEMBER_ID_UQ UNIQUE(ID),
    CONSTRAINT MEMBER_GENDER_CK CHECK(GENDER IN ('남','여')), 
    CONSTRAINT MEMBER_AGE_CK CHECK(AGE >= 0),
    CONSTRAINT MEMBER_GRADE_ID_FK FOREIGN KEY(GRADE_ID) REFERENCES MEMBER_GRADE(GRADE_CODE) ON DELETE CASCADE
);

INSERT INTO MEMBER
VALUES(1, 'USER1', '1234', '홍길동', '남', '22', 10, DEFAULT);

INSERT INTO MEMBER
VALUES(2, 'USER2', '5678', '성춘향', '여', '22', NULL, DEFAULT);

-- MEMBER_GRADE 테이블에서 GRADE_CODE가 10인 데이터를 지우기
DELETE FROM MEMBER_GRADE WHERE GRADE_CODE = 10; -- 부모 및 자식클래스 데이터 삭제


/*
    <SUBQUERY를 이용한 테이블 생성>
       서브 쿼리를 이용해서 SELECT의 조회 결과로 테이블을 생성하는 구문이다. 
       컬럼명과 데이터 타입, 값이 복사되고, 제약조건은 NOT NULL만 복사된다.
*/
-- EMPLOYEE 테이블을 복사한 새로운 테이블 생성
CREATE TABLE EMP_COPY
AS SELECT *
   FROM EMPLOYEE;
   
SELECT * FROM EMP_COPY;

-- MEMBER 테이블을 복사한 새로운 테이블 생성
-- 컬럼, 데이터 타입, 값, NOT NULL 제약조건 복사
CREATE TABLE MEM_COPY
AS SELECT *
   FROM MEMBER;

SELECT * FROM MEM_COPY;

DROP TABLE EMP_COPY; -- 삭제
DROP TABLE MEM_COPY; -- 삭제

-- EMPLOYEE 테이블을 복사한 새로운 테이블 생성
-- 컬럼, 데이터 타입, 값, NOT NULL 제약조건 복사
CREATE TABLE EMP_COPY
AS SELECT *
   FROM EMPLOYEE
   WHERE 1 = 0; -- 1 = 0은 모든 행에서 거짓이기 때문에 컬럼 내 데이터는 복사가 안되고 컬럼만 복사됨
   
SELECT * FROM EMP_COPY;

DROP TABLE EMP_COPY;

-- EMPLOYEE 테이블에서 사번, 직원명, 급여, 연봉을 저장하는 테이블을 생성
-- SELECT 절에 산술연산 또는 함수식이 기술된 경우에는 별칭을 지정해야 한다.
CREATE TABLE EMP_COPY
AS SELECT EMP_ID AS "사번",
          EMP_NAME AS "직원명",
          SALARY AS "급여",
          SALARY * 12 AS "연봉"
    FROM EMPLOYEE;


--------------------------------



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


---------------------------------------------------------------------
-- 실습 문제
-- 도서관리 프로그램을 만들기 위한 테이블 만들기
-- 이때, 제약조건에 이름을 부여하고, 각 컬럼에 주석 달기

-- 1. 출판사들에 대한 데이터를 담기 위한 출판사 테이블(TB_PUBLISHER) 
--  1) 컬럼 : PUB_NO(출판사 번호) -- 기본 키
--           PUB_NAME(출판사명) -- NOT NULL
--           PHONE(출판사 전화번호)
CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER CONSTRAINT TB_PUB_NO_PK PRIMARY KEY,
    PUB_NAME VARCHAR2(30) CONSTRAINT TB_PUB_NAME_N NOT NULL,
    PHONE VARCHAR2(13)
);
DROP TABLE TB_PUBLISHER;

-- 컬럼 주석
COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS '출판사 번호';
COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS '출판사명';
COMMENT ON COLUMN TB_PUBLISHER.PHONE IS '출판사 전화번호';

--  2) 3개 정도의 샘플 데이터 추가하기
INSERT INTO TB_PUBLISHER
VALUES (1, '이지스퍼블리싱', '010-0000-0000');
INSERT INTO TB_PUBLISHER
VALUES (2, '문학동네', '02-1234-5678');
INSERT INTO TB_PUBLISHER
VALUES (3, '다산북스', '02-5647-8521');


-- 2. 도서들에 대한 데이터를 담기 위한 도서 테이블 (TB_BOOK)
--  1) 컬럼 : BK_NO (도서번호) -- 기본 키
--           BK_TITLE (도서명) -- NOT NULL
--           BK_AUTHOR(저자명) -- NOT NULL
--           BK_PRICE(가격)
--           BK_PUB_NO(출판사 번호) -- 외래 키(TB_PUBLISHER 테이블을 참조하도록)
--                                    이때 참조하고 있는 부모 데이터 삭제 시 자식 데이터도 삭제 되도록 옵션 지정
CREATE TABLE TB_BOOK(
    BK_NO NUMBER CONSTRAINT TB_BK_NO_PK PRIMARY KEY,
    BK_TITLE VARCHAR2(40) NOT NULL,
    BK_AUTHOR VARCHAR2(20) NOT NULL,
    BK_PRICE NUMBER,
    BK_PUB_NO NUMBER,
    CONSTRAINT TB_BK_PUB_NO_FK FOREIGN KEY(BK_PUB_NO) REFERENCES TB_PUBLISHER(PUB_NO) ON DELETE CASCADE
); 

-- 컬럼 주석
COMMENT ON COLUMN TB_BOOK.BK_NO IS '도서번호';
COMMENT ON COLUMN TB_BOOK.BK_TITLE IS '도서명';
COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS '저자명';
COMMENT ON COLUMN TB_BOOK.BK_PRICE IS '가격';
COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS '출판사 번호';

--  2) 5개 정도의 샘플 데이터 추가하기
INSERT INTO TB_BOOK
VALUES(100, '자바의 정석', '남궁석', 30000, 1);
INSERT INTO TB_BOOK
VALUES(101, '백설공주에게 죽음을', '넬레', 30000, 3);
INSERT INTO TB_BOOK
VALUES(102, '종의 기원', '정유정', 25000, 2);
INSERT INTO TB_BOOK
VALUES(103, '양들의 침묵', '토머스 해리스', 11000, 3);
INSERT INTO TB_BOOK
VALUES(104, '섀도 하우스', '안나 다운스', 28000, 1);

-- 3. 회원에 대한 데이터를 담기 위한 회원 테이블 (TB_MEMBER)
--  1) 컬럼 : MEMBER_NO(회원번호) -- 기본 키
--           MEMBER_ID(아이디)   -- 중복 금지
--           MEMBER_PWD(비밀번호) -- NOT NULL
--           MEMBER_NAME(회원명) -- NOT NULL
--           GENDER(성별)        -- 'M' 또는 'F'로 입력되도록 제한
--           ADDRESS(주소)       
--           PHONE(연락처)       
--           STATUS(탈퇴 여부)     -- 기본값으로 'N' 그리고 'Y' 혹은 'N'으로 입력되도록 제약조건
--           ENROLL_DATE(가입일)  -- 기본값으로 SYSDATE, NOT NULL
CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER CONSTRAINT TB_MEMBER_NO_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20) NOT NULL,
    MEMBER_NAME VARCHAR2(12) NOT NULL,
    GENDER CHAR(1),
    ADDRESS VARCHAR2(60),
    PHONE VARCHAR2(13),
    STATUS CHAR(1) DEFAULT 'N',
    ENROLL_DATE DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT TB_MEMBER_ID_UN UNIQUE(MEMBER_ID),
    CONSTRAINT TB_GENDER_CK CHECK(GENDER IN ('M', 'F')),
    CONSTRAINT TB_STATUS_CK CHECK(STATUS IN ('Y', 'N'))
);

-- 컬럼 주석
COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS '회원번호';
COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '아이디';
COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '비밀번호';
COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS '회원명';
COMMENT ON COLUMN TB_MEMBER.GENDER IS '성별';
COMMENT ON COLUMN TB_MEMBER.ADDRESS IS '주소';
COMMENT ON COLUMN TB_MEMBER.PHONE IS '연락처';
COMMENT ON COLUMN TB_MEMBER.STATUS IS '탈퇴 여부';
COMMENT ON COLUMN TB_MEMBER.ENROLL_DATE IS '가입일';

--  2) 3개 정도의 샘플 데이터 추가하기
INSERT INTO TB_MEMBER
VALUES(1000, 'AAA', '1234', '홍길동', 'M', '서울시 성동구', '010-0000-1111', DEFAULT, DEFAULT);
INSERT INTO TB_MEMBER
VALUES(2000, 'BBB', '5678', '남주', 'M', '서울시 노원구', '010-1234-1241', 'Y', '22/06/21');
INSERT INTO TB_MEMBER
VALUES(3000, 'CCC', '0000', '여주', 'F', '서울시 종로구', '010-4556-1231', 'N', '23/10/10');
INSERT INTO TB_MEMBER
VALUES(4000, 'DDD', '0111', '조연출', 'F', '서울시 서초구', '010-5223-7855', 'N', '210407');


-- 4. 도서를 대여한 회원에 대한 데이터를 담기 위한 대여 목록 테이블(TB_RENT)
--  1) 컬럼 : RENT_NO(대여번호) -- 기본 키
--           RENT_MEM_NO(대여 회원번호) -- 외래 키(TB_MEMBER와 참조)
--                                      이때 부모 데이터 삭제 시 NULL 값이 되도록 옵션 설정
--           RENT_BOOK_NO(대여 도서번호) -- 외래 키(TB_BOOK와 참조)
--                                      이때 부모 데이터 삭제 시 NULL 값이 되도록 옵션 설정
--           RENT_DATE(대여일) -- 기본값 SYSDATE
CREATE TABLE TB_RENT(
    RENT_NO NUMBER,
    RENT_MEM_NO NUMBER,
    RENT_BOOK_NO NUMBER,
    RENT_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT RENT_RENT_NO_PK PRIMARY KEY(RENT_NO),
    CONSTRAINT RENT_MEM_NO_FK FOREIGN KEY(RENT_MEM_NO) REFERENCES TB_MEMBER(MEMBER_NO) ON DELETE SET NULL,
    CONSTRAINT RENT_BOOK_NO_FK FOREIGN KEY(RENT_BOOK_NO) REFERENCES TB_BOOK(BK_NO) ON DELETE SET NULL
);

COMMENT ON COLUMN TB_RENT.RENT_NO IS '대여번호';
COMMENT ON COLUMN TB_RENT.RENT_MEM_NO IS '대여 회원번호';
COMMENT ON COLUMN TB_RENT.RENT_BOOK_NO IS '대여 도서번호';
COMMENT ON COLUMN TB_RENT.RENT_DATE IS '대여일';

--  2) 샘플 데이터 3개 정도 
INSERT INTO TB_RENT
VALUES(111, 4000, 103, DEFAULT);
INSERT INTO TB_RENT
VALUES(112, 2000, 101, '231101');
INSERT INTO TB_RENT
VALUES(113, 1000, 100, '231108');
INSERT INTO TB_RENT
VALUES(114, 3000, 102, '231019');

-- 5. 102번 도서를 대여한 회원의 이름, 아이디, 대여일, 반납 예정일(대여일 + 7일)을 조회하시오.
SELECT M.MEMBER_NAME AS "이름",
       M. MEMBER_ID AS "아이디",
       R.RENT_DATE AS "대여일",
       R.RENT_DATE + 7 AS "반납 예정일"
FROM TB_RENT R
INNER JOIN TB_MEMBER M ON(R.RENT_MEM_NO = M.MEMBER_NO)
WHERE R.RENT_BOOK_NO = 102;

-- 6. 회원번호가 1000번인 회원이 대여한 도서들의 도서명, 출판사명, 대여일, 반납 예정일(대여일 + 7일)을 조회하시오.
SELECT B.BK_TITLE AS "도서명",
       P.PUB_NAME AS "출판사명",
       R.RENT_DATE AS "대여일",
       R.RENT_DATE + 7 AS "반납 예정일"
FROM TB_RENT R
INNER JOIN TB_MEMBER M ON(R.RENT_MEM_NO = M.MEMBER_NO)
INNER JOIN TB_BOOK B ON (R.RENT_BOOK_NO = B.BK_NO)
INNER JOIN TB_PUBLISHER P ON (B.BK_PUB_NO = P.PUB_NO)
WHERE R.RENT_MEM_NO = 1000;

----------------------------------------------------------------------------------------------------------------