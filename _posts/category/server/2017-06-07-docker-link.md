---
layout: post
comments: true
title: "[docker] container link"
date: 2017-06-07 10:30:00
categories: server
tags: docker 
---

생성한 container 사이에 연동이 필요한 경우에 `link` 옵션을 이용하여 설정을 한다.
    
아래와 같이 생성한 mongodb 컨테이너와 연동을 할 웹컨테이너를 생성
```
$ docker run -d --name myweb --link mongodb httpd
Unable to find image 'httpd:latest' locally
latest: Pulling from library/httpd
10a267c67f42: Already exists
0782edf7745a: Pull complete
f3a72c4d9d02: Pull complete
dd6ec65d8a55: Pull complete
1b7920e1c0df: Pull complete
5b99e4053015: Pull complete
e720548ad189: Pull complete
Digest: sha256:72b55a7c15a4ee3d56ff19f83b57b82287714f91070b1f556a54e90da5eee3fa
Status: Downloaded newer image for httpd:latest
```
    
컨테이너를 생성한 뒤에 myweb 컨테이너에서 mongodb로 ping을 날려보면 응답이 오는 것을 확인할 수 있다. 
```
$ docker exec -t myweb ping mongodb
PING mongodb (172.17.0.2): 56 data bytes
64 bytes from 172.17.0.2: icmp_seq=0 ttl=64 time=0.102 ms
64 bytes from 172.17.0.2: icmp_seq=1 ttl=64 time=0.087 ms
64 bytes from 172.17.0.2: icmp_seq=2 ttl=64 time=0.105 ms
```
_참고로 172.17.0.2는 mongodb 컨테이너의 private ip로 재기동 시에 언제든지 변경될 수 있는 유동적인 값이다_
     
myweb 컨테이너의 hosts 파일을 보면..mongodb에 대한 정보가 기입되어 있는 것을 확인할 수 있다. (해당 값은 mongodb 컨테이너가 재기동 되면 변경되는 구조이다)
```
$ docker exec -t myweb cat /etc/hosts
127.0.0.1	localhost
::1	localhost ip6-localhost ip6-loopback
fe00::0	ip6-localnet
ff00::0	ip6-mcastprefix
ff02::1	ip6-allnodes
ff02::2	ip6-allrouters
172.17.0.2	mongodb 1263c2f75ba0
172.17.0.3	ee5a9cd786f2
```

> **Reference**  
> [Docker Network 구조(4) - container link 구조](http://bluese05.tistory.com/54)      
