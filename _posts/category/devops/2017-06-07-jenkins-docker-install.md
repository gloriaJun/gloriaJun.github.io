---
layout: post
comments: true
title: "[Jenkins] docker container로 설치하기"
date: 2017-06-07 15:05:00
categories: devops
tags: ci/cd docker jenkins
---

docker container로 Jenkins 설치하여 구축하기

#### 컨테이너 생성
```
$ docker run -d -p 8081:8080 -p 50000:50000  —name jenkins jenkins

$ docker ps -a
CONTAINER ID        IMAGE                COMMAND                  CREATED             STATUS                      PORTS                                              NAMES
f357c07d94ca        jenkins              "/bin/tini -- /usr..."   4 seconds ago       Up 3 seconds                0.0.0.0:50000->50000/tcp, 0.0.0.0:8081->8080/tcp   jenkins
```

####  Jenkins 접속 확인 및 플러그인 설치
`http://[docker machine ip]:8081`로 접속
   
초기 패스워드는 아래와 같이 확인할 수 있다
```
$ docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
2397da9a180347a68f2838f76776a9d7
```
    
접속 후에 플러그인을 설치해야하는데…”Install suggested plugins”로 설치를 진행하였음.
    
정상적으로 플러그인 설치가 완료되고 나면, 사용자 계정 생성을 위한 창이 출력된다. 사용자 계정을 생성하고 나면 아래와 같은 초기 화면이 출력되는 것을 확인할 수 있음.  
![]({{ site.url }}/assets/images/post/2017/0607-jenkins-install.png)  
