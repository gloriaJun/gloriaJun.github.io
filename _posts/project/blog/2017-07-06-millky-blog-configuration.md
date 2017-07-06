---
layout: post
title: "[Blog] spring boot로 블로그 만들어보기"
date: 2017-07-06 18:00:00
projects: blog
tags: spring spring-boot gradle
---

[블로그개발-Millky](http://millky.com/@origoni/post/1100)의 글들을 참고해서 spring boot 기반의 블로그를 공부할 겸 만들어보려고 한다.    
기존에 booktree나 가계부 프로젝트를 직접 설계하여 하려고 하니 잘 진행도 안되고 지지부진해져서..일단은 블로그의 글을 보면서 차분히 따라가며 진행해보기로…   
단, 해당 블로그에서는 REST-API 기술과 화면 부분이 별도의 웹서버로 구현되어 있지 않아서 그 부분만 변경하여 진행해보고자 한다.   

그 과정들을 기록하기 위해 정리하기…   

## 프로젝트 생성
#### Backend 프로젝트 생성
api 서버 프로젝트를 spring boot 기반으로 생성한다. 생성한 프로젝트 구조는 아래와 같음.    
```
├── build.gradle
├── gradle.properties
├── settings.gradle
└── src
    └── main
        ├── java
        │   └── com
        │       └── study
        │           └── blog
        │               ├── Application.java
        │               └── controller
        │                   └── MainController.java
        └── resources
            └── application.yml

10 directories, 10 files
```   
        
###### gradle
`build.gradle` 파일 정의는 아래와 같이 하였음.    
```
group 'study'

buildscript {
    repositories {
        mavenCentral()
    }
    dependencies {
        classpath("org.springframework.boot:spring-boot-gradle-plugin:1.5.3.RELEASE")
    }
}

apply plugin: 'war'
apply plugin: 'java'
apply plugin: 'idea'
apply plugin: 'eclipse'
apply plugin: 'org.springframework.boot'

war {
    baseName = 'springboot-blog'
    version = '1.0-SNAPSHOT'
}

repositories {
    mavenCentral()
}

sourceCompatibility = 1.8
targetCompatibility = 1.8
compileJava.options.encoding = 'UTF-8'

dependencies {
    compile 'org.springframework.boot:spring-boot-starter-web'

    // database
    compile 'org.springframework.boot:spring-boot-starter-data-jpa'
    runtime 'com.h2database:h2'

    // other
    compileOnly 'org.projectlombok:lombok:1.16.16'

    // logging
    compile("ch.qos.logback:logback-classic:1.1.6")
    compile("ch.qos.logback:logback-core:1.1.6")
    compile("org.slf4j:slf4j-api:1.7.6")

    // test
    testCompile 'org.springframework.boot:spring-boot-starter-test'
    testCompile 'org.assertj:assertj-core:3.6.2'
}

task wrapper(type: Wrapper) {
    gradleVersion = '3.4.1'
}
```

#### Frontend 프로젝트 생성
Frontend는 "node + bower + gulp"를 이용하여 프로젝트를 생성하였다.    
각 설정 파일과 빌드스크립트는 아래와 같다. (현재는 좀 불편한 부분들이 좀 있지만...공부해가며 개선해나갈 계획이다.)

###### package.json
```json
{
  "name": "springboot-blog-ui",
  "version": "1.0.0",
  "description": "",
  "main": "app.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "devDependencies": {
    "gulp": "^3.9.1",
    "gulp-open": "^2.0.0",
    "gulp-webserver": "^0.9.1"
  }
}
```

###### bower.json
```json
{
  "name": "springboot-blog-ui",
  "homepage": "https://github.com/gloriaJun/springboot-blog",
  "description": "",
  "main": "",
  "license": "MIT",
  "ignore": [
    "**/.*",
    "node_modules",
    "bower_components",
    "test",
    "tests"
  ],
  "dependencies": {
    "jquery": "^3.2.1",
    "bootstrap": "^3.3.7"
  }
}
```

###### gulpfile.js
```
'use strict';

// import할 모듈 정의 :  import 되는 모듈들은 설치가 되어있어야 한다.
var gulp = require('gulp');
var webserver = require('gulp-webserver');
var open = require('gulp-open');

// source 및 산출물 경로 설정
var app = {
    src: './'
}

// webserver 설정
var port = 3000;

/*******************************
 * MAIN TASKS
 *******************************/
// create webserver
gulp.task('serve', function() {
    return gulp.src(app.src)
            .pipe(webserver({
                livereload: true,
                port: port
            }))
            .pipe(open({
                uri: 'http://localhost:' + port
            }));
});
```

###### index.html
라이브러리들이 반영된 것을 확인해보기 위해서 아래와 같이 간단한 페이지를 작성하였다.    

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=yes">

        <link rel="stylesheet" href="bower_components/bootstrap/dist/css/bootstrap.css">

        <title>Sample App:Main</title>
    </head>
    <body>
        <div class="container">
            <h1>This is Main Page<span class="glyphicon glyphicon-tree-deciduous" aria-hidden="true"></span></h1>

            <div>
                <button type="button" class="btn btn-default" aria-label="Left Align">
                  <span class="glyphicon glyphicon-menu-hamburger" aria-hidden="true"></span>
                </button>
            </div>

            <!-- Split button -->
            <div class="btn-group">
              <button type="button" class="btn btn-danger">Action</button>
              <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                <span class="caret"></span>
                <span class="sr-only">Toggle Dropdown</span>
              </button>
              <ul class="dropdown-menu" role="menu">
                <li><a href="#">Action</a></li>
                <li><a href="#">Another action</a></li>
                <li><a href="#">Something else here</a></li>
                <li class="divider"></li>
                <li><a href="#">Separated link</a></li>
              </ul>
            </div>
        </div>
        <!-- footer -->
        <script src="bower_components/jquery/dist/jquery.js"></script>
        <script src="bower_components/bootstrap/dist/js/bootstrap.js"></script>
    </body>
</html>
```

생성한 웹서버를 아래와 같이 실행시킬 수 있다.   
```
$ gulp serve
[21:52:52] Using gulpfile ~/Documents/study/springboot-blog/ui/gulpfile.js
[21:52:52] Starting 'serve'...
[21:52:52] Webserver started at http://localhost:3000
[21:52:52] Opening http://localhost:3000 using the default OS app
[21:52:52] Finished 'serve' after 39 ms
```
   
정상적으로 실행이 되면 아래와 같은 페이지를 확인할 수 있다.
![]({{ site.url }}/assets/images/post/2017/0706-spring-blog-project-first.png)


     

