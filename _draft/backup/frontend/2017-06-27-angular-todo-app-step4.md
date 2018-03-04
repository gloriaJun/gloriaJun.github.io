---
layout: post
comments: true
title: "[AngularJS] todo 어플리케이션 만들기 - Step 4 "
date: 2017-06-27 20:30:00
categories: Frontend
tags: javascript AngularJS
---

angular material을 이용하여 style을 입혀보기

#### 라이브러리 설치
```
npm install angular-animate angular-aria angular-material --save
```
    
> `angular-animate angular-aria`은  material 설치를 위해 필요한 의존 라이브러리 이다.  
     
아래와 같이 스크립트를 추가해 준다.
```html
	<script src="node_modules/angular/angular.js"></script>
	<script src="node_modules/angular-animate/angular-animate.min.js"></script>
	<script src="node_modules/angular-aria/angular-aria.min.js"></script>

	<script src="node_modules/angular-material/angular-material.min.js"></script>
	<link rel="stylesheet" href="node_modules/angular-material/angular-material.min.css">
```

#### 라이브러리 선언
`app.js`에 아래와 같이 수정
```javascript
var myApp = angular.module('myApp', ['ngMaterial']);
```

#### html 코드 수정
```html
<body>
	<div ng-app="myApp" ng-controller="TodoController" ng-cloak layout-padding >
		<h1 class="md-headline">ToDo</h1>

		<form layout ng-submit="add(newToDo)" flex-gt-xs="50">
	    <div layout="row" flex>
	      <md-input-container flex class="sm-icon-float sm-block sm-title" >
	        <label>Input New ToDo</label>
	        <input type="text" ng-model="newToDo" autofocus>
	      </md-input-container>
	      <div>
	        <md-button type="submit" class="md-raised md-primary">
	          Add
	        </md-button>
	      </div>
	    </div>    
  	</form>

  	<md-content>
  		<div flex-xs flex-gt-xs="50" layout="column">
	  		<md-card>
			    <md-list>
			      <md-list-item class="md-2-line" ng-repeat="todo in todos">
			        <div class="md-list-item-text">
			          <md-checkbox ng-model="todo.completed">{{todo.title}}</md-checkbox>
			        </div>
			        <md-button class="md-warn" ng-click="remove(todo.id)">Remove</md-button>
			        <md-divider ng-if="!$last"></md-divider>
			      </md-list-item>
			    </md-list>
		    </md-card>
	    </div>
	  </md-content>
	</div>
</body>
```