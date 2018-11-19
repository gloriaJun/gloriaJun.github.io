---
layout: post
title: "(Javascript) 자바스크립트 함수형 프로그래밍"
date: 2018-11-19 12:15:00
author: gloria
categories: language
tags: javascript

---

* TOC
{:toc}

함수형 프로그래밍은 *공통화, 모듈화* 하기 위한 개발 스타일(?) 중의 하나로, 
기존의 객체지향 프로그래밍과 같은 하나의 개발 패턴이라고 할 수 있는 것 같다.
관련하여 정리해보면...

## 함수형 프로그래밍..??
함수형 프로그래밍은 side effect를 최소화하기 위한 프로그래밍 스타일이다.

함수형 프로그래밍의 특징을 정리하면....
1. 데이터는 불변(immutable) 해야한다.
2. 상태를 유지하지 않아야 한다.

#### 순수함수를 이용하여 작성한다
전달받은 아규먼트를 이용하여 결과를 리턴하는 함수를 말한다.     
순수함수는 side effect가 없다.
```javascript
function add(x, y) {
    return x + y;
}
```

#### 반복을 위해 재귀 함수를 사용한다.
```javascript
function sumRange(start, end, acc) {
    if (start > end)
        return acc;
    return sumRange(start + 1, end, acc + start)
}
console.log(sumRange(1, 10, 0)); // prints 55
```

#### 고차함수
함수를 매개변수로 받을 뿐만 아니라 함수를 반환하기도 한다.
**예제1**     
```javascript
function validateValueWithFunc(value, parseFunc, type) {
    if (parseFunc(value))
        console.log('Invalid ' + type);
    else
        console.log('Valid ' + type);
}

function makeRegexParser(regex) {
    return regex.exec;
}

var parseSsn = makeRegexParser(/^\d{3}-\d{2}-\d{4}$/);
var parsePhone = makeRegexParser(/^\(\d{3}\)\d{3}-\d{4}$/);

validateValueWithFunc('123-45-6789', parseSsn, 'SSN');
validateValueWithFunc('(123)456-7890', parsePhone, 'Phone');
validateValueWithFunc('123 Main St.', parseAddress, 'Address');
validateValueWithFunc('Joe Mama', parseName, 'Name');
```

**예제2**     
```javascript
function makeAdder(constantValue) {
    return function adder(value) {
        return constantValue + value;
    };
}

var add10 = makeAdder(10);
console.log(add10(20)); // prints 30
console.log(add10(30)); // prints 40
console.log(add10(40)); // prints 50
```




## 함수형 프로그래밍의 장점
- 모듈화가 가능하다.
	- 테스트가 쉬워진다.
	- 재사용성이 증가한다.
	- 분석이 쉬워진다.
- side effect가 발생할 가능성이 줄어든다.
- 가독성과 유지보수성이 향상한다.
- 반복되는 패턴에 대한 개발이 쉬워진다.


## Reference
- [함수형 프로그래머가 되고 싶다고? (Part 1)](https://github.com/FEDevelopers/tech.description/wiki/%ED%95%A8%EC%88%98%ED%98%95-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%A8%B8%EA%B0%80-%EB%90%98%EA%B3%A0-%EC%8B%B6%EB%8B%A4%EA%B3%A0%3F-(Part-1))
- [1.2 함수형 자바스크립트의 실용성](https://github.com/indongyoo/functional-javascript/wiki/1.2-%ED%95%A8%EC%88%98%ED%98%95-%EC%9E%90%EB%B0%94%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8%EC%9D%98-%EC%8B%A4%EC%9A%A9%EC%84%B1)
- [함수형 자바스크립트의 기초](http://merong.city/p/fpjs-prelude/0)