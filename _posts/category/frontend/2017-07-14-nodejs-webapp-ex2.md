---
layout: post
comments: true
title: "[NodeJS] 웹어플리케이션 만들기 실습 : 파일 업로드 - 2"
date: 2017-07-14 16:50:00
categories: Frontend
tags: nodejs express jade
---
 
**관련 글들**
[웹어플리케이션 만들기 실습 - 1]({% post_url category/frontend/2017-07-14-nodejs-webapp-ex1 %})
      
[multer](https://github.com/expressjs/multer) 모듈을 이용하여 파일 업로드를 위한 기능을 추가한다.    

## 모듈 설치
```
npm install multer --save
```

##  사용법
`app.js` 에 업로드 모듈에 대하여 정의한다.      
```javascript
var multer  = require('multer');
var storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, 'uploads/'ㅔ)
    },
    fiㅔename: function (req, file, cb) {
        cb(null, file.fieldname + '-' + Date.now())
    }
});
var upload = multer({storage: storage});
```

## 단일 파일에 대한 업로드
###### 파일 업로드 폼 작성
`upload.jade`라는 파일명으로 파일 업로드를 위한 폼을 작성하였음.     
```html
doctype html
html
    head
        meta(charset='utf-8')
        title 첨부파일
    body
        h1 Attachment Management
        form(method='post' enctype='multipart/form-data')
            p
                label 파일
                input(type='file' name='uploadfile')
            p
                input(type='submit')
```

###### 파일 업로드에 대한 라우터 작성
`app.js`에 업로드에 대한 라우터를 작성한다.     
```javascript
app.get('/upload', function(req, res) {
    res.render('upload');
});
app.post('/upload', function (req, res) {
    res.redirect('/upload');
});
```

###### 업로드되는 파일에 대한 정의를 라우터에 추가
업로드에 대한 post 메소드에 업로드되는 파일과 연결시켜주기 위해 `upload.single('uploadfile')`를 아래와 같이 수정한다.       
해당 설정은 전달될 파일에 대한 정보를 정의하는 것으로 메소드에 전달되는 값은 input(type=‘file’)에 정의한 요소의 이름과 일치해야 한다.        
```javascript
app.post('/upload', upload.single('uploadfile'), function (req, res) {
    console.log(req.file);
    res.redirect('/upload');
});
```
      
`console.log(req.file);` 에서는 업로드된 파일에 대한 정보가 아래와 같이 콘솔 로그에 출력된다.      
```
{ fieldname: 'uploadfile',
  originalname: 'web-book-for-full-stack.pdf',
  encoding: '7bit',
  mimetype: 'application/pdf',
  destination: 'uploads/',
  filename: 'fb34836128a9bfbf24a7972eaec32126',
  path: 'uploads/fb34836128a9bfbf24a7972eaec32126',
  size: 24498228 }
```

## 사용자가 정의한 파일명으로 저장하도록 수정
multer에서 기본적으로 파일명을 변경하여 저장을 하는데 사용자가 정의한 파일명으로 저장을 하기 위해 아래와 같이 코드를 수정한다       
```javascript
var storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, dir.upload);
    },
    filename: function (req, file, cb) {
        // cb(null, file.fieldname + '-' + Date.now())
        cb(null, file.originalname);
    }
});
```

