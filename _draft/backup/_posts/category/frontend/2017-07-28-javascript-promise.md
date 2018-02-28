---
layout: post
comments: true
title: "[JavaScript] 비동기 프로그래밍 (Promise & co)"
date: 2017-07-28 15:50:00
categories: Frontend
tags: javascript es6
---

Promise와 co를 이용한 비동기 프로그래밍에 대해 필요해서 공부하면서 정리한 내용     
그리고 참고한 사이트들    
   
해당 함수들을 이해하려면 일단 아래의 내용들을 이해해두어야 한다.        
* async vs sync의 차이     
* callback 함수      
* clousure(클로저)     
* Generator        

## Promise
ECMA Script6에 정식으로 추가된 문법으로 비동기 계산을 위해 사용되는 객체이다.   
promise의 뜻 그대로 *약속*으로 이해아면 좀 더 쉬운 것 같다.     
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

function get(url) {
  // Return a new promise.
  return new Promise(function(resolve, reject) {
    // Do the usual XHR stuff
    var req = new XMLHttpRequest();
    req.open('GET', url);

    req.onload = function() {
      // This is called even on 404 etc
      // so check the status
      if (req.status == 200) {
        // Resolve the promise with the response text
        resolve(req.response);
      }
      else {
        // Otherwise reject with the status text
        // which will hopefully be a meaningful error
        reject(Error(req.statusText));
      }
    };

    // Handle network errors
    req.onerror = function() {
      reject(Error("Network Error"));
    };

    // Make the request
    req.send();
  });
}

// Use it!
get('story.json').then(function(response) {
  console.log("Success!", response);
}, function(error) {
  console.error("Failed!", error);
});
```

## co
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
    
     
이걸 겨우 가볍게나마 이해해놨더니...ES7에는 async와 await가 도입된다고....   
참고--> [ES6 Generator 와 ES7 Generator의 차이점?](http://blog.hazard.kr/archives/399)         


> *Reference*    
> [MDN-Promise](https://developer.mozilla.org/ko/docs/Web/JavaScript/Reference/Global_Objects/Promise)      
> [비동기프로그래밍, ES6(ECMA Script 6) - Promise로 콜백지옥 해결하기](http://beomy.tistory.com/11)      
> [JavaScript Generators와 Co](https://medium.com/@pitzcarraldo/javascript-generators와-co-5316ee9266f9)     
> [ES6의 제너레이터를 사용한 비동기 프로그래밍](http://meetup.toast.com/posts/73)     