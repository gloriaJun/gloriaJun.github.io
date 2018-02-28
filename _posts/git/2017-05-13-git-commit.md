---
layout: post
title: "(Git) git commit"
date: 2017-05-13 10:30:00
author: gloria
categories: devops
tags: git
---

#### 버전관리 대상이 아닌 파일이 이미 git에 반영된 경우에 대한 조치 방법
`.gitignore` 파일에 제외할 폴더나 파일을 추가한 뒤에 아래와 같은 순서대로 실행해주면 된다.
```
git rm --cached -r
git add .
git commit -m "comment"
```

#### commit —ammend
기존에 커밋된 내용을 수정할 수 있다.   
```shell
git commit --ammend
```
