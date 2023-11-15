/*
    < SEQUENCE >
        SEQUENCE는 오라클에서 제공하는 객체로 순차적으로 정수 값을 자동으로 생성한다.
*/
-- 1. SEQUENCE 생성
/*
    CREATE SEQUENCE 시퀀스명
    [START WITH 숫자]	 -- 처음 발생시킬 시작 값을 지정한다. (기본값: 1)
    [INCREMENT BY 숫자]  --	다음 값에 대한 증가치를 지정한다. (기본값: 1)
    [MAXVALUE 숫자]  -- SEQUENCE에서 발생시킬 최대값을 지정한다.
    [MINVALUE 숫자]  -- SEQUENCE에서 발생시킬 최소값을 지정한다.
    [CYCLE | NOCYCLE]	-- 값의 순환 여부를 지정한다.
    [CACHE | NOCACHE]	-- 	캐시메모리 사용 여부를 지정한다.
*/
-- EMPLOTEE 테이블의 PK 값을 생성할 시퀀스 생성
CREATE SEQUENCE SEQ_MNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

-- 현재 계정이 가지고 있는 시퀀스들에 대한 정보를 조회하는 뷰 테이블이다.
SELECT * FROM USER_SEQUENCES;

-- 2. SEQUENCE 사용
/*
    시퀀스명.NEXTVAL; : 시퀀스 값을 증가시키고 증가된 시퀀스 값을 리턴
    시퀀스명.CURRVAL; : 현재 시퀀스의 값을 리턴
*/
-- NEXTVAL를 한번이라도 수행하지 않은 상태에서 CURRVAL를 가져올 수 없다.
-- CURRVAL는 마지막으로 수행된 NEXTVAL값을 저장해서 보여주는 값이다.
SELECT SEQ_MNO.CURRVAL FROM DUAL;

SELECT SEQ_MNO.NEXTVAL FROM DUAL; -- 300
SELECT SEQ_MNO.CURRVAL FROM DUAL; -- 300
SELECT SEQ_MNO.NEXTVAL FROM DUAL; -- 305 (5씩 증가하게 만들었음)
SELECT SEQ_MNO.NEXTVAL FROM DUAL; -- 310
-- 이 이상은 MAXVALUE를 넘어서 오류가 남.

DROP SEQUENCE SEQ_MNO;

-- 3. SEQUENCE 수정
/*
    ALTER SEQUENCE 시퀀스명
    [INCREMENT BY 숫자]
    [MAXVALUE 숫자]
    [MINVALUE 숫자]
    [CYCLE | NOCYCLE]	
    [CACHE | NOCACHE]	
    -- START WITH 값 변경은 불가 (시퀀스 삭제 후 재생성 해야함)
*/
ALTER SEQUENCE SEQ_MNO
START WITH 200; -- 시퀀스 시작 번호는 변경 불가능. 에러 발생

ALTER SEQUENCE SEQ_MNO
INCREMENT BY 10
MAXVALUE 400
NOCYCLE
NOCACHE;

SELECT SEQ_MNO.NEXTVAL FROM DUAL; -- 320
SELECT SEQ_MNO.NEXTVAL FROM DUAL; -- 330
SELECT SEQ_MNO.NEXTVAL FROM DUAL; -- 340
SELECT SEQ_MNO.CURRVAL FROM DUAL;  -- 340 (마지막 값)


-- 4. SEQUENCE 예시
-- 매번 새로운 회원 번호를 생성하는 SEQUENCE를 사용해서 INSERT 작성
INSERT INTO TB_MEMBER(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME)
VALUES (SEQ_MNO.NEXTVAL, 'ISMOON', '1234', '홍길동');

INSERT INTO TB_MEMBER(MEMBER_NO, MEMBER_ID, MEMBER_PWD, MEMBER_NAME)
VALUES (SEQ_MNO.NEXTVAL, 'MOON', '5678', '문문문');

SELECT * FROM TB_MEMBER;

-- 5. SEQUENCE 삭제
DROP SEQUENCE SEQ_MNO;