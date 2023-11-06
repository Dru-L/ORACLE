/*
    <함수>
        단일행 함수
            - N 개의 값을 읽어서 N 개의 값을 반환한다.
            - 매 행 함수 실행 결과를 반환한다.
        그룹 함수
            - N 개의 값을 읽어서 1개의 값을 반환한다.
            - 하나의 그룹별로 함수 실행 결과를 반환한다.
            
    ** ORACLE과 MY SQL 의 함수는 다르다. 여기는 ORACLE 함수들이다.
*/

/*
    <단일행 함수>
    <문자 처리 함수>
        1) LENGTH / LENGTHB
           LENGTH(CHARACTER) : 글자 수 반환
           LENGTHB(CHARACTER) : 글자의 바이트 수 반환
           
           영문자, 숫자, 특수문자 한 글자 -> 1BYTE
           한글 한 글자 -> 3BYTE
*/
SELECT LENGTH('오라클'), LENGTHB('오라클') FROM DUAL;
SELECT LENGTH('ORACLE'), LENGTHB('ORACLE') FROM DUAL;
SELECT LENGTH('ORA클'), LENGTHB('ORA클') FROM DUAL;
SELECT LENGTH('오 라 클'), LENGTHB('오 라 클') FROM DUAL;  -- 공백도 1BYTE/1길이 로 계산

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME),
       EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

/*
    2) INSTR
       INSTR(CHARACTER, CHARACTER[, POSITION, OCCURRENCE])
       지정한 위치부터 지정한 숫자 번째로 나타나는 문자의 시작 위치를 반환한다.(시작위치는 1)
       문자를 찾지 못하면 0을 리턴해준다.
*/
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- 3번째 자리 B
SELECT INSTR('AABAACAABBAA', 'D') FROM DUAL; -- 없으므로 0 리턴
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL;  --1번째 자리부터 서치하라. 3번째 자리 B 리턴
SELECT INSTR('AABAACAABBAA', 'B', 4) FROM DUAL;  --4번째 자리부터 서치하라. 9번째 자리 B 리턴
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;  -- 맨뒤부터 찾아라.(-1) -> 10번째 자리 B 리턴
SELECT INSTR('AABAACAABBAA', 'B', -5) FROM DUAL;  -- 맨뒤의 5번째 자리부터 찾아라. -> 3번째자리 B 리턴
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL;  --1번째 자리부터 서치하라.그리고 2번째 B를 찾아라. -> 10번째 자리 B 리턴
SELECT INSTR('AABAACAABBAA', 'B', 1, -2) FROM DUAL;  -- OCCURRENCE에 음수를 작성하면 오류남.
SELECT INSTR('AABAACAABBAA', 'B', 1, 4) FROM DUAL;  -- 0
SELECT INSTR('AABAACAABBAA', 'B', -1, 3) FROM DUAL;  -- 3번째 자리 B

SELECT EMAIL AS "이메일", 
       INSTR(EMAIL,'@') AS "@위치",
       INSTR(EMAIL, 's', 1, 2) AS "두번째 s 위치"
FROM EMPLOYEE;


/*
    3) LPAD / RPAD
       LPAD/RPAD(CHARACTER, NUMBER[, CHARACTER])
       LPAD/RPAD (문자열, 반환할문자데이터길이[,공백에채울문자])
       LPAD : 주어진 문자열에 임의의 문자열을 왼쪽에 덧붙여 N 길이의 문자열을 반환하다. (왼쪽에 부족한 문자수 만큼 공백을 넣음)
       RPAD : 주어진 문자열에 임의의 문자열을 오른쪽에 덧붙여 N 길이의 문자열을 반환하다. (오른쪽에 부족한 문자수만큼 공백을 넣음)
*/
-- 10만큼의 길이 중 HELLO 값은 오른쪽으로 정렬하고 공백을 왼쪽에 채운다.
SELECT LPAD('HELLO', 10) FROM DUAL;  -- 10개의 문자열이라서 HELLO를 뺀 나머지 5 문자열 개수만큼 공백을 왼쪽에 넣음
SELECT LPAD('HELLO', 10, '*') FROM DUAL;   -- *****HELLO  (빈공백에 *을 넣어라)
SELECT LPAD('HELLO', 3) FROM DUAL; -- 길이가 더 짧으면, 글자를 자름

-- 10만큼의 길이 중 HELLO 값은 왼쪽으로 정렬하고 공백을 오른쪽에 채운다.
SELECT RPAD('HELLO', 10) FROM DUAL; --공백을 오른쪽에 넣음
SELECT RPAD('HELLO', 10, '#') FROM DUAL; -- HELLO#####

-- 991231-1****** 를 출력
SELECT RPAD('991231-1', 14, '*') FROM DUAL;

SELECT EMP_NAME AS "이름",
       RPAD(LPAD(EMP_NAME,2), 5, '*') AS "이름", -- 1한글 = 2자리 라고 생각해야함. LPAD / RPAD 함수 사용시에는 한글을 2BYTE 처리한다.
       EMP_NO AS "주민등록번호",
       RPAD(LPAD(EMP_NO,8), 14, '*') AS "주민등록번호" -- 8번째 자리 이후로 *표시 출력(LPAD, RPAD중첩하는 방법)
FROM EMPLOYEE;

/*
    4) LTRIM / RTRIM
       LTRIM / RTRIM(CHARACTER)
       LTRIM / RTRIM(수정할문장, '제거할문자')
       LTRIM : 주어진 문자열의 왼쪽에서 지정한 문자를 제거한 나머지를 반환한다.
       RTRIM : 	주어진 문자열의 오른쪽에서 지정한 문자를 제거한 나머지를 반환한다.
*/
SELECT LTRIM('    KH') FROM DUAL; -- 왼쪽의 공백을 지움(공백이 아닌 문자를 만날때까지)
SELECT LTRIM('    K H  ') FROM DUAL; -- K*H**
SELECT LTRIM('000123456', '0') FROM DUAL; -- 123456 , 안맞는 숫자가 나올시 그대로 BREAK. 그 이후 남은 숫자만 반환.
SELECT LTRIM('123123456', '123') FROM DUAL; -- 456
SELECT LTRIM('123123456', '321') FROM DUAL; -- 456 (왼쪽부터 문자 하나하나 다 확인하고 맞는 글자를 지운다. 안맞는 숫자가 나올시 그대로 BREAK)

SELECT RTRIM('KH    ')FROM DUAL; -- 오른쪽의 공백을 지운(공백이 아닌 문자를 만날때까지)
SELECT RTRIM('KH    ', '  ')FROM DUAL;
SELECT RTRIM('00012340056000', '0') FROM DUAL;  -- 00012340056, 안맞는 숫자가 나올시 그대로 BREAK. 그 이후 남은 숫자만 반환.

-- 양쪽 공백 제거
SELECT LTRIM(RTRIM('    KH    ')) FROM DUAL;
-- 양쪽 문자 제거
SELECT LTRIM(RTRIM('00012340056000', '0'), '0') FROM DUAL;


/*
    5) TRIM
       TRIM([[LEADING|TRAILING|BOTH] CHARACTER FROM] CHARACTER)
       TRIM([[LEADING|TRAILING|BOTH] 제거할문자 FROM] 수정할문자열)
*/
--양쪽에 있는 공백을 제거한다.
SELECT TRIM('   KH   ')FROM DUAL;
SELECT TRIM(' ' FROM '    KH   ')FROM DUAL;
SELECT TRIM(BOTH ' ' FROM '    KH   ')FROM DUAL;
--앞쪽에 있는 공백을 제거한다.
SELECT TRIM(LEADING ' ' FROM '    KH   ')FROM DUAL;
--뒤쪽에 있는 공백을 제거한다.
SELECT TRIM(TRAILING ' ' FROM '    KH   ')FROM DUAL;

-- 양쪽에 있는 문자를 제거한다.
SELECT TRIM('Z' FROM 'ZZZZZZZKHZZZZ')FROM DUAL;
SELECT TRIM(BOTH 'Z' FROM 'ZZZZZZZKHZZZZ')FROM DUAL;
SELECT TRIM('ZZZ' FROM 'ZZZZZZZKHZZZZ')FROM DUAL; --트림 설정은 하나 문자만 가지고 있어야 합니다. 에러 발생
-- 앞쪽에 있는 문자를 제거한다.
SELECT TRIM(LEADING 'Z' FROM 'ZZZZZZZKHZZZZ')FROM DUAL;
-- 뒤쪽에 있는 문자를 제거한다.
SELECT TRIM(TRAILING 'Z' FROM 'ZZZZZZZKHZZZZ')FROM DUAL;


/*
    6) SUBSTR
       SUBSTR(CHARACTER, POSITION[, LENGTH])
       SUBSTR(시작위치점, 출력개수[,길이])
       주어진 문자열에서 지정한 위치부터 지정한 개수의 문자열을 잘라내어 반환한다.
*/
SELECT SUBSTR ('SHOWMETHEMONEY', 7) FROM DUAL; -- 위치 지정(7번째 단어부터 노출) -> THEMONEY
SELECT SUBSTR ('SHOWMETHEMONEY', 7, 3) FROM DUAL; -- 위치 지정(7번째 단어부터 노출) 이후 3번째 까지만 노출 -> THE
SELECT SUBSTR ('SHOWMETHEMONEY', 1, 6) FROM DUAL; -- SHOWME
SELECT SUBSTR ('SHOWMETHEMONEY', -8, 3) FROM DUAL; -- 뒤에서부터 8번째 단어, 3번째 까지만
SELECT SUBSTR ('SHOW ME THE MONEY', 1, 6) FROM DUAL; -- 공백도 하나의 문자로 인정

-- EMPLOYEE 테이블에서 주민번호에 성별을 나타내는 부분만 잘라서 조회
SELECT EMP_NAME AS "직원명",
       SUBSTR(EMP_NO, 8, 1) AS "성별코드"
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8, 1) = 1 OR SUBSTR(EMP_NO, 8, 1) = 3;
WHERE SUBSTR(EMP_NO, 8, 1) IN (2,4)
ORDER BY "성별코드";

-- EMPLOYEE 테이블에서 주민번호 첫 번째 자리부터 성별코드까지 추출한 결과값의 오른쪽에 * 문자를 채워서 14글자로 조회
-- EX) 991212-1******
SELECT EMP_NAME AS "직원명",
       RPAD(SUBSTR(EMP_NO,1,8),14,'*') AS "성별코드"
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원명, 이메일, 아이디(이메일에서 '@'앞에 문자값만 출력)조회
SELECT EMP_NAME AS "직원명",
       EMAIL  AS "이메일",
       --RTRIM(EMAIL, '@kh.or.kr') AS "아이디"
       --LPAD(EMAIL, INSTR(EMAIL,'@')-1) AS "아이디"
       SUBSTR(EMAIL, 1, INSTR(EMAIL,'@')-1) AS "아이디"
FROM EMPLOYEE;


/*
    7) LOWER / UPPER / INITCAP
       LOWER / UPPER / INITCAP(CHARACTER)
       LOWER / UPPER / INITCAP(문자열)
*/
SELECT UPPER('show me the money') FROM DUAL; -- 대문자로 변경
SELECT LOWER('SHOW ME THE MONEY') FROM DUAL; -- 소문자로 변경
SELECT INITCAP('show me the money') FROM DUAL; -- 단어 앞 글자 마다 대문자로 변경


/*
    8) CONCAT
       CONCAT(CHARACTER, CHARACTER)
       CONCAT(문자열, 이어붙일문자열)
*/
SELECT CONCAT('가나다라','마바사아')FROM DUAL;
SELECT '가나다라' || '마바사아'FROM DUAL;

--CONTACT 함수는 두개의 문자 데이터만 전달받을 수 있다.
SELECT CONCAT('가나다라','마바사아','자차카타')FROM DUAL;
SELECT '가나다라'||'마바사아'||'자차카타'FROM DUAL;
SELECT CONCAT(CONCAT('가나다라','마바사아'),'자차카타')FROM DUAL;

SELECT EMP_NAME || '님의 급여는 ' || SALARY || '입니다.'
FROM EMPLOYEE;
SELECT CONCAT(CONCAT(CONCAT(EMP_NAME, '님의 급여는 '), SALARY), '입니다.')
--SELECT CONCAT (CONCAT(EMP_NAME, '님의 급여는 '), CONCAT(SALARY, '입니다.'))
FROM EMPLOYEE;


/*
    9) REPLACE
       REPLACE(CHARACTER, CHARACTER, CHARACTER)
       REPLACE(전체 문장, 변경하고 싶은 문장, 변경된 문장)
*/
-- EMPLOYEE 테이블에서 이메일의 kh.or.kr을 gmail.com 변경해서 조회
-- sun_di@kh.or.kr -> sun_di@gmail.com
SELECT REPLACE('sun_di@kh.or.kr', 'kh.or.kr', 'gmail.com')
FROM DUAL;

SELECT REPLACE(EMAIL, 'kh.or.kr', 'gmail.com'),
       REPLACE(EMAIL, '@kh.or.kr', '')
FROM EMPLOYEE;


/*
    <숫자 처리 함수>
    1)ABS 
        ABS(NUMBER) : 절대값을 구하는 함수
        ABS(숫자타입데이터)
*/
SELECT ABS(10), ABS(-10) FROM DUAL;
SELECT ABS(10.9), ABS(-10.9) FROM DUAL;
SELECT ABS(-25.2), ABS(25.2) FROM DUAL;


/*
    2) MOD : 나머지값 구하는 함수
       MOD(NUMBER, NUMBER)
*/
SELECT 10 + 3,
       10 - 3,
       10 * 3,
       10 / 3,
       MOD(10,3)
FROM DUAL;

SELECT MOD(-10, 3) FROM DUAL; -- -1
SELECT MOD(10, -3) FROM DUAL; -- 1
SELECT MOD(10.9, 3) FROM DUAL;  -- 1.9 (소수점도 나온다)
SELECT MOD(-10.9, 3) FROM DUAL; -- -1.9


/*
    3) ROUND : 반올림 함수
       ROUND(NUMBER[, POSITION])
       ROUND(반올림할숫자[, .을 기준으로 반올림할 위치])
*/
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.656) FROM DUAL;
SELECT ROUND(123.656, 1) FROM DUAL; -- 소숫점 첫째자리에서 반올림
SELECT ROUND(125.656, -1) FROM DUAL; -- 일의 자리에서 반올림
SELECT ROUND(123.656, 2) FROM DUAL; -- 소숫점 둘째자리에서 반올림
SELECT ROUND(125.656, -2) FROM DUAL; -- 십의 자리에서 반올림


/*
    4) CEIL : 올림 함수
       CEIL(NUMBER)
*/
SELECT CEIL(123.456) FROM DUAL; -- 124
--SELECT CEIL(123.456, 2) FROM DUAL;  -- 에러 발생(소수점밑은 무조건 올린다)


/*
    5) FLOOR : 버림 함수
       FLOOR(NUMBER)
*/
SELECT FLOOR(123.456) FROM DUAL; -- 123
SELECT FLOOR(456.789) FROM DUAL; -- 456
SELECT FLOOR(456.789, 1) FROM DUAL; -- 에러 발생(소수점밑은 무조건 내린다)


/*
    5) TRUNC : 버림 함수
       TRUNC(NUMBER[, POSITION])
       TRUNC(버릴숫자[, .을 기준으로 버릴 위치])
*/
SELECT TRUNC(123.456) FROM DUAL; -- 123
SELECT TRUNC(456.789) FROM DUAL; -- 456
SELECT TRUNC(456.789, 0) FROM DUAL; -- 456
SELECT TRUNC(456.789, 1) FROM DUAL; -- 456.7   소숫점 첫째자리에서 반올림
SELECT TRUNC(456.789, -1) FROM DUAL; -- 450   일의 자리에서 반올림


/*
    <날짜 처리 함수>
     1)SYSDATE : 윈도우에서 호출하는 현재 날짜 및 시간 반영. 년/월/일 로 기본적으로 세팅. 날짜 출력 포맷을 변경할 수 있다.(하단 참고)
*/
SELECT SYSDATE FROM DUAL;

-- 날짜 출력 포맷 변경 : 실행 후 다시 SYSDATE를 실행하면 포맷이 변경되어있다.
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD'; -- 년,월,일 포맷 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS'; -- 년,월,일,시간,분,초 도 호출
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';  -- 기본 포맷


/*
    2) MONTHS_BETWEEN : 두 날짜 사이의 개월수 차이를 리턴.(숫자 타입의 데이터)
       MONTHS_BETWEEN(DATE1, DATE2)
*/
SELECT MONTHS_BETWEEN(SYSDATE, '20230525') FROM DUAL; -- 오늘 날짜와 2023년05월25일까지의 개월수 차이.(소숫점까지 리턴.)
SELECT FLOOR(MONTHS_BETWEEN(SYSDATE, '20230525')) FROM DUAL;  -- 버림함수로 소숫점 버림.(표현하기 쉽게 하기위해 기본적으로 버림함수를 같이 씀)
SELECT FLOOR(MONTHS_BETWEEN(SYSDATE, '2023-05-25 12:25:40')) FROM DUAL; -- 날짜 데이터 포멧을 변경(시간단위까지)했을 때 시간 단위로까지도 개월수 차이 계산 가능

-- EMPLOYEE 테이블에서 직원명, 입사일, 근무 개월 수 조회
SELECT EMP_NAME AS "직원명",
       HIRE_DATE AS "입사일",
       FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS "근무 개월 수"
FROM EMPLOYEE;


/*
    3) ADD_MONTHS : 주어진 날짜에 지정하는 개월 수를 더하여 날짜 데이터를 반환한다.
       ADD_MONTHS(DATE, NUMBER)
       ADD_MONTHS(날짜, 지정하는 개월)
*/
SELECT ADD_MONTHS(SYSDATE, 6) FROM DUAL;

-- EMPLOYEE 테이블에서 직원명, 입사일, 입사후 3개월이 된 날짜를 조회
SELECT EMP_NAME AS "직원명",
       HIRE_DATE AS "입사일",
       ADD_MONTHS(HIRE_DATE, 3) AS "입사 후 3개월"
FROM EMPLOYEE;


/*
    4) NEXT_DAY : 주어진 날짜에 인자로 받은 요일이 가장 가까운 날짜를 반환한다.(지나간 날짜가 아닌 다음 날짜)
       NEXT_DAY(DATE, CHARACTER|NUMBER)	
       NEXT_DAY(날짜, 요일정보 -> 문자 또는 숫자)
*/
-- 현재 날짜에서 제일 가까운 일요일 조회
SELECT SYSDATE, NEXT_DAY(SYSDATE, '일요일') FROM DUAL;  -- 다음 일요일 날짜 반환
SELECT SYSDATE, NEXT_DAY(SYSDATE, '월요일') FROM DUAL; -- 당일이 월요일이라면, 다음주 월요일 날짜 반환
SELECT SYSDATE, NEXT_DAY(SYSDATE, '일') FROM DUAL;  -- 다음 일요일 날짜 반환
SELECT SYSDATE, NEXT_DAY(SYSDATE, 1) FROM DUAL;  -- 1:일, 2:월, 3:화, 4:수, 5:목, 6:금, 7:토
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'SUNDAY') FROM DUAL; -- 영어는 언어를 변경해야 사용 가능
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'SUN') FROM DUAL;

-- 언어 변경
ALTER SESSION SET NLS_LANGUAGE = 'AMERICAN'; -- 영어로 언어 변경 (영어로 변경시 오류 및 문자 언어 인식을 영어로만 함)
ALTER SESSION SET NLS_LANGUAGE = 'KOREAN'; -- 한글로 언어 변경 (한글로로 변경시 오류 및 문자 언어 인식을 한글로만 함)


/*
    5) LAST_DAY : 날짜가 속한 해당 월의 마지막 날짜 반환
       LAST_DAY(DATE)
*/
SELECT LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY('20200201') FROM DUAL; -- 윤달도 계산 다 해줌. 아주 똑똑해

-- EMPLOYEE 테이블에서 직원명, 입사일, 입사월의 마지막 날짜, 급여일(매달 마지막 날)조회
SELECT EMP_NAME AS "직원명",
       HIRE_DATE AS "입사일",
       LAST_DAY(HIRE_DATE) AS "입사월의 마지막 날짜",
       LAST_DAY(SYSDATE) AS "급여일"
FROM EMPLOYEE;

/*
    6) EXTRACT : 주어진 날짜에서 년, 월, 일 정보를 추출하여 반환한다.
       EXTRACT(YEAR|MONTH|DAY FROM DATE)
       EXTRACT(년 정보 OR 월 정보 OR 일 정보 FROM 날짜) 반환을 원하는 년 또는 월 또는 일을 작성한다.
*/
SELECT EXTRACT(YEAR FROM SYSDATE) FROM DUAL; -- 년 정보
SELECT EXTRACT(MONTH FROM SYSDATE) FROM DUAL; -- 월 정보
SELECT EXTRACT(DAY FROM SYSDATE) FROM DUAL; -- 일 정보

-- EMPLOYEE 테이블에서 직원명, 입사년도, 입사월, 입사일 조회
SELECT EMP_NAME AS "직원명",
       EXTRACT(YEAR FROM HIRE_DATE) || '년' AS "입사년도",
       EXTRACT(MONTH FROM HIRE_DATE) || '월' AS "입사월",
       EXTRACT(DAY FROM HIRE_DATE) || '일' AS "입사일"
FROM EMPLOYEE
ORDER BY HIRE_DATE;


/*
    <형 변환 함수>
    -- 포맷 문자 검색 사이트
    -- https://docs.oracle.com/cd/B19306_01/server.102/b14200/sql_elements004.htm
    
     1) TO_CHAR : 문자 타입으로 변환해서 반환 => 포맷을 활용하여 데이터를 정리할 때 사용
        TO_CHAR(NUMBER|DATE[, FORMAT])
        (숫자타입데이터 OR 날짜타입데이터[,형태(포맷)])
*/
-- ※숫자 -> 문자
SELECT TO_CHAR(1234) FROM DUAL;
-- 6칸의 공간을 확보, 오른쪽 정렬, 빈칸 공백으로 채운다.(맨앞의 공백은 부호용(+,-)) => 9라는 숫자 1개가 포맷이라고 생각하면된다.
SELECT TO_CHAR(1234, '999999') FROM DUAL;
-- 포맷의 자리수가 안맞으면 ###으로 출력 됨.
SELECT TO_CHAR(1234, '99') FROM DUAL;
-- 6칸의 공간을 확보, 오른쪽 정렬, 빈칸 0으로 채운다.
SELECT TO_CHAR(1234, '000000') FROM DUAL;
-- 포맷의 자리수가 안맞으면 ###으로 출력 됨.
SELECT TO_CHAR(1234, '00') FROM DUAL;
-- 깔끔하게 3자리씩 나눠서 연봉 조회
SELECT TO_CHAR(2000000, '9,999,999') FROM DUAL; -- , => 자릿수를 구분하기 위한 포맷 문자
SELECT TO_CHAR(2000000, 'L9,999,999') FROM DUAL; -- L : 현재 설정된 나라(LOCAL)의 화폐 기호 붙여주는 포맷 문자 (￦2,000,000), 앞에 공백이 생김
SELECT TO_CHAR(2000000, 'FML9,999,999') FROM DUAL; -- FM : 앞에 붙은 공백을 제거하는 포맷 문자.
SELECT TO_CHAR(2000000, '$9,999,999') FROM DUAL; -- $ : 원하는 화폐 기호를 직접 표기한(지정) 포맷 문자
SELECT TO_CHAR(2000000, '9,999,999.000') FROM DUAL;  -- 소수점 표기하고 싶을때 혼용해서 사용도 함.

-- EMPLOYEE 테이블에서 직원명, 급여, 연봉 조회
SELECT EMP_NAME AS "직원명",
       TO_CHAR(SALARY, 'FML9,999,999') AS "급여",
       TO_CHAR(SALARY*12,'FML999,999,999') AS "연봉"
FROM EMPLOYEE
ORDER BY SALARY;

-- ※날짜 -> 문자
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE) FROM DUAL;
-- 이번 한번만 조회할 날짜의 포맷을 변경하고싶을때 날짜 -> 문자 포맷을 사용
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; -- AM(PM) => 오전/오후(아무거나 써도 상관없음), 시간(HH는 12시간 표기):분:초
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS') FROM DUAL; -- 24시간 형태로 시간 출력
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL; -- MON(MONTH):달, DY:월(요일), DAY:월요일(요일), YYYY:년도
SELECT TO_CHAR(SYSDATE, 'MONTH DAY, YYYY') FROM DUAL; -- 달 정보의 축약은 영어에서 뚜렷히 나타남.(예시: MON -> NOV, MONTH -> NOVEMBER)
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD(DAY)') FROM DUAL; -- 년-월-일(요일)

-- EMPLOYEE 테이블에서 직원명, 입사일(2023-05-25) 출력
SELECT EMP_NAME AS "직원명",
       TO_CHAR(HIRE_DATE,'YYYY-MM-DD(DAY)') AS "입사일",
       -- TO_CHAR(HIRE_DATE,'YYYY')||'년'|| TO_CHAR(HIRE_DATE,'MM')||'월'|| TO_CHAR(HIRE_DATE,'DD')||'일' AS "입사일"
       TO_CHAR(HIRE_DATE,'YYYY"년" MM"월" DD"일"(DY)') AS "입사일" -- 포맷 문자가 아닌 문자를 TO_CHAR안에 쓰고싶으면 " "을 사용하여 출력가능하다.
FROM EMPLOYEE
ORDER BY HIRE_DATE;

-- 연도에 대한 포맷 문자
SELECT TO_CHAR(SYSDATE,'YYYY') FROM DUAL; -- 2023, Y는 어떤 자리든(1~4) 가능하지만 보통 4자리나 2자리 사용
SELECT TO_CHAR(SYSDATE,'YY') FROM DUAL; -- 23
SELECT TO_CHAR(SYSDATE,'RRRR') FROM DUAL; -- 2023 , R로 사용할때는 4자리나 2자리만 가능
SELECT TO_CHAR(SYSDATE,'RR') FROM DUAL; -- 23
SELECT TO_CHAR(SYSDATE,'YEAR') FROM DUAL; -- TWENTY TWENTY-THREE (영어로 년도 표기)

-- 월에 대한 포맷 문자
SELECT TO_CHAR(SYSDATE,'MM') FROM DUAL; -- 11(현재의 달)
SELECT TO_CHAR(SYSDATE,'MON') FROM DUAL; -- 11월. 영어로 썼을때는 축약(NOV)
SELECT TO_CHAR(SYSDATE,'MONTH') FROM DUAL; -- 11월. 영어로 썼을때는 NOVEMBER
SELECT TO_CHAR(SYSDATE,'RM') FROM DUAL;  -- XI. 로마 기호로 월 숫자 표기.

-- 일에 대한 포맷 문자
SELECT TO_CHAR(SYSDATE,'D'), -- 요일의 숫자표기(1:일, 2:월, 3:화, 4:수, 5:목, 6:금, 7:토) -> 1주를 기준으로 며칠째
       TO_CHAR(SYSDATE,'DD'), -- 06(현재의 일) -> 1달을 기준으로 며칠째
       TO_CHAR(SYSDATE,'DDD') -- 1년을 기준으로 몇일이 지났는지 (총 365일까지 표기) -> 1년을 기준으로 며칠째
FROM DUAL;


/*
    2) TO_DATE : 주어진 데이터를 날짜 타입으로 변환해서 반환
       TO_DATE(NUMBER|CHARACTER[, FORMAT])
       TO_DATE(숫자 OR 문자[, 참고날짜타입포맷])
*/
-- ※ 숫자 -> 날짜
SELECT TO_DATE(20231106) FROM DUAL; -- 기본적으로 날짜 형태는 RR/DD/MM으로 지정되어있음.
SELECT TO_DATE(20231106124130) FROM DUAL;  -- 시,분,초까지 있는 포맷으로 변경해야 에러나지 않음
SELECT TO_DATE(20231106124130,'YYYYMMDD HH:MI:SS') FROM DUAL; -- 해당 적힌 포맷을 참고하여 프로그램 자체에 적용되어있는 날짜출력 포맷에 맞춰서 날짜 출력 (YYYYMMDDHHMISS 도 가능)
-- 날짜 출력 포맷 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS'; -- 년,월,일,시간,분,초 도 호출
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';  -- 기본 포맷

-- ※ 문자 -> 날짜
SELECT TO_DATE('20231106') FROM DUAL;
SELECT TO_DATE('20231106140630') FROM DUAL; -- 시,분,초까지 있는 포맷으로 변경해야 에러나지 않음
SELECT TO_DATE('20231106140630','YYYYMMDD HH24:MI:SS') FROM DUAL; -- 해당 적힌 포맷을 참고하여 프로그램 자체에 적용되어있는 날짜출력 포맷에 맞춰서 날짜 출력
-- 날짜 출력 포맷 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'; -- 년,월,일,시간(24시간),분,초 도 호출

-- YY와 RR
-- YY는 무조건 현재 세기를 반영한다.
-- RR은 50미만이면 현재 세기를 반영하고, 50이상이면 이전 세기를 반영한다.
SELECT TO_DATE('231106', 'YYMMDD') FROM DUAL; -- 2023/11/06
SELECT TO_DATE('991106', 'YYMMDD') FROM DUAL; -- 2099/11/06

SELECT TO_DATE('231106', 'RRMMDD') FROM DUAL; -- 2023/11/06
SELECT TO_DATE('991106', 'RRMMDD') FROM DUAL; -- 1999/11/16

-- EMPLOYEE 테이블에서 1998년 1월 1일 이후에 입사한 사원의 사번, 직원명, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
--WHERE HIRE_DATE > '19980101'   자동 형변환되어서 가능
--WHERE HIRE_DATE > TO_DATE('19980101','YYYYMMDD')
--WHERE HIRE_DATE > TO_DATE('19980101','RRRRMMDD')
--WHERE HIRE_DATE > TO_DATE('980101','YYMMDD') -- 20980101  잘못된 결과 !
WHERE HIRE_DATE > TO_DATE('980101','RRMMDD')
ORDER BY HIRE_DATE;
--프로그램 날짜 포맷은 최대한 건드리지않는 방향으로!(추천)


/*
    3) TO_NUMBER : 주어진 문자형 데이터를 숫자 타입으로 변환해서 반환한다.
       TO_NUMBER(CHARACTER[, FORMAT])
*/
SELECT TO_NUMBER('0123456789') FROM DUAL; -- 123456789
SELECT TO_NUMBER('6,000,000', '9,999,999') FROM DUAL; -- ,가 있을때는, 포맷형태를 표현해줘야 읽는게 가능하다. 9를 이용하여 포맷형태 구현.

-- 자동으로 숫자 타입으로 형 변환 뒤 연산처리를 한다.
SELECT '123' + '456' FROM DUAL;  -- +는 산술연산자로만 사용되어서 자동형변환이 되어 더한다.
SELECT '123' + '456A' FROM DUAL; -- 456A는 문자와 숫자가 섞여있어 자동형변환이 안되므로 에러.

--SELECT '10,000,000' - '500,000' FROM DUAL; -- ,로 인해 자동형변환 안되어서 에러.
SELECT TO_CHAR((TO_NUMBER('10,000,000','99,999,999') - TO_NUMBER('500,000','999,999')),'999,999,999')
FROM DUAL;

-- EMPLOYEE 테이블에서 사원번호가 210보다 큰 사원의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE EMP_ID > 210; -- 숫자로 적어도 문자로 자동형변환이 된다.(상황에 따라 자동형변환 가능)
--WHERE EMP_ID > '210';


/*
    <NULL 처리 함수>
      1) NVL : P1이 NULL일 경우 P2를 반환한다.
         NVL(P1, P2)
*/
-- EMPLOYEE 테이블에서 직원명, 보너스 조회
SELECT EMP_NAME AS "직원명",
       NVL(BONUS, 0) AS "보너스" -- 보너스가 NULL일때 0을 반환해라
FROM EMPLOYEE
ORDER BY "보너스";

-- EMPLOYEE 테이블에서 직원명, 부서코드를 조회 (단, 부서코드가 NULL이면 '부서없음' 출력)
SELECT EMP_NAME AS "직원명",
       NVL(DEPT_CODE, '부서없음') AS "부서코드"
FROM EMPLOYEE
ORDER BY "부서코드";  -- 문자 순서는 영어 다음 한글!


/*
    2) NVL2 : P1이 NULL이 아니면 P2, NULL이면 P3를 반환한다.
       NVL2(P1, P2, P3)
*/
-- EMPLOYEE 테이블에서 보너스를 0.1로 동결하여 직원명, 보너스율, 동결된 보너스, 보너스가 포함된 연봉
SELECT EMP_NAME AS "직원명",
       NVL(BONUS, 0) AS "보너스율",
       NVL2(BONUS, 0.1, 0) AS "동결된 보너스", -- BONUS가 NULL이 아니면 0.1을, NULL이면 0으로 반환
       TO_CHAR(((SALARY + (SALARY * NVL2(BONUS, 0.1, 0)))*12), 'FML999,999,999') AS "연봉"
FROM EMPLOYEE;


/*
    3) NULLIF : 주어진 두 개의 값이 동일하면 NULL, 동일하지 않으면 P1을 반환한다.
       NULLIF(P1,P2)
*/
SELECT NULLIF(123, 123) FROM DUAL; -- NULL
SELECT NULLIF(123, 456) FROM DUAL; -- 123

SELECT NULLIF(123, '123') FROM DUAL; -- 데이터 타입이 달라서 오류
SELECT NULLIF('123', '123') FROM DUAL; -- NULL
SELECT NULLIF('123', '456') FROM DUAL; -- 123


/*
    <선택 함수>
      1) DECODE : 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값을 반환한다
         DECODE(컬럼명 또는 값(계산식), 조건값 1, 결과값 1, 조건값 2, 결과값 2, ..., DEFAULT) <- DEFAULT: 모든 조건이 다 만족하지 않았을때 리턴할 기본 값
*/
-- EMPLOYEE 테이블에서 사번, 직원명, 주민번호 성별(남자, 여자) 조회
SELECT EMP_ID AS "사번",
       EMP_NAME AS "직원명",
       EMP_NO AS "주민번호",
       -- SUBSTR(EMP_NO,8,1)
       DECODE(SUBSTR(EMP_NO,8,1), 1, '남자', 2, '여자', 3, '남자', 4, '여자', '잘못된 주민번호 입니다.') AS "성별"
FROM EMPLOYEE
ORDER BY "성별";

-- EMPLOYEE 테이블에서 직원명, 직급 코드, 기존 급여, 인상된 급여 조회
-- 직급 코드가 J7인 사원은 급여를 10%인상
-- 직급 코드가 J6인 사원은 급여를 15%인상
-- 직급 코드가 J5인 사원은 급여를 20%인상
-- 그외의 직급의 사원은 급여를 5% 인상
SELECT EMP_NAME AS "직원명",
       JOB_CODE AS "직급 코드",
       TO_CHAR(SALARY,'FML999,999,999') AS "기존 급여",
       TO_CHAR(DECODE(JOB_CODE, 'J7', SALARY*1.1, 'J6', SALARY*1.15, 'J5', SALARY*1.2, SALARY*1.05),'FML999,999,999') AS "인상된 급여"
FROM EMPLOYEE
ORDER BY JOB_CODE;


/*
    2) CASE : 함수는 아니고 DECODE와 비슷한 조건을 쓰는 문장.
              비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값을 반환한다.(CASE와 END는 꼭 같이 쓸 것)
     CASE WHEN 조건 1 THEN 결과 1
          WHEN 조건 2 THEN 결과 2
          WHEN 조건 3 THEN 결과 3
          ...
          ELSE 결과
     END
*/
-- EMPLOYEE 테이블에서 사번, 직원명, 주민번호 성별(남자, 여자) 조회
SELECT EMP_ID AS "사번",
       EMP_NAME AS "직원명",
       EMP_NO AS "주민번호",
       CASE --WHEN SUBSTR(EMP_NO,8,1) = '1' THEN '남자'
            --WHEN SUBSTR(EMP_NO,8,1) = '2' THEN '여자'
            WHEN SUBSTR(EMP_NO,8,1) IN ('1','3') THEN '남자'
            WHEN SUBSTR(EMP_NO,8,1) IN ('2','4') THEN '여자'
            ELSE '잘못된 주민번호 입니다.'
       END AS "성별"
FROM EMPLOYEE
ORDER BY "성별";

-- EMPLOYEE 테이블에서 직원명, 급여, 급여 등급(S1~S4) 조회
-- SALARY 값이 500만원 초과일 경우 S1
-- SALARY 값이 500만원 이하 350만원 초과일 경우 S2
-- SALARY 값이 350만원 이하 200만원 초과일 경우 S3
-- 그 외에 경우 S4
SELECT EMP_NAME AS "직원명",
       TO_CHAR(SALARY,'999,999,999') AS "급여",
       CASE WHEN SALARY > 5000000 THEN 'S1'
            WHEN SALARY > 3500000 THEN 'S2' -- 조건이 위에서부터 내려오기때문에 이미 500만원 이하 조건이다.
            WHEN SALARY > 2000000 THEN 'S3'
            ELSE 'S4'
       END AS "급여 등급"
FROM EMPLOYEE
ORDER BY SALARY DESC;



/*
    <그룹 함수>
    그룹 함수는 하나 이상의 행을 그룹으로 묶어 연산하며 총합, 평균 등을 <<하나의 컬럼>>으로 반환하는 함수이다.
    모든 그룹 함수는 NULL 값을 자동으로 제외하고 값이 있는 것들만 계산을 한다.
    
     1) SUM : 컬럼 값들의 총합을 반환하는 함수
        SUM(NUMBER 타입의 컬럼)
*/
-- EMPLOYEE 테이블에서 전 사원의 총 급여의 합계를 조회
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 전 사원의 연봉의 합계를 조회
SELECT SUM(SALARY*12)
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 여자 사원의 급여의 합계를 조회
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN ('2','4');

-- EMPLOYEE 테이블에서 부서 코드가 'D5'인 사원들의 연봉의 합계를 조회
SELECT TO_CHAR(SUM(SALARY*12), 'FML999,999,999') AS "연봉 합계"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';