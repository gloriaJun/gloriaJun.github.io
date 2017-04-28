---
layout: post
title: "[Rest Assured] PetStore를 이용하여 사용해보기"
date: 2017-03-23 15:30:00
categories: "Testing"
tags: junit junit5 java restAssured Rest-API
---
 
Swagger 사이트에서 테스트용으로 제공되는 [Swagger Petstore](http://petstore.swagger.io/#￼/)를 이용하여 Rest-Assured 실습해보기.

> **테스트 환경**  
> IntelliJ  
> Java 8  
> JUnit 5  

## pom.xml 의존 라이브러리 추가
pom.xml 파일에 
```xml
<dependency>
    <groupId>io.rest-assured</groupId>
    <artifactId>rest-assured</artifactId>
    <version>3.0.2</version>
    <scope>test</scope>
</dependency>
```

## 공통 정보를 담은 부모 클래스 생성
PetStore 에서는 **Pet, Store, User** 세 개의 매뉴?모듈?을 제공한다.
각각에 대해 테스트 클래스를 생성하여 케이스를 생성할 예정이므로…
공통으로 사용되는 baseURI 정보를 담을 클래스를 생성한 뒤에 각각의 테스트 클래스에서 해당 클래스를 상속해서 사용했음.
```java
package com.restAssured;

import io.restassured.RestAssured;
import org.junit.jupiter.api.BeforeAll;

public class RestAssuredConfiguration {
    @BeforeAll
    public static void init() {
        RestAssured.baseURI = "http://petstore.swagger.io/"
    }
}
```


## 공통 PATH를 관리하기 위한 interface 클래스 생성
“/pet , /user ..”와 같이 정의된 url path에 대해 상수로 관리하기 위해 별도의 interface class를 생성했음. 
_(Spring의 controller에 정의하는 @RequestMapping에 해당하는 부분이라고 해야하나..마땅한 용어를 모르겠다…)_
```java
package com.restAssured.consts;

public interface EndPoint {
    public String PET = "/pet";
    public String STORE = "/store";
    public String USER = "/user";
}
```

## REST-API 테스트 케이스 작성
Swagger petstore를 보면 각각의 API에 대해 아래와 같이 정의되어 있으며, 해당 스펙을 기반으로 테스트 케이스를 작성하면 된다.
![](https://github.com/gloriaJun/gloriaJun.github.io/blob/master/_images/2017-03-23-testing-restassured-usage-with-petstore.png?raw=true)
![]({{ site.url }}/assets/images/testing/2017/0323-restassured-usage-with-petstore/petstore.png)

#### GET

###### Query parameter로 전달되는 형태
```java
@DisplayName("상태에 빈문자열 전달")
@Test
public void findByStatusEmpty() {
    given().
            param("status", "").
    when().
            get("http://petstore.swagger.io/v2" + "/pet/findByStatus").
    then().
            log().all().statusCode(200);
}
```

###### path 로 파라미터가 전달되는 형태
```java
@DisplayName("존재하는 아이디로 검색")
@Test
public void findByIDExpectSuccess() {
    given().
        pathParam("petId", 50).
when().
        get("http://petstore.swagger.io/v2" + "/pet/{petId}").
then().
        log().all().statusCode(200);
}
```

#### POST
###### body에 데이타를 담아서 전달 
_(id에 int 타입을 전달해줘야하는데, string을 전달하여 에러가 발생하게 한 케이스임)_
``` java
@DisplayName("id에 잘못된 값 입력하여 500 에러")
@Test
public void addPetExpectFailed() {
    Map<String, String> pet = new HashMap<String, String>();
    pet.put("id", "abc");

    given().
            contentType("application/json; charset=UTF-8").
            body(pet).
            log().all().
    when().
            post(BASE_URL).
    then().
            log().all().
            statusCode(500);
}
```
