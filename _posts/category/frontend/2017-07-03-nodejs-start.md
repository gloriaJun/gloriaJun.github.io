---
layout: post
comments: true
title: "[NodeJS] Node 시작하기"
date: 2017-07-03 19:30:00
categories: Frontend
tags: nodejs
---

Frontend를 공부하다 보니 Node를 기반으로 왠만한 것들이 시작을 한다.    
그래서 정리를 해보기 시작…   

##  Node.js
NodeJS 는 구글 크롬의 자바스크립트 엔진 (V8 Engine) 에 기반해 만들어진 서버 사이드 플랫폼.      
node 자체로는 아무 것도 해주지 않고, 사용자가 작성한 것을 실행할 수 있도록 해주는 javascript 런타임 엔진이다. 

## 설치하기
node가 설치되었는 지는 아래와 같이 확인을 할 수 있다.   
```
$ node --version
v8.1.2
$ npm --version
5.0.3
```
만약, 설치되어 있지 않다면 [NVM을 이용한 설치 for mac]({% post_url category/server/2017-03-30-nodejs-install-for-mac %}) 을 참고    

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

## 모듈
#### 모듈 설치하기
`npm`을 이용하여 아래와 같이 모듈을 설치할 수 있다.   
```
npm install [설치하고자 하는 모듈 이름]
```
   
기본적으로는 로컬 모드(해당 명령어를 실행한 디렉토리에 *node_modules* 디렉토리를 생성하여 해당 위치에 설치하는 것)로 설치를 진행하며, `-g` 옵션을 주면 글로벌 모드(시스템 디렉토리에 설치)로 설치가 진행된다.    
글로벌 모드로 설치가 진행된 모듈은 아래와 같이 `link`를 해주어야 해당 모듈을 사용할 수 있다.
```
npm link [사용하고자 하는 모듈 이름]
```

#### 모듈 제거하기
아래와 같이 설치된 모듈을 제거할 수 있다.
```
npm uninstall [삭제하고자 하는 모듈 이름]
```

#### 모듈 업데이트
아애롸 같이 설치된 모듈을 업데이트 할 수 있다.
```
npm update [업데이트하고자 하는 모듈 이름]
```

#### 설치된 모듈 검색
로컬 환경에 npm을 이용하여 설치된 모듈은 아래와 같이 확인할 수 있다.   
* 로컬 모드로 설치된 모듈 리스트 확인
    ```
    npm list --depth=0
    ```

* 글로벌 모드로 설치된 모듈 리스트 확인
    ```
    npm list -g --depth=0
    ```

#### 설치 가능한 모듈 검색
아래와 같은 명령어를 이용하거나, [NPM Search](https://npmsearch.com)에서 검색할 수 있다.    
```
npm search [검색할 모듈 이름]
```

#### package.json
`package.json`은 해당 프로젝트에 속성을 정의한 파일이다.    
해당 파일은 해당 프로젝트에 필요한 모듈과 모듈 버전 정보 및 프로젝트에 대한 간략한 정보를 담고 있다.   
```
{
  "name": "angular-todo-app",
  "version": "0.1.0",
  "description": "todo application",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "dependencies": {
    "angular": "^1.6.4",
    "angular-animate": "^1.6.4",
    "angular-aria": "^1.6.4",
    "angular-material": "^1.1.4"
  },
  "devDependencies": {
    "gulp": "^3.9.1",
    "gulp-webserver": "^0.9.1"
  }
}
```



> **Reference**       
> [Node.JS 강좌 01편: 소개 | VELOPERT.LOG](https://velopert.com/133)        