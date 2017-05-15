---
layout: post
title: "[Spring Boot] Spring Boot Test"
date: 2017-05-14 16:10:00
categories: Spring
tags: spring spring-boot unit-test
---

spring doc에 작성된 내용을 기반으로 정리.
(정리하다가 당장 중요하지 않다고 판단된 부분은 skip 하여서 모든 내용이 다 정리된게 아님)

## Working with random ports
[41. Testing](https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-testing.html)
https://docs.spring.io/spring-boot/docs/current/reference/html/howto-embedded-servlet-containers.html#howto-discover-the-http-port-at-runtime

https://spring.io/guides/gs/spring-boot/

## Test scope dependencies
gradle 기준으로 아래의 라이브러리를 정의해주면 된다.
```
dependencies {
	compile ('org.springframework.boot:spring-boot-starter-web')
	testCompile ('org.springframework.boot:spring-boot-starter-test')
}
```

`spring-boot-starter-test`에는 아래와 같은 라이브러리들이 포함되어있다.
* JUnit
The de-facto standard for unit testing Java applications.
* Spring Test & Spring Boot Test
Utilities and integration test support for Spring Boot applications.
* AssertJ
A fluent assertion library.
* Hamcrest
A library of matcher objects (also known as constraints or predicates).
* Mockito
A Java mocking framework.
* JSONassert
An assertion library for JSON.
* JsonPath
XPath for JSON.

## Usage
#### annotation
기본적으로 아래의 annotation을 추가해주어야함.
* @RunWith(SpringRunner.class) 
JUnit 테스트에 사용할 컨텍스트를 로드하고, 테스트 클래스에 자동으로 주입하는 역활을 수행하는 어노테이션
* @SpringBootTest
SpringApplication을 테스트할 수 있도록 ApplicationContext를 생성해준다? 
(해당 annotation을 사용함으로써 bean객체들을 주입하여 사용할 수 있고, 실제 application이 동작하는 것처럼 request를 날리고 response를 받는 동작을 하는 것 같음.)


#### TestRestTemplate
실제 웹서버에 REST 방식으로 API 를 호출하는 클래스
url을 이용하여 반환값을 확인할 수 있음.

예시)
url “/“으로 매핑된 메소드에서 아래와 같은 값을 전달할 때..
```java
    @RequestMapping("/")
    public String index() {
        return "Hello Spring !!";
    }
```

다음과 같이 작성하여 해당 url로부터의 반환값을 확인할 수 있다.
```java
package com.study;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.embedded.LocalServerPort;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.test.context.junit4.SpringRunner;

import static org.assertj.core.api.Assertions.assertThat;

@RunWith(SpringRunner.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class RandomPortExampleTests {

    @Autowired
    private TestRestTemplate restTemplate;

    @LocalServerPort
    private int port;

    @Test
    public void testIndex() {
        System.out.println("port number : " + port);
        String body = this.restTemplate.getForObject("/", String.class);
        assertThat(body).isEqualTo("Hello Spring !!");
    }

    @Test
    public void testIndex2() {
        ResponseEntity<String> responseEntity = this.restTemplate.getForEntity("/", String.class);
        assertThat(responseEntity.getStatusCodeValue()).isEqualTo(200);
    }
}
```

## Auto-configured Spring REST Docs tests
https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-testing.html#boot-features-testing-spring-boot-applications-testing-autoconfigured-rest-docs





