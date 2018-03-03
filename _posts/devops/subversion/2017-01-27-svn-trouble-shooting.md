---
layout: post
title: "(Svn) Trouble Shooting"
date: 2017-01-27 22:30:00
author: gloria
categories: devops
tags: svn stackoverflow
---

* TOC
{:toc}

## svn: Can't convert string from 'UTF-8' to native encoding:
svn checkout 또는 svn commit 시에 위와 같은 에러메시지가 출력이 되면??
repository에 저장된 UTF-8로 저장된 문자열을 받으려고 할 때 발생하는 것이므로 인코딩이 해당 문자열로 설정되어 있어야함.
```bash
$ export LC_CTYPE=ko_KR.UTF-8

# locale 확인
$ locale
LANG=UTF-8
LC_CTYPE=ko_KR.UTF-8
LC_NUMERIC="UTF-8"
LC_TIME="UTF-8"
LC_COLLATE="UTF-8"
LC_MONETARY="UTF-8"
LC_MESSAGES="UTF-8"
LC_PAPER="UTF-8"
LC_NAME="UTF-8"
LC_ADDRESS="UTF-8"
LC_TELEPHONE="UTF-8"
LC_MEASUREMENT="UTF-8"
LC_IDENTIFICATION="UTF-8"
```
