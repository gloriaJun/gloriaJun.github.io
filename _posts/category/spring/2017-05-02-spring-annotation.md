---
layout: post
title: "[Spring Boot] annotation 정리"
date: 2017-05-02 18:50:00
categories: Spring
tags: spring spring-boot annotation
---

Spring Boot에서 사용되는 annotation 정리

### @SpringBootApplication
Application 클래스임을 정의해주는 annotation.
다른 클래스들의 루트 패키지에 위치하는 것을 권장함.

아래 3가지의 annotation을 묶어놓은 것. (v 1.2.0 이전에는 아래의 annotation을 정의해주어야 했다는 듯..)
* @Configuration 
이 어노테이션은 스프링의 자바 기반 구성 클래스를 지정한다. Spring Boot는 Java-based 설정을 선호한다. 따라서 필요한 클래스에 @Configuration 을 추가하여 설정 클래스를 가져올 수 있다. 
* @EnableAutoConfiguration 
이 어노테이션은 Spring Boot에서 기본 beans 들을 classpath 설정이나 다른 beans, 여러가지 property 등 어플리케이션에 추가된 jar와 관련된 설정을 자동으로 설정한다.  또한 EnableAutoConfiguration은  main class가 위치해있는 root package를  기본 package로 정의한다. 예를 들면, 만약 JPA 애플리케이션을 작성하는 경우에, @EnableAutoConfiguration 애노테이션이 위치한 클래스의 패키지는 @Entity 항목을 검색하는데 사용된다.
* @ComponentScan 
컴포넌트 검색 기능을 활성화 한다. 이 어노테이션도 특별한 basePackage 속성을 지정하지 않고도 main class가 위치해있는 root package를 기본 속성으로 사용하여 자동으로 다른 컴포넌트 클래스들을 검색하여 빈으로 등록한다.

### @RestController
@Controller와 @ResponseBody를 합쳐놓은 동작을 수행.

### @Entity
JPA (Java Persistence API)에서 데이터베이스에 저장하기 위해 사용자가 정의한 클래스.

