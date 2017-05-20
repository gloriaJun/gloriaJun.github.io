---
layout: post
comments: true
title: "[github blog] 블로그에 테마 적용하기"
date: 2017-03-26 15:30:00
categories: Git
tags: jekyll github-page theme
---

[Jekyll theme](http://jekyllthemes.org)에서 테마를 다운받아서 github 블로그에 적용하기.

#### 테마 다운받기
일단 사이트에서 원하는 테마를 고른 뒤에 해당 GitHub 저장소로 이동해서 로컬로 다운받는다.
다운받은 테마를 적용하는 방법은 보통 GitHub 페이지에 작성되어 있어 참고해서 적용하면 된다.

#### 테마 적용하기
내가 이번에 적용하려고 하는 테마에서 아래와 같이 설치 방법이 나와있었다.
![]({{ site.url }}/assets/images/post/git/2017/0326-git-blog-theme/theme-install-guide.png)

그래서..아래와 같이 진행해서 로컬 웹브라우저로 확인.
```shell
$ bundle install
$ jekyll serve --watch
```

#### 설정파일 수정
`_config.yml` 파일을 열어서 본인의 블로그에 맞게 정보를 변경하고..
`_post` 폴더에 본인이 작성한 글들을 복사하거나, 새로 작성한 뒤에 웹브라우저를 통하여 확인 후 github repository에 반영하면 된다.
