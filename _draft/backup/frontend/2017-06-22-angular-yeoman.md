---
layout: post
comments: true
title: "[AngularJS] yeoman으로 프로젝트 생성"
date: 2017-06-22 12:30:00
categories: Frontend
tags: javascript angular yeoman
---

Yeoman을 이용하여 간단한 angular 프로젝트를 생성하는 방법에 대하여 정리해보기.    

###### Yeoman … ???
[Yeoman](http://yeoman.io)은 Frontend 개발에 있어서 기본 템플릿을 설정하고 생성할 수 있게 도와주는 자동화 도구

## Install Yeoman 
```
npm install -g yo
```

## Generator
Yeoman 사이트에서 자신이 생성하고자 하는 프로젝트에 해당하는 [Generators | Yeoman](http://yeoman.io/generators/)를 검색하여 선택한다.   
이 중에 gulp 도구 사용법도 익히고자 하는 목적도 있어서, **AngularJS + Gulp**를 위한 [generator-gulp-angular](https://github.com/swiip/generator-gulp-angular#readme)를 선택해서 프로젝트를 생성하였다.     
해당 generator를 이용한 환경 생성 방법은 해당  Github를 참고해서 따라하면 된다. 
```
npm install -g gulp bower
npm install -g generator-gulp-angular
```

## project 생성
프로젝트를 생성할 폴더를 생성한다.
```
mkdir study-angular-yeoman
cd study-angular-yeoman
```
     
Yeoman을 이용하여 angular 프로젝트를 생성한다.     
(각 선택지에서 입맛에 맞게 선택하면..자동으로 프로젝트가 생성된다.)
```
$ yo gulp-angular

     _-----_
    |       |    .--------------------------.
    |--(o)--|    |         Welcome!         |
   `---------´   |     You're using the     |
    ( _´U`_ )    |  fantastic generator for |
    /___A___\    |      scaffolding an      |
     |  ~  |     | application with Angular |
   __'.___.'__   |         and Gulp!        |
 ´   `  |° ´ Y ` '--------------------------'

? Which version of Angular do you want? (Use arrow keys)
❯ 1.5.x (stable)
  1.2.x (legacy)
```
     
프로젝트 생성이 완료되면 아래와 같은 구조로 생성이 된다.
```
$ ls -l
total 552
-rw-r--r--    1 gloria  admin     627  6 22 11:11 bower.json
drwxr-xr-x   17 gloria  admin     578  6 22 11:13 bower_components
drwxr-xr-x    5 gloria  admin     170  6 22 11:11 e2e
drwxr-xr-x   12 gloria  admin     408  6 22 11:11 gulp
-rw-r--r--    1 gloria  admin     655  6 22 11:11 gulpfile.js
-rw-r--r--    1 gloria  admin    2716  6 22 11:11 karma.conf.js
drwxr-xr-x  748 gloria  admin   25432  6 22 11:13 node_modules
-rw-r--r--    1 gloria  admin  258159  6 22 11:13 package-lock.json
-rw-r--r--    1 gloria  admin    1524  6 22 11:13 package.json
-rw-r--r--    1 gloria  admin     746  6 22 11:11 protractor.conf.js
drwxr-xr-x    6 gloria  admin     204  6 22 11:11 src
```
      
`gulp serve`를 실행하면 웹화면으로 통해 간단한 샘플페이지를 확인할 수 있다.
```
$ gulp serve
[11:17:26] Using gulpfile /Volumes/data/private/study-angular-yeoman/gulpfile.js
[11:17:26] Starting 'scripts'...
[11:17:26] Starting 'styles'...
[11:17:27] gulp-inject 2 files into index.scss.
[11:17:27] Finished 'styles' after 566 ms
[11:17:27] all files 13.73 kB
[11:17:27] Finished 'scripts' after 773 ms
[11:17:27] Starting 'inject'...
[11:17:27] gulp-inject 1 files into index.html.
[11:17:27] gulp-inject 9 files into index.html.
[11:17:27] Finished 'inject' after 61 ms
[11:17:27] Starting 'watch'...
[11:17:27] Finished 'watch' after 19 ms
[11:17:27] Starting 'serve'...
[11:17:27] Finished 'serve' after 17 ms
[BS] [BrowserSync SPA] Running...
[BS] Access URLs:
 --------------------------------------
       Local: http://localhost:3000/
    External: http://10.250.65.60:3000/
 --------------------------------------
          UI: http://localhost:3001
 UI External: http://10.250.65.60:3001
 --------------------------------------
[BS] Serving files from: .tmp/serve
[BS] Serving files from: src
```

