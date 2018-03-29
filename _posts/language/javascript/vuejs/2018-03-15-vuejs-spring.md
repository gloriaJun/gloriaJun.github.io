---
layout: post
title: "(VueJS) springboot 연동"
date: 2018-03-15 13:35:00
author: gloria
categories: language
tags: javascript vuejs springboot
---

## Spring Boot 설정
`pom.xml`에 thymeleaf 모듈을 추가한다
```xml
		<!-- template engine library for view -->
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-thymeleaf</artifactId>
		</dependency>
		<dependency>
			<groupId>net.sourceforge.nekohtml</groupId>
			<artifactId>nekohtml</artifactId>
		</dependency>
```

thymeleaf의 경우 html5 모드가 기본으로 설정되어 있어 아래의 설정을 추가해주어야 meta tag로 인한 에러가 발생하지 않는다.   
그리고 추가로 frontend 빌드 산출물에 대한 경로를 설정해준다
```
// src/main/resources/application.properties
spring.thymeleaf.mode=LEGACYHTML5
spring.thymeleaf.prefix=classpath:/templates/
spring.resources.static-locations=classpath:/templates/
```

url로 전달된 요청을 처리하기 위한 `RouteController`를 생성한다
```java
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
public class RouteController {

    @RequestMapping("/")
    public String index() {
        return "index";
    }

    @RequestMapping(value = "/{path:[^\\.]*}")
    public String redirect() {
        return "forward:/";
    }
}
```

## vuejs 설정
webpack 빌드 시에 생성되는 산출물이 생성될 경로를 설정해준다.
```javascript
// config/index.js
build: {
    // Template for index.html
    index: path.resolve(__dirname, '../../resources/templates/index.html'),

    // Paths
    assetsRoot: path.resolve(__dirname, '../../resources/templates/'),
    // (...중략...)
  }
```

## Reference
- [Spring Boot + Vue.js 연동하기](http://itstory.tk/entry/Spring-Boot-Vuejs-%EC%97%B0%EB%8F%99%ED%95%98%EA%B8%B0)  
- [Apache + Tomcat , SPA](https://medium.com/@circlee7/apache-tomcat-spa-59e3d58ced6f)
