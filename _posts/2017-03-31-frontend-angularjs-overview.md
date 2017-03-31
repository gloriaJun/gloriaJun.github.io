---
layout: post
title: "[AngularJS] AngularJS 개념 정리 (ver1 기준)"
date: 2017-03-31 19:30:00
categories: Frontend
tags: javascript AngularJS
---

## AngularJS란??
* 자바스크립트 프레임워크
* HTML, CSS, JavaScript를 사용

## Conceptual Overview
### Directives
확장된 HTML, 커스텀 속성과 엘리먼트로 되어있는 것을 의미함.
tag를 직접 정의해서 사용할 수 있음

### Expressions
html에서 javascript의 내용을 출력해야하는 경우에 사용
아래와 같을 때 `{{ name }}`을 의미
```
<p>hello {{ name }}! </p>
```

### Module
directive, controller, service를 모아놓은 컨테이너를 의미.
기능적으로 비슷한 것들을 모아서 모듈을 만듬
의존 관계가 있는 경우에 다른 모듈을 주입을 해서 사용할 수 있음.

### Controller
html 뒷단에 위치하고, html 뷰를 조절하는데 사용
오직 뷰의 비지니스 로직을 구현하는 경우에만 사용해야한다.

### Service
재사용할 수 있는 비지니스 로직.
싱글톤으로 구현되어있으므로 어플리케이션이 데이타를 관리하는 용도로만 사용하는 것을 권장

## 예제
* ng-app
np-app 이라고 선언하면 라이브러리에게 여기에 angular 코드가 있다고 알려주는 것임.
그럼 angular directive 코드를 찾아서 해석하는 과정을 진행한다고..

* ng-init
자바스크립트 변수를 초기화

```
<html>

  <head>
    <link data-require="bootstrap-css@3.3.7" data-semver="3.3.7" rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.css" />
    <script data-require="angularjs@1.6.2" data-semver="1.6.2" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.2/angular.js"></script>
    <link rel="stylesheet" href="style.css" />
    <script src="script.js"></script>
  </head>

  <body ng-app ng-init="name='Chris'">
    <h1>Hello {{ name }}</h1>
  </body>

</html>
```

위와 같이 선언하면 웹 브라우저 화면에 `Hello Chris` 라는 문자열이 출력됨.

> Plunker 라는 웹브라우저 에디터를 이용하면 간단하게 테스트해 해볼 수 있음  
> https://plnkr.co/edit/?p=preview   

