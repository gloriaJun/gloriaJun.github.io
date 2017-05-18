---
layout: post
title: "[JUnit] JUnit5 Annotation 정리"
date: 2017-03-30 18:50:00
categories: "Testing"
tags: junit junit5 java
---

JUnit5에서 사용되는 Annotation 정리.

##### @Test
테스트 메소드임을 명시한다. JUnit4의 @Test와는 달리 어떠한 속성도 명시하지 않는다.
```java
// junit4 의 경우 필요 시, @Test annotation에 추가적인 속성 명시 가능 ex. @Test(timeout=100)
@Test
void addTest() {
    assertEquals(2, 1 + 1);
}
```

##### @TestFactory
dynamic test를 위한 메소드 임을 명시한다.

##### @DisplayName
테스크 클래스 또는 메소드의 물리적 이름 대신에 해당 annotation에 사용자가 별도로 정의한 이름을 테스트 케이스명으로 사용한다.

* 기존에는 아래와 같은 형태로만 표현이 되었음.
![]({{ site.url }}/assets/images/post/testing/2017/0330-junit5-annotation/DisplayName-nouse.png)


* DisplayName annotation을 사용해서 논리적 이름을 명시한다.
  ```java
  @DisplayName("테스트 클래스")
  public class CalculatorTest {

      @Test
      @DisplayName("더하기")
      void addTest() {
          assertEquals(2, 1 + 1);
      }
  }
  ```
  테스트 수행을 하면, 아래 이미지와 같이 해당 annotation에 명시한 이름이 표현된다.<br/>
![]({{ site.url }}/assets/images/post/testing/2017/0330-junit5-annotation/DisplayName-use.png)

##### @BeforeEach
해당 클래스의 각각의 @Test 메소드 실행 전에 수행된다.
JUnit4의 @Before

##### @AfterEach
해당 클래스의 각각의 @Test 메소드 실행 후에 수행된다.
JUnit4의 @After

##### @BeforeAll
static 메서드. 해당 클래스의 모든 @Test 메소드 실행 전에 수행된다.
JUnit4의 @BeforeClass

##### @AfterAll
static 메서드. 해당 클래스의 모든 @Test 메소드 실행 후에 수행된다.
JUnit4의 @AfterClass

##### @Nested
하나의 테스트 클래스 안에 non-static 테스트 클래스를 포함하여 작성하는 경우에 표시한다.
@BeforeAll, @AfterAll을 @Nested가 표현된 클래스에서는 사용할 수 없다.

아래와 같이 작성된 테스트 케이스에 대해서...
```java
@Test
void addTest() {
    assertEquals(2, 1 + 1);
}

@Test
void addTest2() {
    assertEquals(2, 2 + 1);
}

@Nested
class nestedClass {
    @Test
    void minusTest() {
        assertEquals(1, 2 - 1);
    }

    @Test
    void minusTest2() {
        assertEquals(15, 15 - 1);
    }
}
```
실행한 결과는 아래와 같다.<br/>
![]({{ site.url }}/assets/images/post/testing/2017/0330-junit5-annotation/nested.png)

##### @Tag
메소드 또는 클래스 레벨에서 테스트 필터링을 위해 선언한다.
TestNG의 groups, JUnit4의 Categories와 유사하다.

##### @Disabled
테스크 클래스 또는 메소드를 disable 하기 위해 사용한다.
JUnit4의 @Ignore

##### @ExtendWith
Used to register custom [extensions](http://junit.org/junit5/docs/current/user-guide/#extensions)
