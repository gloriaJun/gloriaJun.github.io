---
layout: post
title: "(Javascript) Primitive"
date: 2018-12-18 10:35:00
author: gloria
categories: language
tags: javascript
---

* TOC
{:toc}

자바스크립트에서는 현재 아래의 6개의 primitive 타입을 제공하며, primitive는 *원시 데이터 타입*을 의미한다.
- undefined
- null
- boolean
- number
- string
- symbol (ECMAScript 2015에서 신규로 추가)

> ECMAScript 표준에서 제공하는 자료형은 다음을 포함한다.
> - 6개의 primitive 타입
> - Object 객체


#### Primitive 객체
null, undefined를 제외한 아래의 primitive 타입은 원시 값을 래핑한 객체를 같는다.
- boolean -> Boolean
- number -> Number
- string -> String
- symbol -> Symbol

래퍼객체는 `valueOf()` 메소드를 이용하여 primitivie 값을 리턴한다.

```javascript
let num1 = new Number(100);
let num2 = num1; // num1의 참조가 전달된다.
console.log(num1 === num2); // true

let num3 = 100;
console.log(num2 === num3); // false
console.log(num2 == num3); // true

num2 = num2 + 100; // num2.valueOf() + 100 으로 연산이 수행되어 연산 결과 primitivie 값이 저장된다.
num3 = num3 + 100;
console.log(num2 === num3); // true
console.log(num2 == num3); // true
```

#### Object.isExtensible()
property를 생성할 수 있는 지에 대한 여부를 확인할 수 있는 메서드이다.

```javascript
let obj = {};
let str = 'aaa';

console.log(Object.isExtensible(obj)); // true
console.log(Object.isExtensible(str)); // false
```

#### 래퍼 객체로의 형변환
자바스크립트의 primitive는 암묵적으로 프리미티브 객체로 형변환이 일어난다. 그러므로 예를 들어 `Number` 객체를 이용하여 생성하지 않아도 `Number` 객체 생성자의 property를 사용할 수 있다.
```javascript
let num = 10.12345;
typeof num; // number
num.toFixed(2); // 10.12
```


## Reference
- [ECMAScript 스펙 톺아보기: Primitive](https://meetup.toast.com/posts/143)
- [MDN-자바스크립트의 자료형](https://developer.mozilla.org/ko/docs/Web/JavaScript/Data_structures)