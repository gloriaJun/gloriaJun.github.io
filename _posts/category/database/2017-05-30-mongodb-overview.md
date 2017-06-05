---
layout: post
comments: true
title: "[MongoDB] Overview"
date: 2017-05-30 17:30:00
categories: database
tags: mongodb
---

## What is MongoDB …?
오픈 소스 프로젝트로 document 기반의 NoSQL 스토리지로 뛰어난 확장성과 성능을  가지고 있다고함.   
특징을 정리하면 다음과 같음
    
* 모든 데이터가 JSON 형태로 저장되며 schema가 없다
(같은 collection이더라도 다른 스키마를 가지고 있을 수 있음)
* Full Index Support : RDBMS에 뒤지지 않는 다양한 인덱싱을 제공
* Replication & High Availability : 데이터 복제를 통해 가용성을 향상시킬 수 있음
* Auto-Sharding : Primary key를 기반으로 여러 서버에 데이터를 나누는 scale-out이 가능
* Querying : key 기반의 get, put 뿐만이 아니라 다양한 종류의 쿼리들을 제공
* Fast In-Place Updates : 고성능의 atomic operation을 지원
* Map/Reduce : 맵리듀스 지원
* GridFS : 별도 스토리지 엔진을 통해 파일을 저장할 수 있음
    
## RDBMS vs MongoDB
![]({{ site.url }}/assets/images/post/2017/0530-rdbms-vs-mongodb.png)

## Tip …???
 [MongoDB를 쓰면서 알게 된 것들 | Bigmatch](http://bigmatch.i-um.net/2013/12/mongodb%EB%A5%BC-%EC%93%B0%EB%A9%B4%EC%84%9C-%EC%95%8C%EA%B2%8C-%EB%90%9C-%EA%B2%83%EB%93%A4/)의 글을 읽으면서 내가 기억해두고 싶은 것들 정리…   

###### Indexing이 자유롭다
MySQL에서 지원하는 대부분의 인덱스를 지원하므로 거의 모든 쿼리들을 빠르게 처리할 수 있다

###### 데이터베이스 단위의 락을 사용한다
기존 RDBMS의 경우에는 row 단위의 락을 지원하나, MongoDB의 경우 데이터베이스 단위의 락을 지원하므로 많은 데이터를 한꺼번에 insert 하면 안된다.   
왜냐하면, read lock과 write lock에 있어서 write lock이 우선권을 가지고 있어서 동시에 요청이 들어오면 write operation만 동작을 하게 되어 다른 작업을 수행하지 못하게 될 수 있다.

###### Json 기반으로 쿼리를 작성해야한다
json 기반의 데이터베이스이며, NoSQL이므로 쿼리 작성 시 json으로 작성해야한다.

###### Subdocument가 계속해서 늘어날 땐 별도의 collection으로 만들고 인덱스를 걸어라
Join이 안되는 MongoDB에서 1:N 관계를 표현할 때에는 referencing과 embedding의 두 가지 방법이 있는데, 가능하면 RDBMS 방식으로 표현을 하는 것이 좋다.
```
// male collection
{
  _id : ObjectId(1),
  name : 'daram'
}
 
// female collection
{
  _id : Object(1),
  name : 'sora',
  male_id : ObjectId(1)
},
{ 
  _id : ObjectId(2),
  name : 'sky',
  male_id : ObjectId(2)
}
```   



> Reference     
> [MongoDB를 쓰면서 알게 된 것들 | Bigmatch](http://bigmatch.i-um.net/2013/12/mongodb%EB%A5%BC-%EC%93%B0%EB%A9%B4%EC%84%9C-%EC%95%8C%EA%B2%8C-%EB%90%9C-%EA%B2%83%EB%93%A4/)  
> [강좌 1편: 소개, 설치 및 데이터 모델링](https://velopert.com/436)  
