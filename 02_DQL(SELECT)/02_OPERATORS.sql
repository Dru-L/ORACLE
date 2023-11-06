/*
    <연결 연산자>
        여러 컬럼 값들을 하나의 컬럼인 것처럼 연결하거나,
        컬럼과 리터럴을 연결할 수 있는 연산자 이다.
*/
-- EMPLOYEE 테이블에서 사번, 직원명, 급여를 연결해서 조회
SELECT EMP_ID || EMP_NAME || SALARY AS "사번 직원명 급여"
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원명, 급여를 리터럴과 연결해서 조회
SELECT EMP_NAME || '의 월급은 ' || SALARY || '원 입니다.' AS "급여 정보"
FROM EMPLOYEE;

/*
    <논리 연산자>
*/
-- EMPLOYEE 테이블에서 부서 코드가 D6이면서 급여가 300만원 이상인 직원들의 사번, 직원명, 부서 코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY >= 3000000;

-- EMPLOYEE 테이블에서 부서 코드가 D5이거나 급여가 500만원 이상인 직원들의 사번, 직원명, 부서 코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY >= 5000000;

-- EMPLOYEE 테이블에서 부서 코드가 D6이 아니고 급여가 200만원 미만인 직원들의 사번, 직원명, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE != 'D6' AND NOT SALARY >= 2000000
ORDER BY EMP_ID DESC;

-- EMPLOYEE 테이블에서 급여가 350만원 이상 600만원 이하를 받는 직원의 사번, 직원명, 부서코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000
-- WHERE SALARY < 3500000  OR SALARY > 6000000;
-- WHERE SALARY >= 3500000  AND SALARY <= 6000000;
ORDER BY DEPT_CODE, SALARY;


/*
    <BETWEEN AND>
*/
-- EMPLOYEE 테이블에서 급여가 350만원 이상 600만원 이하를 받는 직원의 사번, 직원명, 부서코드, 급여조회 (BETWEEN AND 연산자 사용)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000
ORDER BY SALARY;

-- EMPLOYEE 테이블에서 급여가 350만원 이상 600만원 이하가 아닌 직원의 사번, 직원명, 부서코드, 급여조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--NOT 연산자는 컬럼명 앞 또는 BETWEERN 앞에 사용 가능
-- WHERE SALARY NOT BETWEEN 3500000 AND 6000000
WHERE NOT SALARY BETWEEN 3500000 AND 6000000
ORDER BY SALARY;

-- EMPLOYEE 테이블에서 입사일이 '90/01/01' ~ '01/01/01' 인 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE 
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01'
ORDER BY HIRE_DATE;

-- EMPLOYEE 테이블에서 입사일이 '90/01/01' ~ '01/01/01'이 아닌 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
-- WHERE HIRE_DATE NOT BETWEEN '90/01/01' AND '01/01/01'
WHERE NOT HIRE_DATE BETWEEN '90/01/01' AND '01/01/01'
ORDER BY HIRE_DATE;


/*
    <LIKE>
        [표현법]
            WHERE 컬럼 LIKE '패턴'
            
            -비교하려는 컬럼의 값이 지정된 패턴을 만족할 경우 검색 대상이 된다.
            -패턴에는 '%', '_'를 와일드 카드로 사용할 수 있다.
            '%' : 0글자 이상
                EX) 컬럼 LIKE  '문자%' => 컬럼 값 중에 '문자'로 시작하는 모든 행을 조회한다.
                    컬럼 LIKE  '%문자' => 컬럼 값 중에 '문자'로 끝나는 모든 행을 조회한다.
                    컬럼 LIKE  '%문자%' => 컬럼 값 중에 '문자'가 포홤되어있는 모든 행을 조회한다.
            '_' : 1글자
                EX) 컬럼 LIKE '_문자' => 컬럼 값 중에 '문자'앞에 무조건 한 글자가 오는 모든 행을 조회한다.
                    컬럼 LIKE '__문자' => 컬럽 값 중에 '문자'앞에 무조건 두 글자가 오는 모든 행을 조회한다.
*/

-- EMPLOYEE 테이블에서 성이 전 씨인 사원의 직원명, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- EMPLOYEE 테이블에서 성이 김씨 성이 아닌 사원의 사번, 직원명, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
--WHERE NOT EMP_NAME LIKE '김%';
WHERE EMP_NAME NOT LIKE '김%'
--WHERE NOT EMP_NAME NOT LIKE '김%' : 부정의 부정이 되어 '김%'을 찾는다.
ORDER BY EMP_NAME;

-- EMPLOYEE 테이블에서 이름 중에 '하'가 포함된 사원의 직원명, 주민번호, 부서코드 조회
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- EMPLOYEE 테이블에서 전화번호 4번째 자리가 9로 시작하는 사원의 사번, 직원명, 전화번호, 이메일 조회
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '___9%'
ORDER BY EMP_NAME;

-- EMPLOYEE 테이블에서 이메일 중 _ 앞 글자가 3자리인 이메일 주소를 가진 사원의 사번, 직원명, 이메일 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___\_%' ESCAPE '\'; -- '\'이 특수문자는 어떤 특수문자던 상관없음.
--WHERE EMAIL LIKE '___$_%' ESCAPE '$';
--WHERE EMAIL LIKE '___#_%' ESCAPE '#';

-- EMPLOYEE 테이블에서 이름이 '연'으로 끝나는 사원의 직원명, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연'
ORDER BY EMP_ID;

-- EMPLOYEE 테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 사원의 직원명, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

-- DEPARTMENT 테이블에서 해외영업부에 대한 모든 컬럼 조회
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '해외영업%';

/*
    <IS NULL>
        컬럼 값에 NULL이 있을 경우 NULL 값 비교에 사용된다.
        비교 연산자 사용 불가
        IS NULL, IS NOT NULL
*/
-- EMPLOYEE 테이블에서 보너스를 받지 않는 사원의 사번, 직원명, 급여, 보너스를 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
-- WHERE BONUS = NULL;  -- NULL은 비교 연산자로 비교할 수 없다. 오류.
WHERE BONUS IS NULL;

-- EMPLOYEE 테이블에서 관리자가 없는 사원의 직원명, 부서 코드 조회
SELECT EMP_NAME, DEPT_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

-- EMPLOYEE 테이블에서 관리자도 없고, 부서도 배치 받지 않은 사원의 직원명, 부서 코드, 관리자 사번 조회
SELECT EMP_NAME, DEPT_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- EMPLOYEE 테이블에서 부서를 배치 받진 않았지만 보너스를 받는 사원의 직원명, 부서 코드, 보너스 조회
SELECT EMP_NAME, DEPT_CODE, BONUS
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;


/*
    <IN>
        비교하려는 값과 일치하는 값이 목록에 있는지 확인하는 연산자이다.
        DEPT_CODE IN ('D6', 'D8'); => DEPT_CODE = 'D6' OR DEPT_CODE = 'D8'
*/

-- EMPLOYEE 테이블에서 부서 코드가 'D5', 'D6', 'D8'인 사원들의 직원명, 부서 코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
-- WHERE DEPT_CODE = 'D5' OR DEPT_CODE = 'D6' OR DEPT_CODE = 'D8'
WHERE DEPT_CODE IN ('D5', 'D6', 'D8')
ORDER BY DEPT_CODE;


/*
    <연산자 우선순위>
    1.	산술 연산자
    2.	연결 연산자
    3.	비교 연산자
    4.	IS NULL, LIKE, IN
    5.	BETWEEN AND
    6.	NOT(논리 연산자)
    7.	AND(논리 연산자)
    8.	OR(논리 연산자)
*/
-- EMPLOYEE 테이블에서 직급 코드가 'J4' 또는 'J7' 사원들 중 급여가 200만원 이상인 사원들의 직원명, 직급 코드, 급여 조회
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
-- OR 보다 AND 먼저 실행된다.
WHERE (JOB_CODE = 'J4' OR JOB_CODE = 'J7') AND SALARY >= 2000000
ORDER BY JOB_CODE, SALARY;