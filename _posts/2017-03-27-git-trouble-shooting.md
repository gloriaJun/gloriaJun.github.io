---
layout: post
title: "[Git] Trouble Shooting"
date: 2017-03-27 22:30:00
categories: Git
tags: git
---

## There is no tracking information for the current branch.
`git pull`을 실행하는데 위와 같은 에러 메시지가 출력이 되었다.
원인은 git이 어디서 가져와야 할지 몰라서 발생하는 거라는 듯하다.
* 에러 전체 내용
  ```shell
  $ git pull
  There is no tracking information for the current branch.
  Please specify which branch you want to merge with.
  See git-pull(1) for details.

      git pull <remote> <branch>



  Merge branch 'master' of https://github.com/gloriaJun/gloriaJun.github.io
  If you wish to set tracking information for this branch you can do so with:

      git branch --set-upstream-to=origin/<branch> master
  ```

* 해결 방법
먼저 전달할 브랜치를 확인한다.
  ```shell
  $ git branch
  * master
  ```

  upstream할 브랜치를 지정해준다
  ```shell
  $ git branch --set-upstream-to=origin/master master
  Branch master set up to track remote branch master from origin.
  ```
