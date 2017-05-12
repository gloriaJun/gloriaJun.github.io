---
layout: post
title: "[JUnit] JUnit5 vs JUnit4"
date: 2017-03-21 18:30:00
categories: "Testing"
tags: junit junit5 java
---

![image](https://i1.wp.com/howtoprogram.xyz/wp-content/uploads/2016/08/JUnit-5-vs-JUnit-4.png?w=485)

## Architecture
### Junit 4
All in One
즉, junit 라이브러리만 정의해주면 됨.

예시)
```xml
<dependency>
  <groupId>junit</groupId>
  <artifactId>junit</artifactId>
  <version>4.10</version>
  <scope>test</scope>
</dependency>
```
<br/>
### Junit 5
3개의 모듈로 나누어져 있음.
*JUnit 5 = JUnit Platform + JUnit Jupiter + JUnit Vintage*

#### JUnit Platform
JVM 환경에서 테스트 프레임웍을 수행.
TestEngine API 가 정의되어있음.
*ex. @RunWith(JUnitPlatform.class)*
'mvn test'로 테스트 케이스를 수행하기 위해서는 라이브러리를 정의해주어야 한다.

예시)
```xml
<build>
  <plugins>
      <plugin>
          <artifactId>maven-compiler-plugin</artifactId>
          <version>3.6.1</version>
          <configuration>
              <source>1.8</source>
              <target>1.8</target>
          </configuration>
      </plugin>
      <plugin>
          <artifactId>maven-surefire-plugin</artifactId>
          <version>2.19.1</version>
          <dependencies>
              <dependency>
                  <groupId>org.junit.platform</groupId>
                  <artifactId>junit-platform-surefire-provider</artifactId>
                  <version>1.0.0-M3</version>
              </dependency>
          </dependencies>
      </plugin>
  </plugins>
</build>
```

#### JUnit Jupiter
'new asserts, new annotations, Java 8 Lambda Expressions, etc' 과 같은 JUnit5에 테스트를 작성하기 위해 추가된 확장 기능들이 포함되어 있음.
```xml
<dependency>
  <groupId>org.junit.jupiter</groupId>
  <artifactId>junit-jupiter-engine</artifactId>
  <version>5.0.0-M3</version>
  <scope>test</scope>
</dependency>
```

#### JUnit Vintage
JUnit3, JUnit4를 JUnit5 플랫폼에서 수행을 지원한다.
```xml
<dependency>
  <groupId>org.junit.vintage</groupId>
  <artifactId>junit-vintage-engine</artifactId>
  <version>4.12.0-M3</version>
  <scope>test</scope>
</dependency>
```

<br/><br/>
## Supported Java Versions
### Junit 4
Java 5 이상

### Junit 5
Java 8 이상

<br/><br/>
## Annotations
<table class="table table-bordered table-striped">
<thead>
<tr><th>JUnit 5</th><th>JUnit 4</th><th>Features</th></tr>
</thead>
<tbody>
<tr><td>@Test <br>(<em>별도 속성 정의 불가</em>)</td><td>@Test</td><td>테스트 메소드 정의</td></tr>
<tr><td>@BeforeAll</td><td>@BeforeClass</td><td>클래스에 포함된 모든 테스트가 수행하기 전에 실행</td></tr>
<tr><td>@AfterAll</td><td>@AfterClass</td><td>클래스에 포함된 모든 테스트가 수행한 후에 실행</td></tr>
<tr><td>@BeforeEach</td><td>@Before</td><td>클래스에 포함된 각각의 테스트가 수행하기 전에 실행</td></tr>
<tr><td>@AfterEach</td><td>@After</td><td>클래스에 포함된 각각의 테스트가 수행한 후에 실행</td></tr>
<tr><td>@Disable</td><td>@Ignore</td><td>테스트 클래스 또는 메소드 distable 처리</td></tr>
<tr><td>@TestFactory</td><td>N/A</td><td>dynamic test를 위한 테스트 factory 메소드</td></tr>
<tr><td>@Nested</td><td>N/A</td><td>클래스 안의 클래스를 선언</td></tr>
<tr><td>@Tag</td><td>@Category</td><td>테스트 필터링</td></tr>
<tr><td>@ExtendWith</td><td>N/A</td><td>custom extension 등록</td></tr>
</tbody>
</table>

<br/><br/>
## Assertions
달라진 부분만 언급하면..
<table class="table table-bordered table-striped">
<thead>
<tr><th>JUnit 5</th><th>JUnit 4</th></tr>
</thead>
<tbody>
<tr><td>N/A</td><td>assertThat</td></tr>
<tr><td>assertAll</td><td>N/A</td></tr>
<tr><td>assertThrows</td><td>N/A</td></tr>
</tbody>
</table>

#### assertion의 message parametr의 위치가 달라짐.
JUnit4의 경우 첫 번째 파라미터로 전달을 받았으나,
JUnit5에서는 마지막 파라미터로 전달을 받는다.
```java
// junit 4
assertEquals("meesage parameter", "expected value", "actual value");

// junit 5
assertEquals("expected value", "actual value", "meesage parameter");
```
<br/>
#### java8의 lamda를 사용할 수 있음.
```java
assertTrue(1 == 1, () -> "Assertion messages can be provided by Java 8 Lambdas ");

Throwable exception = expectThrows(IllegalArgumentException.class, () -> {
          throw new IllegalArgumentException("Invalid age.");
      });
```

<br/><br/>
## Assumptions
* JUnit 에서 지원하던 아래의 메소드들이 deprecated
  * assumeNoException
  * assumeNotNull
* lamda 사용가능
```java
assumeTrue("QA".equals(System.getenv("ENV")),
            () -> "Should run on QA environment");
```

