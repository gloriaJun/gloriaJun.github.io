---
layout: post
title: "(Docker) 명령어 정리"
date: 2017-12-22 17:19:00
author: gloria
categories: devops
tags: docker
---

## Docker 사용하기
docker의 명령은 기본적으로 `docker <command>` 형태로 이루어져있다.
자세한 사용법은 `docker --help`를 수행하면 확인이 가능하다.
```sh
$ docker --help

Usage:	docker COMMAND

A self-sufficient runtime for containers

Options:
      --config string      Location of client config files (default "/Users/gloria/.docker")
  -D, --debug              Enable debug mode
      --help               Print usage

(... 중략 ...)

Run 'docker COMMAND --help' for more information on a command.
```

#### search
Docker Hub에 공유되어있는 이미지를 검색할 수 있다.
```bash
$ docker search node
NAME                                   DESCRIPTION                                     STARS               OFFICIAL            AUTOMATED
node                                   Node.js is a JavaScript-based platform for...   4872                [OK]
mhart/alpine-node                      Minimal Node.js built on Alpine Linux           330
selenium/node-chrome                                                                   132                                     [OK]
iojs                                   io.js is an npm compatible platform origin...   124                 [OK]
```

#### pull
docker Hub에서 이미지를 다운받는다. tag를 입력하지 앟으면 최신 버전을 가져온다.
```bash
$ docker pull <이미지 이름>:<태그>
```

#### images
로컬에 다운받아 있는 모든 이미지 목록을 출력한다.
```bash
$ docker images
```

#### run
컨테이너를 생성한다. 만약, 로컬에 해당 이미지가 존재하지 않으면 Docker Hub에서 해당 이미지를 가져온 뒤에 컨테이너를 생성한다.
```bash
docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
```

#### ps
현재 생성된 컨테이너 목록을 확인한다. 기본적으로는 현재 실행 중인 컨테이너 목록을 보여주며, 모든 컨테이너를 확인하고 싶으면 -a 옵션을 추가하여 실행하면 된다.
```bash
docker ps [OPTIONS]
```

#### start
컨테이너를 기동한다.

#### restart
컨테이너를 재기동한다.

#### stop
컨테이너를 중지한다.

#### attach
현재 기동 중인 컨테이너에 접속한다.
접속한 뒤에 빠져나올 때에는 Ctrl+P, Ctrl+Q를 입력하여 빠져나온다.
```bash
$ docker attach ubuntu
```

#### exec
컨테이너 내부에 명령을 실행한다.
```bash
$ docker exec ubuntu ls
```
