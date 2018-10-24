---
layout: post
title: "(Javascript) Closure(클로저)"
date: 2018-10-24 21:35:00
author: gloria
categories: language
tags: javascript
---

## 클로저
클로저는 외부에서 내부 변수에 접근할 수 있도록 하는 함수를 말한다.
쉽게 말하면, 함수 내에서 함수를 정의하고 리턴하는 것을 의미한다.

```javascript
function getClosure() {
  var text = 'variable 1';
  function closure() {
    return text;
  };
  return closure;
}

var globalVar = getClosure();
console.log(globalVar());
```
위의 함수는 다음과 같이 동작한다.
1. 전역변수 globalVar에  closure() 함수가 저장된다.
2. 전역에서 globalVar()를 호출한다.
3. closure()는 자신의 스코프에서 text 변수를 찾는다.
4. closure()는 지역 객체에 text가 없으므로 상위 스코프인 getClosure()로 가서 찾는다.
5. getClosure()의 스코프에서 text를 찾아 값인  'variable 1'을 리턴한다.


## 클로저를 왜 사용할까?
클로저를 사용하면 전역변수의 오남용을 방지할 수 있다. 
즉, 클로저를 통하여 모듈패턴을 이용하여 은닉화함으로써 불필요한 변수에 대한 접근을 차단함으로써 전역변수의 오남용을 줄일 수 있다.
```javascript
function hello(name) {
  var _name = name;
  return function() {
    console.log('Hello, ' + _name);
  };
}
```

위의 코드를 prototype을 이용하여 객체를 생성하는 경우에는 내부 변수에 접근이 가능하다.
```javascript
function Hello(name) {
  this._name = name;
}

Hello.prototype.say = function() {
  console.log('Hello, ' + this._name);
}

var hello1 = new Hello('KK');
hello1._name = 'JJ'; // 이렇게 접근하여 의도치않게 변수의 값을 변경할 수 있다.
```

## 클로저 사용 시 주의할 점
###### 반복문
for 문에서 클로저는 상위 함수의 변수를 참조할 때, 자신의 생성될 때가 아닌 내부 변수의 최종 값을 참조한다.
```javascript
function count() {
    for (var i = 1; i < 10; i += 1) {
        setTimeout(function timer() {
            console.log(i);
        }, i*100);
    }
}
count();
```
위의 함수를 수행하면 `1, 2, 3...9`가 의도한데로 출력되는 것이 아니라 반복해서 10이 출력된다.
그 이유는 클로저는 항상 상위 스코프에서 변수 `i`를 찾을 것이다. 그리고 timer는 지정된 시간 후에 호출되는 데, 그 시간 동안 이미 반복문이 수행이 완료되어 i는 10이 되었기 때문이다.

그러므로 해당 코드를 의도한데로 동작하도록 하기 위해서는 아래와 같이 수정하여야 한다.
- 중첩 클로저를 사용

```javascript
function count() {
	var timeout = function(i) {
        setTimeout(function timer() {
            console.log(i);
        }, i*100);
	}
    for (var i = 1; i < 10; i += 1) {
    	timeout(i);
    }
}
count();
```

- 블록 스코프를 사용 (ES6)

```javascript
function count() {
    for (let i = 1; i < 10; i += 1) {
        setTimeout(function timer() {
            console.log(i);
        }, i*100);
    }
}
count();
```

###### 클로저 성능
클로저를 통해 내부 변수를 참조하는 동안에는 내부 변수가 차지하는 메모리를 가비지 컬렉터가 회수하지 않으므로 사용이 끝나면 참조를 제거해준다.
```javascript
var hello = new Hello('KK');
hello();
hello = null;
```

## Reference
- [JavaScript 클로저(Closure)](https://hyunseob.github.io/2016/08/30/javascript-closure/)
- [클로저(Closure) 사용에는 주의가 필요합니다](http://blog.javarouka.me/2012/01/closure.html)
- [JavaScript : Scope 이해](http://www.nextree.co.kr/p7363/)
