---
layout: post
comments: true
title: "[docker] Redis 설치 및 접속 확인"
date: 2017-06-01 09:30:00
categories: server
tags: docker 
---

# [docker] redis 설치
docker machine이 아래와 같이 설치된 상태에서 redis를 설치하고 telnet으로 접속해서 확인하는 방법에 대한 내용    

###### 설치된 docker machine을 확인
```shell
$ docker-machine ls
NAME        ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER        ERRORS
docker-vm   *        virtualbox   Running   tcp://192.168.99.100:2376           v17.05.0-ce
```
    
###### redis 설치 
```shell
$ docker run -d -p 6379:6379 redis
Unable to find image 'redis:latest' locally
latest: Pulling from library/redis
10a267c67f42: Pull complete
5b690bc4eaa6: Pull complete
4cdd94354d2a: Pull complete
71c1f30d820f: Pull complete
c54584150374: Pull complete
d1f9221193a6: Pull complete
d45bc46b48e4: Pull complete
Digest: sha256:548a75066f3f280eb017a6ccda34c561ccf4f25459ef8e36d6ea582b6af1decf
Status: Downloaded newer image for redis:latest
e348e8ce23bd4d1aea385abb2fc2e77387d8d443bdeb2356f04fd6d50cb96c75
```

###### 설치된 redis 컨테이너에 접속
아래와 같이 docker machine에 부여된 ip와 redis container의 포트를 이용하여 접속해볼 수 있다
```shell
$ telnet 192.168.99.100 6379
Trying 192.168.99.100...
Connected to 192.168.99.100.
Escape character is '^]'.
set mykey hello
+OK
get mykey
$5
hello
quit
+OK
Connection closed by foreign host.
```