---
layout: post
comments: true
title: "[Angular] angular 시작하기 (node + bower + gulp)"
date: 2017-06-17 13:30:00
categories: Frontend
tags: javascript angular
---

AngularJS 개발을 위한 환경 구축 방법에 대한 정리

#### Prepare
다음과 같은 도구가 설치되어 있어야 한다.
* node - was와 같은 frontend 웹 프레임워크
* bower - 패키지 의존성 관리 도구 
* gulp - javascript 빌드 도구 (grunt도 빌드 도구에 속함)
   
bower, gulp는 node가 설치되어 있는 상태에서 아래와 같이 설치 할 수 있다.   
(`-g`는 전역으로 설치한다는 의미인 듯함)

```
npm install -g gulp bower
```

## 프로젝트 생성
프로젝트를 생성할 디렉토리를 생성하고, 다음과 같은 과정을 수행해준다.

```
mkdir angluar-first-app
cd angluar-first-app
```

#### npm 설정
`npm init`을 수행하여 `package.json` 파일을 생성한다.

```
$ npm init
This utility will walk you through creating a package.json file.
It only covers the most common items, and tries to guess sensible defaults.

See `npm help json` for definitive documentation on these fields
and exactly what they do.

Use `npm install <pkg>` afterwards to install a package and
save it as a dependency in the package.json file.

Press ^C at any time to quit.
package name: (angluar-first-app)
version: (1.0.0) 0.0.1
description: first app
entry point: (index.js) 
test command:
git repository:
keywords:
author: gloria
license: (ISC)
About to write to /Users/gloria/Documents/study/study-angular/angluar-first-app/package.json:

{
  "name": "angluar-first-app",
  "version": "0.0.1",
  "description": "first app",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "gloria",
  "license": "ISC"
}


Is this ok? (yes) yes
[13:56:24] ~/Documents/study/study-angular/angluar-first-app (master)
$ ls -al
total 8
drwxr-xr-x  3 gloria  staff  102  6 17 13:56 .
drwxr-xr-x  8 gloria  staff  272  6 17 13:55 ..
-rw-r--r--  1 gloria  staff  230  6 17 13:56 package.json
```

###### 의존성 추가
앞에서 생성한 package.json에 gulp, bower에 대한 의존성을 추가해준다.    
개발 단계에서만 필요한 부분이므로 `--save-dev` 옵션을 주어 설치한다.

```
$ npm install bower gulp --save-dev
```

#### bower 설정
`bower init`을 수행하여 `bower.json` 파일을 생성한다.

```
$ bower init
? name angluar-first-app
? description first app
? main file index.js
? keywords
? authors gloria
? license ISC
? homepage https://github.com/gloriaJun/study-angular
? set currently installed components as dependencies? Yes
? would you like to mark this package as private which prevents it from being accidentally published to the registry? Yes
cidentally published to the registry? (y/N) Y
{
  name: 'angluar-first-app',
  description: 'first app',
  main: 'index.js',
  authors: [
    'gloria'
  ],
  license: 'ISC',
  homepage: 'https://github.com/gloriaJun/study-angular',
  private: true,
  ignore: [
    '**/.*',
    'node_modules',
    'bower_components',
    'test',
    'tests'
  ]
}

? Looks good? Yes
```

###### .bowerrc 
bower에 전체적으로 적용할 설정을 정의한 파일을 생성한다. 아래는 bower에서 관리되는 의존성 파일들을 다운로드할 디렉터리에 대해서만 정의하였음.

```
{
  "directory": "bower_components"
}
```

###### 의존 라이브러리 추가
아래와 같이 의존라이브러리를 추가해준다.

```
$ bower install bootstrap --save
```

#### gulp 설정
gulp는 node 기반에서 동작하는 자바스크립트 빌드 도구 이다.   
작성된 자바스크립트를 컴파일 및 minify 하는 동작 등에 대해 task로 정의 및 관리할 수 있게 해준다.   
먼저 웹서버를 띄우기 위한 패키지를 설치한다.

###### gulp-connect
gulp-connect는 웹서버를 띄우고 문서를 수정하고 저장하면 띄워져 있는 웹페이지를 새로고침해주는 기능을 제공한다.   
해당 패키지는 아래와 같이 설치 할 수 있다.
```
npm install gulp-connect --save-dev
```

###### gulp-webserver
gulp-webserver는 gulp-connect와 동일한 기능을 제공하나 진행 중인 프로젝트의 웹페이지를 화면에 출력해주는 기능을 추가로 제공한다.
```
npm install gulp-webserver --save-dev
```

`gulpfile.js` 파일에 설정할 내용들을 작성한다.   

```
'use strict';

// import할 모듈 정의 :  import 되는 모듈들은 설치가 되어있어야 한다.
var gulp = require('gulp');
var connect = require('gulp-connect');
var webserver = require('gulp-webserver');

var src = './src'
var port = '8888';

/*******************************
 * MAIN TASKS
  *******************************/
// webserver를 실행한다.
gulp.task('connect', function() {
    connect.server({
        root: src,
        livereload: true,
        port: port
    });
});

gulp.task('serve', function() {
    gulp.src(src)
        .pipe(webserver({
            livereload: true,
            open: true,
            port: port
    }));
});
```

## 샘플 페이지 작성
`src/index.html` 파일을 아래와 같이 작성한다.

```
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Start Angularjs</title>
</head>

<body>

<div ng-app="">
      <p>Name: <input type="text" ng-model="name"></p>
      <p ng-bind="name"></p>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
</body>
</html>
```

`gulp serve`를 실행하면 웹페이지가 출력되는 것을 확인할 수 있다.
![]({{ site.url }}/assets/images/post/2017/0617-angluarjs-first-app.png)  

> *Reference*    
> [road..道..みち: npm, bower, gulp 를 이용한 웹 클라이언트 개발 환경 구축](https://roadmichi.blogspot.kr/2016/06/npm-bower-gulp.html)    
> [Gulp.js Gulp 입문 ① - Gulp에 대한 소개 | 감성 프로그래밍](http://programmingsummaries.tistory.com/356)   
> [걸프(Gulp) 4. gulp-webserver (웹서버 띄우기 + 자동 새로고침 2) - 회복맨 블로그](http://recoveryman.tistory.com/293)    

