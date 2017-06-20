---
layout: post
comments: true
title: "[AngularJS] 간단 실습하기  Step2"
date: 2017-06-20 22:30:00
categories: Frontend
tags: javascript AngularJS
---

[간단 실습하기  Step1]({% post_url category/frontend/2017-06-19-angular-step1 %})에서 작성한 코드를 “service, controller, application”으로 파일을 분리하기.   

#### Application 모듈
`mainApp.js` 파일을 생성한 뒤 아래와 같이 작성하여 저장한다.
```javascript
var mainApp = angular.module("mainApp", []);
```

#### Controller 모듈
`myController.js` 파일을 생성하고,  controller에 해당하는 부분을 작성하여 저장한다.
```javascript
mainApp.controller("myController",  function($scope) {
	$scope.week={
		day: "Monday",
		schedule: "피아노",

		scheduleList:function() {
			var weekObject;
			weekObject = $scope.week;
			return weekObject.day + " " + weekObject.schedule;
		}
	};
});
```

#### index.html 파일 수정
분리된 코드가 작성된 스크립트 파일을 포함시키도록 변경한다.
```html
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Global Travel</title>
</head>

<body>

<h1>Global Travel</h1>

<div ng-app="mainApp" ng-controller="myController">
	  <p>요일 : <input type="text" ng-model="week.day"></p>
	  <p>스케쥴 : <input type="text" ng-model="week.schedule"></span></p>

	  <p> 입력된 값 : {{week.scheduleList()}}
</div>

	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
	<script src="mainApp.js"></script>
	<script src="myController.js"></script>

</body>
</html>
```
