---
layout: post
comments: true
title: "[Rest Assured] SpecBuilder"
date: 2017-05-15 19:30:00
categories: "Testing"
tags: java restAssured Rest-API
---

rest-assured에서는 모든 spec에서 중복되어 사용되는 기대값과 요청 파라미터들을 각각의 테스트케이스에서 재사용을 할 수 있도록 [RequestSpecBuilder](http://static.javadoc.io/io.rest-assured/rest-assured/3.0.3/io/restassured/builder/RequestSpecBuilder.html)와 [ResponseSpecBuilder](http://static.javadoc.io/io.rest-assured/rest-assured/3.0.3/io/restassured/builder/ResponseSpecBuilder.html)를 제공한다.

각 메소드에 대한 사용방법에 대해 정리하면 아래와 같음

#### RequestSpecBuilder
```java
RequestSpecBuilder builder = new RequestSpecBuilder();
builder.addParam("parameter1", "parameterValue");
builder.addHeader("header1", "headerValue");
RequestSpecification requestSpec = builder.build();
/*
// 또는 아래와 같이 메소드 체이닝 형식으로도 사용 가능
RequestSpecification requestSpec = new RequestSpecBuilder()
				.addParam("parameter1", "parameterValue")
				.addHeader("header1", "headerValue")
				.build();
*/

given().
        spec(requestSpec).
        param("parameter2", "paramValue").
when().
        get("/something").
then().
        body("x.y.z", equalTo("something"));      
```

#### ResponseSpecBuilder
```java
ResponseSpecBuilder builder = new ResponseSpecBuilder();
builder.expectStatusCode(200);
builder.expectBody("x.y.size()", is(2));
ResponseSpecification responseSpec = builder.build();
/*
// 또는 아래와 같이 메소드 체이닝 형식으로도 사용 가능
ResponseSpecification responseSpec = new ResponseSpecBuilder()
				.expectStatusCode(200)
				.expectBody("x.y.size()", is(2))
				.build();
*/

// Now you can re-use the "responseSpec" in many different tests:
when().
       get("/something").
then().
       spec(responseSpec).
       body("x.y.z", equalTo("something"));
```


> 참고 링크  
> [Usage · rest-assured/rest-assured Wiki · GitHub](https://github.com/rest-assured/rest-assured/wiki/Usage#specification-re-use)  