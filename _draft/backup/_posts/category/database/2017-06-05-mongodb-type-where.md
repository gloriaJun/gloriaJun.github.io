---
layout: post
comments: true
title: "[MongoDB] 데이터 타입 및 조건절"
date: 2017-06-05 15:00:00
categories: database
tags: mongodb
---

MongoDB에서 지원하는 데이터 타입 과 사용가능한 조건절

#### 데이터 타입
![]({{ site.url }}/assets/images/post/2017/0605-mongodb-datatype.png)


#### 조건절
`find()` 메소드의 아규먼트로 해당 조건을 명시한다.   
![]({{ site.url }}/assets/images/post/2017/0605-mongodb-where.png)
    
###### AND
콤마로 연결하여 입력한다.
```
> db.student.find({"name":"Jay"})
{ "_id" : ObjectId("5934ef1c2d0fc43769940533"), "no" : "1", "name" : "Jay" }
{ "_id" : ObjectId("5934ef572d0fc43769940534"), "no" : "4", "name" : "Jay" }

> db.student.find({"no":"1", "name":"Jay"})
{ "_id" : ObjectId("5934ef1c2d0fc43769940533"), "no" : "1", "name" : "Jay" }
```

###### OR
`$or` 키워드를 사용하여 해당 조건들을 배열로 입력한다.
```
> db.student.find({$or:[{"name":"Mike"}, {age:{$lt:9}}]}).sort({no:1})
{ "_id" : ObjectId("5934f0ba44ff2f6b8e31dbaa"), "no" : 1, "name" : "Kay", "age" : 8 }
{ "_id" : ObjectId("5934f0ba44ff2f6b8e31dbac"), "no" : 3, "name" : "Mike", "age" : 10 }
{ "_id" : ObjectId("5934f0b044ff2f6b8e31dba9"), "no" : 5, "name" : "Mike", "age" : 18 }
```

###### 문자열 검색
`$regex`   키워드를 이용하여 검색한다.
```
> db.student.find({"name":{$regex:"^[A-Z].*a$"}})
{ "_id" : ObjectId("5934f0ba44ff2f6b8e31dbab"), "no" : 2, "name" : "Julia", "age" : 10 }
```


> **Reference**  
> [보리 & 마고 :: MongoDB Query -  쿼리 질의 시에 연산자 조합 사용법](http://winmargo.tistory.com/182)      
>   