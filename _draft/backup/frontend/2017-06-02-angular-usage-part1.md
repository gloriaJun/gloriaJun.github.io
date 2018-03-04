---
layout: post
comments: true
title: "[AngularJS] AngularJS Usage - 1"
date: 2017-06-02 22:30:00
categories: Frontend
tags: javascript angular
---

[AngularJS Tutorial](https://www.tutorialspoint.com/angularjs/)을 참고로 실습한 부분을 정리    

## Directives
`ng-`로 시작한다.
* ng-app : angular app의 시작임을 알려줌.
* ng-init : 데이타를 초기화한다.
* ng-model : HTML의 input으로부터 값을 바인딩 한다
* ng-repeat : collection의 item을 반복해서 출력한다

```html
<div ng-app = "" ng-init = "countries = [{locale:'en-US',name:'United States'}, {locale:'en-GB',name:'United Kingdom'}, {locale:'en-FR',name:'France'}]"> 
   <p>Enter your Name: <input type = "text" ng-model = "name"></p>
   <p>Hello <span ng-bind = "name"></span>!</p>
   <p>List of Countries with locale:</p>

   <ol>
      <li ng-repeat = "country in countries">
         {{ 'Country: ' + country.name + ', Locale: ' + country.locale }}
      </li>
   </ol>
</div>
```

## Expressions
데이타를 html로 표현하기 위한 방법으로 `ng-bind` 또는 `{{ }}`을 사용하여 표현한다.
```html
<div ng-app = "" ng-init = "quantity = 1;cost = 30; student = {firstname:'Mahesh',lastname:'Parashar',rollno:101};marks = [80,90,75,73,60]">
   <p>Hello {{student.firstname + " " + student.lastname}}!</p>
   <p>Expense on Books : {{cost * quantity}} Rs</p>
   <p>Roll No: {{student.rollno}}</p>
   <p>Marks(Math): {{marks[3]}}</p>
</div>
```

## HTML DOM
###### ng-disabled
```html
<input type = "checkbox" ng-model = "enableDisableButton">Disable Button
<button ng-disabled = "enableDisableButton">Click Me!</button>
```

###### ng-show 
```html
<input type = "checkbox" ng-model = "showHide1">Show Button
<button ng-show = "showHide1">Click Me!</button>
```

###### ng-hide
```html
<input type = "checkbox" ng-model = "showHide2">Hide Button
<button ng-hide = "showHide2">Click Me!</button>
```

###### ng-click
```html
<p>Total click: {{ clickCounter }}</p>
<button ng-click = "clickCounter = clickCounter + 1">Click Me!</button>
```

## ngInclude
`ng-include` directive를 사용하여 html 페이지를 포함시킬 수 있음.
```html
<div ng-app = "mainApp" ng-controller="studentController">
   <div ng-include = "main.htm"></div>
   <div ng-include = "subjects.htm"></div>
</div>
```

## $HTTP
[$http](https://docs.angularjs.org/api/ng/service/$http)는 리모트의 http 서버와의 통신을 제공하는 서비스이다.  (ajax와 유사한 기술인 듯)     
응답되는 데이타는 JSON 형태여야 한다.
```javascript
app.controller('EmpController', function($scope, $http) {
	$http.get('data/emp.json')
		.then(function(response) {
			$scope.employees = response.data;
		});
});
```

## Route
Single Page에서 다양한 화면을 제공하기 위한 SPA(Single Page Applcation)을 제공하기 위한 기능.    
```html
</head>
<body ng-app="mainApp">
  <a href="#!/">Home</a>&nbsp;&nbsp;
  <a href="#!/about">About</a>&nbsp;&nbsp;
  <a href="#!/menu">Menu</a>
  
  <hr/>
  <div ng-view></div>
  
  <script>
    var app = angular.module("mainApp", ['ngRoute']);
    
    app.config(function($routeProvider) {
      $routeProvider
        .when("/", {
          template: '<div>Main Page</div>'
        })
        .when("/about", {
          template: '<div>About Page</div>'
        })
        .when("/menu", {
          template: '<div>Menu Page</div>'
        })
    });
  </script>
</body>
```

> Angular 1.6 부터 `#/myUrl `에서  `#!/myUrl`와 같이 링크 표시 방식이 변경되었음.    



