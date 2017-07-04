---
layout: post
comments: true
title: "[NodeJS] Node with Express"
date: 2017-07-04 15:30:00
categories: Frontend
tags: nodejs
---

NodeJS 웹프레임워크를 이용하여 웹서버 구축하기     
웹프레임워크 종류로는 **Express, Koa, Hapi** 등이 있으며, 그 중 Express가 가장 많은 예제를 찾을 수 있는 듯…     

## 프로젝트 생성
프로젝트 디렉토리를 생성하고, `npm init`을 이용하여  `package.json`을 생성한다.       
```
npm init
```

## 의존 모듈 설치
의존 모듈들을  `--save` 옵션을  주어 설치한다.      
(save 옵션을 주면 모듈 설치와 함께 package.json 파일에 자동으로 추가된다)    
```
npm install express ejs --save
```

###### 간단한 Server  코드 작성하여 확인하기
웹브라우저에  `http://localhost:3000`을 입력하면, “Hello World”  메시지를 출력하는 서버 코드를 작성한다.    
```javascript
var express = require('express');
var app = express();

var port = 3000;

// server를 기동시킨다.
var server = app.listen(port, function() {
	console.log("Server has started on port " + port);
});
```


##  HTML  페이지 작성
###### index.html
```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=yes">

		<title>Sample App:Main</title>
	</head>
	<body>
		<h1>Sample Page</h1>
		This is Index Page.
	</body>
</html>
```

###### about.html
```html
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=yes">

		<title>Sample App:About</title>
	</head>
	<body>
		<h1>About Page</h1>
		About Something ...
	</body>
</html>
```


## Router를 반영한 Server 
**Router**를 이용하여 특정 URL 로 들어오는 HTTP Request를 처리하기 위한 코드를 추가한다.     
###### router/main.js
router와 관련된 부분은 별도의 디렉토리에 소스 코드를 분리하여 관리하기 위해 `router` 디렉토리를 생성하고 그 안에 파일을 생성하였음.         
```javascript
module.exports =  function(app) {
	app.get('/', function(req, resp) {
		resp.render('index.html');
	});
	app.get('/about', function(req, resp) {
		resp.render('about.html');
	});
}
```

###### app.js
앞에서 생성한 서버 코드를 수정한다.   
```javascript
var express = require('express');
var app = express();
// router 모듈을 정의한 파일을 불러와서 app에 전달한다.
var router = require('./router/main')(app);

var config = {
	port : 3000,
	views : __dirname
};

// html template 설정
app.set('views', config.views);
app.set('view engine', 'ejs');
app.engine('html', require('ejs').renderFile);

// server를 기동시킨다.
var server = app.listen(config.port, function() {
	console.log("Server has started on port " + config.port);
});
```      



> **Reference**      
> [Node.JS 강좌 09편: Express 프레임워크 사용해보기 | VELOPERT.LOG](https://velopert.com/294)         
> [조대협의 블로그 :: 빠르게 훝어 보는 node.js - #4 웹개발 프레임웍 Express 1/2](http://bcho.tistory.com/887)  


