---
layout: post
title: "(Javascript) 자바스크립트 엔진"
date: 2018-10-31 19:15:00
author: gloria
categories: language
tags: javascript

---

* TOC
{:toc}


이해하기가 어렵다.ㅡㅠ



## Javascript 엔진
자바스크립트 엔진의 기본적인 역할은, 개발자가 작성한 자바스크립트 코드를 브라우저에 의해 해석되거나 어플리케이션에 임베드 될 수 있는 빠르고 최적화된 코드로 변환하는 일이다. 
자바스크립트 엔진 중에 유명한 것이 구글의 V8 엔진이다. V8 엔진은 크롬과 Node.js에서 사용된다.

## 가비지 컬렉션
자바스크립트에서 객체, 문자열 등이 생성되어 메모리가 할당되었는데, 더 이상 사용되지 않으면 자동으로 메모리가 반환이 되는 과정을 말한다.
메모리에는 다음과 같은 것들이 저장된다.
- 프로그램에서 사용되는 모든 변수와 기타 데이터
- 운영체제 및 개별 프로그램의 코드

## 자바스크립트에서 흔한 메모리 누수
#### 전역변수
함수 내에서 의도치 않게 전역변수를 생성하는 경우. 
```javascript
function foo() {
    this.var1 = "potential accidental global";
}
// 다른 함수 내에 있지 않은 foo를 호출하면 this는 글로벌 객체(window)를 가리킴
foo();
```

#### 잊혀진 타이머 혹은 콜백함수
```javascript
var serverData = loadData();
setInterval(function() {
    var renderer = document.getElementById('renderer');
    if(renderer) {
        renderer.innerHTML = JSON.stringify(serverData);
    }
}, 5000); // 매 5초 마다 실행
```


#### 클로저
자바 스크립트의 특성상 아래와 같이 메모리 누수가 발생할 수 있다.
```javascript
var theThing = null;
var replaceThing = function () {
  var originalThing = theThing;
  var unused = function () {
    if (originalThing) // 'originalThing'에 대한 참조
      console.log("hi");
  };
  theThing = {
    longStr: new Array(1000000).join('*'),
    someMethod: function () {
      console.log("message");
    }
  };
};
setInterval(replaceThing, 1000);
```

#### DOM에서 벗어난 요소 참조
```javascript
var elements = {
    button: document.getElementById('button'),
    image: document.getElementById('image')
};
function doStuff() {
    elements.image.src = 'http://example.com/image_name.png';
}
function removeImage() {
    // image는 body 요소의 바로 아래 자식임
    document.body.removeChild(document.getElementById('image'));
    // 이 순간까지 #button 전역 요소 객체에 대한 참조가 아직 존재함
    // 즉, button 요소는 아직도 메모리 상에 있고 가비지컬렉터가 가져갈 수 없음
}
```




## Reference
- [(번역) 바보들을 위한 자바스크립트 엔진 가이드](https://dongwoo.blog/2015/10/12/%EB%B2%88%EC%97%AD-%EB%B0%94%EB%B3%B4%EB%93%A4%EC%9D%84-%EC%9C%84%ED%95%9C-%EC%9E%90%EB%B0%94%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8-%EC%97%94%EC%A7%84-%EA%B0%80%EC%9D%B4%EB%93%9C/)
- [자바스크립트는 어떻게 작동하는가: 엔진, 런타임, 콜스택 개관](https://engineering.huiseoul.com/%EC%9E%90%EB%B0%94%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8%EB%8A%94-%EC%96%B4%EB%96%BB%EA%B2%8C-%EC%9E%91%EB%8F%99%ED%95%98%EB%8A%94%EA%B0%80-%EC%97%94%EC%A7%84-%EB%9F%B0%ED%83%80%EC%9E%84-%EC%BD%9C%EC%8A%A4%ED%83%9D-%EA%B0%9C%EA%B4%80-ea47917c8442)
- [자바스크립트는 어떻게 작동하는가: 메모리 관리 + 4가지 흔한 메모리 누수 대처법](https://engineering.huiseoul.com/%EC%9E%90%EB%B0%94%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8%EB%8A%94-%EC%96%B4%EB%96%BB%EA%B2%8C-%EC%9E%91%EB%8F%99%ED%95%98%EB%8A%94%EA%B0%80-%EB%A9%94%EB%AA%A8%EB%A6%AC-%EA%B4%80%EB%A6%AC-4%EA%B0%80%EC%A7%80-%ED%9D%94%ED%95%9C-%EB%A9%94%EB%AA%A8%EB%A6%AC-%EB%88%84%EC%88%98-%EB%8C%80%EC%B2%98%EB%B2%95-5b0d217d788d)
- 