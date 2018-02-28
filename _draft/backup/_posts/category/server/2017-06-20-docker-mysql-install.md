---
layout: post
comments: true
title: "[docker] mysql 컨테이너 생성"
date: 2017-06-20 10:30:00
categories: server
tags: docker mysql
---

docker를 이용하여 mysql 설치하기.   

#### 컨테이너 생성
```
$ docker \
   run \
   --detach \
   --env MYSQL_ROOT_PASSWORD=myadmin \
   --env MYSQL_USER=soul \
   --env MYSQL_PASSWORD=soul1234 \
   --env MYSQL_DATABASE=souldb \
   --name mysqldb \
   --publish 3306:3306 \
   mysql;
```

###### docker-compose를 이용한 생성
yml 파일 
```
version: '2'

services:
   db:
     image: mysql:latest
     container_name: mysqldb
     restart: always
     environment:
       MYSQL_ROOT_PASSWORD: myadmin
       MYSQL_DATABASE: souldb
       MYSQL_USER: soul
       MYSQL_PASSWORD: soul1234
     ports:
       - "3306:3306"
```

#### mysql 접속
```
$ docker exec -it mysqldb mysql -u root -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 4
Server version: 5.7.18 MySQL Community Server (GPL)

Copyright (c) 2000, 2017, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| souldb             |
| sys                |
+--------------------+
5 rows in set (0.01 sec)
```