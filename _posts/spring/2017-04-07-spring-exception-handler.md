---
layout: post
title: "[Spring Boot] exception handler 정의하기"
date: 2017-04-07 17:00:00
categories: Spring
tags: spring spring-boot exception
---

앞에서 multi module로 생성한 프로젝트 [Spring Boot multi module project on Maven]({% post_url /spring/2017-04-06-spring-multi-module-maven %})에  exception handler를 추가하기.



### Exception 처리를 위한 클래스 생성
Exception 처리를 위해 3개의 클래스를 생성하였음.
* ErrorResponse
* ToDoException
* RestExceptionHandler

##### ErrorResponse 객체 정의
에러 코드와 메시지를 담을 객체를 정의한다.
{% gist /gloriaJun/a42c12e4ded0754cd8e672752b164ca8 ErrorResponse.java %}

##### ToDoException 정의
Exception 을 상속받아서 사용자 Exception을 정의한다.
{% gist /gloriaJun/a42c12e4ded0754cd8e672752b164ca8 ToDoException.java %}

##### RestExceptionHandler 정의
특정 Exception 발생 시, 처리할 내용을 정의한 메소드를 담은 클래스를 정의한다.
{% gist /gloriaJun/a42c12e4ded0754cd8e672752b164ca8 RestExceptionHandler.java %}

* @ControllerAdvice
스프링3.2 이상에서 사용가능.
해당 클래스가 Exception 처리에 대한 것이라고 스프링에게 알려줌.
* @ExceptionHandler
어떠한 에러를 처리할 것인지 정의한 Exception이 발생하면 해당 메소드에 정의한 내용이 동작한다.

### Controller에서 에러 처리 추가
controller에 id 조회에 대한 메소드를 추가하고, 조회한 데이타가 없는 경우에 에러를 발생시키는 로직을 추가한다.
{% gist /gloriaJun/a42c12e4ded0754cd8e672752b164ca8 ToDoController.java %}

### 테스트
postman을 이용해서 존재하지 않는 id를 전달하거나, mapping 되지 않은 request를 전달하면 정상적으로 동작하는 것을 확인할 수 있음.

* 존재하지 않은 id 를 조회하는 경우<br/>
![]({{ site.url }}/assets/images/spring/2017/0407-spring-exception-handler/notfound.png)

* 존재하지 않는 request 전달 시<br/>
![]({{ site.url }}/assets/images/spring/2017/0407-spring-exception-handler/badrequest.png)


> **관련된 글들**
> [1. 멀티 모듈의 프로젝트 생성하기]({% post_url /spring/2017-04-06-spring-multi-module-maven %})
>  [2. unit test]({% post_url /spring/2017-04-07-spring-unit-test %})




