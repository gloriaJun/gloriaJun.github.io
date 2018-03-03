---
layout: post
title: "(Linux) Expect"
date: 2017-11-01 19:33:00
author: gloria
categories: os
tags: linux expect
---

* TOC
{:toc}

## 배열
**선언**
{% raw %}
```bash
set a { 1 2 3 ...}
```
{% endraw %}

**값 가져오기**
```bash
# i 번째의 배열을 가져옴.
lindex $a i

# i번째부터 j 번째까지 가져옴.
lrange $a i j
```

**리스트의 갯수**
```bash
llength $a
```

## 문자열 길이
```bash
string length 변수
```
