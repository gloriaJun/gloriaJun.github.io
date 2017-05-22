
---
layout: post
comments: true
title: "[Spring Boot] yaml 파일을 이용해서 환경 설정 하기"
date: 2017-05-04 16:25:00
categories: Spring
tags: spring spring-boot yaml
---

환경 설정 파일을 yaml을 이용하여 환경에 따른 각기 다른 설정 값을 읽어들이도록 하기

## yaml
[YAML](http://yaml.org)은 JSON의 superset 형태로, 계층 구조로 설정이 가능하고 매우 편리한 포맷 형태라고 함. 그리고 SpringApplication 클래스는 자동으로 yaml 을 지원한다고 한다.

## application.yml
`src/main/resources/application.yml` 파일에 환경 설정 관련된 내용들을 작성한다.
`---`으로 각 섹션을 구분한다.
```
spring:
  profiles:
	  # active로 설정된 profile이 활성화되어 해당 설정 값들을 읽어들임
    active: dev

# log level
logging.level.org.springframework: INFO

---
spring:
  profiles: dev
  application:
    name: booktree-service-dev
  # jpa
  h2.console.enabled : true
  jpa:
    show-sql: true

---
spring:
  profiles: test
  application:
    name: booktree-service-test
  # jpa
  h2.console.enabled : false
  jpa:
    show-sql: false
```

그리고 참고로 아래와 같이 파일을 분리하여 사용할 수 있음.
application.yml
application-dev.yml
application-test.yml

위와 같이 사용하는 경우에는 `application.yml`에 로딩할 파일의 구분자(?)를 아래와 같이 설정해주어야함.
```
spring.profiles.active: dev
```

#### 로그 메시지에서 활성화된 profile 확인 
application을 기동해보면 로그 메시지에서 아래와 같이 활성화된 profile 확인도 가능하다.
```
2017-05-04 14:27:34.365  INFO 24012 --- [           main] study.booktree.reading.DemoApplication   : The following profiles are active: dev
```



> 참고 링크  
> [스프링 부트(Spring boot)에서 profile, yml 사용하기](http://www.donnert.net/79)  
> [24. Externalized Configuration](https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-external-config.html)  

