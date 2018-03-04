---
layout: post
comments: true
title: "[JUnit] JUnit5 Annotation @Tag"
date: 2017-03-30 19:50:00
categories: "Testing"
tags: junit junit5 java
---

@Tag annotation에 대해서 잘 이해가 되지 않아서 구글링해서 관련된 내용이랑 junit5 doc을 참고해서 정리해보았다.

* JUnit4의 category 와 유사한 기능.
* 각 테스트 클래스 또는 메소드를 카테고리별로 나누어서 수행할 테스트를 그룹핑?? 할 수 있음.

## @Cateogry for JUnit4
JUnit4의 Category 에 대해 간략히 정리하면..
*org.junit.experimental.categories* 에 포함되어 있음.

1. 카테고리화 할 것들을 interface 함수로 정의한다.
    ```java
    public interface Category01Test {}
    public interface Category02Test {}
    ```

2. 테스트 메소드를 작성하고, 메소드에 대한 카테고리를 지정한다.
    ```java
    public class UnitTest {
        @Category(Category02Test.class)
        @Test
        public void aLivingCellShouldPrintAsAPlus() {
            System.out.println("category - Category02Test");
        }

        @Category(Category01Test.class)
        @Test
        public void thePlusSymbolShouldProduceALivingCell() {
            System.out.println("category - Category01Test");
        }

        // 일반 테스트 메소드
        @Test
        public void theMinusSymbolShouldProduceADeadCell() {
            System.out.println("no category. general method");
        }
    }
    ```
    만약, 클래스에 포함된 전체 메소드에 동일한 카테고리를 지정하려면 클래스에 지정해도 된다.

3. 테스트 suite에 해당하는 클래스를 작성한다.
    *@IncludeCategory* : 속성에 정의된 카테고리에 해당하는 테스트 메소드 또는 클래스에 대해서 실행한다.
    *@ExcludeCategory* : 속성에 정의된 카테고리는 제외하고 실행한다.
    *@SuiteClasses* : TestSuite로 지정할 클래스명들을 명시한다.

    * 특정 카테고리에 대해서만 실행하기 
        ```java
        @RunWith(Categories.class)
        @Categories.IncludeCategory(Category02Test.class)
        @Suite.SuiteClasses( { UnitTest.class})
        public class TestSuite {
        }
        ```
        
        *실행 결과*
        ```
        Running com.study.junit4.category.TestSuite
        category - Category02Test
        Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.033 sec
        ```

    
    * 특정 카테고리를 제외하고 실행
        ```java
        @RunWith(Categories.class)
        @Categories.ExcludeCategory(Category02Test.class)
        @Suite.SuiteClasses( { UnitTest.class})
        public class TestSuite {
        }
        ```
        
        *실행 결과*
        ```
        Running com.study.junit4.category.TestSuite
        category - Category01Test
        no category. general method
        Tests run: 2, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.035 sec
        ```
