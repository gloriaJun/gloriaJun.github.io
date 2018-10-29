---
layout: post
title: "(Javascript) 웹 어플리케이션 만들기"
date: 2018-10-26 14:15:00
author: gloria
categories: language
tags: javascript

---

*아직 작성 중*

* TOC
{:toc}


매번 webpack을 이용해서 프로젝트를 만들고 생성하다보니, 그 안의 동작들을 정확히 이해하지 못하고 넘어가고 있는 듯해서 한땀 한땀 만들어보는 과정을 해봐야겟다고 생각이 들었다.

**기본부터 탄탄하게..**라는 내 자신과의 프로젝트를 진행 중이다...

> 기본적으로 node와 npm 또는 yarn이 설치되어있다는 가정하에 문서를 작성하였다.

## 프로젝트 생성
```bash
$ mkdir my-webapp
$ cd my-webapp
```

## package.json 생성
```bash
$ yarn init 
// or
$ npm init
```

아래와 같이 `package.json`이 생성된다.
```json
{
  "name": "my-webapp",
  "version": "1.0.0",
  "main": "app.js",
  "license": "MIT"
}
```

## Node만을 이용하여 간단한 서버 기동하기
#### server.js 생성
서버 어플리케이션의 진입점이 되는 `server.js` 스크립트를 생성한다.
```javascript
// server.js
const http = require('http');

// server information
const hostname = '127.0.0.1';
const port = 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello World\n');
});

server.listen(port, hostname, () => {
  console.log('server start');
});
```

#### 서버 실행 및 확인
```bash
$ node server.js
server start
```

위와 같이 실행 후에 별도의 터미널 또는 웹브라우저를 통하여 정상적으로 서버가 기동되고 동작하는 것을 확인할 수 있다.
```bash
$ curl http://127.0.0.1:3000
Hello World
```

## Express를 이용하여 서버 기동하기
node만을 이용하여 기동한 서버를 이용하여 운영하기에는 부족하다. 그러므로 다양한 npm 모듈들을 추가하여 손쉽게 웹서버를 기동할 수 있도록 제공하는 라이브러리가 [express](https://expressjs.com)이다.
express는 웹 개발 프레임워크이다.

#### Express 설치
```bash
$ yarn add express
```

#### index.html 
`views/index.html`을 생성한다.
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Javascript30</title>
</head>
<body>
Hello !!!
</body>
</html>
```

#### server.js
기존 앞에서 작성한 `server.js` 파일을 아래와 같이 수정한다.
서버 기동 후에 확인해보면 정상적으로 서버가 기동되고, 브라우저에 응답값이 출력되는 것을 확인할 수 있다.
```javascript
// define webserver
const express = require('express');
const app = express();
// for loading file
const fs = require('fs');

// server information
const port = 3000;

// set port
app.listen(port, () => {
  console.log('server start');
});

// set routing
app.get('/', (req, res) => {
  fs.readFile('views/index.html', (error, data) => {
    if (error) {
      console.log(error);
    } else {
      res.writeHead(200, {
        'Content-Type': 'text/html',
      });
      res.end(data);
    }
  });
});
```

#### 템플릿 엔진 설치
html이 매번 정적인 내용만 담고 있는 것은 아니다, 클라이언트 요청에 따라 내용이 달라질 수도 있다. 이러한 부분들을 제공하기 위해서 `ejs, pug ...`등과 같은 템플릿 엔진이 제공된다.

```bash
yarn add ejs
```

###### 기존 코드 수정
```javascript
// define webserver
const express = require('express');
const app = express();

// set template engine
app.set('views', `${__dirname}/views`);
app.set('view engine', 'ejs');
app.engine('html', require('ejs').renderFile);

// server information
const port = 3000;

// set port
app.listen(port, () => {
  console.log('server start');
});

// set routing
app.get('/', (req, res) => {
  res.render('index.html');
});
```


## Reference
