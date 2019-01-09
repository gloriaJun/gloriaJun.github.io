---
layout: post
title: "(Javascript) Passport.js"
date: 2019-01-09 10:35:00
author: gloria
categories: language
tags: javascript
---

* TOC
{:toc}

[Passport.js](http://www.passportjs.org/)는 Node.js를 위한 사용자 인증을 위한 모듈 미들웨어로써, 사용자 로그인 기능을 쉽게 만들 수 있게 도와준다.
로컬 로그인, OAuth 등을 위한 기능들을 제공한다.

일단, passport를 이용한 사용자 인증 기능을 구현하려면 core 모듈인 `passport`를 필수로 설치해야한다.

```bash
yarn add passport
```

위의 모듈을 설치하고, 연계하려는 인증 방식에 따라서 passport document를 참고하여 구현을 하면 된다.

# 로컬 로그인 기능 구현

`passport-local` 모듈을 설치하여야 한다.
만약, mongodb를 이용하여 인증 기능을 구현하는 경우에는 [passport-local-mongoose](https://github.com/saintedlama/passport-local-mongoose)를 사용하면 간단하게 사용자 인증 기능을 구현할 수 있다.

```bash
yarn add passport-local
```

# OAuth

* http://www.passportjs.org/packages/ 에서 passport에서 제공하는 모듈들과 설정 방법을 확인할 수 있따.

## Github

* http://www.passportjs.org/packages/passport-github/
* 사전에 https://github.com/settings/applications/new 에서 연계하고자 하는 App에 대한 정보를 등록해두어야 한다.

# Reference

* [node.js에서 passport를 이용한 로그인 구현하기](http://html5around.com/wordpress/tutorials/node-js%EC%97%90%EC%84%9C-passport%EB%A5%BC-%EC%9D%B4%EC%9A%A9%ED%95%9C-%EB%A1%9C%EA%B7%B8%EC%9D%B8-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0/)