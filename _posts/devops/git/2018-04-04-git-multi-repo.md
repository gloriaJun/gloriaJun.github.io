---
layout: post
title: "(Git) git multi repository"
date: 2018-04-04 09:30:00
author: gloria
categories: devops
tags: git
---

git의 경우 하나의 프로젝트에서 multi repository를 사용할 수 있도록 지원을 한다고 한다.

#### git 레파지토리 설정
```bash
git remote add [리모트 레파지토리를 구분할 이름] [레파지토리 주소]
```

예제)
```bash
git remote add remote1 https://pureainu@bitbucket.org/pureainu/xxxx.git
git remote add remote2 https://pureainu@bitbucket.org/pureainu/yyyyy.git
```

#### push/pull
push와 pull을 할 때에 리모트 레파지토리를 명시해서 사용한다.
```bash
git pull remote1 master
git push remote1 master
```

## Reference
[git - 여러 개의 원격 저장소(remote repository) 설정하기](https://www.lesstif.com/pages/viewpage.action?pageId=17105553)
