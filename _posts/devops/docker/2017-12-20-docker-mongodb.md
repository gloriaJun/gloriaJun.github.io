---
layout: post
title: "(Docker) mongodb 설치하기"
date: 2017-12-20 15:01:00
author: gloria
categories: devops
tags: docker mongodb dockerfile
---

## docker 명령어를 이용한 설치
"-v" 옵션을 주어서 volume 바인딩을 하여 데이터베이스 파일을 컨테이너 내부가 아닌 호스트에 저장하도록 하였음.
```bash
mkdir /Volumes/data/docker/db/mongodb
docker run -d -p 27017:27017 -v /Volumes/data/docker/db/mongodb:/data/db --name mongodb mongo
```

## docker-compose를 이용한 설치
docker 명령어와 동일한 조건으로 docker-compose를 이용하여 설치하기 위해 yaml 파일을 생성하고 설치하기
```bash
version: '3'

services:
  mongodb:
    image: mongo:latest
    container_name: "mongodb"
    environment:
      - MONGO_DATA_DIR=/data/db
      - MONGO_LOG_DIR=/dev/null
    ports:
      - 27017:27017
    volumes:
      - /Volumes/data/docker/db/mongodb/:/data/db
```

yaml 파일명을 "docker-compose.yml"로 생성한 경우에는 간단하게 "docker-compose up -d"로 설치를 진행하면 된다.

하지만, default 이름이 아닌 custom 이름으로 생성한 경우에는  "-f" 옵션을 이용하여 설치를 진행하면 된다.
```bash
docker-compose -f
docker-compose-mongodb.yml up -d
```

## 나만의 Dockerfile 만들어서 설치하기
docker 이미지를 만들고 설치 그리고 git 저장소와 dockerhub에 등록해서 이미지를 내려받아 컨테이너 설치해보기.

ubuntu 16.04를 기준으로 하여 mongodb 설치를 위한 이미지 파일을 아래와 같이 생성하였음.

(mongodb 설치 관련 참고한 내용 : https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-mongodb-on-ubuntu-16-04)

```bash
#### Installation mongodb with auth and create user database
FROM ubuntu:16.04

# Import the public key used by the package management system
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

# Create a list file for MongoDB
RUN echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list

# update local package database
RUN apt-get update

# Install the latest stable version of MongoDB
RUN apt-get install -y mongodb-org

# create database folder
VOLUME ["/data/db"]

# excute mongodb
CMD ["mongod"]

# expose ports
#   - 27017: process
#   - 28017: http
EXPOSE 27017
EXPOSE 28017
```

위와 같이 생성한 뒤에 빌드 및 컨테이너를 생성하여 정상적으로 동작하는 지 확인
(외부 mongodb 접속 클라이언트를 이용하거나 컨테이너 내부에 접속하여 mongodb 동작 확인)
```bash
$ docker build -t test .
$ docker run -d -p 27017:27017 --name mongo test
```

#### docker 이미지 공유하기
두 가지 방법이 있는데 git 레파지토리를 이용해서 공유하는 방법을 실습해보았음
- docker push로 docker hub에 등록
- Dockerfile을 git 레파지토리와 연동

###### github에 docker 이미지 등록
github에 repository를 생성하여 Dockerfile을 업로드한다.

###### docker hub와 github 연동
[Docker Hub](https://hub.docker.com)에 접속해서 `Creat -> Create Automated Build` 매뉴를 선택한 뒤에 github 계정 정보를 입력하여 연동한다.

Docker 이미지가 저장된 레파지토리를 선택하여 생성한 뒤에 `Build Settings` 매뉴를 선택하여 `Trigger` 버튼을 누른 뒤 `Build Details` 매뉴에 들어가면 잠시 뒤 이미지 파일을 빌드가 진행되는 것을 확인할 수 있다.

###### 빌드된 이미지 다운
아래와 같은 명령어를 이용하여 이미지를 다운받을 수 있다.
```bash
docker pull gloriajun/my-mongo
```

## 참고글
- http://www.marshalling.net/yard/wordpress/?p=99
- https://novemberde.github.io/2017/04/02/Docker_8.html
