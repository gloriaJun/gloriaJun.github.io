---
layout: post
comments: true
title: "[github blog] jekyll로 생성한 블로그의 환경 설정하기"
date: 2017-03-19 15:30:00
categories: Git
tags: jekyll github-page
---

로컬에 생성된 블로그 디렉토리를 보면 아래와 같이 구성되어 있다.
```shell
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


## _config.yml 파일 수정하기
`_config.yml` 파일은 기본 설정 파일이다.
해당 파일을 이용하여 블로그의 전반적인 환경을 설정할 수 있다.
해당 파일의 위치는 로컬에서 블로그명으로 생성한 디렉토리 하위에 있다.

파일을 수정한 뒤에 `jekyll serve —watch`를 실행하면 로컬에서 변경된 내용들을 확인할 수 있다.
