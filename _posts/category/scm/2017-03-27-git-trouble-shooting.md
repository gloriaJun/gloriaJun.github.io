---
layout: post
comments: true
title: "[Git] Trouble Shooting"
date: 2017-03-27 22:30:00
categories: scm
tags: git
---

## There is no tracking information for the current branch.
`git pull`을 실행하는데 위와 같은 에러 메시지가 출력이 되었다.
원인은 git이 어디서 가져와야 할지 몰라서 발생하는 거라는 듯하다.

###### 에러 전체 내용
  ```
  $ git pull
  There is no tracking information for the current branch.
  Please specify which branch you want to merge with.
  See git-pull(1) for details.

      git pull <remote> <branch>



  Merge branch \'master\' of https://github.com/gloriaJun/gloriaJun.github.io
  If you wish to set tracking information for this branch you can do so with:

      git branch --set-upstream-to=origin/<branch> master
  ```

###### 해결 방법
먼저 전달할 브랜치를 확인한다.
```
$ git branch
* master
```

upstream할 브랜치를 지정해준다
```
$ git branch --set-upstream-to=origin/master master
Branch master set up to track remote branch master from origin.
```

## fatal: refusing to merge unrelated histories
`git pull`을 실행하는데 위와 같은 에러 메시지가 출력이 되었다.
remote의 저장소에 이미 파일이  adding이 된 후에 pull을 시도하려고 하는 경우에 발생하는 에러인 듯하다.

###### 에러 전체 내용
  ```
$ git pull
fatal: refusing to merge unrelated histories
  ```

###### 해결 방법
`--allow-unrelated-histories` 옵션을 추가하고 pull을 한다.
아래와 같이 실행하면 기존 adding 된 파일을 merge 여부를 확인하고 원격지에서 파일을 가져오게 된다.
```
$ git pull origin master --allow-unrelated-histories
```

예시)
```
$ git pull origin master --allow-unrelated-histories
From https://github.com/[사용자아이디]/[레파지토리명]
 * branch            master     -> FETCH_HEAD
Merge made by the 'recursive' strategy.
 README.md | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 README.md
```
