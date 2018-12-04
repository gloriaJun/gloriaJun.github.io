---
layout: post
title: "(Javascript) 개념정리 - Scope(스코프)"
date: 2018-10-24 13:35:00
author: gloria
categories: language
tags: javascript
---

* TOC
{:toc}


## 스코프
변수의 유효 범위를 의미하며, 전역과 지역 스코프로 나뉜다.

######  같은 이름으로 가진 경우, 함수 내부에서는 지역 스코프가 전역보다 우선시된다.
```javascript
var scope = 'global';
function func() {
	var scope = 'local';
	return scope;
}
func();
/*
"local"
*/
```

###### var 키워드를 생략하여 선언하는 경우, 의도하지 않는 동작이 발생할 수 있다.
```javascript
scope = 'global';
function func() {
	scope = 'local';
	myscope = 'local2';
	return [scope, myscope];
}
console.log('before call func : ', scope, typeof myscope);
console.log('call func : ', func());
console.log('after call func : ', scope, typeof myscope);
/*
before call func :  global undefined
call func :  (2) ["local", "local2"]
after call func :  local string
*/
```

###### 함수 단위로 스코프가 설정된다.
**예제1)**
```javascript
var a = 1;
function func() {
    if(true) {
        var b = 2;
    } 
    console.log(b); 
    return ;  
}
func();
/*
2
*/
```

**예제2)**
```javascript
function scopeTest() {  
    var a = 0;
    if (true) {
        var b = 0;
        for (var c = 0; c < 5; c++) {
            console.log("c=" + c);
         }
         console.log("c=" + c);
    }
    console.log("b=" + b);
	console.log("a=" + a);
}
scopeTest();
/*
c=0
c=1
c=2
c=3
c=4
c=5
b=0
a=0
*/
```

###### 렉시컬 스코프 (Lexical Scope)
함수 실행 시의 유효범위를 정의 단계에서 설정한다.
```javascript
function f1 () {
    var a = 1;
    f2 ();
}
 
function f2 () {
    return a;
}
 
f1();
/*
undefined
*/
```

###### 블록 레벨 스코프
ES6에서 let, const 키워드를 이용하는 경우 블록 레벨 스코프가 생성된다.
```javascript
let a = 1;
function func() {
    if(true) {
        let b = 2;
    } 
    console.log(b); 
    return ;  
}
func();
/*
Uncaught SyntaxError: Identifier 'a' has already been declared
    at <anonymous>:1:1
    */
```



## 스코프 체인

자바스크립트에서 함수가 실행될 때마다 함수의 유효 범위를 가지는 렉시컬 스코프가 생성되고, 생성된 스코프는 상위 스코프를 참조한다 이것을 `스코프 체인`이라고 한다.
자바스크립트는 실행 시점에 Excecution Context(EC)가 생성이 된고, 스코프 정보를 생성한다.




## 호이스팅
함수가 실행될 때, `var` 키워드로 선언된 변수와 함수 선언문으로 선언된 함수는 호이스팅 된다.



###### var 키워드로 선언된 변수

```javascript
var scope = 'global';
function func() {
    console.log(scope);
    var scope = 'local';
    console.log(scope);
}
func();
/*
undefined
local
*/
```
위와 같이 선언된 함수는 호이스팅으로 인하여 아래와 같이 선언한 것과 동일하다. 그러므로 첫번째 `consol.log(scope)`에서는 scope 변수가 위에서 선언이 되었으나, 초기화는 되지 않았으므로 undefined를 출력하는 것이다.
```javascript
var scope = 'global';
function func() {
	var scope;
    console.log(scope);
    scope = 'local';
    console.log(scope);
}
func();
```



###### 함수 선언문으로 선언된 함수

```javascript
// 함수 선언문
hoistingExam();  
function hoistingExam(){  
    var hoisting_val =10;
    console.log("hoisting_val ="+hoisting_val);
}
/*
hoisting_val =10  
*/
```

위와 같이 함수 선언문으로 선언된 함수는 호이스팅이 되어 정상적으로 동작을 한다.

하지만, 함수 표현식이나 생성자를 이용하여 선언된 경우에는 에러가 발생한다.

```javascript
hoistingExam();  
var hoistingExam = function(){  
    var hoisting_val =10;
    console.log("hoisting_val ="+hoisting_val);
}
/*
Uncaught TypeError: hoistingExam is not a function
*/
```



## Reference
- [(번역) 자바스크립트 스코프와 클로저(JavaScript Scope and Closures)](https://medium.com/@khwsc1/%EB%B2%88%EC%97%AD-%EC%9E%90%EB%B0%94%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8-%EC%8A%A4%EC%BD%94%ED%94%84%EC%99%80-%ED%81%B4%EB%A1%9C%EC%A0%80-javascript-scope-and-closures-8d402c976d19)
- [JavaScript : Scope 이해](http://www.nextree.co.kr/p7363/)

