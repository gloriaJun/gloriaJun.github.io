---
layout: post
comments: true
title: "[Hygieia] Configuration"
date: 2017-06-07 15:05:00
categories: devops
tags: ci/cd
---

Dashboard 오픈소스인 [Hygieia](https://github.com/capitalone/Hygieia) 를 Docker 환경에서 구축하는 방법에 대하여 정리   
hygieia dashboard 환경구성을 위해서는 아래와 같은 app 설치 및 연동이 필요하다.   
* Database
* API Layer
* UI Layer
* Tool Collectors
* Plugin WebHook

## Database
MongoDB container를 생성한다.
```
docker run -d -p 27017:27017 --name mongodb mongo:latest  mongod --smallfiles
```
    
사용자를 생성한다.
```
$ docker exec -it mongodb mongo
> use dashboard
switched to db db
> db.createUser(
  {
    user: "db",
    pwd: "dbpass",
    roles: [ { role: "readWrite", db: "dashboard" }]
  }
)
Successfully added user: {
	"user" : "db",
	"roles" : [
		{
			"role" : "readWrite",
			"db" : "dashboard"
		}
	]
}
``` 
    
사용자 생성 후에 아래와 같이 접속이 되는 지 확인한다.    
``` 
$ docker exec -it mongodb mongo -u "db" -p "dbpass" --authenticationDatabase "dashboard"
MongoDB shell version v3.4.4
connecting to: mongodb://127.0.0.1:27017
MongoDB server version: 3.4.4
Server has startup warnings:
2017-06-07T05:06:52.179+0000 I STORAGE  [initandlisten]
2017-06-07T05:06:52.179+0000 I STORAGE  [initandlisten] ** WARNING: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine
2017-06-07T05:06:52.179+0000 I STORAGE  [initandlisten] **          See http://dochub.mongodb.org/core/prodnotes-filesystem
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten]
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten] ** WARNING: Access control is not enabled for the database.
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten] **          Read and write access to data and configuration is unrestricted.
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten]
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten]
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten] ** WARNING: /sys/kernel/mm/transparent_hugepage/enabled is 'always'.
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten] **        We suggest setting it to 'never'
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten]
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten] ** WARNING: /sys/kernel/mm/transparent_hugepage/defrag is 'always'.
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten] **        We suggest setting it to 'never'
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten]
> exit
```
_만약, 아래와 같은 방식으로 사용자 생성 후 접속이 되지 않으면 api 컨테이너를 생성 후에 서비스가 올라가는 과정에서 “Authication failed” 에러가 발생한다_

## Api
docker image를 빌드하여 생성한다.
```
# from top-level project
mvn clean package -pl api docker:build

$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
hygieia-api         latest              bc14a0745d94        2 hours ago         688MB
```
    
컨테이너 생성 시 앞에서 생성한 MongoDB 컨테이너와 링크를 걸어준다.
```
docker run -d -p 8080:8080 --name hygieia-api --link mongodb:mongo   -i hygieia-api:latest 
```
   
컨테이너가 정상적으로 기동된 후에 아래와 같이 접속되는 것을 확인할 수 있다.
```
$ curl http:/192.168.99.100:8080/api/dashboard
[]
```

## UI
docker image를 빌드하여 생성한다.
```
# from top-level project
mvn clean package -pl UI docker:build

$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
hygieia-ui          latest              08b9d0e3943a        27 seconds ago      116MB
```
    
컨테이너 생성 시 앞에서 생성한 `hygieia-api `와 링크를 걸어준다.
```
docker run -d -p 8088:80 --name hygieia-ui --link hygieia-api -i hygieia-ui:latest
```
    
컨테이너가 정상적으로 기동되면 웹브라우라저를 이용하여 `http://docker-machine ip:8088`로 접속하면 아래와 같은 페이지를 확인할 수 있다.   
![]({{ site.url }}/assets/images/post/2017/0607-devops-hygieia.png)


