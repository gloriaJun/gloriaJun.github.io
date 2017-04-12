---
layout: post
title: "[Rest Assured] Getting Started"
date: 2017-03-23 09:30:00
categories: "Testing"
tags: junit junit5 java restAssured Rest-API
---

[Rest Assured Document Getting Started](https://github.com/rest-assured/rest-assured/wiki/GettingStarted)에 작성된 부분에서 테스트 시 필요에 따라 정의해야하는 패키지들에 부분만 정리한 부분임.

Maven을 사용하는 경우, pom.xml에 아래와 같이 dependency를 정의한다.


#### REST Assured ####
```
<dependency>
      <groupId>io.rest-assured</groupId>
      <artifactId>rest-assured</artifactId>
      <version>3.0.2</version>
      <scope>test</scope>
</dependency>
```
- JUnit에 대한 dependency를 선언하기 전에 정의해야한다.
- JsonPath, XmlPath를 포함하고 있다.

#### JsonPath ####
```
<dependency>
      <groupId>io.rest-assured</groupId>
      <artifactId>json-path</artifactId>
      <version>3.0.2</version>
</dependency>
```
- 독립실행형 이다.
- JSON 구문에 대한 parsing을 쉽게 해준다.
- [Groovy's GPath](http://groovy-lang.org/processing-xml.html#_gpath) 를 사용하여 동작하므로  Jayway의 [JsonPath](https://github.com/jayway/JsonPath) 와 혼돈하지 말아야 함.

#### XmlPath ####
```
<dependency>
      <groupId>io.rest-assured</groupId>
      <artifactId>xml-path</artifactId>
      <version>3.0.2</version>
</dependency>
```
- 독립실행형 이다.
- XML 구문에 대한 parsing을 쉽게 해준다.

* JSON Schema Validation
<dependency>
      <groupId>io.rest-assured</groupId>
      <artifactId>json-schema-validator</artifactId>
      <version>3.0.2</version>
      <scope>test</scope>
</dependency>
- [Json Schema](http://json-schema.org/) 에 맞는지에 대해 응답된 Json을 검증하기를 원하면 해당 모듈을 사용한다.
- 좀 더 많은 정보를 위해서는 [documentation](https://github.com/rest-assured/rest-assured/wiki/Usage#json-schema-validation)을 참고

#### Spring Mock Mvc ####
```
<dependency>
      <groupId>io.rest-assured</groupId>
      <artifactId>spring-mock-mvc</artifactId>
      <version>3.0.2</version>
      <scope>test</scope>
</dependency>
```
- Spring MVC를 사용한다면, 해당 모듈을 이용하여 RestAssuredMockMvc API를 사용하는 controller에 대한 단위테스트를 수행할 수 있다.

#### Scala Support ####
```
<dependency>
    <groupId>io.rest-assured</groupId>
    <artifactId>scala-support</artifactId>
    <version>3.0.2</version>
    <scope>test</scope>
</dependency>
```
- Scala를 사용한다면, 해당 모듈을 사용할 수 있다.

#### Static Import ####
Rest assured를 사용하기 위해서는 아래와 같은 패지키를 클래스 파일에 import 해주어야 한다.
```
io.restassured.RestAssured.*
io.restassured.matcher.RestAssuredMatchers.*
org.hamcrest.Matchers.*
```
만약, Json Schema 검증을 하기를 원하면 아래의 패키지를 import 해준다.
io.restassured.module.jsv.JsonSchemaValidator.*
자세한 내용은 Json Schema Validation 를 참고해라.

만약, Spring MVC를 사용한다면, spring-mock-mvc를 단위테스트를 위해 사용할 수 있다.
```
io.rest-assured.RestAssured 와 io.rest-assured.matcher.RestAssuredMatchers 대신에 RestAssuredMockMvc 에서 import를 해야한다.
io.restassured.module.mockmvc.RestAssuredMockMvc.*
io.restassured.matcher.RestAssuredMatchers.*
```
