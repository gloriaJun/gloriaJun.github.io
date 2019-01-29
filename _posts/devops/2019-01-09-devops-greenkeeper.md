---
layout: post
title: "Temp - (DevOps) 패키지 의존성 관리를 위한 GreenKeeper"
date: 2018-01-17 13:57:00
author: gloria
categories: devops
tags: rancher docker
---

# GreenKeeper

* 각 패키지의 의존성을 실시간으로 감시하고 업데이트 할 수 있게 도와주는 도구
* 오픈소스 레파지토리에 대해서는 무료

## 설정하는 방법

### 사전 조건

* travisCI와 같은 CI 도구와 연동이 되어 있어야 한다.
* 해당 레파지토리에 `package.json` 파일이 존재해야 한다

### GreenKeeper 설치

https://github.com/marketplace 에서 해당 서비스를 선택해서 설치한다.

설치를 하면, travisCI가 연동이 되어있는 경우에 greenkeeper가 알아서 greenkeeper 브랜치를 생성하여 의존성 체크 및 빌드를 수행 후에 `readme.md` 파일을 수정하여 뱃지를 생성해주는 작업을 한 뒤 PR을 날려준다.

만약, greenkeeper 연동 과정에 대한 상태를 `https://account.greenkeeper.io/account/<username>#repositories`에서 확인할 수 있다.

### 연동하면서 기억하고 싶은 부분들

- 당연히 CI 도구를 이용한 빌드 과정에 에러가 없어야 한다.
- 작성한 빌드 스크립트로는 정상적으로 빌드가 수행이 되는 데, greenkeepr에서 수행하는 빌드과정에서 에러가 발생한다면..greenkeeper가 날린 PR의 내용을 잘 확인해보자. 패키지 버전 업데이트로 인한 빌드 오류일 수도 있다.
- 만약, 다시 greenkeeper 설정을 하고 싶다면, `https://account.greenkeeper.io/account/<username>#repositories` 페이지에서 `fix repo` 버튼을 눌러서 출력되는 모달 창의 내용을 따라서 수행한 뒤에 재설정을 해주면 된다. (근데 하루에 3번인가 이상 반복하면..30분 뒤에나 다시 수행할 수 있더라는....)

# Reference

* [GitHub과 연동해서 의존성 라이브러리를 관리할 수 있는 서비스들](https://blog.outsider.ne.kr/1323)