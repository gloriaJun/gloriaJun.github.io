---
layout: post
comments: true
title: "[NodeJS] Express 실습하기 - 1"
date: 2017-07-13 17:30:00
categories: Frontend
tags: nodejs express
---

[Express](http://expressjs.com/ko/)는 NodeJS 기반의 웹 프레임워크이다.    
다른 자바스크립트 기반의 웹프레임워크로는 **Koa, Hapi**가 있으며, Express가 가장 널리 사용된다고 한다.     
> 생활코딩의 [nodejs 강좌](https://opentutorials.org/course/2136/11850)를 참고하여 실습한 내용들에 대한 정리

## 프로젝트 생성
프로젝트 디렉토리를 생성하고, `npm init`을 이용하여  `package.json`을 생성한다.       
```
npm init
```

## Express 모듈 설치
Express 모듈을  `--save` 옵션을 주어 설치한다.      
(save 옵션을 주면 모듈 설치와 함께 package.json 파일에 자동으로 추가된다)    
```
npm install express --save
```

#### 서버를 생성하는 방법
일반적으로 `app.js`로 파일명을 생성한다.   
```javascript
var express = require('express');
// 가져온 모듈이 실제는 함수라서 호출하면 application을 리턴한다
var app = express();

const hostname = '127.0.0.1';
const port = 3000;

app.get('/', function (req, res) {
app.get('/', function (req, res) {
    res.send('Hello World!\n');
});

// 포트를 지정해주면 해당 포트로 리스닝하는 서버를 생성한다
app.listen(port, function () {
    console.log(`Server running at http://${hostname}:${port}/`);
});
```
     
위의  코드는 아래와 같은 동작을 하는 코드이다.    
```javascript
var http = require('http');

const hostname = '127.0.0.1';
const port = 3000;

var server = http.createServer(function(req, res) {
    res.writeHead(200, {'Content-Type' : 'text/plain'});
    res.end('Hello World\n');
});
server.listen(port, hostname, function() {
    console.log(`Server running at http://${hostname}:${port}/`);
});
```

## Router
웹브라우저를 통하여 요청을 하는 사용자가 있고, router와 controller로 이루어진 웹 어플리케이션이 아래와 같이 이루어져 있을 때에…   
![]({{ site.url }}/assets/images/post/2017/0713-nodejs-express-router1.png)
       
사용자가 요청한 값에 대하여 각 요청에 대한 처리를 하는 controller와 연결해주는 역할을 말한다.      
![]({{ site.url }}/assets/images/post/2017/0713-nodejs-express-router2.png)
             
위의 그림에 대한 어플리케이션의 동작에 대해 코드로 작성하면 아래와 같다.     
```javascript
var express = require('express');
// 가져온 모듈이 실제는 함수라서 호출하면 application을 리턴한다
var app = express();

app.get('/', function (req, res) {
    res.send('Hello World!\n');
});

app.get('/login', function (req, res) {
   console.log('This is Login Page');
   res.send('Login Please...');
});
```

## 정적 파일 서비스 하기 
다음과 같이 정적파일들이 위치할 때에…      
```
public/
├── css
├── img
│   └── git-branch.png
└── js
```
      
`app.use` 함수를 사용하여 정적파일이 위치한 경로를 정의해준다.    
```javascript
app.use(express.static('public'));
```
       
그런 뒤에 `http://localhost:3000/img/git-branch.png`를 입력하면 해당 이미지 파일이 웹브라우저에 출력된다.      

> 정적 파일은 node 재기동 없이 수정된 내용이 바로 반영된다.  

## 동적인 파일 서비스 하기
반복되는 값이나, 변경되는 값에 대하여 표현하고자 하는 경우에 대한 코드 예시    
```javascript
app.get('/dynamic', function (req, res) {
    var line = '';
    for(var i = 0; i < 5; i++) {
        line += `<li>반복 : ${i}</li>`;
    };

    var output = `
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Sample</title>
    </head>
    <body>
        <h1>Hello, This Dynamic HTML Sample Page !!</h1>
        <br/>
        <ul>
            ${line}
        </ul>
        <br/>
        <img src="/img/git-branch.png">
    </body>
    </html>
    `
    res.send(output);
});
```
> 동적 파일이 수정이 발생한 경우에는 node를 재기동해야 한다.  
