---
layout: post
title: "[NodeJS] NVM을 이용한 설치 for mac"
date: 2017-03-30 22:30:00
categories: NodeJS
tags: nodejs mac
---

NVM을 이용하여 설치를 하면 NodeJS를 쉽게 설치할 수 있을 뿐만 아니라 버전별로도 관리를 할 수 있음.
>[NVM]( [GitHub - creationix/nvm: Node Version Manager - Simple bash script to manage multiple active node.js versions](https://github.com/creationix/nvm))의 github에 보면 좀 더 자세한 설치 방법이 나와있음.

### nvm 설치
```
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
```

설치 후에, `~/.profile`을 적용한 뒤 `nvm` 명령어가 실행되는 지 확인
```
$ . ~/.profile
$ nvm --version
0.33.1
```

### node js 설치
아래는 node js 최신 버전을 설치하는 경우에 대한 예시임.
```
$ nvm install node
Downloading and installing node v7.8.0...
(...중략...)
```

설치된 node의 버전은 아래와 같이 확인할 수 있다.
```
$ nvm ls
->       v7.8.0
default -> node (-> v7.8.0)
node -> stable (-> v7.8.0) (default)
stable -> 7.8 (-> v7.8.0) (default)
iojs -> N/A (default)
nlts/* -> lts/boron (-> N/A)
vlts/argon -> v4.8.1 (-> N/A)
lts/boron -> v6.10.1 (-> N/A)

$ nvm current
v7.8.0
```
<br/><br/>
