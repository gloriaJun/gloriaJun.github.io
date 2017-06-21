---
layout: post
comments: true
title: "[docker] MongoDB 설치하기"
date: 2017-06-02 09:30:00
categories: server
tags: docker mongodb
---

docker를 이용하여 MongoDB를 설치하는 방법에 대하여 정리   

## MongoDB 컨테이너 생성
docker hub에서 이미지를 가져와서 생성한다.
```shell
$ docker run --name mongodb -p 27017:27017 -d mongo
Unable to find image 'mongo:latest' locally
latest: Pulling from library/mongo
56c7afbcb0f1: Pull complete
ac4863389b54: Pull complete
fccbd1684456: Pull complete
5565b5f177e7: Pull complete
b00971241c47: Pull complete
c0300dc07374: Pull complete
b93b8ba2b93b: Pull complete
661362338965: Pull complete
fa170e22de2e: Pull complete
86992ab45331: Pull complete
e233325a655e: Pull complete
Digest: sha256:c4bc4644b967a4b58022a79cf5c9afcd25ed08180c958a74df57b7753cfc8649
Status: Downloaded newer image for mongo:latest
20beccf7d7a54d731d6d2be820fe584b7c2cc12498bc536ae79630320f50f537
```

생성 후에 아래와 같이 해당 컨테이너가 실행 중인 것을 확인할 수 있다.
```shell
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                    PORTS               NAMES
20beccf7d7a5        mongo               "docker-entrypoint..."   3 seconds ago       Up 2 seconds              0.0.0.0:27017->27017/tcp   mongodb
```


## MongoDB에 접속하기
###### 컨테이너에서 접속하기
```shell
$ docker exec -it mongodb mongo
MongoDB shell version v3.4.4
connecting to: mongodb://127.0.0.1:27017
MongoDB server version: 3.4.4
Welcome to the MongoDB shell.
For interactive help, type "help".
For more comprehensive documentation, see
	http://docs.mongodb.org/
Questions? Try the support group
	http://groups.google.com/group/mongodb-user
Server has startup warnings:
2017-06-02T01:46:38.291+0000 I STORAGE  [initandlisten]
2017-06-02T01:46:38.291+0000 I STORAGE  [initandlisten] ** WARNING: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine
2017-06-02T01:46:38.291+0000 I STORAGE  [initandlisten] **          See http://dochub.mongodb.org/core/prodnotes-filesystem
2017-06-02T01:46:38.624+0000 I CONTROL  [initandlisten]
2017-06-02T01:46:38.624+0000 I CONTROL  [initandlisten] ** WARNING: Access control is not enabled for the database.
2017-06-02T01:46:38.624+0000 I CONTROL  [initandlisten] **          Read and write access to data and configuration is unrestricted.
2017-06-02T01:46:38.624+0000 I CONTROL  [initandlisten]
2017-06-02T01:46:38.624+0000 I CONTROL  [initandlisten]
2017-06-02T01:46:38.624+0000 I CONTROL  [initandlisten] ** WARNING: /sys/kernel/mm/transparent_hugepage/enabled is 'always'.
2017-06-02T01:46:38.624+0000 I CONTROL  [initandlisten] **        We suggest setting it to 'never'
2017-06-02T01:46:38.624+0000 I CONTROL  [initandlisten]
2017-06-02T01:46:38.624+0000 I CONTROL  [initandlisten] ** WARNING: /sys/kernel/mm/transparent_hugepage/defrag is 'always'.
2017-06-02T01:46:38.624+0000 I CONTROL  [initandlisten] **        We suggest setting it to 'never'
2017-06-02T01:46:38.624+0000 I CONTROL  [initandlisten]
>
```

###### 외부에서 mongo client 를 이용하여 접속하기
* docker machine의 ip 확인
```shell
$ docker-machine ls
NAME        ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER        ERRORS
docker-vm   *        virtualbox   Running   tcp://192.168.99.100:2376           v17.05.0-ce
$ docker-machine ip docker-vm
192.168.99.100
```
    
* MongoDB에 접속
```shell
$ mongo 192.168.99.100:27017
MongoDB shell version v3.4.4
connecting to: 192.168.99.100:27017
MongoDB server version: 3.4.4
Server has startup warnings:
2017-06-02T08:23:35.217+0000 I STORAGE  [initandlisten]
2017-06-02T08:23:35.217+0000 I STORAGE  [initandlisten] ** WARNING: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine
2017-06-02T08:23:35.217+0000 I STORAGE  [initandlisten] **          See http://dochub.mongodb.org/core/prodnotes-filesystem
2017-06-02T08:23:35.233+0000 I CONTROL  [initandlisten]
2017-06-02T08:23:35.233+0000 I CONTROL  [initandlisten] ** WARNING: Access control is not enabled for the database.
2017-06-02T08:23:35.233+0000 I CONTROL  [initandlisten] **          Read and write access to data and configuration is unrestricted.
2017-06-02T08:23:35.233+0000 I CONTROL  [initandlisten]
2017-06-02T08:23:35.233+0000 I CONTROL  [initandlisten]
2017-06-02T08:23:35.233+0000 I CONTROL  [initandlisten] ** WARNING: /sys/kernel/mm/transparent_hugepage/enabled is 'always'.
2017-06-02T08:23:35.233+0000 I CONTROL  [initandlisten] **        We suggest setting it to 'never'
2017-06-02T08:23:35.233+0000 I CONTROL  [initandlisten]
2017-06-02T08:23:35.233+0000 I CONTROL  [initandlisten] ** WARNING: /sys/kernel/mm/transparent_hugepage/defrag is 'always'.
2017-06-02T08:23:35.233+0000 I CONTROL  [initandlisten] **        We suggest setting it to 'never'
2017-06-02T08:23:35.233+0000 I CONTROL  [initandlisten]
>
```

## 스키마 생성 및 확인
다음과 같이 간단한 하나의 스키마를 생성하고 데이타 넣고 확인해보기
###### 컬렉션 생성
```shell
> db.createCollection('cities')
{ "ok" : 1 }
```

###### 데이타 입력
``` 
> db.cities.insert({ name: 'New York', country: 'USA' })
WriteResult({ "nInserted" : 1 })
> db.cities.insert({ name: 'Paris', country: 'France' })
WriteResult({ "nInserted" : 1 })
```

###### 데이타 수정
```
> db.cities.update({name: 'Paris'}, {$set : {country:'France1'}})
WriteResult({ "nMatched" : 1, "nUpserted" : 0, "nModified" : 1 }
```

###### 조회
```
> db.cities.find()
{ "_id" : ObjectId("5930c42ac3a32dd42d8107ca"), "name" : "New York", "country" : "USA" }
{ "_id" : ObjectId("5930c4b2c3a32dd42d8107cb"), "name" : "Paris", "country" : "France1" }
```
   
기타 자세한 쿼리 사용법은 [SQL to MongoDB Mapping Chart](https://docs.mongodb.com/manual/reference/sql-comparison/)를 참고.   



> **Reference**  
> [Getting Started With Docker, Node and Mongo – Justin Siddon](http://people.oregonstate.edu/~siddonj/site/wordpress/2016/05/22/getting-started-with-docker-node-and-mongo/)        
> [Setting up MongoDB Instance with Docker Toolbox](http://codehangar.io/mongodb-image-instance-with-docker-toolbox-tutorial/)  