---
layout: post
title: "(Docker) dockerfile 명령어 정리"
date: 2018-01-11 11:40:00
author: gloria
categories: devops
tags: docker dockerfile
---

#### FROM
어떤 이미지를 기반으로 할지 설정한다.

#### RUN
쉡 스크립트 또는 명령어를 실행한다.

#### VOLUME
호스트와 공유할 디렉터리 목록
docker run 명령에서 -v로 지정하는 옵션으로도 설정할 수 있다.

#### CMD
컨테이너가 기동될 때 수행할 명령어 또는 스크립트

#### WORKDIR
CMD에서 지정한 명령어가 수행될 디렉터리

#### EXPOSE
호스트와 연결할 포트 번호 설정
