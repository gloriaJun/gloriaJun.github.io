---
layout: post
title: "[Git] ignore 파일 관리"
date: 2017-04-18 01:30:00
categories: Git
tags: git
---

`.gitignore`는 git에 반영할 때 반영하지 않고 무시할 파일들에 대하여 정리하는 파일이다.

### 각 프로젝트별 파일 예시
###### spring boot
```
.gradle
.idea
/build
*.iml
/target
```


### 반영되지 말하야할 폴더가 git에 반영된 경우
버전관리 대상이 아닌 파일이 이미 git에 반영된 경우에 대한 조치 방법
`.gitignore` 파일에 제외할 폴더나 파일을 추가한 뒤에 아래와 같은 순서대로 실행해주면 된다.
```
git rm --cached -r
git add .
git commit -m "comment"
```




