---
layout: post
title: "(Javascript) Async/Await"
date: 2018-10-31 11:15:00
author: gloria
categories: language
tags: javascript

---

* TOC
{:toc}

## 콜백함수
싱글 쓰레드 기반인 자바스크립트에서 비동기 처리를 위해서 콜백함수를 사용한다.
예를 들어 대표적인 콜백함수는 `setTimeout(callback, milliseconds)`가 있다.
```javascript
function getData(callbackFunc) {
	$.get('https://domain.com/products/1', function (response) {
		// 서버에서 받은 데이터 response를 callbackFunc() 함수에 넘겨준다
		callbackFunc(response); 
	});
}

getData(function (tableData) {
	// $.get()의 response 값이 tableData에 전달된다
	console.log(tableData); 
});
```

#### 콜백함수의 단점
비동기 처리 로직을 위해 콜백함수를 연속으로 사용하는 경우에 **콜백 지옥**이 발생할 수 있다. 콜백 지옥은 코드의 가독성을 떨어뜨림과 동시에 해당 로직의 변경이 어려워질 수 있다.

###### 콜백 지옥 해결 방법
각각의 콜백함수를 분리하여 작성해주거나, promise 또는 aysnc/await 구문을 사용하여 개선할 수 있다.


## Promise
ECMA Script6에 정식으로 추가된 문법으로 비동기 계산을 위해 사용되는 객체이다.   
promise의 뜻 그대로 *약속*으로 이해하면 좀 더 쉬운 것 같다.     
즉, "지금은 아니지만, 곧 해당 약속한 부분을 완료하겠다"라는 뜻으로....    

#### 구문
```javascript
new Promise( /* executor */ function(resolve, reject) { ... } );
```

#### promise의 상태
promise는 다음 중 하나의 상태를 가진다.
* pending - 초기 상태로써 아직 대기 중인 상태    
* fulfilled - 수행이 성공하였음        
* rejected - 수행이 실패하였음      
* settled - 수행이 완료된 상태     

#### 예시
```javascript
// From Jake Archibald's Promises and Back:
// http://www.html5rocks.com/en/tutorials/es6/promises/#toc-promisifying-xmlhttprequest

function get() {
  return new Promise(function(resolve, reject) {
  	const endpoint = 'https://gist.githubusercontent.com/Miserlou/c5cd8364bf9b2420bb29/raw/2bf258763cdddd704f8ffd3ea9a3e81d25e2c6f6/cities.json';
  	fetch(endpoint)
    	.then(res => res.json())
        .then(data => resolve(data))
        .catch(error => reject(error));
  });
}

// Use it!
// 1. then()으로 에러를 처리하는 경우
get().then(function (response) {
  console.log("Success!", response);
}, function (error) {
  console.error("Failed!", error);
});


// 2. catch()로 에러를 처리하는 경우
get().then((response) => {
  console.log("Success!", response);
}).catch(error => {
  console.error("Failed!", error);
});
```


## Generator (co)
[co](github.com/tj/co)는 Generator를 이용한 control flow 모듈로써 내부적으로 promise를 사용하여 구현되어 있다.    

#### 예제
```javascript
var co = require('co');

co(function *(){
  // yield any promise
  var result = yield Promise.resolve(true);
}).catch(onerror);

co(function *(){
  // resolve multiple promises in parallel
  var a = Promise.resolve(1);
  var b = Promise.resolve(2);
  var c = Promise.resolve(3);
  var res = yield [a, b, c];
  console.log(res);
  // => [1, 2, 3]
}).catch(onerror);

// errors can be try/catched
co(function *(){
  try {
    yield Promise.reject(new Error('boom'));
  } catch (err) {
    console.error(err.message); // "boom"
 }
}).catch(onerror);

function onerror(err) {
  // log any uncaught errors
  // co will not throw any errors you do not handle!!!
  // HANDLE ALL YOUR ERRORS!!!
  console.error(err.stack);
}
```


## Async/Await
ECMAScript 2017에서 표준으로 정의되었다. 비동기 프로그래밍을 동기 방식처럼 직관적으로 표현할 수 있다는 장점이 있다.
> async/await의 목적은 프로미스의 이용을 쉽게하는 것이다.

```javascript
function getNumber1() {
    return Promise.resolve('374');
}

async function getNumber2() {
    return 374;
}
```

#### aysnc/await 코드를 이용한 코드 작성 팁
####### 클린코드
`aysnc/await`를 이용하면 훨씬 간결한 코드를 작성할 수 있다.
```javascript
/*
rp(‘https://api.example.com/endpoint1').then(function(data) {
 // …
});
*/
var response = await rp(‘https://api.example.com/endpoint1');
```

####### 에러처리
동일한 코드 구조로 비동기 코드와 동기 코드의 에러를 처리하는 것이 가능하다.
```javascript
/*
function loadData() {
    try { // Catches synchronous errors.
        getJSON().then(function(response) {
            var parsed = JSON.parse(response);
            console.log(parsed);
        }).catch(function(e) { // Catches asynchronous errors
            console.log(e); 
        });
    } catch(e) {
        console.log(e);
    }
}
*/
async function loadData() {
    try {
        var data = JSON.parse(await getJSON());
        console.log(data);
    } catch(e) {
        console.log(e);
    }
}
```

####### 조건문 작성
훨씬 직관적인 조건문 작성이 가능하다.
```javascript
/*
function loadData() {
  return getJSON()
    .then(function(response) {
      if (response.needsAnotherRequest) {
        return makeAnotherRequest(response)
          .then(function(anotherResponse) {
            console.log(anotherResponse)
            return anotherResponse
          })
      } else {
        console.log(response)
        return response
      }
    })
}
*/
async function loadData() {
  var response = await getJSON();
  if (response.needsAnotherRequest) {
    var anotherResponse = await makeAnotherRequest(response);
    console.log(anotherResponse)
    return anotherResponse
  } else {
    console.log(response);
    return response;    
  }
}
```

###### 스택프레임
프로미스 체인에서 반환된 에러 스택은 어디에서 에러가 발생했는지에 대한 정보를 주지 않는 반면, `aysnc/await`로 구현하면 에러 스택을 통하여 에러가 발생한 위치를 확인할 수 있다.

###### 디버깅
`aysnc/await`의 경우에는 개발자 도구에서 디버깅이 프로미스 보다는 수월하다.


## Reference
- [ES6의 제너레이터를 사용한 비동기 프로그래밍](http://meetup.toast.com/posts/73) 
- [Async-await는 어떻게 구현하는가](http://dev-momo.tistory.com/m/entry/Asyncawait%EB%8A%94-%EC%96%B4%EB%96%BB%EA%B2%8C-%EA%B5%AC%ED%98%84%ED%95%98%EB%8A%94%EA%B0%80-1?category=536788)
- [자바스크립트 비동기 처리와 콜백 함수](https://joshua1988.github.io/web-development/javascript/javascript-asynchronous-operation/)
- [자바스크립트 Promise 쉽게 이해하기](https://joshua1988.github.io/web-development/javascript/promise-for-beginners/)
- [자바스크립트는 어떻게 작동하는가: 이벤트 루프와 비동기 프로그래밍의 부상, async/await을 이용한 코딩 팁 다섯 가지](https://engineering.huiseoul.com/%EC%9E%90%EB%B0%94%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8%EB%8A%94-%EC%96%B4%EB%96%BB%EA%B2%8C-%EC%9E%91%EB%8F%99%ED%95%98%EB%8A%94%EA%B0%80-%EC%9D%B4%EB%B2%A4%ED%8A%B8-%EB%A3%A8%ED%94%84%EC%99%80-%EB%B9%84%EB%8F%99%EA%B8%B0-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D%EC%9D%98-%EB%B6%80%EC%83%81-async-await%EC%9D%84-%EC%9D%B4%EC%9A%A9%ED%95%9C-%EC%BD%94%EB%94%A9-%ED%8C%81-%EB%8B%A4%EC%84%AF-%EA%B0%80%EC%A7%80-df65ffb4e7e)