---
layout: post
comments: true
title: "[docker] docker 설치하기 for Mac"
date: 2017-05-31 09:30:00
categories: server
tags: docker
---

## Docker ... ?
리눅스 컨테이너 기술을 이용해 어플리케이션 패키징, 배포를 지원하는 경량의 가상화 오픈소스 프로젝트.   
많은 사람들이 가상화 도구라고 생각하고 있으나 **docker는 패키징과 배포를 위한 도구** 라고 할 수 있다.   
docer는 호스트의 운영체제를 공유하는 방식으로 VM에 비하여 빠르고 가벼운 가상화를 제공한다.
![]({{ site.url }}/assets/images/2017/0531-docker-vs-vm.png)
    
## Docker 설치하기
Mac을 기준으로 말하면...   
Docker를 설치하는 방법은 *Docker for Mac*과 *Docker Toolbox*를 이용해서 설치하는 두 가지 방법이 있다.   
그 두 가지 방법의 가장 큰 차이점은 사용하는 가상머신이 다르다는 것으로 아래와 같다.   
* Docker for Mac - HyperKit이라는 macOS를 위한 경량화 가상머신을 사용   
(이 부분은 내가 느낀 바로는 리눅스 환경에 docker를 설치한 것과 같이 native로 사용할 수 있게 해주는 것 같았다.)      
* Docker Toolbox - VirtualBox를 사용

어떠한 방식으로 설치하여 사용할 지는 사용자의 몫이지만...나는 `Docker Toolbox`를 이용하여 설치를 하기로 하였다.   

#### install docker on Mac with *Docker Toolbox*
mac 환경에서 homebrew를 이용한 도커 설치 방법 정리

###### virtualbox 설치하기
만약 virtualbox가 설치되어 있다면 해당 과정은 skip해도 된다.
인터넷을 검색하면 *brew cask* 사용을 위해 별도 설치해야 한다고 하는 데...
아래의 명령만 수행해도 내 경험에서는 cask가 없으니 설치를 먼저 진행하고 virtualbox 설치가 진행되었다.
```shell
$ brew cask install virtualbox

==> Tapping caskroom/cask
Cloning into '/usr/local/Homebrew/Library/Taps/caskroom/homebrew-cask'...
remote: Counting objects: 3716, done.
remote: Compressing objects: 100% (3701/3701), done.
remote: Total 3716 (delta 36), reused 369 (delta 11), pack-reused 0
Receiving objects: 100% (3716/3716), 1.24 MiB | 361.00 KiB/s, done.
Resolving deltas: 100% (36/36), done.
Tapped 0 formulae (3,725 files, 3.9MB)
==> Creating Caskroom at /usr/local/Caskroom
==> We'll set permissions properly so we won't need sudo in the future
Password:
==> Downloading http://download.virtualbox.org/virtualbox/5.1.18/VirtualBox-5.1.
######################################################################## 100.0%
==> Verifying checksum for Cask virtualbox
==> Running installer for virtualbox; your password may be necessary.
==> Package installers may write to any location; options such as --appdir are i
==> installer: Package name is Oracle VM VirtualBox
==> installer: Upgrading at base path /
==> installer: The upgrade was successful.
🍺  virtualbox was successfully installed!
```

###### docker 설치
```shell
$ brew install docker docker-compose docker-machine
```

설치한 것들 버전 확인하는 방법
```shell
$ docker --version
Docker version 17.03.0-ce, build 60ccb22
$ docker-compose --version
docker-macdocker-compose version 1.11.2, build unknown
$ docker-machine  --version
docker-machine version 0.10.0, build 76ed2a6
```

###### docker-machine을 이용하여 가상머신 생성하기
docker 이미지로부터 컨테이너를 생성하기 위해서는 리눅스 기반의 가상머신이 필요하다.
docker-machine을 이용하여 virtualbox를 사용한 가상머신을 생성한다.
```shell
$ docker-machine create --driver virtualbox docker-vm
```
위의 명령어는 driver로 virtualbox를 이용하여 docker-vm이라는 이름을 가진 가상머신을 생성하겠다라는 명령어이다.
driver로는 virtualbox, aws 등..을 지원하고 있다고 한다.

정상적으로 명령이 수행되었다면 virtualbox를 통해서도 이미지가 생성된 것을 확인할 수 있다.
![]({{ site.url }}/assets/images/post/2017/0531-docker-vm.png)

그리고 또한 아래와 같이 docker-machine 명령어를 통해서도 확인이 가능하다.
```shell
$ docker-machine status docker-vm
Running

$ docker-machine ls
NAME        ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER        ERRORS
docker-vm   -        virtualbox   Running   tcp://192.168.99.100:2376           v17.03.0-ce
```

###### docker cli 사용을 위해 환경변수 가져오기
cli를 이용한 명령 수행을 위해 가상머신의 환경변수를 가져오기 위해서는 아래와 같이 수행한다
```shell
$ eval "$(docker-machine env docker-vm)"
```

별도로 해당 명령어를 수행해보면 반영된 환경변수들을 확인할 수 있다.
```shell
$ docker-machine env docker-vm
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.99.100:2376"
export DOCKER_CERT_PATH="/Users/hyena/.docker/machine/machines/docker-vm"
export DOCKER_MACHINE_NAME="docker-vm"
# Run this command to configure your shell:
# eval $(docker-machine env docker-vm)
```

###### docker container 실행 (hello world)
간단하게 hello-world 컨테이너를 내려받고 실행해봄으로써 정상적으로 docker 환경구성이 완료되었는 지를 확인할 수 있다.
```shell
$ docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
78445dd45222: Pull complete
Digest: sha256:c5515758d4c5e1e838e9cd307f6c6a0d620b5e07e6f927b07d05f6d12a1ac8d7
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://cloud.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/engine/userguide/
```
해당 명령을 수행해보면...
* hello-world 이미지를 Pulling 해오고 (로컬로 가져오고)
* 해당 이미지를 이용하여 컨테이너를 실행
한 것을 확인할 수 있다.

해당 명령을 수행한 후에 *docker images* 명령어를 수행하여 hello-world 이미지가 로컬에 다운받아졌음을 알수 있고, ps 명령어를 이용하여 정상적으로 컨테이너가 실행이 되고 종료되었음을 알 수 있다.
```shell
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
hello-world         latest              48b5124b2768        2 months ago        1.84 kB

$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                     PORTS               NAMES
aadc1e1fd9b9        hello-world         "/hello"            2 minutes ago       Exited (0) 2 minutes ago                       upbeat_curran
```
   

> Reference   
> [Mac OS X에서 docker 설치하기(시작하기)](http://blog.saltfactory.net/upgrade-latest-docker-using-with-homebrew/)   
> [Docker 간편한 설치부터 실행까지](http://swalloow.github.io/docker-install)