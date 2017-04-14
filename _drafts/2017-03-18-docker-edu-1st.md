# Docker 교육 in 패캠 - 2017.03.18
- - - -
layout: post
title: [패캠] Docker 기반의 DevOps 인프라 구축 Workshop 1일차
date: 2017-03-18 20:00:00
categories: Docker
tags: docker 
- - - -
_패스트캠프에서 강의한 ‘Docker 기반의 DevOps 인프라 구축 Workshop’ 이란 주제 강의 내용에 대한 정리_

## 교육 전 사전 준비 사항
강의 시간에 실습을 위해 사용할 노트북에 docker 설치해두기.

## 처음 배우는 도커
### What is Docker ?
리눅스 컨테이너 기술을 이용해 어플리케이션 패키징, 배포를 지원하는 경량의 가상화 오픈소스 프로젝트임.
docker의 엔진은 go언어로 개발되었으나, 그 외는 다양한 기술을 통하여 만들어졌다고함.
많은 사람들이 가상화 도구라고 생각하고 있으나 **docker는 패키징과 배포를 위한 도구** 라고 한다.

##### 도커의 시작
도커를 발표할 당시(2013년)에 아래의 명령어를 수행하여 데모를 보여줌으로써 세상에 알려지기 시작했다고….
```
$ docker run busybox echo 'Hello World'
```
해당 명령어가 수행되는 과정은…다음과 같음.
1. 도커 명령어가 실행된 로컬에서 이미지를 확인하고 없으면, dokerhub에서 다운로드
2. busybox 이미지로 새로운 컨테이너를 생성
3. 컨테이너 시행
4. TTY로 'Hello World' 출력
5. 출력된 결과를 유닉스 소켓을 통해 클라이언트로 전송

##### 도커의 특징
![]({{ site.url }}/assets/images/docker/2017/03-facam-edu/docker-feature.png)










