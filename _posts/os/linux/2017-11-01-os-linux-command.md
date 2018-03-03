---
layout: post
title: "(Linux) command"
date: 2017-11-01 09:30:00
author: gloria
categories: os
tags: linux
---

* TOC
{:toc}

## 사용자 생성
###### group 생성
```bash
groupadd 그룹명
```

###### user생성
study 라는 그룹에 study01이라는 user 생성
```bash
useradd -g study study01  
```

자신이 원하는 곳으로 홈 경로를 지정하고 싶은 경우
```bash
useradd study01 -d homeDir
```

###### password지정
```bash
passwd study01
```

## 시간 설정
###### date
- 2005 년 10월 5일 로 바꾸기
```bash
date -s 10/5/2005
```

- 10 시 30 분 40 초로 시간 변경하기
```bash
date -s 10:30:40
```

- 설정하려는 날짜 + 시간이 2004년 07월 15일 오후 4시 15분 50초 한꺼번에 마추기.
```bash
date 071516152004.50
```

###### rdate
- 타임 서버 시간 보기
```bash
rdate -p time.bora.net
```

- 타임 시간을  로컬 시간으로
```bash
rdate -s time.bora.net
```

## 압축
###### 디렉토리만 압축 풀기
```bash
tar xvf [tarfile] [prefix of directory]

# ex)
tar xvf test.tar /test/sample
```

###### 잘못 푼 압축파일 제거하기
만약 압축파일을 풀었는데 해당 압축파일에 대한 디렉토리가 생기지 않고 현재 디렉토리에 파일들이 풀리는 경우
일일이 해당 파일들을 삭제해야하는 경우가 생기는 데..그러한 경우 사용가능
```bash
# tar인 경우
$rm -rf `tar -tvf 파일.tar | awk {'print %$6}'`

# tar.gz 혹은 tgz 인 경우
$rm -rf `tar -tvzf 파일.tar | awk {'print %$6}'`

# bzip2 인 경우
$rm -rf `tar -tvlf 파일.tar | awk {'print %$6}'`
```

###### 특정 폴더 제외하고 압축하기
`--exclude` 옵션을 사용하면 된다.
```bash
tar xcvf /home/soul/apache.tar --exclude /usr/local/apache/logs /usr/local/apache
```
- /home/soul/apache.tar : 저정할 파일명
- \--exclude /usr/local/apache/logs : 제외시킬 경로
- /usr/local/apache : 압축할 대상


## netstat
###### 현재 Listen 상태인 포트 확인
```bash
netstat -nlt
```
- n: numeric - 주소를 보여줌
- l: listen - 열려진 포트
- t: tcp - tcp 연결상태

###### 현재 Active 상태인 포트 확인
```bash
netstat -nat
```
- n: numeric - 주소를 보여줌
- a: Active - 활동중인 포트
- t: tcp - tcp 연결상태

## tee
read from standard input and write to standard output and files
(즉, 화면과 파일에 동시에 출력하여 준다.)

**사용방법**
```bash
tee [OPTION]... [FILE]...
```

**Option**
```bash
Copy standard input to each FILE, and also to standard output.

-a, --append

      append to the given FILEs, do not overwrite

-i, --ignore-interrupts

      ignore interrupt signals

If a FILE is -, copy again to standard output.
```

**예시**   
date를 해서 나온 결과를 화면에 출력해주는 것과 동시에 date.txt을 생성하여 파일에도  출력해준다.
```bash
date | tee date.txt
```
`-a` 옵션을 주는 경우는 기존에 생성된 파일에 이어서 작성하고자 하는 경우...
```bash
ls -al | tee -a abc.txt
```

화면에 출력되는 내용을 한 번 더 출력한다. 아래와 같이~~
```bash
date | tee -
2011. 09. 23. (금) 11:04:42 KST
2011. 09. 23. (금) 11:04:42 KST
```
