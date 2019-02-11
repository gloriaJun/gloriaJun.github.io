---
layout: post
title: "(Javascript) this"
date: 2018-10-29 23:15:00
author: gloria
categories: language
tags: javascript

---

* TOC
{:toc}

javascript에서는 `this`의 동작에 대해 이해를 하려면 *Execution Context*와 *Lexical Environment*를 이해해야한다.

# Execution Context

- 자바스크립트 엔진은 실행이 가능한 코드를 만나면 Execution Context를 생성한다.
- 매번 함수의 호출마다 새로운 Execution Context가 생성된다
- EC는 Lexical Environment, Variable Environment, ThisBinding에 대한 정보를 가지고 있다.

## Lexical Environment Object

- **자원을 어디에서 찾을 것인가?**
- 해당 Context에서 선언된 변수/함수들의 Reference 값을 저장하는 객체
- EC 생성 초기 시점에는 Variable Environment와 동일한 값을 가지나, 바인딩된 값들에 따라 변경된다.

## Variable Environment Object

- Lexical Environment에 포함되는 개념
- 내부에 선언된 변수, 함수 선언, 함수 매개 변수 들을 저장한다.
- 값이 절대로 변하지 않는다.

## ThisBinding

- ThisBinding은 함수의 호출 시점에 정해지며, `this` 키워드를 말한다.
- **`this`는 함수가 현재 어느 EC에서 구동하고 있는 지를 알려준다.**
- ThisBinding이 null, undefined이면 기본으로 global(window)를 대입한다.
- 단, 'use strict' 모드인 경우에는 null로 대입한다.

## 자바스크립트에서의 `this` 예시

`this`는 함수의 현재 실행 문맥을 말한다. 즉, 함수가 호출된 시점에서 포함된 객체를 찾아서 this에 바인딩한다.

```javascrip시
var item = 'global item!';
var obj = {
  item: 'item from obj',
  mtd: function() {
  	console.log('this === window : ', this === window);
  	console.log('this === obj : ', this === obj);
    console.log(this.item);
  }
}

var mtd = obj.mtd;
mtd();	
obj.mtd();
/**
this === window :  true
this === obj :  false
global item!

this === window :  false
this === obj :  true
item from obj
**/
```

### 함수 실행에서의 this

일반적인 함수 실행에서의 this는 전역 객체이다.

```javascript
function func() {
    console.log('in func, this === window : ', this === window);
    console.log('in func, this === undefined : ', this === undefined);
}
func();
console.log('out func, this === window : ', this === window);
/*
in func, this === window :  true
in func, this === undefined :  false
out func, this === window :  true
*/
```

하지만 `strict mode`를 선언하는 경우에는 함수 내부에서 `this` 는 전역 객체가 아니다.

```javascript
'use strict'
function func() {
    console.log('in func, this === window : ', this === window);
    console.log('in func, this === undefined : ', this === undefined);
}
func();
console.log('out func, this === window : ', this === window);
/*
in func, this === window :  false
in func, this === undefined :  true
out func, this === window :  true
*/
```

`strict mode` 선언을 함수 스코프 내에서만 적용되도록 사용할 수 있다.

```javascript
function strictFunc() {
    'use strict'
    console.log('in strictFunc, this === window : ', this === window);
    console.log('in strictFunc, this === undefined : ', this === undefined);
}

function func() {
    console.log('in func, this === window : ', this === window);
    console.log('in func, this === undefined : ', this === undefined);
}

func();
strictFunc();
console.log('out func, this === window : ', this === window);
/*
in func, this === window :  true
in func, this === undefined :  false
in strictFunc, this === window :  false
in strictFunc, this === undefined :  true
out func, this === window :  true
*/
```

### bind & apply & call

`bind`,  `apply`, `call` 메서드는 **this**에 강제로 해당 메서드를 호출한 함수를 바인딩 시킨다.
*bind* 메서드는 바인딩 후 새로운 함수를 반환하는 반면, *apply* 메서드는 해당 함수를 호출한다.
*call* 메서드는 apply 메서드와 동일하나 여러 개의 파라미터를 전달받을 수 있다.

**bind 메서드 예시**

```javascript
function speakNation() {
  console.log(this.nation);
}

var person = {
  name: 'Hong Kil Dong',
  nation: '한국'
}

var hongSpeakNation = speakNation.bind(person);
hongSpeakNation();
```

**apply 메서드 예시**

```javascript
function speakNation() {
  console.log(this.nation);
}

var person = {
  name: 'Hong Kil Dong',
  nation: '한국'
}

speakNation.apply(person);
```

## ES6 - Arrow Function

`Arrow Function`을 사용하면 현재 실행 시점의 this를 가르키는 것이 아니라,  상위 스코프의 this를 가르킨다. 

```javascript
const job = {
    items: ['teacher', 'baker', 'student'],
    find() {
       	this.items.findIndex(function(item) {
    		console.log('this === window : ', this === window); // true
    	}); 
    	this.items.findIndex((item) => {
        	console.log('this === window : ', this === window); // false
    	});
    }
}
job.find();
```

# Reference

- [자바스크립트에서 사용되는 this에 대한 설명 1](http://webframeworks.kr/tutorials/translate/explanation-of-this-in-javascript-1/)
- [JavaScript - this 이해하기](https://blog.kesuskim.com/2016/09/understanding-js-this/)
- [Lexical Environment in ECMA-262 5th edition](http://huns.me/development/1407)