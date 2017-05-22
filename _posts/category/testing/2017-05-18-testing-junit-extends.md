---
layout: post
comments: true
title: "[JUnit] 테스트 클래스 상속 시에 대한 내용 정리"
date: 2017-05-18 18:24:00
categories: "Testing"
tags: junit extends
---

각 테스트 클래스마다 반복해되는 부분에 대해서 중복코드 없이 재사용을 하고 싶었다.<br/>
공통으로 사용되는 부분에 대해서 유틸리티 클래스를 생성하려고 하다가,  모든 테스트 클래스에 대한 부모 클래스를 생성하고 상속으로 해결하기 위해서 부모와 자식 클래스에 “static method”, “생성자”, “beforeclass” … 등을 생성해서 실행되는 순서와 차이점을 확인해보았다. 

### BeforeClass vs Constructor
@BeforeClass와 생성자의 동작 방식을 먼저 확인해보았다.<br/>
@BeforeClass의 경우에는 부모, 자식 상관없이 최초 테스트 클래스 실행 시점에 **한 번만** 수행이 된다.<br/>
하지만 static method, constructor의 경우에는 @Before와 마찬가지로 **테스트 메소드 실행 시점마다** @Before 메소드가 수행되기 전에 수행이 된다.<br/>
메소드를 생성해서 테스트를 실행해보면 아래와 같은 순서로 동작된다.
```
Parent : BeforeClass
Child : BeforeClass

Parent : static method
Parent : constructor method
Child : static method
Child : constructor method
Parent : Before
Child : Before
Child : test01
Child : After
Parent : After

Parent : static method
Parent : constructor method
Child : static method
Child : constructor method
Parent : Before
Child : Before
Child : test02
Child : After
Parent : After

Child : AfterClass
Parent : AfterClass
```

참고로 작성한 테스트 코드는 아래와 같음
```java
public class ParentTest {

  static {
    System.out.println("Parent : static method");
  }

  public ParentTest() {
    System.out.println("Parent : constructor method");
  }

  @BeforeClass
  public static void parentInit() {
    System.out.println("Parent : BeforeClass");
  }

  @AfterClass
  public static void parentDispose() {
    System.out.println("Parent : AfterClass");
  }

  @Before
  public void parentBefore() {
    System.out.println("Parent : Before");
  }

  @After
  public void parentAfter() {
    System.out.println("Parent : After");
  }
}

public class SampleTest extends ParentTest {

  static {
    System.out.println("Child : static method");
  }

  public SampleTest() {
    System.out.println("Child : constructor method");

  }

  @BeforeClass
  public static void init() {
    System.out.println("Child : BeforeClass");
  }

  @AfterClass
  public static void dispose() {
    System.out.println("Child : AfterClass");
  }

  @Before
  public void setUp() {
    System.out.println("Child : Before");
  }

  @After
  public void tearDown() {
    System.out.println("Child : After");
  }

  @Test
  public void test01() {
    System.out.println("Child : test01");
  }

  @Test
  public void test02() {
    System.out.println("Child : test02");
  }
}
```

### 유의할 점
부모와 자식의 클래스에서 @BeforeClass, @AfterClass, @Before, @After의 메소드명은 동일하게 정의하면 자식 클래스에서 (당연하겠지만?) override 한 것으로 판단하고 부모클래스의 메소드가 호출이 되지 않는다.<br/>
그러므로 반드시 메소드명을 다르게 정의하여 주어야 한다.