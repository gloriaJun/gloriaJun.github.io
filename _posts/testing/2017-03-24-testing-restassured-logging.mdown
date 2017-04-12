---
layout: post
title: "[Rest Assured] Logging"
date: 2017-03-24 12:30:00
categories: "Testing"
tags: junit junit5 java restAssured Rest-API
---

## Request Logging
```
given().log().all(). .. // Log all request specification details including parameters, headers and body
given().log().params(). .. // Log only the parameters of the request
given().log().body(). .. // Log only the request body
given().log().headers(). .. // Log only the request headers
given().log().cookies(). .. // Log only the request cookies
given().log().method(). .. // Log only the request method
given().log().path(). .. // Log only the request path
```

gievn.log().all()을 수행한 경우 아래와 같은 로그 내용이 출력된다.
```
Request method:	GET
Request URI:	http://localhost:8080/student
Proxy:			<none>
Request params:	<none>
Query params:	<none>
Form params:	<none>
Path params:	<none>
Multiparts:		<none>
Headers:		Accept=*/*
Cookies:		<none>
Body:			<none>
```

예시)
```
given().log().all().
        get(EndPoint.GET_STUDENT_LIST).
then().
        statusCode(200);
```

## Response Logging
응답코드에 상관없이 로깅하고 싶다면...
```
get("/x").then().log().body() ..
```
에러가 발생하는 경우에 로깅하고 싶은 경우
```
get("/x").then().log().ifError(). ..
```
응답상태 등 모두 로깅하고 싶다면..
```
get("/x").then().log().all(). ..
```
아래의 정보들은 필요에 따라 각각 로깅할 수 있음.
```
get("/x").then().log().statusLine(). .. // Only log the status line
get("/x").then().log().headers(). .. // Only log the response headers
get("/x").then().log().cookies(). .. // Only log the response cookies
```
또한 응답 코드가 조건에 맞는 경우에 로깅하도록 할 수도 있다.
```
get("/x").then().log().ifStatusCodeIsEqualTo(302). .. // Only log if the status code is equal to 302
get("/x").then().log().ifStatusCodeMatches(matcher). .. // Only log if the status code matches the supplied Hamcrest matcher
```

### Log if validation fails 
2.3.1 버전 이후 부터는 validation이 실패하는 경우에 로깅할 수 있다.
```
# request에 대한 로깅
given().log().ifValidationFails(). ..

# response에 대한 로깅
.. .then().log().ifValidationFails(). ..
```
또한 [LogConfig](http://static.javadoc.io/io.rest-assured/rest-assured/3.0.2/io/restassured/config/LogConfig.html)를 설정함으로 response와 request에 동일하게 설정할 수도 있다.
```
given().config(RestAssured.config().logConfig(logConfig().enableLoggingOfRequestAndResponseIfValidationFails(HEADERS))). ..

또는

RestAssured.enableLoggingOfRequestAndResponseIfValidationFails();
```
