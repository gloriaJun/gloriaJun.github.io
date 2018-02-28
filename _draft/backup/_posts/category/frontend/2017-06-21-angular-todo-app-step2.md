---
layout: post
comments: true
title: "[AngularJS] todo 어플리케이션 만들기 - Step 2"
date: 2017-06-21 23:30:00
categories: Frontend
tags: javascript AngularJS
---

[간단 실습하기  Step1]({% post_url category/frontend/2017-06-21-angular-todo-app-step1 %})에서 이어서 실습하기...    
이번에는 controller를 만들어서 웹화면에 메시지를 출력해보기.    
      
아래와 같이 디렉토리 구조를 생성하였음.
```
├── app
│   ├── app.js
│   ├── controller
│   ├── directive
│   └── service
├── gulpfile.js
├── index.html
└── package.json
```

#### app/app.js
```javascript
var myApp = angular.module('myApp', []);
```

#### app/controller/todoController.js
```javascript
myApp.controller('TodoController', ['$scope', function($scope) {
  $scope.title = 'My ToDo List';
}]);
```

#### index.html
아래와 같이 변경해준다.
```html
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=yes">

	<script src="node_modules/angular/angular.js"></script>
	<script src="app/app.js"></script>
	<script src="app/controller/todoController.js"></script>

	<title>My Angular Todo App</title>
</head>

<body>
	<div ng-app="myApp" ng-controller="TodoController">
		<h1>{{ title }}</h1>
	</div>
</body>

</html>
```

#### 확인
`gulp serve`를 구동하면 웹화면에서 “My ToDo List” 라는 메시지가 출력되는 것을 확인할 수 있음.

> **Reference**      
> [앵귤러로 Todo앱 만들기 3 - 컨트롤러](http://blog.jeonghwan.net/lectures/todomvc-angular/3/)       