---
layout: post
comments: true
title: "[NodeJS] cookie & session"
date: 2017-07-20 15:50:00
categories: Frontend
tags: nodejs express 
---

클라이언트와의 정보 유지를 위해 cookie와 session을 사용한다.    

## Cookie
클라이언트의 정보를 클라이언트에 저장한다. (사용자의 컴퓨터에 저장한다.)    

#### Example
###### cookie-parser 설치 
[cookie-parser](https://www.npmjs.com/package/cookie-parser)는 cookie에 값을 사용할 수 있도록 해주는 모듈이다.     
```
npm install cookie-parser --save
```

###### cookie parser 등록
```javascript
var cookieParser = require('cookie-parser');
// cookie parser 등록
app.use(cookieParser());
```

###### cookie를 활용한 간단한 예제
count라는 변수를 cookie에 저장시키고 새로고침 시마다 카운트 하는 예제    
```javascript
app.get('/', function (req, res) {
    var count = 0;
    if (req.cookies.count) {
        count = parseInt(req.cookies.count);
    }
    res.cookie('count', ++count);
    res.send(`count : ${count}`);
});
```

###### cookie에 저장되는 값 암호화
cookie에 저장되는 값을 암호화하기 위해서는 “cookieParser()”를 등록할 때, 암호화할 때에 사용할 키 값을 아규먼트로 전달해준다.    
```javascript
app.use(cookieParser("keyString"));
```
      
그리고 아래와 같이 cookie를 저장하고 사용하는 코드를 변경한다.      
```javascript
app.get('/count', function (req, res) {
    var count = 0;
    if (req.signedCookies.count) {
        count = parseInt(req.signedCookies.count);
    }
    res.cookie('count', ++count, {signed:true});
    res.send(`count : ${count}`);
});
```

## Session
클라이언트의 정보를 웹 서버의 웹 컨테이너에 저장한다.      

#### Example
###### express-session 설치 
[express-session](https://github.com/expressjs/session)을 설치한다.     
```
npm install express-session --save
```

###### express-session 등록
express-session을 등록하고 session에 대한 설정을 추가한다.   
```javascript
let session = require('express-session');
app.use(session({
    secret: 'secretKey', // 암호화 키 값
    // 아래는 그냥 권장 값 그대로 사용
    resave: false,
    saveUninitialized: true
}));
```

###### 간단한 예제
count라는 변수를 session에 저장시키고 새로고침 시마다 카운트 하는 예제    
```javascript
app.get('/count', function (req, res) {
    if (!req.session.count) {
        req.session.count = 0;
    }
    res.send(`hi Session!! Count : ${++req.session.count}`);
});
```

> mysqlDB를 세션 저장소로 사용하는 방법에 대한 내용은    
> [Server Side JavaScript - session 9 : session store - mysql - YouTube](https://youtu.be/izwKddFGrUg)를 참고





