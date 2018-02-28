---
layout: post
comments: true
title: "[MongoDB] Usage"
date: 2017-06-05 14:30:00
categories: database
tags: mongodb
---

MongoDB 간단 사용방법 정리

## DataBase
###### 데이터베이스 생성
`use` 키워드를 이용하여 데이터베이스를 생성하거나, 이미 존재하는 데이터베이스인 경우 해당 데이터베이스를 사용한다.  
```
> use mydb
switched to db mydb
```

###### 현재 사용 중인 데이터베이스 확인
현재 접속하여 사용 중인 데이터베이스를 확인한다.
```
> db
mydb
```

###### 데이터베이스 목록 조회
참고로 데이터가 저장되어 있지 않은 데이터베이스는 목록에 표시되지 않는다
```
> show dbs
admin  0.000GB
local  0.000GB
```

###### 데이터베이스 삭제
삭제하고자 하는 데이타베이스로 변경한 뒤에 삭제해야한다.
```
> use mydb
switched to db mydb
> db.dropDatabase();
{ "dropped" : "mydb", "ok" : 1 }
```

## Collection
RDBMS에서의 Table에 해당한다.
`db.createCollection(name, [options])`과 같이 사용한다.   
option에서 사용가능한 값들은 다음과 같다.   
![]({{ site.url }}/assets/images/post/2017/0605-mongodb-collection.png)

###### collection 리스트 확인
Database에 생성되어있는 collection 목록을 확인한다.
```
> show collections
books
student
```

###### 생성
```
> db.createCollection("books")
{ "ok" : 1 }

> db.createCollection("articles", {
... capped: true,
... autoIndex: true,
... size: 6142800,
... max: 10000
... })
{ "ok" : 1 }
```

또는 별도로 collection을 생성하지 않아도 document를 추가하면 자동으로 생성된다.
```
> db.student.insert({"no":"1", "name":"Jay"})
WriteResult({ "nInserted" : 1 })
> show collections
student
```

###### 삭제
반드시 사용할 DataBase를 선택 후 해당 명령어를 사용한다.
```
> use mydb
switched to db mydb
> db.people.drop()
true
```
    
만약, 존재하지 않는 collection을 drop 하는 경우에는 false가 반환된다.
```
> db.abc.drop()
false
```

## Document
RDBMS에서의 Tuple/Row에 해당한다.   
`db.COLLECTION_NAME.insert(document)`과 같이 사용한다.   

###### Insert
한 건의 document를 입력   
```
> db.student.insert({"no":"1", "name":"Jay"})
WriteResult({ "nInserted" : 1 })
```

다 건의 document를 입력
```
> db.student.insert([
... {"no":"2", "name":"Alice"},
... {"no":"3", "name":"Julia"}
... ])
BulkWriteResult({
	"writeErrors" : [ ],
	"writeConcernErrors" : [ ],
	"nInserted" : 2,
	"nUpserted" : 0,
	"nMatched" : 0,
	"nModified" : 0,
	"nRemoved" : 0,
	"upserted" : [ ]
})
```

###### 조회
find() 명령어를 이용하여 조회한다.
```
> db.student.find()
{ "_id" : ObjectId("5934dfb7fd6da20182689369"), "no" : "1", "name" : "Jay" }
{ "_id" : ObjectId("5934e131fd6da2018268936a"), "no" : "2", "name" : "Alice" }
{ "_id" : ObjectId("5934e131fd6da2018268936b"), "no" : "3", "name" : "Julia" }
```
   
`pretty()` 메소드를 추가하면 포맷팅된 형식으로 출력된다.
```
> db.student.find().pretty()
{
    "_id" : ObjectId("5934ed392d0fc43769940531"),
    "no" : "2",
    "name" : "Alice"
}
{
    "_id" : ObjectId("5934ed392d0fc43769940532"),
    "no" : "3",
    "name" : "Julia"
}
```
   
`findOne()` 메소드의 경우에는 하나의 Document만 반환된다. 
```
}
> db.student.findOne()
{
    "_id" : ObjectId("5934ed392d0fc43769940531"),
    "no" : "2",
    "name" : "Alice"
}
> db.student.findOne({"no":3})
null
> db.student.findOne({"no":"3"})
{
    "_id" : ObjectId("5934ed392d0fc43769940532"),
    "no" : "3",
    "name" : "Julia"
}
```

###### 삭제
`db.COLLECTION_NAME.remove(criteria, justOne)` 구문을 이용하여 삭제한다.       
각 매개변수의 의미는 다음과 같다.    
![]({{ site.url }}/assets/images/post/2017/0605-mongodb-remove.png)

단 건 삭제
```
> db.student.remove({"no": "1"})
WriteResult({ "nRemoved" : 1 })
> db.student.find()
{ "_id" : ObjectId("5934e131fd6da2018268936a"), "no" : "2", "name" : "Alice" }
{ "_id" : ObjectId("5934e131fd6da2018268936b"), "no" : "3", "name" : "Julia" }
```

아래와 같이 매개변수를 전달하는 경우에는 모든 데이터가 제거된다.
```
> db.student.remove({})
WriteResult({ "nRemoved" : 2 })
> db.student.find()
>
```
   
> *Refenece*
> [MongoDB 강좌 2편: Database/Collection/Document 생성·제거 | VELOPERT.LOG](https://velopert.com/457)   





 