---
layout: post
comments: true
title: "[NodeJS] 웹어플리케이션 만들기 실습 : Database 연동 - 3"
date: 2017-07-17 13:50:00
categories: Frontend
tags: nodejs express jade mysql
---

**관련 글들**
[웹어플리케이션 만들기 실습 - 1]({% post_url category/frontend/2017-07-14-nodejs-webapp-ex1 %})     
[웹어플리케이션 만들기 실습 : 파일 업로드 - 2]({% post_url category/frontend/2017-07-14-nodejs-webapp-ex2 %})
      
데이터베이스(mysql)을 연동하기     

## 테이블 생성
데이터베이스를 생성한 뒤 해당 데이터베이스를 선택한다.      
```sql
CREATE DATABASE souldb CHARACTER SET utf8;
use souldb;
```
       
테이블 및 샘플 데이타를 입력한다.     
```sql

CREATE TABLE `topic` (
`id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `author` varchar(30) NOT NULL,
  PRIMARY KEY (id)
);
INSERT INTO topic (title, description, author) VALUES('JavaScript','Computer language for web.', 'soul');
```
    
## node를 이용한 데이터베이스 접속
#### mysql 모듈 설치
[node0mysql](https://github.com/mysqljs/mysql)을 npm을 이용하여 접속한다.    
```
npm install mysql --save 
```

#### DB 접속 정보 설정 및 연결
```javascript
// mysql
var mysql = require('mysql');
var conn = mysql.createConnection({
    host    : '192.168.99.100',
    user    : 'soul',
    password: 'soul1234',
    database: 'souldb'
});
conn.connect();
```

## CRUD 어플리케이션 수정
[웹어플리케이션 만들기 실습 - 1]({% post_url category/frontend/2017-07-14-nodejs-webapp-ex1 %})에서 생성한 `/board`를 DB를 사용하여 CRUD를 수행하도록 코드를 수정한다. 

/`app.js` 에서 변경한 부분만 정리하였으며, 수정된 전체 코드는 [[nodejs-webapp-step2 · GitHub](https://gist.github.com/gloriaJun/c8246a7ad0a1ebba04e3db8dc521c068)]를 참고/

#### 목록 조회
기존에 파일을 읽어서 가져오던 부분을 아래와 같이 수정하였음.     
```javascript
// 변경되는 path var는 ":"을 주어 표시하고 아래와 같이 가져올 수 있다
var sql = 'SELECT id, title, author FROM topic';
    conn.query(sql, function (err, rows, fields) {
        if(err) {
            console.log(err);
            res.status(500).send('Internal Server Error');
        }

        var id = req.params.id;
        // 만약, path에서 id가 포함되어 요청이 온 경우라면...
        if (id) {
            var sql = 'SELECT * FROM topic WHERE id = ?';
            conn.query(sql, [id], function(err, row, fields) {
                if(err) {
                    console.log(err);
                    res.status(500).send('Internal Server Error');
                }
                
                console.log(row);
                res.render('board/list', {
                    topics: rows,
                    topic: row[0]
                });
            });
        } else {
            res.render('board/list', {topics: rows});
        }
    });
```

#### 게시글 추가
```javascript
    var params = req.body;
    var title = params.title;
    var description = params.description;
    var author = params.author;

    var sql = 'INSERT INTO topic (title, description, author) VALUES (?, ?, ?)';
    conn.query(sql, [title, description, author], function (err, result, fields) {
        if(err) {
            console.log(err);
            res.status(500).send('Internal Server Error');
        }
         // 목록 조회 페이지로 redirect 처리
        res.redirect(path.board + '/' + result.insertId);
    });
```

#### 게시글 편집
```javascript
app.get('/board/:id/edit', function (req, res) {
    var id = req.params.id;
    var sql = 'SELECT * FROM topic WHERE id = ?';
    conn.query(sql, [id], function(err, row, fields) {
        if(err) {
            console.log(err);
            res.status(500).send('Internal Server Error');
        }

        res.render('board/edit', {
            topic: row[0]
        });
    });
});
app.post('/board/:id/edit', function(req, res) {
    var params = req.body;
    var id = params.id;
    var title = params.title;
    var description = params.description;
    var author = params.author;

    var sql = 'UPDATE topic ' +
        'SET ' +
        '   title = ?, description = ?, author = ? ' +
        'WHERE id = ?';
    conn.query(sql, [title, description, author, id], function (err, result, fields) {
        if(err) {
            console.log(err);
            res.status(500).send('Internal Server Error');
        }
        // 목록 조회 페이지로 redirect 처리
        res.redirect(path.board + '/' + id);
    });
});
```

####  게시글 삭제
```javascript
app.get('/board/:id/delete', function (req, res) {
    var id = req.params.id;
    var sql = 'DELETE FROM topic WHERE id = ?';
    conn.query(sql, [id], function(err, row, fields) {
        if(err) {
            console.log(err);
            res.status(500).send('Internal Server Error');
        }

        res.redirect(path.board);
    });
});
```
