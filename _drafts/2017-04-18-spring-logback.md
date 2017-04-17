---
layout: post
title: "[Spring Boot] logback"
date: 2017-04-18 02:00:00
categories: Spring
tags: spring spring-boot logback
---

spring boot 환경에서 logback 설정하기

### dependency 
아래의 의존관계를 추가해준다.
```
dependencies {
        compile("ch.qos.logback:logback-classic:1.1.6")
        compile("ch.qos.logback:logback-core:1.1.6")
    }
```

### 로그파일 설정하기
스프링부트에서는 logback-spring.xml을 설정하길 권장한다. logback.xml로 설정하면 스프링부트가 설정하기 전에 로그백 관련한 설정을 하기 때문에 제어할 수가 없게 된다고함.

