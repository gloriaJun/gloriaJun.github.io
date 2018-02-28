## 강의 전 사전 준비 사항
#### install docker
mac 환경인 경우..
[Docker CE for Mac](https://store.docker.com/editions/community/docker-ce-desktop-mac)을 설치한다.
* 이미지를 하나밖에 못만듬.
만약, 하나 이상의 이미지를 사용하고 싶으면 virtual box를 이용하여 설치한 뒤에 toolbox를 이용하여 설치해야한다.

#### 설치 확인
docker 호스트 서버 상제 정보를 확인한다
```
$ docker version
```

호스트 서버 상세정보를 확인한다.
```
$ docker info
```

hello-world를 docker로 실행해서 정상적으로 설치가 완료되었는 지 확인한다.
```
$ docker run hello-world
```


* docker for mac/windows로 설치하는 경우에는 리눅스 환경에 docker를 설치한 것과 같이 native로 사용할 수 있게 해준다.
그러므로 docker-machine 명령어를 이용하여 별도의 가상머신(host)을 설치할 필요가 없는거다.
즉, 로컬 컴퓨터를 host라고 생각하고 사용하면 된다.
그러므로 별도로 로컬에 ip 설정이나 사용할 디렉토리의 위치등을 도커 환경설정 창을 이용하여  설정해주어야 한다.

---
# my adding
docekr for mac을 설치하니...강의 중에 docker-machine에 대한 명령을 실습해볼 수가 없었다.
그리고 강의 자료가 대부분 docker-machine을 이용한 가상머신에 컨테이너를 설치하는 방식으로 진행이 되다보니 바로 바로 내 환경에 매칭하여 이해하기가 어려운 면도...
(그러다보니 오늘처럼 강의한 후에 docker에 대해 좀 더 검색하고나서 docker for mac의 경우 리눅스 환경과 같이 native 처럼 사용할 수 있게 해주어 내 로컬이 docker-machine이라고 생각해야하는 거구나...라고 이해한..ㅠㅠ)
그래서..결국 설치한 docker for mac을 삭제하고 toolbox를 이용해 설치하기로....에효~~

난 실습을 위해 이렇게 했지만...
docker에서 권장하는 방법은 'docker for mac/windows'를 이용하여 설치하여 운영하는 것이다.
그게 좀 더 가볍고 리소르를 덜 사용한다고 하는 듯하다.


---
# install docker on Mac with toolbㅠox

mac 환경에서 homebrew를 이용한 도커 설치..

## virtualbox 설치하기
만약 virtualbox가 설치되어 있다면 해당 과정은 skip해도 된다.
인터넷을 검색하면 *brew cask* 사용을 위해 별도 설치해야 한다고 하는 데...
아래의 명령만 수행해도 내 경험에서는 cask가 없으니 설치를 먼저 진행하고 virtualbox 설치가 진행되었다.
```
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

## docker 설치
```
$ brew install docker docker-compose docker-machine
```

설치한 것들 버전 확인하는 방법
```
$ docker --version
Docker version 17.03.0-ce, build 60ccb22
$ docker-compose --version
docker-macdocker-compose version 1.11.2, build unknown
$ docker-machine  --version
docker-machine version 0.10.0, build 76ed2a6
```

# docker-machine을 이용하여 가상머신 생성하기
docker 이미지로부터 컨테이너를 생성하기 위해서는 리눅스 기반의 가상머신이 필요하다.
docker-machine을 이용하여 virtualbox를 사용한 가상머신을 생성한다.
```
$ docker-machine create --driver virtualbox docker-vm
```
위의 명령어는 driver로 virtualbox를 이용하여 docker-vm이라는 이름을 가진 가상머신을 생성하겠다라는 명령어이다.
driver로는 virtualbox, aws 등..을 지원하고 있다고 한다.

정상적으로 명령이 수행되었다면 virtualbox를 통해서도 이미지가 생성된 것을 확인할 수 있다.
![virtual](./img/docker-vm.png)

그리고 또한 아래와 같이 docker-machine 명령어를 통해서도 확인이 가능하다.
```
$ docker-machine status docker-vm
Running

$ docker-machine ls
NAME        ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER        ERRORS
docker-vm   -        virtualbox   Running   tcp://192.168.99.100:2376           v17.03.0-ce
```

## docker cli 사용을 위해 환경변수 가져오기
cli를 이용한 명령 수행을 위해 가상머신의 환경변수를 가져오기 위해서는 아래와 같이 수행한다
```
$ eval "$(docker-machine env docker-vm)"
```

별도로 해당 명령어를 수행해보면 반영된 환경변수들을 확인할 수 있다.
```
$ docker-machine env docker-vm
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.99.100:2376"
export DOCKER_CERT_PATH="/Users/hyena/.docker/machine/machines/docker-vm"
export DOCKER_MACHINE_NAME="docker-vm"
# Run this command to configure your shell:
# eval $(docker-machine env docker-vm)
```

## docker container 실행 (hello world)
간단하게 hello-world 컨테이너를 내려받고 실행해봄으로써 정상적으로 docker 환경구성이 완료되었는 지를 확인할 수 있다.
```
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
```
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
hello-world         latest              48b5124b2768        2 months ago        1.84 kB

$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                     PORTS               NAMES
aadc1e1fd9b9        hello-world         "/hello"            2 minutes ago       Exited (0) 2 minutes ago                       upbeat_curran
```
