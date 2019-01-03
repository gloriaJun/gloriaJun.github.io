---
layout: post
title: "(Docker) Container 관리"
date: 2017-11-09 17:19:00
author: gloria
categories: devops
tags: docker
---

* TOC
{:toc}

# container 조회

* docker에 만들어진 모든 컨테이너를 확인할 수 있다.

```bash
$ docker ps -a
CONTAINER ID        IMAGE                COMMAND                  CREATED             STATUS                  PORTS               NAMES
f2e7af803f3a        gloriajun/my-mongo   "docker-entrypoint.s…"   5 days ago          Exited (0) 5 days ago                       mongodb
```

# conatainer 시작/종료

```bash
# start
$ docker start <container name | container id>

# stop
$ docker stop <container name | container id>
```

# 재시작 옵션 변경

```bash
# restart on
$ docker update --restart=always crowd
crowd

# restart off
$ docker update --restart=no crowd
crowd
```
