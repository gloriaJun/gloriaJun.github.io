---
layout: post
comments: true
title: "[AngularJS] 간단 실습하기  Step1"
date: 2017-06-19 22:30:00
categories: Frontend
tags: javascript angular
---

개발 환경 구성이 되어 있지 않다면 [angular 시작하기]({% post_url category/frontend/2017-06-17-angular-start %}) 참고.    
개념 정리가 필요하면 [AngularJS 개념 정리 (ver1 기준)]({% post_url category/frontend/2017-03-31-frontend-angularjs-overview %}) 참고     
      
## Directives
###### ng-app
해당 문구가 명시된 부분이 angular 앱이라는 것을 알려준다.

```html
<div ng-app="">
	  <p>Name: <input type="text" ng-model="name"></p>
	  <p>Hello!! <span ng-bind="name"></span>.</p>
</div>
```

###### ng-init
데이터들을 초기화 해준다.

```html
<div ng-app="" ng-init="colors = ['빨강', '보라', '초록']">
</div>
```

###### ng-model
변수를 설정한다.

```html
<p>Name: <input type="text" ng-model="name"></p>
```

###### ng-repeat
collection에 담긴 item을 하나씩 출력한다.  for, while 문과 같은 동작임.
{% raw %}
```html
<div ng-app="" ng-init= "colors = ['빨강', '보라', '초록']">
	  <ol>
	  	<li ng-repeat = "color in colors">
	  		{{ color }}
	  	</li>
	  </ol>
</div>
```
{% endraw %}

###### ng-bind
변수에 값을 바인딩하여 출력한다.
```html
<p>Hello!! <span ng-bind="name"></span>.</p>
```
    
참고로  `ng-bind`를 이용하여 출력할 수도 있지만 `{{ }}` 괄호를 이용하여서도 출력할 수 있다.
{% raw %}
```html
<p>Hello!! {{name}}</p>	
```
{% endraw %}


## Contoller
contorller는 html 뷰를 구성하기 위한 비지니스 로직을 구현하는 데 사용한다.   
간단한 예제는 아래와 같다.
{% raw %}
```html
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<title>Global Travel</title>
</head>

<body>

<h1>Global Travel</h1>

<div ng-app="myApp" ng-controller="myController">
	  <p>요일 : <input type="text" ng-model="week.day"></p>
	  <p>스케쥴 : <input type="text" ng-model="week.schedule"></span></p>

	  <p> 입력된 값 : {{week.scheduleList()}}
</div>

	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>

	<script>
		var myApp = angular.module("myApp", []);

		myApp.controller("myController",  function($scope) {
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
	</script>
</body>
</html>
```
{% endraw %}
