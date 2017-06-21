---
layout: post
comments: true
title: "[AngularJS] todo 어플리케이션 만들기 - Step 1"
date: 2017-06-21 22:30:00
categories: Frontend
tags: javascript AngularJS
---

angularJS를 이용하여 [앵귤러로 Todo앱 만들기 2 - 앵귤러 로딩](http://blog.jeonghwan.net/lectures/todomvc-angular/2/)에 정리된 ToDO 어플리케이션 만들기 실습 따라하기…

##   개발 환경 구성하기
###### Initiate NPM 
`package.json`파일을 생성한다.
```
npm init
```

###### Install Angular
```
npm install angular --save
```

###### Install gulp
자바스크립트 빌드 및 웹서버 기동을 위해 gulp 를 설치한다.
```
npm install gulp gulp-webserver --save-dev
```

###### gulpfile.js
```javascript
'use strict';

// import할 모듈 정의 :  import 되는 모듈들은 설치가 되어있어야 한다.
var gulp = require('gulp');
var webserver = require('gulp-webserver');

var src = '.'
var port = '3000';

/*******************************
 * MAIN TASKS
  *******************************/
// webserver를 실행한다.
gulp.task('serve', function() {
    gulp.src(src)
    	.pipe(webserver({
            livereload: true,
            open: true,
            port: port
    }));
});
```


## index.html
간단한 `index.html`파일을 생성한 뒤에  아래와 같이 간단한 페이지를 작성한 뒤에 실행을 해보면 웹화면에 **2 + 5 = 7**이라는 문구가 출력됨으로써 정상적으로 angular 모듈이 로딩된 것을 확인할 수 있다.
{% raw %}
```html
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=yes">

	<script src="node_modules/angular/angular.js"></script>
	
	<title>My Angular Todo App</title>
</head>

<body>
	<div ng-app="">
	<p>2 + 5 = {{ 2 + 5 }}</p>
	</div>
</body>

</html>
```
{% endraw %}
     
> **Reference**      
> [앵귤러로 Todo앱 만들기 2 - 앵귤러 로딩](http://blog.jeonghwan.net/lectures/todomvc-angular/2/)       