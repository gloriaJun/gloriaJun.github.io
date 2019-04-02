---
layout: post
title: "(Javascript) ECMAScript 정리하기"
date: 2019-01-09 10:35:00
author: gloria
categories: language
tags: javascript
---

* TOC
{:toc}

# ECMAScript 정리하기

## ECMAScript 2015 (ES6)

### Object Destructuring

#### 변수의 선언과 분리하여 할당해야 하는 경우

```javascript
let result = null;
try {
    ({ data: result } = await (isMovies ? moviesApi.movieDetail : tvApi.showDetail)(id));
} catch {
	//...
} finally {
    console.log(result);
}
```

#### key에 해당하는 값이 없는 경우에 대한 default value 설정

```javascript
let {a = 10, b = 5} = {a: 3};

console.log(a); // 3
console.log(b); // 5
```

#### 새로운 변수명 선언과 함께 default value 설정

```javascript
let {a: aa = 10, b: bb = 5} = {a: 3};

console.log(aa); // 3
console.log(bb); // 5
```

### Reflect API

[Reflect API](https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/Reflect)는 객체의 속성과 메서드를 조사하고 조작하는 API이다.

> 일부 api는 브라우저에서 지원하지 않으므로 사용에 주의해야한다.
> *2019.03.28 기준*

기존에는 어떤 메소드는 Object 객체를 통해서 접근하고, 어떤 메소드는 만들어진 객체를 통해서 접근했으나, Reflect를 이용하여 접근하면 메소드를 구분하지 않아도 된다.

## ECMAScript 2016 (ES7)

### 제곱연산자

`Math.pow(a, b)`대신에 연산자를 이용하여 표현할 수도 있다.

```javascript
const i = 3;
i ** 3; // 15
let i **=3; // 15
```

### 배열.includes(찾을 요소, 시작 순서)

`indexOf` 메소드와 동작이 유사하나 `NaN`에 대한 처리가 다르다.

```javascript
[NaN].includes(NaN); // true
[NaN].indexOf(NaN) > -1; // false
```

## ECMAScript 2017 (ES8)

### String

문자열에 padding을 추가하기 위한 메소드 지원

#### 문자열.padStart(최종길이, 보충문자열)

```javascript
'zero'.padStart(10); // '      zero' (빈칸 6글자 + zero 4글자)
'zero'.padStart(10, 'babo'); // 'babobazero' (baboba 6글자 + zero 4글자)
'zero'.padStart(6, 'babo'); // 'bazero'
'zero'.padStart(3); // 'zero' (원래 길이보다 최종 길이가 작으면 원래 상태로)
```

#### 문자열.padEnd(최종길이, 보충문자열)

```javascript
'zero'.padEnd(10); // 'zero      '
'zero'.padEnd(10, 'babo'); // 'zerobaboba'
'zero'.padEnd(6, 'babo'); // 'zeroba'
'zero'.padEnd(3); // 'zero'
```


## ECMAScript 2018 (ES9)

### Promise finally
Promise의 성공/실패와 상관없이 무조건 실행된다.

```javascript
Promise.resolve('hello')
  .then((msg) => Promise.resolve(msg))
  .finally(() => console.log('finally!'))
  .then((msg) => console.log(msg)); // 콘솔에 finally와 hello가 찍힘
```

### Async iteration

비동기 반복 처리에 대하여 아래와 같이 처리가 가능해짐.

```javascript
(async() => {
  const promises = ['1000', '2000', '3000'].map((timer) => (
    new Promise((res, rej) => {
      setTimeout(() => res(timer), timer);
    })
  ));
  for await (const result of promises) {
    console.log(result);
  }
})();
```

### 정규표현식

`s` 플래그, lookbehind, 캡쳐링 그룹을 사용할 수 있다.
```javascript
/zero.cho/s.test('zero\ncho') // true
/zero.cho/.test('zero\ncho') // false

const result = /(?<babo>바보)(?<name>제로초)/.exec('바보제로초');
result.groups.babo; // 바보
result.groups.name; // 제로초
result.groups[1]; // 바보
result.groups[2]; // 제로초
```


## ECMAScript 2019 (ES10)

### Object.fromEntries

Object.entries의 반대 기능이다.
```javascript
Object.entries({ a: 'zerocho', b: ['hello'] }); // [['a', 'zerocho'], ['b', ['hello']]]
Object.fromEntries([['a', 'zerocho'], ['b', ['hello']]]); // { a: 'zerocho', b: ['hello'] }
```

### Array.prototype.flat, Array.prototype.flatMap

다중 배열을 펼치는 기능이다.
```javascript
let multi = [1,2,3,[4,5,6,[7,8,9,[10,11,12]]]];
multi.flat();               // [1,2,3,4,5,6,Array(4)]
multi.flat().flat();        // [1,2,3,4,5,6,7,8,9,Array(3)]
multi.flat().flat().flat(); // [1,2,3,4,5,6,7,8,9,10,11,12]
multi.flat(Infinity);       // [1,2,3,4,5,6,7,8,9,10,11,12]

let array = [1, 2, 3, 4, 5];
array.map(x => [x, x * 2]);
array.flatMap(v => [v, v * 2]); // [1, 2, 2, 4, 3, 6, 4, 8, 5, 10]
```

### String.prototype.trimStart, trimEnd, trimLeft, trimRight

```javascript
let greeting = "     Space around     ";
greeting.trimEnd();   // "     Space around";
greeting.trimStart(); // "Space around     ";
```

### Optional Catch
`try~catch` 구문을 사용 시에 error 매개변수를 사용하지 않는 경우 생략이 가능하다.

```javascript
try {
    JSON.parse(text);
    return true;
}
catch
{
    return false;
}
```

### Function.toString()

```javascript
function sayHello(text) { console.log(`Hello ${text}`) }
console.log(sayHello.toString())
// function sayHello(text) { console.log(`Hello ${text}`) }

console.log(Number.parseInt.toString())
// function parseInt() { [native code] }
```

## References
- [JavaScript brief history and ECMAScript(ES6,ES7,ES8,ES9) features](https://medium.com/@madasamy/javascript-brief-history-and-ecmascript-es6-es7-es8-features-673973394df4)
