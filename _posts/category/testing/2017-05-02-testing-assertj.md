---
layout: post
title: "[Unit Test] AssertJ"
date: 2017-05-02 10:50:00
categories: "Testing"
tags: junit assertj
---

hamcrest에 대해 검색을 하다가 assertj라는 것을 알게 되어 좀 더 검색을 해보니 테스트 코드 작성에 좀 더 편리한 기능들을 제공하는 것 같았다.
그리고 다음과 같은 장점이 있다고 한다.
* 메소드 체이닝을 지원하여 깔끔한 테스트 코드 작성이 가능
* 다양한 메소드를 제공

## 의존 라이브러리 설정
`spring-boot-starter-test`의 경우 기본적으로 `2.6.0` 버전을 포함하고 있다.
만약, 별도로 설정해주어야 한다면…
* java8 이상인 경우
```
testCompile 'org.assertj:assertj-core:3.6.2'
```
* java7 인 경우
```
testCompile 'org.assertj:assertj-core:2.6.0'
```

## static import
assertj 관련 메소드를 static import 해주어야 한다.
```
import static org.assertj.core.api.Assertions.*;
```

## 테스트 코드 예시
기존에는 hamcrest를 이용하여 아래와 같이 작성되었던 코드를..
```java
  @Test
  public void testAdd() {
    BookInfo result = bookInfoRepository.save(bookInfo);
    assertThat(result, is(notNullValue()));
    assertThat(result, is(bookInfo));
  }
```

assertj를 이용하면 아래와 같이 작성하여 좀 더 코드를 보기 좋고 이해하기 쉽게 작성할 수 있는 것 같다.
```java
  @Test
  public void testAdd() {
    BookInfo result = bookInfoRepository.save(bookInfo);
    assertThat(result)
        .isNotNull()
        .isEqualTo(bookInfo);
  }
```

> 참고 링크  
> [AssertJ / Fluent assertions for java](http://joel-costigliola.github.io/assertj/index.html)  
> [AssertJ 소개 - Dale’s Blog](http://www.daleseo.com/java/assertj/)  