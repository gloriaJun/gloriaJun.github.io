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

#### info
현재 운영 중인 컨테이너와 상태 정보를 볼 수 있음.
정상적으로 도커가 기동된 상태가 아니면 해당 명령어를 수행했을 때 에러가 발생함.
```shell
$ docker info
Containers: 1
 Running: 0
 Paused: 0
 Stopped: 1
Images: 1
Server Version: 17.05.0-ce
Storage Driver: aufs
 Root Dir: /mnt/sda1/var/lib/docker/aufs
 Backing Filesystem: extfs
 Dirs: 9
 Dirperm1 Supported: true
Logging Driver: json-file
Cgroup Driver: cgroupfs
Plugins:
 Volume: local
 Network: bridge host macvlan null overlay
Swarm: inactive
Runtimes: runc
Default Runtime: runc
Init Binary: docker-init
containerd version: 9048e5e50717ea4497b757314bad98ea3763c145
runc version: 9c2d8d184e5da67c95d601382adf14862e4f2228
init version: 949e6fa
Security Options:
 seccomp
  Profile: default
Kernel Version: 4.4.66-boot2docker
Operating System: Boot2Docker 17.05.0-ce (TCL 7.2); HEAD : 5ed2840 - Fri May  5 21:04:09 UTC 2017
OSType: linux
Architecture: x86_64
CPUs: 1
Total Memory: 995.8MiB
Name: docker-vm
ID: YMHG:JI62:NG2F:MWC7:7LLC:MC4V:4TL2:UOMF:GMCL:XMD7:L3EQ:5R76
Docker Root Dir: /mnt/sda1/var/lib/docker
Debug Mode (client): false
Debug Mode (server): true
 File Descriptors: 15
 Goroutines: 23
 System Time: 2017-06-01T02:38:41.470100151Z
 EventsListeners: 0
Registry: https://index.docker.io/v1/
Labels:
 provider=virtualbox
Experimental: false
Insecure Registries:
 127.0.0.0/8
Live Restore Enabled: false
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

#### private ip
컨테이너에 할당된 private ip 확인
{% raw %}
```
$ docker inspect -f "{{ .NetworkSettings.IPAddress }}" mongodb
172.17.0.2
```
{% endraw %}


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

## Reference     
- [초보를 위한 도커 안내서 - 설치하고 컨테이너 실행하기](https://subicura.com/2017/01/19/docker-guide-for-beginners-2.html)      
