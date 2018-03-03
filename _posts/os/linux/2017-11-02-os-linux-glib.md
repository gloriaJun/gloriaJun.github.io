---
layout: post
title: "(Linux) glib 설치하기"
date: 2017-11-02 18:13:00
author: gloria
categories: os
tags: linux
---

#### 현재 설치된 버전 확인
```bash
$ getconf -a | grep libc
GNU_LIBC_VERSION                   glibc 2.5
```


## 설치하기
http://ftp.acc.umu.se/pub/gnome/sources/glib/2.34/

#### glib 다운받기
http://ftp.gnome.org/pub/gnome/sources/glib/2.42/glib-2.42.2.tar.xz

#### 압축 풀기
```bash
tar xvf glib-2.42.2.tar.xz
```

#### configure 실행
```bash
cd glib-2.42.2
./configure
```

###### configure 실행 중 없는 패키지 찾아 설치
zlib가 없다고 나와서 zlib를 설치하였다.
zlib 다운 - http://zlib.net/zlib-1.2.8.tar.gz
```bash
# 압축 풀기
tar xvfz zlib-1.2.7.tar.gz
cd zlib-1.2.7
./configure
make test
make install
make
make install
```


`pkg-config --cflags -libs glib-2.0` 실행하면
```bash
-I/usr/local/include/glib-2.0 -I/usr/local/lib/glib-2.0/include -L/usr/local/lib -lglib-2.0
```
이 뜨면 정상적으로 설치된 것

#### 테스트
간단한 프로그램 작성 후 컴파일
```bash
gcc test.c `pkg-config --cflags --libs glib-2.0`
```


## Reference :
- glib 설치 : http://cccob.blogspot.kr/2014/05/glib.html
- zlib 설치 : http://blog.daum.net/purume77/7332137
- glib reference manual : https://developer.gnome.org/glib/
