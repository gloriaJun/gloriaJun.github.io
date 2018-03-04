
---
layout: post
comments: true
title: "[NodeJS] Express 실습하기 - 3"
date: 2017-07-13 18:30:00
categories: Frontend
tags: nodejs express template-engine
---

**관련 글들**
[Express 실습하기 - 1]({% post_url category/frontend/2017-07-13-nodejs-express1 %})
[Express 실습하기 : 템플릿 엔진(Jade) - 2]({% post_url category/frontend/2017-07-13-nodejs-express2 %})

## URL을 이용한 정보 전달
url을 이용하여 다음과 같이 전달된 정보에 대하여 전달받는 방법들에 대하여 정리

#### Query String
URL에 담겨져 `id=10&name=Kelly`와 같이 전달된 Query 파라미터에 대하여 **{ name: 'Kelly', id: '100' }**와 같은 json 문법으로 request 객체에 담겨 전달되어 진다.        
```javascript
app.get('/param', function (req, res) {
    var params = req.query;
    // 전달받은 전체 파라미터를 출력
    console.log(params);
    // name 이라는 특정 값만 출력
    console.log(params.name);
});
```      

> 추가적인 예제는 [Express 4.x - API Reference](http://expressjs.com/en/4x/api.html#req.query)를 참고      

## POST 방식을 이용한 정보 전달
post 방식으로 전달되어 RequestBody에 담긴 데이타를 읽기 위해서는 아래의 확장 기능 모듈을 설치하여 포함시켜야 한다.    
```
npm install body-parser --save
```
     
설치 후에 해당 모듈을 사용하기 위헤 `app.js`에 추가해준다     
```javascript
// request body에 담긴 값을 읽기 위한 모듈
var bodyParser = require('body-parser');

// for parsing application/json
app.use(bodyParser.json());
// for parsing application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));
```
                      
 값을 전달하기 위한 form 을 작성한다.      
```jade
doctype html
html
    head
        meta(charset='utf-8')
    body
        form(action='/join' method='post')
            p
                label 아이디
                input(type='text' name='username')
            p
                label 패스워드
                input(type='password' name='password')
            p
                label 세부내용
                textarea(name='content')
            p
                input(type='submit')
```
          
해당 html 페이지를 출력과 값을 post로 전달받기 위한 router를 추가해준다.      
```javascript
// post 방식으로 전달되는 파라미터에 대한 예시
app.get('/join', function(req, res) {
    res.render('join');
});
// post로 전달된 값을 전달받기 위한 예시
app.post('/join', function(req, res) {
    console.log(req.body);
    res.json(req.body);
});
```


## Tip : 언제 Get을 쓰고 Post를 사용해야 하는 걸까??
###### Get을 써야 하는경우
* 링크를 클릭했을 때에 주소가 변경되는 것을 원하는 경우
* 어떠한 정보에 대한 주소를 나타내야하는 경우

###### Post를 써야 하는 경우
* 화면을 통하여 어떠한 정보가 입력되어 제출된 경우 (ex.  회원가입)
* 매우 긴 글에 대해서 전달하는 경우 (매우 긴 글을 get으로 전송하는 경우 url 길이 규약으로 인하여 내용이 유실 될 수 있다)
     
> Get, Post 방식이건 어떠한 중요한 정보를 가로채는 방식에 대해서 post가 조금 더 어려울 뿐이지 보안상 아주 안전하다고는 할 수 없다.          
> (htts, ssl 방식이 조금 더 보안상 안전함)  


## Tip : Nodejs를 자동으로 재시작하기
자바스크립트 코드가 변경이 된 경우 node가 자동으로 감지하여 재시작하도록 하기 위해서는 [supervisor](https://github.com/petruisfan/node-supervisor)모듈을 설치한다.       
```
npm install supervisor -g
```
      
설치 후에, 아래와 같이 실행하여 어플리케이션을 실행시키면 자바스크립트 코드가 변경되는 경우에 자동으로 감지하여 변경 내용을 반영해 준다.     
```
supervisor app.js
```
         
> 변경된 내용을 자동으로 감지하여 반영해주는 기능을 `watch`  라고 하며,        
> supervisor 외에도 비슷한 기능을 제공하는 다양한 도구들이 존재한다.   

