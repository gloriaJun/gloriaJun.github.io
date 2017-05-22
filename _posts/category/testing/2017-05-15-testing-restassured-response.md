---
layout: post
comments: true
title: "[Rest Assured] Response"
date: 2017-05-15 19:50:00
categories: "Testing"
tags: java restAssured Rest-API
---

_io.restassured.response_ 에 포함된 response관련 클래스 정리

## Response
요청한 값에 대한 응답을 저장한다.

* 사용예제 (javadoc에 나와있는 예제)
```java
Response response = get("/lotto");
String body = response.getBody().asString();
String headerValue = response.getHeader("headerName");
String cookieValue = response.getCookie("cookieName");
```

다른 예제를 들자면….
아래와 같이 작성된 코드를…
```java
given().param("status", "pending").
when(). get(EndPoint.PET + "/findByStatus").
then().statusCode(200).log().all();
```

 Response 객체를 사용해서 아래와 같이 수정할 수 있다.
```java
// api 호출한 응답 결과를 Response 객체에 저장한다.
Response resp = given().param("status", "pending").
		when().get(EndPoint.PET + "/findByStatus");
// 응닶 결과에 대한 코드 값을 검증하고, 로깅한다.
resp.then().statusCode(200).log().all();
```


## ValidatableResponse
Response와 유사하나,  응답된 값을 검증을 위한 것이라..”then()” 구문 까지 또는 검증한 결과에 대해서도 저장이 가능한 것 같다.
즉, 응답값에 대해 기본적으로 검증을 진행 후에 추가적인 확인을 하고자 하는 경우에 활용이 가능할 것 같다.

* 사용예제 
```java
ValidatableResponse resp = given().param("status", "pending").
                when().get(EndPoint.PET + "/findByStatus").
                then();

// 또는 아래와 같이도 가능.
ValidatableResponse resp = given().param("status", "pending").
                when().get(EndPoint.PET + "/findByStatus").
                then().statusCode(200).log().all();
```

