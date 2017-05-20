---
layout: post
comments: true
title: "[Git] Branch 사용법 정리"
date: 2017-05-10 14:30:00
categories: Git
tags: git
---

## Branch 관리
#### Branch 확인
* 원격 저장소의 Branch 리스트 보기
```
$ git branch -r
  origin/HEAD -> origin/master
  origin/dev
  origin/feature/client-profile
  origin/master
  origin/tmp
```

* 모든 Branch 리스트 보기
```
$ git branch -a
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/dev
  remotes/origin/feature/client-profile
  remotes/origin/master
  remotes/origin/tmp
```

#### 현재 작업 중인 Branch 확인
```
$ git status
HEAD detached at origin/dev
nothing to commit, working tree clean
```

#### Branch 변경하기
```
$ git checkout origin/dev
```

#### Branch 생성
```
$ git branch <BRANCHNAME>
```

만약, 브랜치를 생성과 생성한 브랜치로 이동을 하려고 한다면..
```
$ git checkout -b <BRANCHNAME>
```

#### Branch 삭제
```
$ git branch -d
```
