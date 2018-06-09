---
layout: post
title: "(React) react 시작하기"
date: 2018-06-09 21:35:00
author: gloria
categories: language
tags: javascript frontend react
---

## create-react-app 설치
`create-react-app`은 페이스북에서 제공하는 리액트 앱을 만들어주는 도구이다
```bash
$ yarn global add create-react-app
```

## create-react-app을 이용한 프로젝트 생성
```bash
$ create-react-app hello-react
$ cd hello-react
$ yarn start
```

프로젝트는 아래와 같이 구성되어 있다.
```bash
$ tree
.
├── README.md
├── package.json
├── public
│   ├── favicon.ico
│   ├── index.html
│   └── manifest.json
├── src
│   ├── App.css
│   ├── App.js
│   ├── App.test.js
│   ├── index.css
│   ├── index.js
│   ├── logo.svg
│   └── registerServiceWorker.js
└── yarn.lock

2 directories, 13 files
```


## Reference
- [누구든지 하는 리액트 2편: 리액트 프로젝트 시작하기](https://velopert.com/3621)
