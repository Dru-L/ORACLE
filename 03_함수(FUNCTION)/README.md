## 함수(Function)
### 1. 함수
* 함수는 하나의 프로그램에서 반복적으로 사용되는 부분들을 분리하여 작성해 놓은 작은 서브프로그램이다.
* 함수는 호출하여 사용하고 호출하면서 값을 전달하고 결과를 리턴 받을 수도 있다.
* 함수는 SELECT, WHERE, ORDER BY, GROUP BY, HAVING 절에 기술할 수 있다.
* 단일 행 함수는 각 행마다 반복적으로 적용되어
입력받은 행의 개수만큼 결과 반환하는 함수이다.
* 그룹 함수는 특정 행들의 집합으로 그룹이 형성되어 적용된다. 각 그룹 당 1개의 결과 반환하는 함수이다.
### 2. 단일 행 함수 
#### 2.1. 문자 처리 함수
|리턴 타입|함수|설명|
|:--:|:--:|:--:|
|NUMBER|LENGTH(CHARACTER)|주어진 문자열의 길이(문자 개수)를 반환한다.|
|NUMBER|LENGTHB(CHARACTER)|주어진 문자열의 길이(BYTE)를 반환한다.|
|NUMBER|INSTR(CHARACTER, STR, [POSITION,[OCCURRENCE]])|지정한 위치부터 지정한 숫자 번째로 나타나는 문자의 시작 위치를 반환한다.|
|CHARACTER|LPAD(CHARACTER, N, [STR])|주어진 문자열에 임의의 문자열을 왼쪽에 덧붙여 N 길이의 문자열을 반환하다.|
|CHARACTER|RPAD(CHARACTER, N, [STR])|주어진 문자열에 임의의 문자열을 오른쪽에 덧붙여 N 길이의 문자열을 반환하다.|
|CHARACTER|LTRIM(CHARACTER, STR) |주어진 문자열의 왼쪽에서 지정한 문자를 제거한 나머지를 반환한다.|
|CHARACTER|RTRIM(CHARACTER, STR) |주어진 문자열의 오른쪽에서 지정한 문자를 제거한 나머지를 반환한다.|
|CHARACTER|TRIM([LEADING\|TRAILING\|BOTH] [CHARACTER] FROM STR)|주어진 문자열의 양쪽에 있는 지정한 문자를 제거한 나머지를 반환한다.|
|CHARACTER|SUBSTR(CHARACTER, POSITION, [LENGTH])|주어진 문자열에서 지정한 위치부터 지정한 개수의 문자열을 잘라내어 반환한다.|
|CHARACTER|LOWER(CHARACTER)|주어진 문자열을 소문자로 변환하여 반환한다.|
|CHARACTER|UPPER(CHARACTER)|주어진 문자열을 대문자로 변환하여 반환한다.|
|CHARACTER|INITCAP(CHARACTER)|주어진 문자열을 첫 글자만 대문자로 변환하여 반환한다.|
|CHARACTER|CONCAT(CHARACTER, CHARACTER)|주어진 문자열 두 개를 하나로 합친 후 반환한다.|
|CHARACTER|REPLACE(CHARACTER, STR1, STR2)|주어진 문자열에서 특정 문자(열)을 지정한 문자(열)로 바꾼 후 반환한다.|
#### 2.2. 숫자 처리 함수
|리턴 타입|함수|설명|
|:--:|:--:|:--:|
|NUMBER|ABS(NUMBER)|주어진 숫자의 절대값을 반환한다.|
|NUMBER|MOD(NUMBER, DIVISION)|주어진 숫자를 나누어 나머지를 반환한다.|
|NUMBER|ROUND(NUMBER, [POSITION])|주어진 숫자에서 지정한 위치부터 반올림하여 값을 반환한다.|
|NUMBER|CEIL(NUMBER)|주어진 숫자를 올림하여 반환한다.|
|NUMBER|FLOOR(NUMBER)|주어진 숫자를 버림하여 반환한다.|
|NUMBER|TRUNC(NUMBER, [POSITION])|주어진 숫자에서 지정한 위치부터 버림하여 값을 반환한다.|
#### 2.3. 날짜 처리 함수
|리턴 타입|함수|설명|
|:--:|:--:|:--:|
|DATE|SYSDATE|시스템에 저장되어 있는 현재 날짜를 반환한다.|
|NUMBER|MONTHS_BETWEEN(DATE1, DATE2)|주어진 날짜 데이터 두 개의 개월 수 차이를 반환한다.|
|DATE|ADD_MONTHS(DATE, NUMBER)|주어진 날짜에 지정된 개월 수를 더하여 날짜 데이터를 반환한다.|
|DATE|NEXT_DAY(DATE, CHARACTER\|NUMBER)|주어진 날짜에 인자로 받은 요일이 가장 가까운 날짜를 반환한다.|
|DATE|LAST_DAY(DATE)|주어진 날짜가 속한 달의 마지막 날짜를 반환한다.|
|NUMBER|EXTRACT(YEAR\|MONTH\|DAY FROM DATE)|주어진 날짜에서 년, 월, 일 정보를 추출하여 반환한다.|
#### 2.4. 형 변환 함수
![image](https://user-images.githubusercontent.com/26870393/164882457-2dd3d0d1-d4ef-48c8-a5ce-74a419c79a91.png)

|리턴 타입|함수|설명|
|:--:|:--:|:--:|
|CHARACTER|TO_CHAR(DATE\|NUMBER, [FORMAT])|주어진 날짜 또는 숫자형 데이터를 문자 타입으로 변환해서 반환한다.|
|DATE|TO_DATE(NUMBER\|CHARACTER, [FORMAT])|주어진 숫자 또는 문자형 데이터를 날짜 타입으로 변환해서 반환한다.|
|NUMBER|TO_NUMBER(CHARACTER, [FORMAT])|주어진 문자형 데이터를 숫자 타입으로 변환해서 반환한다.|
#### 2.5. NULL 처리 함수
|리턴 타입|함수|설명|
|:--:|:--:|:--:|
|NUMBER\|CHARACTER|NVL(P1, P2)|P1이 NULL일 경우 P2를 반환한다.|
|NUMBER\|CHARACTER|NVL2(P1, P2, P3)|P1이 NULL이 아니면 P2, NULL이면 P3를 반환한다.|
|NUMBER\|CHARACTER|NULLIF(P1, P2)|주어진 두 개의 값이 동일하면 NULL, 동일하지 않으면 P1을 반환한다.|
#### 2.6. 선택 함수
* DECODE 함수는 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값을 반환한다.
  ```sql
  DECODE(컬럼 또는 값(계산식), 조건 1, 결과 1, 조건 2, 결과 2, ..., DEFAULT)
  ```
* CASE 문은 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값을 반환한다.
  ```sql
  CASE WHEN 조건 1 THEN 결과 1
       WHEN 조건 2 THEN 결과 2
       WHEN 조건 3 THEN 결과 3
       ...
       ELSE 결과
  END
  ```
### 3. 그룹 함수
* 그룹 함수는 하나 이상의 행을 그룹으로 묶어 연산하며 총합, 평균 등을 하나의 컬럼으로 반환하는 함수이다.
* 모든 그룹 함수는 NULL 값을 자동으로 제외하고 값이 있는 것들만 계산을 한다.
#### 3.1. SUM 함수
* 컬럼 값들의 총합을 반환하는 함수이다.
  ```sql
  SELECT SUM(SALARY)
  FROM EMPLOYEE;
  ```
#### 3.2. AVG 함수
* 컬럼 값들의 평균을 반환하는 함수이다.
  ```sql
  -- NULL 값을 가진 행은 평균 계산에서 제외되지 않도록 NVL 함수를 사용한다.
  SELECT AVG(NVL(BONUS, 0))
  FROM EMPLOYEE;
  ```
#### 3.3. MAX 함수
* 컬럼 값들 중에 가장 큰 값을 반환하는 함수이다.
  ```sql
  SELECT MAX(BONUS)
  FROM EMPLOYEE;
  ```
#### 3.4. MIN 함수
* 컬럼 값들 중에 가장 작은 값을 반환하는 함수이다.
  ```sql
  SELECT MIN(BONUS)
  FROM EMPLOYEE;
  ```
#### 3.5. COUNT 함수
* 조회된 행의 개수를 반환하는 함수이다.
  ```sql
  -- COUNT(*)은 조회 결과에 해당하는 모든 행 개수를 반환한다.
  SELECT COUNT(*)
  FROM EMPLOYEE;

  -- COUNT(컬럼명)은 제시한 컬럼 값이 NULL이 아닌 행의 개수를 반환한다.
  SELECT COUNT(DEPT_CODE)
  FROM EMPLOYEE;

  -- COUNT(DISTINCT 컬럼명)은 해당 컬럼 값의 중복을 제거한 행의 개수를 반환한다.
  SELECT COUNT(DISTINCT DEPT_CODE)
  FROM EMPLOYEE;
  ```
