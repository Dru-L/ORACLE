# 오라클 수업자료
## 데이터베이스(Database) 개요
### 1. 자료(Data)
* 관찰하고 측정해서 얻은 값을 자료(Data)라 한다.   
``ex) 에베레스트의 높이 : 8849m``
### 2. 정보(Information)
* 자료(Data)를 목적에 맞게 가공하여 의미와 가치를 부여한 것이 정보이다.   
``ex) 에베레스트는 세계에서 가장 높은 산이다.``
### 3. 데이터베이스(Database)
* 한 조직에 필요한 정보들을 조직의 여러 시스템에서 사용할 수 있도록 데이터를 모으고 중복되는 데이터를 최소화하여 구조적으로 통합/저장해놓은 것이 데이터베이스이다.
#### 3.1. 데이터베이스의 정의
* 한 조직 내에서 공동으로 사용되는 데이터이다. (공용 데이터(Shared Data))
* 중복 최소화로 중복으로 인한 데이터 불일치 현상이 제거된 데이터이다. (통합 데이터(Integrated Data))
* 컴퓨터 저장 장치에 저장된 데이터이다. (저장 데이터(Stored Data))
* 조직의 목적을 위해 사용되는 데이터이다. (운영 데이터(Operational Data))
#### 3.2. 데이터베이스의 특징
* 사용자가 데이터 요청 시 실시간으로 결과 서비스한다. (실시간 접근성(Real Time Accessibility))
* 데이터 값은 시간에 따라 항상 바뀐다. (계속적인 변화(Continuous Change))
* 서로 다른 업무 또는 여러 사용자에게 동시 공유된다. (동시 공유(Concurrent Sharing))
* 사용자가 요구하는 데이터 내용으로 데이터를 찾는다. (내용에 의한 참조(Content Reference))
### 2. DBMS(DataBase Management System)
* 데이터베이스에서 데이터 추출, 조작, 정의, 제어 등을 할 수 있게 해주는 데이터베이스 전용 관리 프로그램이다.
#### 2.1. DBMS의 기능
* 데이터의 구조를 정의하고 데이터의 저장 공간을 정의하는 작업을 수행한다. (데이터 정의(Definition))
* 실제 데이터를 조작하는 작업을 수행한다. (데이터 조작(Manipulation))
* 사용자가 데이터를 조회하거나 추출하는 작업을 수행한다. (데이터 추출(Retrieval))
* 데이터베이스의 사용자를 생성하고, 모니터링하며 접근을 제어하는 작업을 수행한다. (데이터 제어(Control))
#### 2.1. DBMS 종류와 특징
||Access|SQL Server|Oracle|MySQL|MariaDB|SQLite|
|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|제조사|MS|MS|Oracle|Oracle|MariaDB 재단|리처드 힙(오픈소스)|
|운영체제|윈도우즈|윈도우즈|윈도우즈, 유닉스, 리눅스|윈도우즈, 유닉스, 리눅스|윈도우즈, 유닉스, 리눅스|안드로이드, IOS 등|
|용도|개인용|윈도우즈 기반 기업용|대용량 데이터베이스|소용량 데이터베이스|소용량 데이터베이스| 모바일 전용 데이터베이스|
## 실습 환경 구축
### 1. Oracle DBMS 설치
* Oracle DBMS의 종류
  * Oracle Database EE(Enterprise Edition)
  * Oracle Database SE(Standard Edition)
  * Oracle Database XE(Express Edition)
* 오라클 홈페이지에 접속한다.(https://www.oracle.com/kr/database/technologies/xe-downloads.html)
* Oracle Database 21c Express Edition을 다운로드한다.
* 다운로드된 압축 파일의 압축을 해제 후 setup.exe 파일을 실행하여 설치한다.
* 설치가 완료되면 "명령 프롬프트" 실행 후 아래의 명령어를 입력하여 정상적으로 설치되었는지 확인한다.
  ```
  > sqlplus / as sysdba
  SQL*Plus: Release 21.0.0.0.0 - Production on 토 10월 28 21:59:23 2023
  Version 21.3.0.0.0

  Copyright (c) 1982, 2021, Oracle.  All rights reserved.

  다음에 접속됨:
  Oracle Database 21c Express Edition Release 21.0.0.0.0 - Production
  Version 21.3.0.0.0

  SQL> show user
  USER은 "SYS"입니다
  ```
### 2. SQL Developer 설치
* Oracle 데이터베이스에서 SQL로 작업하기 위한 통합 개발 환경이다.
* 오라클 홈페이지(https://www.oracle.com/database/sqldeveloper/technologies/download/) 접속 후 SQL Developer를 다운로드한다.
* 다운로드된 압축 파일의 압축 해제 후 sqldeveloper.exe를 실행한다.
* 인코딩 설정
  * 도구 -> 환경 설정 -> Environment에서 인코딩을 UTF-8로 변경한다.
* 라인 번호 설정
  * 도구 -> 환경 설정 -> 코드 편집기 -> 행 여백에서 행 번호 표시를 선택한다.
* AUTO COMMIT(자동 커밋) 비활성
  * 도구 -> 환경 설정 -> 데이터베이스 -> 고급 -> 자동 커밋의 체크박스를 해제한다.
* 프린트 라인 지우기
  * 도구 -> 환경 설정 -> 코드 편집기 -> 표시에서 표시되는 오른쪽 여백 표시의 체크박스를 해제한다. 
* 자동 완성 대문자 표기
  * 도구 -> 환경 설정 -> 코드 편집기 -> 형식에서 식별자 대소문자, 키워드 대소문자를 UPPER로 변경한다.
