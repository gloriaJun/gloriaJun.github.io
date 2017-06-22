---
layout: post
comments: true
title: "[AngularJS] AngularJS 개념 정리 (ver1 기준)"
date: 2017-03-31 19:30:00
categories: Frontend
tags: javascript angular
---

angular에 대한 개념을 간략하게 [AngularJS Overview](https://www.tutorialspoint.com/angularjs/angularjs_overview.htm)를 참고하여 정리한 부분   

## AngularJS … ??
* 자바스크립트 프레임워크
* MVC 방식의 클라이언트 어플리케이션을 작성할 수 있는 방법을 제공
* 각 브라우저에 적합한 javascript 코드를 처리함으로써 corss-browser 제공
* 오픈소스 프로젝트

## Core Features
![]({{ site.url }}/assets/images/post/2017/0331-angular-features.png)  

###### Data-binding
model과 view  컴포넌트 사이의 데이타가 자동으로 동기화된다.

###### Scope
모델을 참조하는 개체로 controller와 view를 연결하는 역할을 한다.    

###### Controller
특정 scope에 바인딩된 javascript function 이다.    
view의 비지니스 로직을 구현하는 경우에 사용된다.

###### Services
재사용할 수 있는 비지니스 로직을 정의한다.   
싱글톤으로 구현되어있으므로 어플리케이션이 데이타를 관리하는 용도로만 사용하는 것을 권장한다.   

###### Filters
사용자에게 보여지는 데이터의 포맷을 변경하거나, 조건에 맞는 데이타를 보여주는 등의 데이터의 출력 형식을 설정하기 위해 사용한다.       
angular에서 지원하는 filter는 [Filter components in ng](https://docs.angularjs.org/api/ng/filter) 를 참고하면 된다.
또한 “$filterProvider”를 이용하여 사용자 정의 필터를 만들어 사용할 수 도 있다.

###### Directives
확장된 HTML, 커스텀 속성과 엘리먼트로 되어있는 것을 의미한다.       
사용자가 tag를 직접 정의해서 사용할 수 있으며, angular에서는 **ng-app, ng-model, …**과 같은 directive를 내장하고 있다.

###### Templates
controller와 model로부터 정보를 합쳐서 동적으로 view를 생성하기 위한 파일이다.    
`index.html`과 같은 하나의 페이지  또는 하나의 페이지에 여러의 뷰로 나누어 표현할 수 있다.

###### Routing
사용자가 보는 화면 전환을 말한다.

###### Expressions
html에서 javascript의 내용을 출력해야하는 경우에 사용     
아래와 같을 때 {% raw %}`{{ name }}`{% endraw %}을 의미
{% raw %}
```
<p>hello {{ name }}! </p>
```
{% endraw %}

###### Module
directive, controller, service를 모아놓은 컨테이너를 의미.      
기능적으로 비슷한 것들을 모아서 모듈을 만듬     
의존 관계가 있는 경우에 다른 모듈을 주입을 해서 사용할 수 있음.


## 간단한 예제
아래는 웹 브라우저 화면에 `Hello Chris` 라는 문자열이 출력되는 간단한 예제이다.
{% raw %}
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
{% endraw %}
        
`np-app`은 HTML 코드에서 angular에게 angular application임을 알려주는 directive이다.    
`ng-init`은 쉽게 말하면 특정 변수에 값을 초기화 하기 위한 directive이다. 위의 예제에서는 name이라는 변수에 'Chris'라는 값을 할당하여 초기화한다.     

> Plunker 라는 웹브라우저 에디터를 이용하면 간단하게 테스트해 해볼 수 있음  
> https://plnkr.co/edit/?p=preview   
     
