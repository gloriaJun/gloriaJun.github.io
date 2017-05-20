---
layout: post
comments: true
title: "[Rest Assured] Object Mapping"
date: 2017-03-24 17:30:00
categories: "Testing"
tags: java restAssured Rest-API
---

아래와 같은 object에 대한 데이타를 json format으로 전달해주어야 한다고  할 때..ojbect를 생성하여 object 로 전달하는 방법이 있을까 싶어 찾아보았다.
![]({{ site.url }}/assets/images/post/testing/2017/0324-restassured-object-mapping/put-user.png)

찾아보니..rest-assured의 [Usage](https://github.com/rest-assured/rest-assured/wiki/Usage#object-mapping) 문서에 관련해서 설명이 나와있었다.

### jackson (databind) 라이브러리 정의
“application/json”으로 전달할 것이기 때문에 관련된 부분만 찾아 보니.. `It will first try to use Jackson if found in classpath and if not Gson will be used.`  라고 설명이 되어있었다.
그렇다면 jackson 이 먼저인 것 같다. 그래서 jackson 라이브러리를 사용하기로…
[maven 저장소](jackson-databind 2.2.2 maven)에서  `pom.xml`에 정의하기 위한 dependency 정의 부분을 복사해서 붙였다.
```xml
<dependency>
    <groupId>com.fasterxml.jackson.core</groupId>
    <artifactId>jackson-databind</artifactId>
    <version>2.8.7</version>
</dependency>
```

### object 생성
```java
public class User {
    private int id;
    private String username;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String phone;
    private long userStatus;
...
}
```

### object mapping
###### Serialization
다음과 같이 생성한 object에 전달할 값을 매핑하여 객체를 전달하면 된다.
```java
User user = new User(10, "tester", "제이제이", "lee", "tester@tttt.com", "passwd", "010-1111-2222", 0L);
given().
        contentType("application/json; charset=UTF-8").
        body(user).
when().
        post("http://petstore.swagger.io/v2" + "/user").
then().
        statusCode(200).log().all();
```
> contentType에 `charset=UTF-8`을 정의해준 것은. 영문자가 아닌 데이타를 전송할 때에 깨지지 않고 올바르게 전달되게 하기 위해서임.  

###### Deserialization
서버로부터 json body에 담겨온 값을 object에 mapping 하기 위해서는 아래와 같이 사용하면 된다.
```java
User user = given().
        pathParam("username", "tester").
when().
        get("http://petstore.swagger.io/v2" + "/user/{username}").
        as(User.class);

System.out.println(user.toString());
```

## Array 형태에 대한 object mapping
response body를 통하여 list 형태로 전달된 객체에 대해 Deserialization하는 방법.
```java
List<Pet> petList = Arrays.asList(given().
        param("status", "pending").
when().
        get("http://petstore.swagger.io/v2" + "/pet/findByStatus").as(Pet[].class));
```

##### object 객체에 포함된 string array 형태에 대한 mapping
아래와 같은 형태로 전달되는 json 데이타에 대해서...
```xml
{
  "id": 0,
  "category": {
    "id": 0,
    "name": "string"
  },
  "name": "doggie",
  "photoUrls": [
    "string"
  ],
  "tags": [
    {
      "id": 0,
      "name": "string"
    }
  ],
  "status": "available"
}
```

아래와 같이 객체를 생성해서 매핑하면 된다.
```java
public class Category {
    long id;
    String name;
...
}

public class Pet {
    long id;
    Category category;
    String name;
    String[] photoUrls;
    List<Category> tags;
    String status;
...
}
```
