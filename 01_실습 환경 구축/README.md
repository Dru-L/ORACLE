## 실습 환경 설정
### 1. 사용자 계정 생성
* SQL Developer에서 관리자 계정으로 DB에 접속한다.
* 01_사용자계정생성.sql 파일을 열어 관리자 계정으로 실행한다.
### 2. 실습 환경 스크립트 실행
* SQL Developer에서 생성한 사용자 계정으로 DB에 접속한다.
* 02_실습환경스크립트.sql 파일을 열어 사용자 계정으로 실행한다.
## 오라클 DBMS 기초
### 1. 관계형 데이터 베이스
* 관계형 데이터 베이스는 가장 대표적인 데이터베이스 시스템이다.
* 데이터를 테이블 형태로 저장하고 여러 테이블을 조합하여 비즈니스 관계를 도출하는 구조를 가진다.
* 데이터의 중복을 최소화할 수 있으며 사용하기 편리하고 데이터의 무결성, 트랜잭션 처리 등 데이터베이스 관리 시스템으로 뛰어난 성능을 보여준다. 
<br>![image](https://user-images.githubusercontent.com/26870393/164882413-ac47ccec-b7bc-44d3-a4ac-1f8a8684fbba.png)
#### 1.1. 테이블 구조
* 테이블(Table)은 행(Rows)과 열(Columns)로 구성되는 가장 기본적인 데이터베이스 객체이다.
#### 1.2. SQL(Structured Query Language)
* 관계형 데이터베이스에서 데이터를 조회하거나 조작하기 위해 사용하는 표준 검색 언어이다.
#### 1.3. SQL 분류
* DDL(Data Definition Language)은 데이터 정의어로 DBMS의 구조를 정의하거나 변경, 삭제하기 위해 사용하는 언어이다. (CREATE(생성), ALTER(수정), DROP(삭제))
* DML(Data Manipulation Language)은 데이터 조작어로 실제 데이터를 조작하기 위해 사용하는 언어이다. (INSERT(삽입), UPDATE(수정), DELETE(삭제), SELECT(조회))
* DQL(Data Query Language)은 데이터 질의어로 데이터를 조회(검색)하기 위해 사용하는 언어이다. (SELECT만 별도로 분류)
* DCL(Data Control Language)은 데이터 제어어로 DBMS에 대한 보안, 무결성, 복구 등 DBMS를 제어하기 위한 언어이다. (GRANT(권한 부여), REVOKE(권한 회수))
* TCL(Transaction Control Language)은 트랜젝션 제어하는 언어이다. (COMMIT(실행), ROLLBACK(취소))
### 2. 주요 데이터 타입
<table>
	<tr>
		<th>데이터 타입</th>
		<th>하위 데이터 타입</th>
		<th>설명</th>
	</tr>
	<tr>
		<td>NUMBER</td>
		<td></td>
		<td>숫자</td>
	</tr>
	<tr>
		<td rowspan="3">CHARACTER</td>
		<td>CHAR</td>
		<td>고정길이 문자(최대 2000바이트)</td>
	</tr>
	<tr>
		<td>VARCHAR2</td>
		<td>가변길이 문자(최대 4000바이트)</td>
	</tr>
	<tr>
		<td>LONG</td>
		<td>가변길이 문자(최대 2기가 바이트)</td>
	</tr>
	<tr>
		<td>DATE</td>
		<td></td>
		<td>날짜</td>
	</tr>
</table>

### 3. DUAL 테이블
* 오라클의 기본 테이블로 SYS 사용자가 소유하는 테이블이다.
* SYS 사용자가 소유하지만 모든 사용자가 사용 가능한 임시(DUMMY) 테이블이다.
* 사용자가 함수나 계산의 결과를 출력해 보고 싶을 때 사용하는 테이블이다.
  ```sql
  SELECT 1 + 2
  FROM DUAL;
  ```
