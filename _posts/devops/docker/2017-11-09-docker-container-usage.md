---
layout: post
title: "(Docker) Container 관리"
date: 2017-11-09 17:19:00
author: gloria
categories: devops
tags: docker
---

* TOC
{:toc}

## 재시작 옵션 변경
```bash
# restart on
$ docker update --restart=always crowd
crowd

# restart off
$ docker update --restart=no crowd
crowd
```
