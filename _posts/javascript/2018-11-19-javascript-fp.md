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

함수형 프로그래밍에 대해 내가 이해한 것을 정리하면...
`*공통화, 모듈화* 하기 위한 개발 스타일(?) 중의 하나로,  side effect를 최소화하기 위한 프로그래밍 스타일`이라고 이해가 되었다.

그리고 함수형프로그래밍의 대표적인 라이브러리 예시가 [underscorejs](https://underscorejs.org/) 라이브러리를 들 수 있다고....

관련하여 정리해보면...

## 함수형 프로그래밍..??
함수형 프로그래밍을 `함수형 자바스크립트(O'Reilly)` 책에서는  다음과 같은 한 문장으로 설명할 수 있다고 언급한다.

> 함수형 프로그래밍은 값을 추상화의 단위로 바꾸는 기능을 하며 결국 바뀐 값들로 소프트웨어 시스템이 만들어진다.

- 함수형 프로그래밍에서는 관찰할 수 있는 상태 변화를 최소화 하고자 한다. (작은 각각의 독립적인 모델(?)로 쪼개서 순수 함수로 구현을 함으로써????)
- 함수형과 객체 지향 스타일을 적절하게 잘 사용하는 것이 관점.

#### 함수형 프로그래밍의 특징
###### 추상화를 식별해서 함수로 만든다.
함수를 구현할 때에 한 개의 동작에 대해 한 개의 함수에 포함하여 구현을 하면, 기존 함수의 동작이 변경되는 경우, 다른 코드의 수정이 없이 교체할 수 있다.

> 실행할 수 있게 한 다음, 올바로 동작하게 하고, 그 다음 빠르게 실행되도록 만들어라
>
> - 켄트 백의 테스트주도개발(TDD) -

**예제**.   
```javascript
function parseAge(age) {
    if (!_.isString) throw new Error('Expecting a string');
    ...
}
```

위와 같이 pargeAge 함수에서 에러를 처리하는 부분을 **에러, 경고, 정보**를 출력하는 함수를 추상화하여 구현한 뒤에 해당 함수를 호출하여 사용하는 형식으로 사용하는 것이 더 바람직하다.
```javascript
function fail(thing) {
    throw new Error(thing);
}

function warn(thing) {
    console.log(['WARNING: ', thing].join(' '));
}

...

function parseAge(age) {
    if (!_.isString) fail('Expecting a string');
    ...
}
```

###### 기존 함수를 이용해서 더 복잡한 추상화를 만든다.
###### 기존 함수를 다른 함수에 제공해서 더 복잡한 추상화를 만든다.
위의 두가지는 클로저를 활용하여 함수를 추상화한다는 뜻인듯.....       
그리고 **반복을 위한 재귀함수 구현, 고차함수**를 이해하고 구현하기 위해서는 클로저의 개념 이해가 필요하다.


#### 함수형 프로그래밍의 장점
- 모듈화가 가능하다.
	- 테스트가 쉬워진다.
	- 재사용성이 증가한다.
	- 분석이 쉬워진다.
- side effect가 발생할 가능성이 줄어든다.
- 가독성과 유지보수성이 향상한다.
- 반복되는 패턴에 대한 개발이 쉬워진다.



## 함수형 프로그래밍 작성을 위한 개념 이해하기
#### 순수함수
전달받은 아규먼트를 이용하여 결과를 리턴하는 함수를 말한다.     
```javascript
function add(x, y) {
    return x + y;
}
```

#### 재귀 함수를 이용하여 반복문을 구현하기
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

#### 커링
커링 함수는 한 번에 오직 1개의 매개변수만 받는 함수를 말한다.
```javascript
function add(x) {
    return function(y) {
        return x + y;
    }
}
// 위의 함수를 array function을 이용하여 아래와 같이 작성할 수도 있다.
let add2 = x => y => x + y;

console.log(add(4)(3)); // 7
console.log(add2(4)(3)); // 7
```





## Reference
#### 함수형 프로그래머가 되고 싶다고?
- [Part 1 - 순수함수, 불변성](https://github.com/FEDevelopers/tech.description/wiki/%ED%95%A8%EC%88%98%ED%98%95-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%A8%B8%EA%B0%80-%EB%90%98%EA%B3%A0-%EC%8B%B6%EB%8B%A4%EA%B3%A0%3F-(Part-1))
- [Part 2 - 리팩토링, 고차함수, 클로저](https://github.com/FEDevelopers/tech.description/wiki/%ED%95%A8%EC%88%98%ED%98%95-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%A8%B8%EA%B0%80-%EB%90%98%EA%B3%A0-%EC%8B%B6%EB%8B%A4%EA%B3%A0%3F-(Part-2))
- [Part 3 - 합성함수](https://github.com/FEDevelopers/tech.description/wiki/%ED%95%A8%EC%88%98%ED%98%95-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%A8%B8%EA%B0%80-%EB%90%98%EA%B3%A0-%EC%8B%B6%EB%8B%A4%EA%B3%A0%3F-(Part-3))
- [Part 4 - 커링, 커링과 리팩토링, 일반적인 함수형 함수](https://github.com/FEDevelopers/tech.description/wiki/%ED%95%A8%EC%88%98%ED%98%95-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%A8%B8%EA%B0%80-%EB%90%98%EA%B3%A0-%EC%8B%B6%EB%8B%A4%EA%B3%A0%3F-(Part-4))
- [Part 5 - 참조 투명성, 실행 순서,  ](https://github.com/FEDevelopers/tech.description/wiki/%ED%95%A8%EC%88%98%ED%98%95-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%A8%B8%EA%B0%80-%EB%90%98%EA%B3%A0-%EC%8B%B6%EB%8B%A4%EA%B3%A0%3F-(Part-5))

#### 다른 참고글들
- [1.2 함수형 자바스크립트의 실용성](https://github.com/indongyoo/functional-javascript/wiki/1.2-%ED%95%A8%EC%88%98%ED%98%95-%EC%9E%90%EB%B0%94%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8%EC%9D%98-%EC%8B%A4%EC%9A%A9%EC%84%B1)
- [함수형 자바스크립트의 기초](http://merong.city/p/fpjs-prelude/0)