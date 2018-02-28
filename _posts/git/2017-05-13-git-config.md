---
layout: post
title: "(Git) git config"
date: 2017-05-13 09:30:00
author: gloria
categories: devops
tags: git
---

#### 현재 설정된 설정 값을 확인
```
# 전역으로 설정된 값 확인
$ git config --global --list

# 현재 위치한 프로젝트에 대한 설정 값 확인
$ git config --list
```

#### git 저장소를 프로젝트 별로 다른 사용자 계정 설정하기
다수의 git 계정(회사, 개인적인, 스터디 그룹 등..)을 가지고 있는 경우에 프로젝트 별로 다른 사용자 정보를 설정해야하는 경우에 대한 설정 방법.

* git 프로젝트 디렉토리의. `.git/config` 파일에 설정 하거나 `git config` 명령어로 설정을 할 수 있다.
    ```
    # git config 설정 방법
    $ cat .git/config
    [user]
        name = username
        email = username@email.com

    # git config 명령어 사용방법
    git config user.name [username]
    git config user.email [username@email.com]
    ```

* 만약 사용자 홈디렉토리의 `.gitconfig` 에 사용자 정보가 입력되어 있다면, 별도로 각 프로젝트마다 사용자 정보를 설정하지 않으면 기본으로 전역으로 설정된 값이 반영되게 된다.<br/>
_(이런 경우 의도치 않게 전역으로 설정된 개인적인 git 저장소의 사용자 정보로 회사 git 저장소에 반영되는 경우가 생길 수도 있다..ㅠㅠ 실 경험담…아흑~~ push까지 해버렸어~~)_<br/><br/>
참고로 global 로 반영하는 방법은…`git config`에 `--global`옵션을 추가로 넣어주면 된다.

#### git commit 메시지 편집기 설정
아래와 같은 방법으로 자신이 원하는 편집기를 사용할 수 있도록 설정할 수 있음.
```
$ git config --global core.editor vim
```


## 레파지토리 생성
#### 새로 생성된 원격저장소와 로컬 저장소를 연결하여 원격 저장소에 반영하기
```
$ git init
$ git remote add origin [remote url]
$ git add .
$ git commit -m "init commit"
$ git push origin master
```
