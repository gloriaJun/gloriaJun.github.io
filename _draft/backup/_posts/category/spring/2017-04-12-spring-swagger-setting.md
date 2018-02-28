---
layout: post
comments: true
title: "[Spring Boot] swagger2 설정하기"
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

<<<<<<< HEAD
swagger를 설정하는 부분은 application과 동일한 패키지에 위치해야 하지 않으면 controller를 읽어들이지를 못한다.
만약, 다른 곳에 위치하는 경우에는 configuration(?) 설정을 별도로 해주어야한다고 함. (_해당 부분은 나중에 별도로 확인해보기_)

###### 읽어들일 패키지 정의 
아래의 부분을 통하여 RequestMapping으로 정의된 부분을 어디서 읽어올지를 설정한다.
```java
.apis(RequestHandlerSelectors.any())
.paths(PathSelectors.any())
```
`any()`라고 정의하면 모든 url을 읽어들이고..
특정 패키지를 읽어들이고 싶으면 `RequestHandlerSelectors.basePackage(패키지명)`과 같이..
그리고 특정 url 패턴은 `PathSelectors.ant("/todo/*")`와 같이 정의할 수 있다.
(_그리고 정규식 패턴으로도 정의할 수 있는 듯함_)
=======
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
![]({{ site.url }}/assets/images/post/2017/0412-swagger-ui.png)

> 참고 사이트  
> [Setting Up Swagger 2 with a Spring REST API | Baeldung](http://www.baeldung.com/swagger-2-documentation-for-spring-rest-api)  
<<<<<<< HEAD
> [Springfox Reference Documentation](https://springfox.github.io/springfox/docs/current/#introduction)
> [Springfox Reference Documentation](http://springfox.github.io/springfox/docs/current/#springfox-samples)
