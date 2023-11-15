## JDBC(Java DataBase Connectivity)
### 1. JDBC(Java DataBase Connectivity)
* 자바에서 데이터베이스에 접근할 수 있게 해주는 표준 Programming API이다.
* 자바와 데이터베이스 연결 시 사용하는 DBMS에 알맞은 JDBC 드라이버를 사용해야 한다.
* JDBC 드라이버를 사용하면 DBMS의 종류 상관없이 동일한 방법으로 데이터베이스에 다양한 작업을 할 수 있다.
  ![image](https://github.com/Ismoon-Training/java/assets/26870393/a7f25421-d09d-47e8-b3f7-39f401194347)
### 2. JDBC 주요 객체
#### 2.1. DriverManager
* DriverManager 클래스는 JDBC 드라이버를 통하여 Connection을 만드는 역할을 한다.
* `Class.forName()` 메소드를 이용해서 JDBC 드라이버를 등록하면 드라이버 내부에 있는 클래스들을 동적으로 로드한다.
  ```java
  Class.forName("oracle.jdbc.driver.OracleDriver"); // 오라클
  Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); // MSSQL
  Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL
  ```
#### 2.2. Connection
* DriverManager 클래스를 통해 실제 데이터베이스와 연결된 Connection 객체를 얻을 수 있다.
* Connection 객체는 직접 생성이 불가능하고 `DriverManager.getConnection()` 메소드를 호출하여 Connection 객체를 얻어올 수 있다.
  ```java
  Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@127.0.0.1:1521:xe", "web", "web");
  ```
#### 2.3. Statement
* Connection 객체를 통해 데이터베이스에 SQL 구문을 전달하여 실행시키고 결과를 반환받는 역할을 하는 객체이다.
* Statement 객체는 직접 생성이 불가능하고 Connection 객체의 `createStatement()` 메소드를 호출하여 Statement 객체를 생성할 수 있다.
  ```java
  Statement stmt = connection.createStatement();
  ```
* SQL 구문의 종류에 따라 실행에 필요한 메소드가 달라진다.
  ```java
  // SELECT 쿼리 실행 (ResultSet 객체를 리턴한다.)
  ResultSet rs = stmt.executeQuery("SELECT * FROM EMPLOYEE");

  // INSERT, UPDATE, DELETE 쿼리 실행 (정수값을 리턴한다.)
  int result = stmt.executeUpdate("DELETE FROM EMPLOYEE")
  ```
#### 2.4. PreparedStatement
* SQL 구문을 미리 컴파일 하고 실행 시간 동안 인수 값을 위한 공간을 확보한다는 점에서 Statement와 다르다.
* PreparedStatement 객체는 직접 생성이 불가능하고 Connection 객체의 `prepareStatement()` 메소드를 호출하여 PreparedStatement 객체를 생성할 수 있다.
  ```java
  String query = "SELECT * FROM EMPLOYEE WHERE EMP_NO = ?";
  PreparedStatement pstmt = connection.prepareStatement(query);

  pstmt.setString(1, "201");

  ResultSet rs = pstmt.executeQuery();
  ```
#### 2.5. ResultSet
* ResultSet 객체는 SELECT 쿼리의 실행 결과에 의해 생성된 테이블(Result Set)을 담고 있으며 커서(cursor)로 조회된 행들의 데이터에 접근할 수 있다.
  ```java
  ResultSet rs = stmt.executeQuery("SELECT * FROM EMPLOYEE");

  while(rs.next()){
    System.out.println(rs.getString("EMP_NO") + ", " + rs.getString(2));
  }
  ```
