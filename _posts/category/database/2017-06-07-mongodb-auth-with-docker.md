---
layout: post
comments: true
title: "[MongoDB] Enable Auth With Docker"
date: 2017-06-07 14:30:00
categories: database
tags: mongodb docker
---

MongoDB는 기본적으로 보안모델 없이 접속을 하여 사용을 할 수가 있지만, 보안기능 제공을 위해 Authorization 기능을 제공하고 있다.    

해당 기능을 사용하기 위해서는 admin 계정을 생성하고, 인증 모드로 MongoDB를 기동한다.

#### MongoDB Container Create With Auth
MongoDB 컨테이너를 생성할 때, `—auth` 옵션을 주고 생성한다.    
```
$ docker run -d -p 17017:27017 --name testdb mongo:latest --auth
6fd5733f2bdd7613e6ecb1b03fe9e415c9c317eaf2a3304fa7dee37c8bd5377b

$ docker ps -a
CONTAINER ID        IMAGE                COMMAND                  CREATED             STATUS                  PORTS                      NAMES
6fd5733f2bdd        mongo:latest         "docker-entrypoint..."   3 seconds ago       Up 3 seconds            0.0.0.0:17017->27017/tcp   testdb
```
   
#### Create the user administrator.
 mongo shell에 접속할 때 `admin` 을 입력해서 접속한 뒤 관리자 계정을 생성한다.
```
$ docker exec -it testdb mongo admin
MongoDB shell version v3.4.4
connecting to: mongodb://127.0.0.1:27017/admin
MongoDB server version: 3.4.4
Welcome to the MongoDB shell.
For interactive help, type "help".
For more comprehensive documentation, see
	http://docs.mongodb.org/
Questions? Try the support group
	http://groups.google.com/group/mongodb-user
> use admin
switched to db admin
> db.createUser(
  {
    user: "myUserAdmin",
    pwd: "abc123",
    roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
  }
)
Successfully added user: {
	"user" : "myUserAdmin",
	"roles" : [
		{
			"role" : "userAdminAnyDatabase",
			"db" : "admin"
		}
	]
}
```

#### MongoDB Instance ReStart
MongoDB 인스턴스를 재기동한 뒤에 아래와 같은 방법으로 접속이 되는 것을 확인할 수 있다.
```
$ docker exec -it testdb mongo -u "myUserAdmin" -p "abc123" --authenticationDatabase "admin"
MongoDB shell version v3.4.4
connecting to: mongodb://127.0.0.1:27017
MongoDB server version: 3.4.4
> use admin
switched to db admin
> show users
{
	"_id" : "admin.myUserAdmin",
	"user" : "myUserAdmin",
	"db" : "admin",
	"roles" : [
		{
			"role" : "userAdminAnyDatabase",
			"db" : "admin"
		}
	]
}
>
```
    
만약, 인증을 거치지 않은 경우에는 아래와 같이 에러가 발생한다.
```
$ docker exec -it testdb mongo
MongoDB shell version v3.4.4
connecting to: mongodb://127.0.0.1:27017
MongoDB server version: 3.4.4
> use admin
switched to db admin
> show users
2017-06-07T05:24:00.173+0000 E QUERY    [thread1] Error: not authorized on admin to execute command { usersInfo: 1.0 } :
_getErrorWithCode@src/mongo/shell/utils.js:25:13
DB.prototype.getUsers@src/mongo/shell/db.js:1537:1
shellHelper.show@src/mongo/shell/utils.js:752:9
shellHelper@src/mongo/shell/utils.js:659:15
@(shellhelp2):1:1
```
    
shell안에서 `db.auth(<username>, <pwd>)`를 이용하면 인증 변경을 할 수 있다. (사용자 변경과 같은 거로 이해하면 될 듯)
```
$ docker exec -it testdb mongo
MongoDB shell version v3.4.4
connecting to: mongodb://127.0.0.1:27017
MongoDB server version: 3.4.4
> use admin
switched to db admin
> db.auth("myUserAdmin", "abc123" )
1
> show users
{
	"_id" : "admin.myUserAdmin",
	"user" : "myUserAdmin",
	"db" : "admin",
	"roles" : [
		{
			"role" : "userAdminAnyDatabase",
			"db" : "admin"
		}
	]
}
```

#### 사용자 추가
아래와 같이 필요한 사용자를 추가할 수 있음.
```
use test
db.createUser(
  {
    user: "myTester",
    pwd: "xyz123",
    roles: [ { role: "readWrite", db: "test" },
             { role: "read", db: "reporting" } ]
  }
)
```
   
아래와 같이 해당 데이타베이스에 접속하면 된다.
```
$ docker exec -it testdb mongo -u "myTester" -p "xyz123" --authenticationDatabase "test"
MongoDB shell version v3.4.4
connecting to: mongodb://127.0.0.1:27017
MongoDB server version: 3.4.4
> use test
switched to db test
```
   
추가된 사용자에 데이타를 입력하고자 하는 경우 아래와 같이 사용
```
> use test
switched to db test
> db.auth("myTester", "xyz123" )
1
> db.foo.insert( { x: 1, y: 1 } )
WriteResult({ "nInserted" : 1 })
> db.foo.find()
{ "_id" : ObjectId("59378f14f7a554ce927ca8ba"), "x" : 1, "y" : 1 }
```

#### 사용자 삭제
삭제하고자 하는 사용자가 접속이 되어있지 않은 상태에서 `dropUser()` 메소드를 이용하여 삭제한다.
```
> db.dropUser("myTester")
true
```


> **Reference**  
> https://docs.mongodb.com/manual/tutorial/enable-authentication/     