---
layout: post
title: "[Spring Boot] exception handler 정의하기"
date: 2017-04-07 17:00:00
categories: Spring
tags: spring spring-boot exception
---

앞에서 multi module로 생성한 프로젝트 [Spring Boot multi module project on Maven](https://gloriajun.github.io/spring/2017/04/06/spring-multi-module-maven.html)에  exception handler를 추가하기.


### Exception 처리를 위한 클래스 생성
Exception 처리를 위해 3개의 클래스를 생성하였음.
* ErrorResponse
* ToDoException
* RestExceptionHandler

##### ErrorResponse 객체 정의
에러 코드와 메시지를 담을 객체를 정의한다.
```java
package com.study.exception;

public class ErrorResponse {
    private int errorCode;
    private String message;

    public int getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(int errorCode) {
        this.errorCode = errorCode;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
```

##### ToDoException 정의
Exception 을 상속받아서 사용자 Exception을 정의한다.
```java
package com.study.exception;

public class ToDoException extends Exception {
    private String errMsg;

    public String getErrMsg() {
        return errMsg;
    }

    public ToDoException() {
        super();
    }

    public ToDoException(String errMsg) {
        super(errMsg);
        this.errMsg = errMsg;
    }
}
```

##### RestExceptionHandler 정의
특정 Exception 발생 시, 처리할 내용을 정의한 메소드를 담은 클래스를 정의한다.
```java
package com.study.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class RestExceptionHandler {

    @ExceptionHandler(ToDoException.class)
    public ResponseEntity<ErrorResponse> exceptionToDoHandler(Exception ex) {
        ErrorResponse err = new ErrorResponse();
        err.setErrorCode(HttpStatus.NOT_FOUND.value());
        err.setMessage(ex.getMessage());
        return new ResponseEntity<ErrorResponse>(err, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> exceptionHandler(Exception ex) {
        ErrorResponse err = new ErrorResponse();
        err.setErrorCode(HttpStatus.BAD_REQUEST.value());
        err.setMessage("bad request");
        return new ResponseEntity<ErrorResponse>(err, HttpStatus.BAD_REQUEST);
    }
}
```

* @ControllerAdvice
스프링3.2 이상에서 사용가능.
해당 클래스가 Exception 처리에 대한 것이라고 스프링에게 알려줌.
* @ExceptionHandler
어떠한 에러를 처리할 것인지 정의한 Exception이 발생하면 해당 메소드에 정의한 내용이 동작한다.

### Controller에서 에러 처리 추가
controller에 id 조회에 대한 메소드를 추가하고, 조회한 데이타가 없는 경우에 에러를 발생시키는 로직을 추가한다.
```java
    @GetMapping("/{id}")
    public ToDo getToDobyId(@PathVariable("id")long id) throws ToDoException {
        logger.info("get toDo Info : {}", id);
        ToDo toDo = service.getById(id);
        if (toDo == null) {
            throw new ToDoException("ToDo not exsit !!");
        }
        return toDo;
    }
```

### 테스트
postman을 이용해서 존재하지 않는 id를 전달하거나, mapping 되지 않은 request를 전달하면 정상적으로 동작하는 것을 확인할 수 있음.

* 존재하지 않은 id 를 조회하는 경우<br/>
![](https://github.com/gloriaJun/gloriaJun.github.io/blob/master/_images/2017-04-07-spring-exception-notfound.png?raw=true)

* 존재하지 않는 request 전달 시<br/>
![](https://github.com/gloriaJun/gloriaJun.github.io/blob/master/_images/2017-04-07-spring-exception-badrequest.png?raw=true)


> **관련된 글들**
> [1. 멀티 모듈의 프로젝트 생성하기](https://gloriajun.github.io/spring/2017/04/06/spring-multi-module-maven.html)
>  




