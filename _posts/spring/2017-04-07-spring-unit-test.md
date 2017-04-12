---
layout: post
title: "[Spring Boot] unit test"
date: 2017-04-07 19:00:00
categories: Spring
tags: spring spring-boot unit-test
---

controller와 service에 대한 단위 테스트.

### Dependency 정의
pom.xml에 unit test를 위한 dependency를 추가한다.
{% gist /gloriaJun/4461cc6873214b32542d5bf44a9924a6 pom.xml %}

### Controller 테스트 클래스 생성
controller 테스트를 위한 클래스를 생성한 뒤에, MockMVC 객체를 생성하는 코드를 작성한다.
{% gist /gloriaJun/4461cc6873214b32542d5bf44a9924a6 ToDoControllerTest.java %}

> **MockMVC ??**<br/>
> 실제 was에서 spring MVC가 요청에 응답하는 부분에 대해서 테스트를 할 수 있게 지원해줌.
> <br/><br/>
> **@WebAppConfiguration** <br/>
> WebApplicationContext를 생성할 수 있도록 해줌.


##### get 요청에 대한 테스트 메소드 작성
`@GetMapping("/") public List<ToDo> getAllToDo()`에 대한 테스트 메소드를 작성한다.
{% gist /gloriaJun/4461cc6873214b32542d5bf44a9924a6 ToDoControllerTest-testgetAllToDo.java %}

정상적으로 테스트가 수행이 되면 아래와 같은 로그가 출력이 된다.
```
MockHttpServletRequest:
      HTTP Method = GET
      Request URI = /
       Parameters = {}
          Headers = {Accept=[application/json;charset=UTF-8]}

Handler:
             Type = com.study.controller.ToDoController
           Method = public java.util.List<com.study.model.ToDo> com.study.controller.ToDoController.getAllToDo()

Async:
    Async started = false
     Async result = null

Resolved Exception:
             Type = null

ModelAndView:
        View name = null
             View = null
            Model = null

FlashMap:
       Attributes = null

MockHttpServletResponse:
           Status = 200
    Error message = null
          Headers = {Content-Type=[application/json;charset=UTF-8]}
     Content type = application/json;charset=UTF-8
             Body = [{"id":1,"text":"clean up the room","completed":false},{"id":2,"text":"study math","completed":true}]
    Forwarded URL = null
   Redirected URL = null
          Cookies = []
```

##### 에러처리에 대한 테스트 메소드를 작성.
{% gist /gloriaJun/4461cc6873214b32542d5bf44a9924a6 ToDoControllerTest-error.java %}

### Service 테스트 클래스 생성
Mockito를 이용하여 service에 대한 테스트 클래스를 작성한다. 
{% gist /gloriaJun/4461cc6873214b32542d5bf44a9924a6 ToDoServiceTest.java %}


> **참고 링크**<br/>
>  [Auto-configured Spring REST Docs tests](https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-testing.html#boot-features-testing-spring-boot-applications-testing-autoconfigured-rest-docs)<br/>
> [Spring Boot + RESTful + JUnit + Mockito + Hamcrest + EclEmma](https://medium.com/@gustavo.ponce.ch/spring-boot-restful-junit-mockito-hamcrest-eclemma-5add7f725d4e)
