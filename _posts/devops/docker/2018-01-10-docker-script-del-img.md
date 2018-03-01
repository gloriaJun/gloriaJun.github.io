---
layout: post
title: "(Docker) 이미지 삭제 스크립트"
date: 2018-01-10 18:35:00
author: gloria
categories: devops
tags: docker shell
---

여러 개의 등록된 이미지를 한 번에 삭제하기 위해서 작성한 스크립트이다.
내가 한 방법보다 더 좋은 방법이 있을 수도 있긴하겠지만....

- 로컬의 docker image에 등록된 모든 이미지 데이타 삭제 하는 스크립트
```bash
for f in `docker images | grep -v IMAGE | awk '{split($0,array," ")} {print array[3]}'`
do
  echo "==> delete image : $f"
  docker rmi $f
done
```


아래는 alias로 등록해놓고 사용하는 경우에..
```sh
alias dirm='for f in `docker images | grep -v IMAGE | awk '"'"'{split($0,array," ")} {print array[3]}'"'"'`;do echo "==> delete image : $f";docker rmi $f;done'
```
