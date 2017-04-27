---
layout: post
title: "[Spring Boot] swagger2 연동하기"
date: 2017-04-11 20:00:00
categories: Spring
tags: spring spring-boot gradle swagger
---

### Swagger ?
REST API 리스트를 HTML 파일로 생성해주는 라이브러리

### Dependency 추가
`build.gradle` 파일에 정의해준다.
{% gist /gloriaJun/f0975061cc8997a06f3b533127a4f5ad build.gradle %}

### Swagger를 설정하는 Bean을 등록한다.
`@EnableSwagger2` annotation을 통하여 설정이 되어진다.
{% gist /gloriaJun/f0975061cc8997a06f3b533127a4f5ad ToDoApplication.java  %}

### Swagger Doc 확인
`http://localhost:8080/v2/api-docs`로 접속하면 확인할 수 있다.
만약, `v2/api-docs`를 변경하고 싶으면..
resources/swagger.properties를 생성한 뒤 아래와 같이 작성하고
```
springfox.documentation.swagger.v2.path=/api-docs
```

swagger를 정의한(?) 클래스에서 아래의 annotation을 추가해주면 된다. (해당 예제의 경우 ToDoApplication.java)
```
@PropertySource("classpath:swagger.properties")
```

### Swagger UI로 확인
`http://localhost:8080/swagger-ui.html`에 접속하면 아래와 같은 화면을 확인할 수 있다.
![]({{ site.url }}/assets/images/spring/2017/0412-swagger-setting/swagger-ui.png)

> 참고 사이트  
> [Setting Up Swagger 2 with a Spring REST API | Baeldung](http://www.baeldung.com/swagger-2-documentation-for-spring-rest-api)  