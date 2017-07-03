
---
layout: post
comments: true
title: "[NodeJS] Node 시작하기"
date: 2017-07-03 19:30:00
categories: server
tags: nodejs
---

Frontend를 공부하다 보니 Node를 기반으로 왠만한 것들이 시작을 한다.    
그래서 정리를 해보기 시작…   

##  Node.js
NodeJS 는 구글 크롬의 자바스크립트 엔진 (V8 Engine) 에 기반해 만들어진 서버 사이드 플랫폼.      
node 자체로는 아무 것도 해주지 않고, 사용자가 작성한 것을 실행할 수 있도록 해주는 javascript 런타임 엔진이다. 

## 설치하기
[NVM을 이용한 설치 for mac]({% post_url category/server/2017-03-30-nodejs-install-for-mac %}) 을 참고

## 간단한 application  만들기
어플리케이션 작성에 필요한 모듈을 불러올 때는 `require`  명령을 사용하여 불러온다.     
다음은 3000번 포트를 사용하는 웹서버를 생성하는 예제 코드이다.      
```javascript
// app.js
var http = require('http');

var port = 3000;
var server = http.createServer(function(req, res) {
    res.writeHead(200, {'Content-Type' : 'text/plain'} );
    res.end('Hello World!!');
});

server.listen(port);

console.log("Server running at http://localhost:" + port);
```    
        
생성한 서버는 아래와 같이 실행할 수 있다.           
```
$ node app.js
Server running at http://localhost:3000
```
      
웹 브라우저에서 `http://localhost:3000`를 접속하면 'Hello World!!' 라는 메시지를 확인할 수 있다.     

> **Reference**       
> [Node.JS 강좌 01편: 소개 | VELOPERT.LOG](https://velopert.com/133)        