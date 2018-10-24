---
layout: post
title: "(Javascript) 성능 최적화를 위한 코드 스타일"
date: 2018-10-22 09:35:00
author: gloria
categories: language
tags: javascript 자바슼크립트성능
---

* TOC
{:toc}

아주 기본적일 수도 있으나, 코드를 어떻게 작성하느냐에 따라 자바스크립트 실행 성능을 약간은 높일 수 있다.


## 객체의 생성 및 접근
객체를 생성할 때에 `new`보다는 리터럴 형식을 사용해 객체를 생성한다.

#### Object
###### 생성 시
```javascript
// 실행 시간 : 0.010986328125ms
let obj1 = new Object(); 

// Better - 실행 시간 : 0.00634765625ms
let obj2 = {};
```

###### 접근 시
```javascript
// 실행 시간 : 0.031982421875ms
let obj1 = {};
obj1.a = 'a';
obj1.b = 'b';
obj1.c = 'a';
obj1.d = 'a';
obj1.e = 'a';
obj1.f = 'a';
obj1.g = 'a';
obj1.h = 'a';

// Better - 실행 시간 : 0.010009765625ms
let obj2 = {};
obj2['a'] = 'a';
obj2['b'] = 'b';
obj2['c'] = 'a';
obj2['d'] = 'a';
obj2['e'] = 'a';
obj2['f'] = 'a';
obj2['g'] = 'a';
obj2['h'] = 'a';
```


####  Array
###### 생성 시
```javascript
// 실행 시간 : 0.005126953125ms
let arr1 = new Array(); 

// Better - 실행 시간 : 0.004150390625ms
let arr2 = [];
```

###### 접근 시
```javascript
// 실행 시간 : 0.10791015625ms
let arr1 = [];
for (let i = 0; i < 1000; i++) {
  arr1.push(i);
}

// Better - 실행 시간 : 0.057861328125ms
let arr2 = {};
for (let i = 0; i < 1000; i++) {
  arr[i];
}
```


####  String
###### 생성 시
```javascript
// 실행 시간 : 0.0078125ms
let str1 = new String(); 

// Better - 실행 시간 : 0.0009765625ms
let str2 = '';
```

###### 문자열 연산 시
```javascript
// 실행 시간 : 4.03271484375ms
let str1 = '''';
for (let i = 0; i < 10000; i++) {
  str1 += `test${i}\n`;
}

// Better - 실행 시간 : 2.7021484375ms
let str1 = ''; 
arr1 = [];

for (let i = 0; i < 10000; i++) {
  arr[i] = `test${i}\n`;
}

str1 = arr.join('');
```
> `+= 연산자`는 두 문자열을 합친 새로운 문자열을 만들고 새로운 메모리 위치에 저장함과 동시에 기존 문자열에 대한 참조를 변경하는 연산을 반복적으로 실행해야 한다.
> 하지만 `Array.join()` 메서드로 연산하면 비교적 메모리에 효율적으로 접근할 수 있는 배열을 사용한다.
> 즉, 배열에 저장된 문자열을 모두 합쳐 하나의 문자열을 생성하고 저장하므로 문자열이 병합될수록 점점 더 큰 문자열을 생성하고 저장해야 하는 += 연산에 비해 불필요한 문자열 참조 변경과 재생성 작업이 없다. (자바의 String과 StringBuffer개념과 유사)



## 정규표현식
- 탐색의 대상을 축소한다. 
- 루프 문 안에 정규표현식을 넣으면 매 루프 수행 시마다 컴파일이 처리되므로 루프 밖에 선언하여 한 번만 컴파일되도록 한다.

#### 탐색 대상 축소
정규표현식을 사용할 때에 불필요한 탐색 과정이 반복되지 않도록 주의한다.

예) 
```javascript
// Better - 아래와 같이 trim 연산을 위한 정규식을 분리시키면 앞의 공백을 찾아 제거하는 경우에 성능 상의 이득을 가져올 수 있다.
str.replace(/^\s+/, '').replace(/\s+$/, '');

// 반면, 아래와 같이 정규식을 정의하면, 항상 앞뒤의 공백을 찾아야하므로 탐색의 시간이 나게 되어 성능이 저하된다.
str.replace(/^\s+|\s+$/g, '');
```

#### 컴파일 횟수 축소
```javascript
// 반복문을 수행할 때마다 정규식을 컴파일하게 된다.
for (var i = 0; i < 100; i++) {
    str.replace(/^\s+/, '').replace(/\s+$/, '');
}
 
// Better - 최초의 한 번만 정규식 컴파일을 수행한다.
var reg1 = /^\s+/;
var reg2 = /\s+$/;
for (var i = 0; i < 100; i++) {
    str.replace(reg1, '').replace(reg2, '');
}
```

## 스코프 체인 탐색 줄이기
런타임 환경에서 자바스크립트의 성능을 저해하는 주요 요인이 변수, 객체, 함수 등의 메모리상의 위치를 찾는 탐색 작업인데,  이 탐색 작업이 브라우저에서 어떻게 이뤄지는지는 스코프 체인을 통해 알 수 있다.

스코프 체인은 `활성화 객체(Activate Object)`와  `전역 객체(Global Object)`로 구성되어있다.
- 활성화 객체 
: 함수 내부에서 접근 가능한 `지역변수, this, argument 객체`가 포함된다. 활성화 객체는 함수 내부 접근 시 생성되어 함수 실행이 완료되면 제거된다.
- 전역 객체 
: 함수 외부에서도 접근할 수 있는 `windows, document, 전역함수, 전역변수`가 포함된다.
자바스크립트 동작 시 항상 접근 가능한 데이터를 포함하고 있기 때문에 웹 페이지의 자바스크립트가 동작하는 모든 시간 동안 존재하며, 함수 실행 시 함수의 스코프 체인에서 전역 속성을 탐색하는 데 사용된다.

실행 문맥(Execution Context)은 함수가 동작하는 환경을 나타내며, 브라우저 내부에서 사용되는 객체로써 *함수가 실행될 때 새로 생성되고 함수가 종료될 때 소멸된다.* 그리고 함수의 스코프 체인에 대한 참조를 가지고 있다.
실행 문맥은 자신과 연관된 함수의 스코프 체인을 참조하고 있는데, 함수에서 접근하는 속성의 탐색 경로는 `실행 문맥 > 스코프 체인 > 활성화 객체 > 스코프 체인 > 전역 객체`와 같이 구성된다.

그러므로 함수의 중첩이 깊어질 수록 `실행 문맥 > 스코프 체인 > 활성화 객체 1 > 스코프 체인 > 활성화 객체2 > ... > 전역 객체`와 같이 긴 탐색 경로를 거쳐야 한다.
즉, 이러한 탐색 경로를 줄임으로써 실행시간을 단축하고 성능을 향상 시킬 수 있다.

#### 지역변수를 활용한 스코프 체인 탐색 성능 개선
```javascript
// 실행시간: 7052.68310546875ms
let globalArr = [];

function func() {
	for (let i = 1; i < 100; i++) {
        globalArr[i] = 'test';
	}
}
func();

// Better - 실행시간: 5886.0087890625ms
let globalArr = [];
function func() {
	let arr = globalArr;
	for (let i = 1; i < 100; i++) {
        arr[i] = 'test2';
	}
}
func();
```

#### 프로토타입 체인 탐색 줄이기
new 연산자로 생성된 객체는 생성자의 프로토타입을 참조하게 된다.
생성된 인스턴스 객체가 생성자의 프로토타입 속성을 탐색할 때에도 체인이 생성되는데, 이를 **프로토타입 체인**이라고 한다.
그러므로 스코프 체인과 마찬가지로 프로토타입에 존재하는 속성을 사용하는 경우 지역변수에 담아 사용하면 탐색경로를 줄입으로써 성능을 향상시킬 수 있다.

```javascript
// 실행시간: 0.30615234375ms
let obj = {
  name: 'jay',
  age: 30,
};

function func() {
  return obj.hasOwnProperty('name');
}
func();

// Better - 실행시간: 0.296142578125ms
let obj = {
  name: 'jay',
  age: 30,
};

function func() {
  let temp = obj;
  return temp.hasOwnProperty('name');
}
func();
```


## 반복문

#### `for-in` 구문은 가급적 사용하지 말라
다른 반목문은 주어진 배열 객체를 배열의 특성에 맞게 순차적으로 모든 요소를 탐색하는 반면에, `for-in` 구문은 배열을 배열이 아닌 일반 객체로 취급하며, 반복 시점마다 객체의 모든 속성을 무작위로 탐색한다. 
즉, 반복문 중에 가장 성능이 떨어진다.

```javascript
let arr = [];
for (var i = 0; i < 1000; i++) {
    arr[i] = i;
}

// for-in 구문 - 실행시간: 0.347900390625ms
for (let i in arr) {
  arr[i]++;
}

// for문 - 실행시간: 0.084716796875ms
for (let i = 0, cnt = arr.length; i < cnt; i++) {
  arr[i]++;
}
```

#### for문 안에서 Array.length를 직접 하지 말고, 외부에서 별도의 변수에 선언하여 사용해라
Array.length 함수를 for문 안에서 사용하면 매번 반복할 때마다 length를 구하는 함수를 수행하게 된다. (스코프 체인의 탐색 시간이 수행된다) 

```javascript
let arr = [];
for (var i = 0; i < 1000; i++) {
    arr[i] = i;
}

// 실행시간: 0.202880859375ms
for (let i = 0; i < arr.length; i++) {
  arr[i]++;
}

// Better - 실행시간: 0.084716796875ms
for (let i = 0, cnt = arr.length; i < cnt; i++) {
  arr[i]++;
}
```


## 알고리즘을 적절히 활용한다
반복횟수를 최소화하기 위한 효율적인 알고리즘을 사용한다.
quick-sort, merge-sort, breadth first search, depth first search 등과 같이 증명된 알고리즘을 사용하여 성능을 향상시킬 수 있다.


## 연산자
#### || 연산자
`||`연산자는 참을 만나면 그 뒤는 연산을 하지 않으므로 연산 횟수를 줄일 수 있다.
```javascript
let name = user.name || 'default';
```

#### && 연산자
`&&` 연산자는 참을 만나야 다음 연산을 하므로 어떠한 조건을 만족할 때 실행하도록 하는 코드에서 사용하면 연산 횟수를 줄일 수 있다.
```javascript
var userID;
if (user && user.loggedIn) {
    userID = user.id;
} else {
    userID = null;
}

// && 연산자 사용
var userID = user && user.loggedIn && user.id
```


## try ~ catch 구문
#### 성능에 민감한 함수는 도우미 함수를 생성하여 호출한다.

`try ~ catch` 구문안에 있는 코드는 컴파일러가 최적화하지 못한다. 그러므로 *성능에 민감한 함수들은 도우미 함수를 생성*하여 사용하는 것이 좋다.

```javascript
function helper_func() {
  // 성능에 민감한 작업.
}

try {
    helper_func();
} catch (e) {
}
```

#### 반복문 안에 포함되는 경우 별도의 함수로 생성하여 호출한다.
catch 구문은 반복문이 생성될 때마다 에러객체를 생성한다 그러므로 별도의 함수를 생성하여 반복문을 수행한다.
```javascript
function func() {
  try {
  } catch (e) {
  }
}

for (let i = 0; i < 1000; i++) {
    func();
}
```



## Reference
- [성능을 높이는 코드 스타일](https://12bme.tistory.com/134)
- [자바스크립트 성능 최적화 팁](https://isme2n.github.io/devlog/2017/07/10/javascript-perfomance-optimization/)
- [안티 패턴](https://github.com/nhnent/fe.javascript/wiki/%EC%95%88%ED%8B%B0-%ED%8C%A8%ED%84%B4)




