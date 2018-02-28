---
layout: post
comments: true
title: "[docker] docker command usage"
date: 2017-06-07 11:40:00
categories: server
tags: docker 
---

docker container에 대해 사용 가능한 커맨드 정리   

#### version
사용 중인 docker의 버전을 확인
```shell
$ docker version
Client:
 Version:      17.05.0-ce
 API version:  1.29
 Go version:   go1.8.1
 Git commit:   89658be
 Built:
 OS/Arch:      darwin/amd64

Server:
 Version:      17.05.0-ce
 API version:  1.29 (minimum version 1.12)
 Go version:   go1.7.5
 Git commit:   89658be
 Built:        Thu May  4 21:43:09 2017
 OS/Arch:      linux/amd64
 Experimental: false
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
Docker hub에서 이미지를 검색할 수 있다.    
```shell
$ docker search mysql
NAME                            DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
mysql                           MySQL is a widely used, open-source relati...   4398      [OK]
mysql/mysql-server              Optimized MySQL Server Docker images. Crea...   301                  [OK]
centurylink/mysql               Image containing mysql. Optimized to be li...   51                   [OK]
...
```

#### run
컨테이너를 실행
```
docker run [OPTIONS] IMAGE[:TAG|@DIGEST] [COMMAND] [ARG...]
```
   
run 에서 사용가능한 명령어 옵션들
![]({{ site.url }}/assets/images/post/2017/0607-docker-run-option.png)

#### private ip
컨테이너에 할당된 private ip 확인
{% raw %}
```
$ docker inspect -f "{{ .NetworkSettings.IPAddress }}" mongodb
172.17.0.2
```
{% endraw %}


> Reference     
> [초보를 위한 도커 안내서 - 설치하고 컨테이너 실행하기](https://subicura.com/2017/01/19/docker-guide-for-beginners-2.html)      
>   


