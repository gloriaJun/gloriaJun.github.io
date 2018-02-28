---
layout: post
comments: true
title: "[Gulp] gulp를 이용한 javascript 빌드 자동화"
date: 2017-07-05 16:30:00
categories: Frontend
tags: gulp
---

[Gulp](https://github.com/gulpjs/gulp)는 Grunt와 같은 자동화 빌드 시스템이다.    
예를 들어, javascript, css와 같은 파일의 용량을 줄이기 위한 압축, 병합 등에 대한 작업을 자동화 및 웹서버로 동작할 수 있도록 해주는 등의 일을 할 수 있다.    
       
해당 페이지에서는 javascript 기반의 간단한 웹페이지를 만들고 gulp를 이용하여 빌드 및 서버를 기동해보는 방법에 대해 정리하려고 한다.    

## 프로젝트 생성 및 gulp 설치
 gulp는 node 기반에서 동작하므로 node가 설치되어 있어야 하며, 아래와 같이 프로젝트 생성을 하고 gulp를 설치해준다.
```
mkdir study-gulp
cd study-gulp
npm init
npm install gulp -g
npm install gulp --save-dev
```

## 프로젝트 구조 설정
아래와 같이 프로젝트 구조를 설정하였다.     
```
$ tree
.
├── gulpfile.js
├── package-lock.json
├── package.json
└── src
    ├── index.html
    └── public
        └── scss
        └── js

3 directories, 6 files
```

## gulp 관련 패키지 설치
파일 병합 및 압축 등을 위한 패키지를 설치한다.
```
npm install gulp-uglify gulp-concat  gulp-sass gulp-minify-css gulp-webserver gulp-open gulp-clean --save-dev
```
     
각 패키지들에 대한 설명은 아래와 같다.    
* gulp-uglify  :  javascript 파일을 압축하기 위한 패키지
* gulp-concat  : 파일을 병합하기 위한 패키지 
*  gulp-sass :  scss 파일 컴파일을 위한 패키지
* gulp-minify-css :  css  파일을 압축하기 위한 패키지
* gulp-webserver : 웹서버를 구동을 위한 패키지
* gulp-open : 웹서버 구동 후, 웹브라우저에 출력을 위한 패키지
* gulp-clean : 빌드 산출물을 삭제하기 위한 패키지

## 웹서버 기동
#### index.html 
아래와 같이 간단한 `index.html`을 생성한다.
```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=yes">

        <link rel="stylesheet" href="public/css/style.css"/>
        <script src="public/js/sample.js"></script>

        <title>Sample App:Main</title>
    </head>
    <body>
        <h1>Sample Page</h1>
        This is Index Page.
    </body>
</html>
```

#### gulpfile.js
웹서버 기동을 위해 아래와 같이 파일을 작성한다.
```javascript
'use strict';

// import할 모듈 정의 :  import 되는 모듈들은 설치가 되어있어야 한다.
var gulp = require('gulp');
var webserver = require('gulp-webserver');
var open = require('gulp-open');

var distSrc = 'src/';
var port = 3000;

gulp.task('serve', function() {
    return gulp.src(distSrc)
            .pipe(webserver({
                port: port
            }))
            .pipe(open({
                uri: 'http://localhost:' + port
            }));
});
```
     
작성 후에 아래와 같이 실행하면 웹브라우저를 통하여 index.html에 작성된 내용을 확인할 수 있다.     
```
$ gulp serve
[19:11:47] Using gulpfile /Volumes/data/private/study-javascript/gulpfile.js
[19:11:47] Starting 'serve'...
[19:11:47] Webserver started at http://localhost:3000
[19:11:47] Opening http://localhost:3000 using the default OS app
[19:11:47] Finished 'serve' after 34 ms
```

## javascript 파일 생성
gulp-concat과 gulp-uglify를 반영해보기 위해서 간단한 javascript 파일을 작성한다.

#### 샘플 코드 작성
###### src/public/js/test1.js
```javascript
console.log('test1.js');
```

###### src/public/js/test2.js
```javascript
console.log('test2.js');
```

#### gulpfile 수정
기존에 작성한 `gulpfile.js`에  빌드 산출물 디렉토리에  javascritp 파일을 병합 및 압축하여 생성하는 로직을 추가한다.    
```javascript
var gulp = require('gulp');
var webserver = require('gulp-webserver');
var open = require('gulp-open');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');

// source 및 산출물 경로 설정
var app = {
    src: 'src/',
    dist: 'dist/'
}
var jsFiles = 'public/js/**/*.js';
var cssFiles = 'public/css/**/*.scss';

// webserver 설정
var port = 3000;

/*******************************
 * MAIN TASKS
 *******************************/
// javascript build
gulp.task('js', function() {
    var idx = jsFiles.lastIndexOf("/");
    var dir = jsFiles.substring(0, idx).replace("**", "");
    return gulp.src(app.src + jsFiles)
            .pipe(concat('sample.js'))
            .pipe(uglify())
            .pipe(gulp.dest(app.dist + dir));
});

// create webserver
gulp.task('serve', function() {
    return gulp.src(app.src)
            .pipe(webserver({
                port: port
            }))
            .pipe(open({
                uri: 'http://localhost:' + port
            }));
});
```

#### Task 실행
`gulp js`를 수행하여 해당 task를 실행한다.   
```
$ gulp js
[13:25:03] Using gulpfile /Volumes/data/private/study-javascript/gulpfile.js
[13:25:03] Starting 'js'...
[13:25:03] Finished 'js' after 58 ms
```
      
해당 task를 수행한 후에 빌드 산출물 경로를 확인하면 파일이 생성된 것을 확인할 수 있다.
```
$ tree dist/
dist/
└── public
    └── js
        └── sample.js

2 directories, 1 file

$ cat dist/public/js/sample.js
console.log("test1.js"),console.log("test2.js");
```

## scss 파일 생성
scss파일을 작성하고, 작성된 파일을 css로 컴파일 및 병합하는 로직을 작성한다.

#### 샘플 코드 작성
###### src/public/css/main.scss
```css
$primary-color: #333;

body {
  background-color: $primary-color;
}
```

###### src/public/css/error.scss
```css
.error {
    border : 1px solid red;
    background-color : #fdd;
}
.seriousError {
    @extend .error;
    border-width : 3px;
}
```

#### gulpfile 수정
기존에 작성한 `gulpfile.js`에   scss 파일을 컴파일 및 압축을 위한 로직을 추가한다.    
```javascript
var sass = require('gulp-sass');
var minifyCss = require('gulp-minify-css');

// sass build
gulp.task('sass', function() {
    var idx = cssFiles.lastIndexOf("/");
    var dir = cssFiles.substring(0, idx).replace("**", "");
    return gulp.src(app.src + cssFiles)
            .pipe(concat('style.css'))
            .pipe(sass())
            .pipe(minifyCss())
            .pipe(gulp.dest(app.dist + dir));
});
```

#### Task 실행
`gulp sass`를 수행하여 해당 task를 실행한다.   
```
$ gulp sass
[15:51:15] Using gulpfile /Volumes/data/private/study-javascript/gulpfile.js
[15:51:15] Starting 'sass'...
[15:51:15] Finished 'sass' after 19 ms
```
      
해당 task를 수행한 후에 빌드 산출물 경로를 확인하면 파일이 생성된 것을 확인할 수 있다.
```
$ tree dist/
dist/
└── public
    ├── js
    │   └── sample.js
    └── css
        └── style.css

3 directories, 2 files

$ cat dist/public/css/style.css
.error,.seriousError{border:1px solid red;background-color:#fdd}.seriousError{border-width:3px}body{background-color:#333}
```

## html 코드를 산출물 디렉토리로 복사 및 clean task 추가
빌드 시 html 파일들도 산출물 디렉토리인 `dist` 로 복사하는 로직 및 빌드 산출물을 clean하기 위한 task를 추가한다.   
```javascript
var clean = require('gulp-clean');

var htmlFiles = '**/*.html';

// html copy
gulp.task('html', function() {
    return gulp.src(app.src + htmlFiles)
            .pipe(gulp.dest(app.dist));
});

// clean
gulp.task('clean', function() {
    return gulp.src(app.dist, {read: false})
            .pipe(clean());
});
```

## 파일 변경 감지를 위한  task 추가
파일이 변경되면 자동으로 빌드 디렉토리의 내용을 갱신하기 위한 task를 추가한다.      
```javascript
// watch for update if modify
gulp.task('watch', function() {
    gulp.watch(app.src + jsFiles, ['js']);
    gulp.watch(app.src + cssFiles, ['sass']);
    gulp.watch(app.src + htmlFiles, ['html']);
});
```

## 웹서버 기동 task 수정
`serve` task 수행 시에 “clean - 빌드 관련 task” 들을 수행 하고 동작되도록 수정한다.     
```javascript
// create webserver
gulp.task('serve', ['clean', 'js', 'sass', 'html', 'watch'], function() {
    return gulp.src(app.dist)
            .pipe(webserver({
                livereload: true,
                port: port
            }))
            .pipe(open({
                uri: 'http://localhost:' + port
            }));
});
```
      
`serve` task 수행하면 아래와 같이 수행된 task를 로그 메시지를 통하여 확인할 수 있다.    
```
$ gulp serve
[16:07:22] Using gulpfile /Volumes/data/private/study-javascript/gulpfile.js
[16:07:22] Starting 'clean'...
[16:07:22] Starting 'js'...
[16:07:22] Starting 'sass'...
[16:07:22] Starting 'html'...
[16:07:22] Finished 'clean' after 20 ms
[16:07:22] Finished 'js' after 77 ms
[16:07:22] Finished 'sass' after 74 ms
[16:07:22] Finished 'html' after 72 ms
[16:07:22] Starting 'serve'...
[16:07:22] Webserver started at http://localhost:3000
[16:07:22] Opening http://localhost:3000 using the default OS app
[16:07:22] Finished 'serve' after 18 ms
```


> **Reference**      
> [Web Club :: Gulp #1(걸프 설치 및 개요)](http://webclub.tistory.com/467)        
> [걸프(Gulp) 1. 소개 및 설치 - 회복맨 블로그](http://recoveryman.tistory.com/285)        
> [Gulp – 초보자 따라하기 (Webstorm)](http://wagunblog.com/wp/?p=1823)       

