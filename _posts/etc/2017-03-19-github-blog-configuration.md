---
layout: post
title: "(github blog) 환경 설정"
date: 2017-03-19 15:30:00
author: gloria
categories: etc
tags: jekyll blog
#cover:  "/assets/instacode.png"
---

로컬에 생성된 블로그 디렉토리를 보면 아래와 같이 구성되어 있다.
```
gloriaJun.github.io]$ tree
.
├── Gemfile
├── Gemfile.lock
├── _config.yml
├── _posts
│   └── 2017-03-18-welcome-to-jekyll.markdown
├── _site
│   ├── about
│   │   └── index.html
│   ├── assets
│   │   └── main.css
│   ├── feed.xml
│   ├── index.html
│   └── jekyll
│       └── update
│           └── 2017
│               └── 03
│                   └── 18
│                       └── welcome-to-jekyll.html
├── about.md
└── index.md

9 directories, 11 files
```

## `_config.yml` 파일 수정하기
`_config.yml` 파일은 기본 설정 파일이다.
해당 파일을 이용하여 블로그의 전반적인 환경을 설정할 수 있다.
해당 파일의 위치는 로컬에서 블로그명으로 생성한 디렉토리 하위에 있다.

파일을 수정한 뒤에 `jekyll serve —watch`를 실행하면 로컬에서 변경된 내용들을 확인할 수 있다.

## 테마 적용하기
[Jekyll theme](http://jekyllthemes.org)에서 테마를 다운받아서 github 블로그에 적용하기.

#### 테마 다운받기
일단 사이트에서 원하는 테마를 고른 뒤에 해당 GitHub 저장소로 이동해서 로컬로 다운받는다.
다운받은 테마를 적용하는 방법은 보통 GitHub 페이지에 작성되어 있어 참고해서 적용하면 된다.

#### 테마 적용하기
내가 이번에 적용하려고 하는 테마에서 아래와 같이 설치 방법이 나와있었다.
![]({{ site.baseurl }}/assets/images/post/2017/0326-blog-theme-install-guide.png)

그래서..아래와 같이 진행해서 로컬 웹브라우저로 확인.
```shell
$ bundle install
$ jekyll serve --watch
```

#### 설정파일 수정
`_config.yml` 파일을 열어서 본인의 블로그에 맞게 정보를 변경하고..
`_post` 폴더에 본인이 작성한 글들을 복사하거나, 새로 작성한 뒤에 웹브라우저를 통하여 확인 후 github repository에 반영하면 된다.

## 포스트 등록하기
블로그 디렉토리 하위의 **_post** 디렉토리에 markdown 을 이용하여 작성한 파일을 추가하면된다.
단, 다음과 같은 규칙을 지켜야 한다.
* 파일명은 **YYYY-MM-DD-[영문파일명].md** 로 생성한다.
* 파일명은 반드시 한글로 생성해야한다.

#### 블로그 내용 작성
파일을 생성하고 상단에 아래와 같은 헤더를 입력한다.
해당 부분의 값을 이용해서 블로그의 카테고리와 태그를 설정할 수 있다.
```
---
layout: post
disqus_disabled: true
title: "[github blog] 환경 설정"
date: 2017-03-19 15:30:00
author: gloria
categories: etc
tags: jekyll github
cover:  "/assets/instacode.png"
---
```

그리고 하단에 markdown을 이용해서 내용을 작성한다.

#### 작성한 블로그 내용 확인하기
`jekyll server —watch`  명령을 터미널에서 수행한 뒤에 로컬에서 확인할 수 있다.

#### GitHub 에 반영하기
Git 명령어를 이용해서 원격레파지토리에 작성한 내용을 반영해서 올리면 내가 작성한 글이 블로그에 포스팅 된다.

```shell
git add .
git commit -m "commit message"
git push origin master
```
