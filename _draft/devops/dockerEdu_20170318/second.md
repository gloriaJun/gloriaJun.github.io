# Docker 교육 in 패캠 - 2017.03.25
강의내용 링크 : [패스트캠퍼스 Devops With Docker  2일차 강의자료  |authorSTREAM](http://www.authorstream.com/Presentation/%EC%83%81%EC%B2%A0432508-3085668-devops-docker/)

## 데이터 컨테이너
특정 디렉토리를 공유하는 데이터 컨테이너를 생성
```shell
$ docker run --name mydata -v /data/app1 busybox true
```

## Docker Compose
어플리케이션을 만들기 위한 서비스를 정의하는 yaml 파일.
* 설정파일을 생성 시에는 tab을 사용하지 않음. (space를 활용)
* 로그보기
특정 로그를 보고 싶을 때는 `-f [alias]`와 같이 보면 된다.

* 생성한 설정파일을 가상머신에는 올릴 필요가 없다.
* 

## Docker 프로젝트 환경
#### Docker Hub & Registry
###### Docker Hub
* 도커 허브 계정 필요 : https://hub.docker.com
* 이미지당 레파지토리가 하나임.

1. 도커 이미지를 올리기 위한 레파지토리를 생성
2. 터미널에서 로그인
```shell
$ docker login
--> 도커 허브에 생성한 자신의 계정 정보 입력하여 로그인
```

3. 도커파일을 가지고 이미지를 생성
```
$ docker build -t docker-whale .

$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
docker-whale        latest              b09838e42d98        16 seconds ago      275 MB
hello-world         latest              48b5124b2768        2 months ago        1.84 kB
docker/whalesay     latest              6b362a9f73eb        22 months ago       247 MB
```

4. 이미지에 repo 정보를 태그한다.
```
$ docker tag b09838e42d98 gloriajun/docker-whale:latest

$ docker images
REPOSITORY                  TAG                 IMAGE ID            CREATED              SIZE
docker-whale                latest              b09838e42d98        About a minute ago   275 MB
gloriajun/docker-whale   latest              b09838e42d98        About a minute ago   275 MB
hello-world                 latest              48b5124b2768        2 months ago         1.84 kB
docker/whalesay             latest              6b362a9f73eb        22 months ago        247 MB
```
이미지를 태깅하면 내 로컬에 방금 생성한 이미지에 대한 레파지토리 정보가 생성된다.

5. 이미지를 repo에 올린다.
```
$ docker push gloriajun/docker-whale:latest
The push refers to a repository [docker.io/gloriajun/docker-whale]
```

6. 도커허브 사이트에 접속해서 보면 방금 올린 이미지를 확인할 수 있다.
https://hub.docker.com/r/gloriajun/docker-whale/tags/

###### Docker Registry
도커 이미지를 저장하고 공유할 수 있는 서버
현재는 v1 은 사용하지 않음. 

* 레지스트리 컨테이너 실행
: 5000번이 기본포트
```
$ docker run -d -p 5000:5000 --name myregistry registry:2

$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
ccc0e9012883        registry:2          "/entrypoint.sh /e..."   46 seconds ago      Up 46 seconds       0.0.0.0:5000->5000/tcp   myregistry
```

* docker hub에 push 한 것과 같이 private registry를 생성하였다 가정하고, 이미지를 해당 registry에 등록하기 위해서..
이미지에 repo tag를 한다.
```
$ docker-machine ls
NAME        ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER        ERRORS
default     -        virtualbox   Stopped                                       Unknown
docker-vm   *        virtualbox   Running   tcp://192.168.99.101:2376           v17.03.0-ce
[hyena@hyenaui-MacBook-Pro:~/Documents/study/dockerEdu_20170318/docker-image]$ docker images
REPOSITORY               TAG                 IMAGE ID            CREATED             SIZE
docker-whale             latest              b09838e42d98        11 minutes ago      275 MB
gloriajun/docker-whale   latest              b09838e42d98        11 minutes ago      275 MB
registry                 2                   047218491f8c        3 weeks ago         33.2 MB
hello-world              latest              48b5124b2768        2 months ago        1.84 kB
docker/whalesay          latest              6b362a9f73eb        22 months ago       247 MB
$ docker tag b09838e42d98 192.168.99.101:2376/docker-wahile:latest

$ docker images
REPOSITORY                          TAG                 IMAGE ID            CREATED             SIZE
192.168.99.101:2376/docker-wahile   latest              b09838e42d98        12 minutes ago      275 MB
```

* 이미지를 레지스트리 서버에 push 한다.
```
$ docker push 192.168.99.101:5000/docker-wahile:latest
The push refers to a repository [192.168.99.101:5000/docker-wahile]
An image does not exist locally with the tag: 192.168.99.101:5000/docker-wahile
```

* 이미지를 가져오기
```
$ docker pull 192.168.99.101:5000/docker-wahile:latest
Error response from daemon: Get https://192.168.99.101:5000/v1/_ping: http: server gave HTTP response to HTTPS client
```
-> 위와 같은 에러가 발생하는 것은 docker는 기본적으로 https를 사용하여 통신하도록 되어있어서 에러가 발생하는 부분이다.
해당 부분을 해결하기 위해서는 인증과 관련된 옵션을 끄거나 https 인증서를 넣어줘야한다.

###### 레지스트리 사용시 
* 레지스트리 사용은 조심해서 사용해야한다.
* 인증서를 적용도 당연히 해야함.
* 레지스트리 저장 시에는 host 위치로 바인딩하여 컨테이너 내부가 아닌 곳에 저장해야한다.

###### 레지스트리 사용하여 구축 시의 팁
* 네이밍 기준 
: 루트, repo명을 어떻게 가져가는 지가 중요.
사용하는 곳이 한 곳이 생기면 변경하려고 하여도 변경하기가 힘들어짐.
이미지는 기하급수적으로 늘어날 수 있음.
* 이미지데이터 관리 
: 이미지를 생성하다보면 금방 늘어남. gc 필요.
* 성능 이슈
: 이미지를 pull, push 하는데 시간이 오래 걸림.
해결 방법 : 이미지를 다이제스트 해야함. 
이미지를 당겨오는 서버를 토렌트와 같이 분산시켜놓음. (페북의 사례)
 도커 저장소를 공유디스크로 만들어버림. 대신 동시에 당기면..락이 걸리는 이슈가 있음…
등과 같은 여러 방법이 있음. 

## 개발 환경 구성
https://github.com/marcelbirkner/docker-ci-tool-stack

1. ci 환경 구성을 위한 가상머신을 생성
```
$ docker-machine create -d virtualbox docker-ci
$ eval $(docker-machine env docker-ci)
```

2. 편의를 위해 GitHub repo 연결
```
$ git clone https://github.com/marcelbirkner/docker-ci-tool-stack.git
```

3.  tool-stack 실행
```
$ cd docker-ci-tool-stack
$ docker-compose up -d
```

> Tip) git에 환경 구성을 위한 도커파일을 관리하기 위한 레파지토리를 생성해서 관리하면 매우 편함.  

4. 

###### GitLab
이슈관리, 코드리뷰, ci/cd를 지원하는 통합 개발환경 서버

* gitlab 컨테이너 생성
```
$ docker run --detach \
   --hostname gitlab.example.com \
   --publish 443:443 --publish 80:80 --publish 22:22 \
   --name gitlab \
   --restart always \
   --volume /srv/gitlab/config:/etc/gitlab \
   --volume /srv/gitlab/logs:/var/log/gitlab \
   --volume /srv/gitlab/data:/var/opt/gitlab \
   gitlab/gitlab-ce:latest
```

###### Yona
프로젝트 단위로 형상관리, 이슈관리, 코드리뷰, 게시판을 지원하는 협업개발 플랫폼

```
docker run -d \
   --publish 9000:9000 \
   --name yona \
   --restart always \
   yongseoklee/docker-yona:latest
```

http://192.168.99.101:9000/

###### gogs
go로 개발된 git 서비스. 가볍고 빠름
만약, git repo만 필요하면 gogs를 사용해도 나쁘지 않다.

```
# data 컨테이너 생성
$ docker run --name=gogs-data --entrypoint /bin/true gogs/gogs

# gogs 컨테이너 생성
$ docker run -d --name=gogs --volumes-from gogs-data -p 10022:22 -p 3000:3000 gogs/gogs
```
[Gogs](http://192.168.99.101:3000)
실제로 사용하려면 데이터베이스를 설치해서 연동해주어야함.

###### Nexus
다양한 형식의 컴포넌트 레파지터리 매니저
무거운 편임. 
사내 전용 레파지터리 구축을 해서 nexus를 이용하여 공유가 가능하다.

###### nGrinder
서버에 대한 성능 테스트를 위한 오픈소스. 성능테스트를 위한 웹 ui를 제공한다.
agent와 controller가 필요.
agent를 docker를 사용하여 필요한 만큼 생성하여 사용이 가능함.
_(강사님이 적극 추천하시는 듯)_

```
$ docker run -d -v ~/.ngrinder:/root/.ngrinder -p 80:80 -p 16001:16001 -p 12000-12009:12000-12009 ngrinder/controller:3.3
```

> 환경을 구성하다가 로컬 설정을 반영하려면??  
> - 볼륨바인딩을 이용하여 설정파일을 물려서 컨테이너를 실행해주면된다.  


## Docker CI 환경 구성
### GitHub & DockerHub를 이용한 자동빌드 환경 구성
> 준비물  
> - GitHub 계정  
> - docker hub 계정  

1. github에 이미지 업로드를 위한 레파지토리 생성
2. dockerhub에서 create auto build 선택
3. dockerhub에서 GitHub 연결
4. 빌드 트리거 실행

### junkins & docker
* 도커 이미지를 빌드_테스트_배포하는데 Jenkins를 활용
* junkins master&slave를 도커로 실행한다.

### Docker in Docker
도커는 나름의 셋탑박스 모델을 가지고 있음.
도커명령어는 루트 권한을 가지고 있음.

도커 컨테이너를 띄우고 컨테이너 내부에서 도커 명령어를 실행하게 하는 것 -> Docker in Docker
내부적으로 특정 컨테이너가 소켓 파일에 대하여 접근할 수 있게…해주면 가능.

1. Docker 이미지 빌드용 젠킨스 컨테이너 실행
```
$ docker run -d --name jenkins -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock k16wire/docker-jenkins
```
-> docker.sock을 컨테이너 내부에 볼륨바인딩을 이용하여 넣어줌 (소켓 파일에 접근할 수 있게 하는 권한을 부여)

2. 젠킨스 암호 입력
```
$ docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
48a8d402caf445a6846f3cd68c9f7a8d
```
-> exec : 도커를 멈추지 않고 컨테이너에 먼가 명령을 주고 싶을때?
컨테이너 내부의 파일을 가져온다던가…실행한다던가 등의 명령이 가능함.
detach로 접속하여 사용도 가능하나..빠져나올 때 컨테니어가 죽는 경우도 생길 수 있음.

3. 젠킨스 콘솔 접속
젠킨스 job을 이용하여 도커 플러그인을 설치해서 할 수도 있고.
젠킨스 job을 이용하여 콘솔에서 커맨드로도 날릴 수 있음.

### junkins master&slave
Ssh 플러그인 설치 필요.
클라우드 영역 설정 필요 ex) kube, docker …
Job 정의 -> 클라우드 빌드 job으로 생성해야함.

## Docker 멀티 호스트 구성
### Docker 볼륨과 네트워킹
. 도커 볼륨이라는 것이 별도로 있음. (-v 옵션에 해당)
. 볼륨을 바인딩하게 되면 호스트에 다이렉트로 쓰는 형태로 뜨게 되어, 컨테이너 내부에 쓰는 것보다 I/o 성능이 향상해진다고 함.

##### 볼륨 관리 유형
###### 컨테이너 내부에 저장 
컨테이너와 생사를 같이 한다면…내부 저장. 컨테이너 삭제 시에 같이 데이타도 삭제되어야한다면….

###### 도커 ufs에 저장 
데이타 컨테이너로 생성하는 것. 도커 데몬이 살아있는 동안에 유지되어야하는 데이타라면…

###### 도커 호스트 파일 볼륨 마운트 
가장 많이 사용되고..가장 일반적인 케이스라고..

###### volume-driver를 이용해 네트워크로 연결된 장치에 저장 
. public cloud를 왠만한 것을 지원하여 사용 가능하다고..
. 멀티 호스트 구성에서는 외부 스토리지를 이용하여 구성하는 것을 고민해볼만함

##### 실습
```
$ docker volume create --name test1
test1
[hyena@hyenaui-MacBook-Pro:~]$ docker volume ls
DRIVER              VOLUME NAME
local               00d5dd01b760f60fcca05e82a4511162d6ebf800e626175a0991dc4b58d50b5f
local               190e82f35eff811849849f193b65b61829d217e1225779162b0652f825ac473c
local               7318ff9df3b1bb31b63efd3581627972ba770e6f039d0059d692df0501d98226
local               883bbdb656f77d7365aa2202b8435b768872c0f87698077bdfae7d84fd39c504
local               b242e6f33e01d01dcd52009d9881de79d738e75493083a41d83d4dc46d0cbb67
local               test1
```

볼륨을 조회하면 내가 만들지 않은 것들도 확인된다. 이것들은 컨테이너 생성 시에 자동으로 생성된 볼륨이다.

아래와 같이 생성한 볼륨을 이용하여 컨테이너를 생성할 수 있음.
```
$ docker run -it -v test1:/www/test1 ubuntu:14.04 bash
```

### 컨테이너 네트워킹
컨테이너 생성 시에 아이피를 지정하여 생성 가능.

호스트에 대한 네트워크 정보
```
$ docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
427b55cb838e        bridge              bridge              local
f6e0bf3f5f71        host                host                local
1490cef3176b        none                null                local
```
bridge가 호스트 임.

bridge에 대해 확인해보면….docker0인 것을 확인할 수 있음.
```
$ docker network inspect bridge
[
    {
        "Name": "bridge",
        "Id": "427b55cb838e48b2ac0d3d100cd6c3ebbef8075c025fe1f6a6e400ff175b4226",
        "Created": "2017-03-25T07:27:25.02112409Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16",
                    "Gateway": "172.17.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Containers": {},
        "Options": {
            "com.docker.network.bridge.default_bridge": "true",
            "com.docker.network.bridge.enable_icc": "true",
            "com.docker.network.bridge.enable_ip_masquerade": "true",
            "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
            "com.docker.network.bridge.name": "docker0",
            "com.docker.network.driver.mtu": "1500"
        },
        "Labels": {}
    }
]
```


Bridge 네트워크가 싱글 호스트. (docker0와 같은 네트워크)
컨테이너는 동일 호스트 내에 위치해야함.
컨테이너 간에 통신이 가능했던 것이 동일 호스트 내에 있었기 때문에 가능하다고..

###### 브리지 네트워크 만들기 실습
. 싱글 호스트 내에서 하는 것임.

1. 네트워크 생성
```
[hyena@hyenaui-MacBook-Pro:~]$ docker network create red
ad5651b59cc2c93747b85c1fb24a5d8df29d33de30449c478aedc8e543077bd4
[hyena@hyenaui-MacBook-Pro:~]$ docker network create blue
a65de9cd906c1a697a9fcf308167f46f24ab529ec5dfaf5db2dd83fcb1a63f36
```

2. 컨테이너 생성
```
$ docker run -itd --net=red --name ubuntu1 ubuntu
$ docker run -itd --net=red --name ubuntu2 ubuntu
```

```
$ docker run -itd --net=blue --name ubuntu3 ubuntu
```

* ubuntu4는 아래와 같이 설치해서..
```
$ docker run -it --net=blue --name ubuntu4 ubuntu
```

ubuntu4에서 ping 을 테스트하면 같은 네트워크에 있는 곳에만 응답이 오는 것을 확인할 수 있음.
```
root@847614d8d6fc:/# ping ubuntu3
PING ubuntu3 (172.19.0.2): 56 data bytes
64 bytes from 172.19.0.2: icmp_seq=0 ttl=64 time=0.085 ms
64 bytes from 172.19.0.2: icmp_seq=1 ttl=64 time=0.075 ms
^C--- ubuntu3 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max/stddev = 0.075/0.080/0.085/0.000 ms
root@847614d8d6fc:/# ping ubuntu1
ping: unknown host
```

### overlay network
* 멀티 호스트 간의 네트워크 구성하는 것.
* 네트워크 요건
. 두개의 저장소를 연결해주는 것이 필요.
-> key-value 스토어 : consul, Etc, zookeeper

###### consul 머신 환경 구성
```
# 머신 생성
$ docker-machine create -d virtualbox mhl-consul
$ eval $(docker-machine env mhl-consul)

# 컨테이너 생성
$ docker $(docker-machine config mhl-consul) run -d -p 8500:8500 -h consul progrium/consul -server -bootstrap
```
-bootstrap : consul의 옵션임.

###### demo1, demo2  머신 생성
기본적인 방법으로 생성하면..생성 후 접속해서 설정 파일들을 변경하여 consul  클러스터 관련해서 설정해주어야하므로 머신 생성 시에 옵션을 주어 생성해야한다.
```
$ docker-machine create \
-d virtualbox \
--engine-opt="cluster-store=consul://$(docker-machine ip mhl-consul):8500" \
--engine-opt="cluster-advertise=eth1:0" \
mhl-demo1

$ docker-machine create \
-d virtualbox \
--engine-opt="cluster-store=consul://$(docker-machine ip mhl-consul):8500" \
--engine-opt="cluster-advertise=eth1:0" \
mhl-demo2
```

Overlay network를 추가한다.
demo1이던 demo2던 어디서 overlay network를 추가하면 두군데서 동일하게 보여야 한다.
```
$ docker $(docker-machine config mhl-demo1) network ls
NETWORK ID          NAME                DRIVER              SCOPE
c744a08984e7        bridge              bridge              local
6812da1b5466        host                host                local
ed451848097c        none                null                local

$ docker $(docker-machine config mhl-demo1) network create -d overlay frontend
01829d34c466d61fe6934092ed8262d6b8c210933cb652eb2d454a212fe227ee

$ docker $(docker-machine config mhl-demo1) network ls
NETWORK ID          NAME                DRIVER              SCOPE
c744a08984e7        bridge              bridge              local
01829d34c466        frontend            overlay             global
6812da1b5466        host                host                local
ed451848097c        none                null                local
$ docker $(docker-machine config mhl-demo2) network ls
NETWORK ID          NAME                DRIVER              SCOPE
f52365faf1ac        bridge              bridge              local
01829d34c466        frontend            overlay             global
fc6ddba6157b        host                host                local
b722f9057dab        none                null                local
```

###### 각각의 머신에 컨테이너를 생성하고 서로 통신하게 하기
```
$ docker $(docker-machine config mhl-demo1) run -itd --name=web --net=frontend nginx

$ docker $(docker-machine config mhl-demo2) run -it --rm --net=frontend busybox wget -qO- http://web
```
`--rm`을 주면 종료되면 알아서 삭제가 됨.

demo2에서 demo1의 웹서버를 읽어서 출력하는 것을 확인할 수 있음.
```
$ docker $(docker-machine config mhl-demo2) run -it --rm --net=frontend busybox wget -qO- http://web
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```

그리고 rm 옵션을 주었기 때문에 실행 후에 ps 해보면 해당 컨테이너가 확인되지 않는다.
```
$ docker $(docker-machine config mhl-demo2) ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```

### docker swarm
각각의 노드에 컨테이너를 배치해주는게 swarm의 역할.

##### swarm mode??
도커엔진에 통합된 모드를 말함. 
* 멀티 호스트 네트워킹
* 디스커버리 : n개의 노드에 알아서 컨테이너를 띄우는데 사용자는 어느 노드에 컨테이너가 떠있는지 알수가 없다. 이걸 찾아주는 서비스가 디스커버리 서비스임. 
이전에는 제공해주지 않아서 consul과 같은 다른 서비스를 가져다 사용했었음.
* 로드밸런싱
* 롤링 업데이트 : 버전 업데이트를 순차적으로 해주는 것.
* 헬스체크
* 스케일 아웃 : 컨테이너를 원하는 상태로 관리하는 것. 
* 로깅
* 모니터링
* ha

Bluegrreen deployment
. 현재 운영중인 것(green)을 각 서버당 한벌씩….
그리고 복제해서 복제한 것(blue)에 패치하고….테스트 후 router를 변경해서 운영 -> 쉽고, 편하지만… 단점은 돈이 많이 든다.
이 단점을 보완해서 Bluegreen deployment를 구성하는 방법이 롤링 업데이트?

###### swarm 실습
```
# swarm 클러스터를 생성할. 머신 추가
$ docker-machine create -d virtualbox swl-consul

# consul 컨테이너 생성
$ docker $(docker-machine config swl-consul) run -d \
-p "8500:8500" \
-h "consul" \
progrium/consul -server -bootstrap
```

데모 머신 생성
```
$ docker-machine create \
-d virtualbox \
--virtualbox-disk-size 50000 \
--swarm \
--swarm-master \
--swarm-discovery="consul://$(docker-machine ip swl-consul):8500" \
--engine-opt="cluster-store=consul://$(docker-machine ip swl-consul):8500" \
--engine-opt="cluster-advertise=eth1:0" \
swl-demo0

$ docker $(docker-machine config swl-demo0) ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                              NAMES
20f7704b2412        swarm:latest        "/swarm join --adv..."   4 seconds ago       Up 3 seconds        2375/tcp                           swarm-agent
8aa588331271        swarm:latest        "/swarm manage --t..."   8 seconds ago       Up 7 seconds        2375/tcp, 0.0.0.0:3376->3376/tcp   swarm-agent-master
```

```
$ docker-machine create \
-d virtualbox \
--virtualbox-disk-size 50000 \
--swarm \
--swarm-discovery="consul://$(docker-machine ip swl-consul):8500" \
--engine-opt="cluster-store=consul://$(docker-machine ip swl-consul):8500" \
--engine-opt="cluster-advertise=eth1:0" \
swl-demo1
```

Nginx 추가
```
# overlay network add
$ docker $(docker-machine config swl-demo0) network create -d overlay frontend

$ docker $(docker-machine config swl-demo0) run -itd --name=web --net=frontend --env="constraint:node==swl-demo1" nginx
```

##### swarm 클러스터
앞에서 했던 과정들이 쉽게 구성할 수 있다.
앞에서 했던 overlay 구성하고 했던 과정들을 자동화해서 진행해줌.


