---
layout: post
comments: true
title: "[펌글] Top 20 JUnit Testcase Best Practices"
date: 2017-04-24 14:50:00
categories: "Testing"
tags: junit
---

[Top 20 JUnit Testcase Best Practices - HowToDoInJava](http://howtodoinjava.com/best-practices/unit-testing-best-practices-junit-reference-guide/)을 바탕으로 기억해둘 부분들을 정리한 내용

프로그래밍에 있어서, Unit Testing은 각각의 소스 코드 조각들을  사용하기에 적합한지 결정하기 위해 테스트 하기 위한 방법이다.

## Unit testing is not about finding bugs
단위 테스트의 동기를 이해하는 것이 중요하다.
단위 테스트는 버그를 찾거나 regression 단계에서 추적하기 위한 효과적인 방법이 아니다. 단위 테스트를 정의하면 *코드의 각 단위를 검사하는 것*이다.
만약, 당신이 버그를 찾고자 시도한다면, 매뉴얼 테스트와 마찬가지로 제품의 운영되는 것과 비슷한 환경에서 전체 어플리케이션을 실제 운영하는 것이  효과적이다. 이러한 종류의 테스트를 미래에 발생할 때를 대비하여 발견하기 위해 자동화 한다면, 통합테스트 라고 부르고 일반적으로 단위테스트와는 다른 기술을 사용한다.
기본적으로 단위 테스트는 TDD와 같은 프로세스 설계의 부분으로 생각하면 된다.

## Tips for writing great unit tests
#### Test only one code unit at a time (수행 시점에 하나의 코드 단위만 테스트 하라)
코드의 단위를 테스트를 시도하려고 할 때, 하나의 단위는 여러 개의 유스 케이스를 가질 수 있다. 분리된 테스트 케이스에서 각각의 유스 케이스를 테스트 하여야 한다.<br/>
![]({{ site.url }}/assets/images/post/testing/2017/0424-junit-tc-best-practices/unit-test.png)


#### Don’t make unnecessary assertions (불필요한 assertion을 만들지 마라)
단위 테스트는 코드가 발생하는 모든 상황에 대하여 관찰한 리스트가 아니라 특정 동작이 어떻게 작동해야하는 지 설계된 디자인이다.

#### Make each test independent to all the others (다른 테스트로부터 독립적인 테스트로 만들어라)
테스트 케이스 간의 연결 고리를 만들지 말아라. 그것은 테스트 케이스 실패의 의 근본 원인을 확인하기 어렵게 하고, 코드를 디버깅하게 된다. 또한 하나의 테스트 케이스가 변경이 발생하면, 불필요하게 다른 테스트 케이스도 변경을 해야한다.
테스트 케이스에서 사전에 요구되는 작업은 @Before, @After 메소드를 사용해라.  @Before, @After 에서 각기 다른 테스트 케이스에 여러가지 작업이 필요하다면, 새로운 테스트 클래스를 만드는 것을 고려해라.

#### Mock out all external services and state (외부 서비스와 상태로부터 분리하여 mock을 사용하라는 뜻 같음)
외부 서비스나 상태에 의해 테스트가 영향을 미칠 수 있다. 특정 순서로 테스트를 수행해야 한다던가, 데이터베이스나 네트워크가 활성화가 되어야 수행이 가능한다던가..
또한 외부 시스템의 오류로 인하여 테스트케이스가 실패할 수도 있으므로 이 부분은 중요하다.

#### Don’t unit-test configuration settings (단위 테스트 config 설정을 하지 마라)
configuration 설정은 어떠한 코드 단위의 부분이 아니다.
당신의 환경을 검사하기 위한 단위 테스트를 작성해야한다면, 정상적으로 로딩이 되는 지 검사하기 위한 한개 또는 두개의 테스트 케이스로 작성하면 된다.

#### Name your unit tests clearly and consistently (단위 테스트의 이름을 명확하고 일관적으로 지어라)
기억하고, 지켜야 하는 중요한 포인트이다. 테스트케이스의 이름을 실제로 무엇을 하고 테스트 하는 지에 대해 지어야한다.
테스트 케이스 이름에 클래스명이나 메소드명을 사용하는 것은 좋지 않다. 메소드나 클래스 명이 변경되면 많은 테스트케이스도 업데이트가 되어야 한다. 

E.g. Test case names should be like:
1) TestCreateEmployee_NullId_ShouldThrowException
2) TestCreateEmployee_NegativeId_ShouldThrowException
3) TestCreateEmployee_DuplicateId_ShouldThrowException
4) TestCreateEmployee_ValidId_ShouldPass

#### Write tests for methods that have the fewest dependencies first, and work your way up (의존성이 가장 적은 메소드에 대한 테스트를 작성하고 작업해라)
예를 들어, Employee 모듈에 대해 테스트를 한다면, Employee를 생성하는 모듈부터 테스트 해라. 그 다음에는 일부 직원이 데이터베이스에 있어야하는 수정 부분을 작업한다.

#### All methods, regardless of visibility, should have appropriate unit tests (모든 메소드는, 가시성에 따라 적절한 단위 테스트를 가져야한다)

#### Aim for each unit test method to perform exactly one assertion
하나의 테스트 케이스에서 여러 개의 assertion을 테스트 하지 말아라. 

#### Create unit tests that target exceptions
어플리케이션으로부터 던져지는 exception에 대해서 테스트 케이스를 작성해라.

#### Use the most appropriate assertion methods
여러 개의 assert method가 존재하는 데, 가장 적절한 것을 사용해라.

#### Put assertion parameters in the proper order
assert 메소드는 두 개의 파라미터를 받는데, 첫번 째는 기대 값, 두번째는 검사하려는 값이다. 올바른 위치에 놓아라.

#### Ensure that test code is separated from production code
빌드 스크립트에서 실제 소스 코드와 함께 배포가 되면 안되게 보장되어야 한다. 

#### Do not print anything out in unit tests
테스트 케이스에서 print 구문을 사용할 필요가 없다.

#### Do not use static members in a test class. If you have used then re-initialize for each test case

#### Do not write your own catch blocks that exist only to fail a test
예외를 try-catch하지 말고, 테스트 케이스 선언 자체에 Exception 문을 사용해라.

#### Do not rely on indirect testing
특정 테스트 케이스가 다른 시나리오를 테스트한다고 가정하지 마라.
대신 각 시나리오에 대해 다른 테스트 케이스를 작성하십시오.

#### Integrate Testcases with build script
테스트 케이스를 빌드 스크립트와 통합하여 자동으로 실행되도록 하면, 제품의 안정성을 향상 시킬 수 있다.

#### Do not skip unit tests
일부 테스트 케이스가 유효하지 않을 경우, @Ignore 또는  svn.test.skip 옵션을 사용하지 말고 제거해라.

#### Capture results using the XML formatter



