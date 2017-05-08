---
layout: post
title: "[Spring Boot] trouble shooting"
date: 2017-05-08 18:50:00
categories: Spring
tags: spring spring-boot
---

## java.lang.IllegalStateException: Unable to find a @SpringBootConfiguration, you need to use @ContextConfiguration or @SpringBootTest(classes=...) with your test
repository, service, web을 각각의 모듈로 하여 멀티모듈로 프로젝트를 구성한 경우에 repository에 대한 단위 테스트를 작성하여 수행하는 경우에 발생
예시 프로젝트)
[Spring Boot multi module project on Gradle](https://gloriajun.github.io/spring/2017/04/11/spring-multi-module-gradle.html)
[Spring Boot multi module project on Maven](https://gloriajun.github.io/spring/2017/04/06/spring-multi-module-maven.html)

###### 원인
spring context를 불러오는 포인트가 repository 를 생성하는 모듈에는 존재하지 않기 때문임.

###### 해결방법
테스트를 위해서 spring context를 로딩하기 위한 클래스를 생성해준다.
```java
package study;

import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class CommonApplicationTest {
  public void contextLoads() {}
}
```
