---
layout: post
comments: true
title: "[NodeJS] 웹어플리케이션 만들기 실습 - 1"
date: 2017-07-14 14:30:00
categories: Frontend
tags: nodejs express jade
---

해당 실습은 생활코딩의 [nodejs 강좌](https://opentutorials.org/course/2136/11850)를 참고하여 실습한 내용들에 대한 정리내용임.     

## 필요한 모듈 설치 및 서버 생성
#### 모듈 설치
```
npm install express jade body-parser --save
```

#### 서버 생성
웹어플리케이션 생성을 위한 모듈 호출 및 기본적인 설정과 서버를 실행하기 위한 코드를 작성한다.     
```javascript
var express = require('express');
// request body에 담긴 값을 읽기 위한 모듈
var bodyParser = require('body-parser');

// 가져온 모듈이 실제는 함수라서 호출하면 application을 리턴한다
var app = express();

const host = {
    ip : '127.0.0.1',
    port : 3000
}

// express와 템플릿 엔진(jade)를 연결해준다
app.set('view engine', 'jade');
// 템플릿이 위치한 경로를 설정한다
app.set('views', './views');
// 템플릿 엔진을 이용하여 렌더링된 html을 보기 좋게 출력하기 위해 설정한다
app.locals.pretty = true;

// for parsing application/json
app.use(bodyParser.json());
// for parsing application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));

// 정적 파일이 위치하는 디렉토리를 정의
app.use(express.static('public'));

/**----------------------------
 * Create Server
 -----------------------------*/
// 포트를 지정해주면 해당 포트로 리스닝하는 서버를 생성한다
app.listen(host.port, function () {
    console.log(`Server running at http://${host.ip}:${host.port}/`);
});
```

## 게시판 만들기
게시글을 작성하고, 리스트로 확인하기 위한 기능을 만들어 본다.     

#### 게시글 작성
게시글을 작성하기 위한 폼을 작성한다.     
```jade
doctype html
html
    head
        meta(charset='utf-8')
        title 게시글 작성
    body
        form(method='post')
            p
                lable 제목
                input(type='text' name='title' placeholder='제목을 입력하세요')
            p
                lable 내용
                textarea(name='description')
            p
                input(type='submit')
```
       
다음으로는 폼을 출력하기 위한 코드와 전달받은 데이타를 저장하기 위한 코드를 작성한다.   (여기서 전달받은 데이타는 `data/`에 파일로 작성하도록 하였음)      
```javascript
app.get('/board/add', function (req, res) {
    res.render('board/add');
});

app.post('/board/add', function(req, res) {
    var params = req.body;
    var title = params.title;
    var description = params.description
    console.log(params);

    // 전달받은 데이터를 저장
    fs.writeFile(dir.data + 'board/' + title, description, function (err) {
        if(err) {
            console.log(err);
            res.status(500).send('Internal Server Error');
        }
    })

    res.send('Add Success !!!');
});
```

#### 게시글 목록 조회
작성된 글들의 목록을 조회하는 리스트 화면을 작성한다.      
```jade
doctype html
html
    head
        meta(charset='utf-8')
        title 게시글 목록 조회
    body
        h1 Board List

        ul
            each title in topics
                li
                    a(href='/board/' + title)= title
```
          
`/data/board` 디렉토리에 저장된 게시글들의 데이타 목록을 가져와서 전달하는 router를 작성한다.
```javascript
app.get('/board', function(req, res) {
    var cnt = 0;
    // 저장된 글 목록을 출력하기 위해 디렉토리의 파일 갯수와 정보를 읽는다
    fs.readdir(dir.data + 'board/', function (err, files)  {
        if(err) {
            console.log(err);
            res.status(500).send('Internal Server Error');
        }

        res.render('board/list', {
            topics: files
        });
    });
});
```

#### 게시글 확인
요청이 들어온 글을 조회해서 확인하는 부분을 `list.jade` 파일에 추가한다.     
```jade
doctype html
html
    head
        meta(charset='utf-8')
        title 게시글 목록 조회
    body
        h1
            a(href='/board') Board List

        hr
        ul
            each topic in topics
                li
                    a(href='/board/' + topic)= topic
        hr
        div
            a(href='/board/add') 등록

        // 게시글 링크 클릭 시 내용 출력
        article
            h4= title
            = description
```
        
router를 작성한다.        
```javascript
app.get('/board/:id', function(req, res) {
    // 변경되는 path var는 ":"을 주어 표시하고 아래와 같이 가져올 수 있다
    var id = req.params.id;

    fs.readdir(dir.data + 'board/', function (err, files)  {
        if(err) {
            console.log(err);
            res.status(500).send('Internal Server Error');
        }

        fs.readFile(dir.data + 'board/' + id, 'utf8', function(err, data) {
            if(err) {
                console.log(err);
                res.status(500).send('Internal Server Error');
            }
            res.render('board/list', {
                topics: files,
                title: id,
                description: data
            });
        });
    });
});
```

## 작성된 코드 리팩토링
작성된 코드들에 대해 중복된 코드 등을 제거하는 등 코드를 리팩토링 한다.

#### 중복 코드 제거
###### path 정리
Express에서는 router에 여러 개의 path를 받을 수 있다.  해당 기능을 이용하여 `/board`와 `/board/detail/.:filename` 부분의 코드를 정리한다.     
```javascript
// 변경되는 path var는 ":"을 주어 표시하고 아래와 같이 가져올 수 있다
app.get(['/board', '/board/:id'], function(req, res) {
    var template = 'board/list';

    // 저장된 글 목록을 출력하기 위해 디렉토리의 파일 갯수와 정보를 읽는다
    fs.readdir(dir.data + 'board/', function (err, files)  {
        if(err) {
            console.log(err);
            res.status(500).send('Internal Server Error');
        }

        // filename의 유무에 따라서 로직을 처리하도록 개선한다
        var id = req.params.id;

        if (id) {
            fs.readFile(dir.data + 'board/' + fileidname, 'utf8', function(err, data) {
                if(err) {
                    console.log(err);
                    res.status(500).send('Internal Server Error');
                }
                res.render('board/list', {
                    topics: files,
                    title: id,
                    description: data
                });
            });
        } else {
            res.render('board/list', {
                topics: files
            });
        }
    });
});
```

###### 기타 중복 코드 정리


#### board/list.jade
`article` 부분이 데이타가 존재하지 않는 경우에는 출력되지 않도록  if 문을 추가하여 아래와 같이 수정     
```jade
        if title
            // 게시글 링크 클릭 시 내용 출력
            article
                h4= title
                = description
```

#### 등록 후, 내용 상세 보는 곳으로 redirect 처리
게시글을 등록한 후에 특정 페이지로 보내도록 처리    
```javascript
app.post('/board/add', function(req, res) {
    var params = req.body;
    var title = params.title;
    var description = params.description
    console.log(params);

    // 전달받은 데이터를 저장
    fs.writeFile(dir.data + 'board/' + title, description, function (err) {
        if(err) {
            console.log(err);
            res.status(500).send('Internal Server Error');
        }
    })

    // 등록한 글에 대한 내용을 확인하는 페이지로 redirect 처리
    res.redirect('/board/' + title);
});

```

> 전체 코드는 [https://gist.github.com/gloriaJun/4ae50a47b311668f6b1b13ea63c20760](https://gist.github.com/gloriaJun/4ae50a47b311668f6b1b13ea63c20760) 에서 확인 가능   
