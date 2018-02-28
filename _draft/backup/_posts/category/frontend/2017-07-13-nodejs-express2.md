---
layout: post
comments: true
title: "[NodeJS] Express 실습하기 : 템플릿 엔진(Jade) - 2"
date: 2017-07-13 18:30:00
categories: Frontend
tags: nodejs express template-engine
---

**관련 글들**
[Express 실습하기 - 1]({% post_url category/frontend/2017-07-13-nodejs-express1 %})
     
## 템플릿 엔진
#### 개념
* 정적인 페이지와 동적인 페이지에 대한 장단점을 결합한 새로운 체계이다.     
* 템플릿 엔진에서 제공하는 문법에 맞게 작성하면 해당 내용을 html 또는 javascript로 변환해준다. 
* 모델과 뷰를 분리를 하여 작성하면, 해당 정보를 합칠 수 있도록 도와주는 도구이다.
* Mustache, doT, Jade, Handlebars 등 다양한 템플릿 엔진 등이 존재한다.

#### 템플릿 엔진 사용하기
[jade](https://www.npmjs.com/package/jade) 라는 템플릿 엔진을 이용하여 실습해보기

> 기존의 pug가 Jade로 이름이 변경되었음.  

###### 설치
```
$ npm install jade --save
```

###### Express와 Jade 연결  
Express 엔진에게 어떠한 템플릿 엔진을 사용할 것인지 설정한다.     
```javascript
// express와 템플릿 엔진(jade)를 연결해준다
app.set('view engine', 'jade');
```

###### 템플릿 파일이 위치한 경로를 설정
작성할 템플릿 파일들이 위치할 디렉토리를 생성 후, 해당 경로를 설정한다.     
```javascript
// 템플릿이 위치한 경로를 설정한다
app.set('views', './views');
```

###### 렌더링된 html 코드를 보기 좋게 표현하기
```javascript
// 템플릿 엔진을 이용하여 렌더링된 html을 보기 좋게 출력하기 위해 설정한다
app.locals.pretty = true;
```
    
만약, 해당 설정을 하지 않는 경우에는 렌더링된 html 코드가 한 줄로 표현되어 생성된 것을 웹브라우저의 “페이지 소스 보기” 기능을 통하여 확인할 수 있다.

###### 사용하기
템플릿 엔진을 이용하여 렌더링을 하므로 `render` 라는 함수를 사용하여 정의한다.     
```javascript
// "/login" 에 대한 요청이 들어오면 템플릿 엔진을 이용하여 렌더링 하여 화면에 표현한다.
app.get('/login', function (req, res) {
    res.render('login');
});
```
     
템플릿 파일을 `./views/login.jade`라는 파일명으로 생성한다.       
```jade
// 들여쓰기를 이용하여 레벨을 구분한다
html
    head
        title 로그인 페이지

    body
        h1 Login Please
        br

        label 아이디 :
        input
        br
        label 패스워드 :
        input

        ul
            // 자바스크립트 문법을 사용할 수도 있다 "-"로 시작해야 한다
            -for(var i=0; i < 5; i++)
                li 반복
                    dev= i

        // 현재의 시간을 출력하기 위함 time에 들어갈 값에 대해서는 전달받아야 한다
        div= time
```
     
서버를 실행 시킨 후에 `http://localhost:3000/login`으로 접속하면 아래와 같이 생성된 html 코드를 확인할 수 있다.     
```html

<!-- 들여쓰기를 이용하여 레벨을 구분한다-->
<html>
  <head>
    <title>로그인 페이지</title>
  </head>
  <body>
    <h1>Login Please</h1><br/>
    <label>아이디 :</label>
    <input/><br/>
    <label>패스워드 :</label>
    <input/>
    <ul>
      <!-- 자바스크립트 문법을 사용할 수도 있다 "-"로 시작해야 한다-->
      <li>반복
        <dev>0</dev>
      </li>
      <li>반복
        <dev>1</dev>
      </li>
      <li>반복
        <dev>2</dev>
      </li>
      <li>반복
        <dev>3</dev>
      </li>
      <li>반복
        <dev>4</dev>
      </li>
    </ul>
    <!-- 현재의 시간을 출력하기 위함 time에 들어갈 값에 대해서는 전달받아야 한다-->
    <div>Thu Jul 13 2017 19:26:52 GMT+0900 (KST)</div>
  </body>
</html>
```

> Jade 문법에 대해서는 [Jade Template Syntax Documentation](https://naltatis.github.io/jade-syntax-docs/) 참고  


