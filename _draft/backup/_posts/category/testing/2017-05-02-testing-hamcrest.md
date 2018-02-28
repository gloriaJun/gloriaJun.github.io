---
layout: post
comments: true
title: "[Unit Test] hamcrest"
date: 2017-05-02 11:50:00
categories: "Testing"
tags: junit hamcrest
---

Junit을 사용하여 테스트할 때 사용하는 외부 라이브러리.
해당 라이브러리를 이용하면 기대값과 실제 값 내용을 좀 더 구체적으로 알아낼 수 있다고 한다.

## dependency
* pom.xml
```xml
    <dependency>
      <groupId>org.hamcrest</groupId>
      <artifactId>hamcrest-all</artifactId>
      <version>1.3</version>
      <scope>test</scope>
    </dependency>
```

* gradle
```
testCompile "org.hamcrest:hamcrest-all:1.3"
```

## Usage
#### assertThat
`assertThat(T actual, Matcher<? super T> matcher)`의 형태로 기대 값과 실제 값을 비교할 수 있음.

assertThat 메소드의 경우 `org.junit.Assert.assertThat`에도 포함되어 있지만 junit5 부터는 미지원하고, hamcrest에 포함된 것으로 사용하도로 가이드 하고 있으므로 차후 junit5로 변경을 고려해서 hamcrest의 것으로 import하여 사용하는 것도 나쁘지 않을 것 같다.

예시)
```java
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;

import org.junit.Test;

public class BookInfoServiceTest {
  @Test
  public void testAdd() {
    assertThat(2, is(1+1));
  }
}
```

#### 기본 제공 matcher
`org.hamcrest.CoreMatchers`  메서드에 아래와 같은 기본 matcher를 제공

###### null check
```java
//hello static import, nullValue here
import static org.hamcrest.CoreMatchers.*;
import org.junit.Test;

//...
	@Test
	public void testApp()
    {
        //true, check null
        assertThat(null, is(nullValue()));

        //true, check not null
        assertThat("a", is(notNullValue()));
    }
```

> 참고 링크  
> [assertThat](http://sejong-wiki.appspot.com/assertThat)  
