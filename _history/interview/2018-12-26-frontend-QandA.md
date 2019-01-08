---
layout: post
title: "(Q) 프론트앤드 지식 관련 알아두어야 하는 기본적인 것들."
date: 2018-12-26 10:12:00
author: gloria
tags:
---

* TOC
{:toc}

# html

## DocType

* https://www.w3schools.com/tags/tag_doctype.asp
* http://webberstudy.com/html-css/html-2/doctype/
* `<!DOCTYPE>`은 html 문서의 `<html>` 태그 이전에(즉, 최상위에) 선언해야한다.
* 웹 브라우저에게 해당 페이지의 html 버전이 무엇인지를 알려주는 것이다.

## meta 태그

* https://developer.mozilla.org/ko/docs/Web/HTML/Element/meta
* 웹 페이지의 정보를 제공하기 위해 사용하는 태그이다.
* 페이지의 설명 요약, 작성자, 키워드 등에 대한 데이터를 포함한다.

# CSS

## Float

* float의 의미인 **뜨다**의 의미처럼. 페이지에서 컨텐츠를 특정 위치에 띄워서 배치할 것인지에 대해 설정하는 속성 값이다.
* float된 자식 엘리먼트의 높이는 부모에게 영향을 미치지 않는다. 이에 대한 해결방법은  http://naradesign.net/wp/2008/05/27/144/ 를 참고.
  * 부모의 속성에 `display: inline-block`을 준다.
  * 부모의 가상 선택자 `:after`로 **content:" "; display:block; clear:both** 속성을 추가한다.
* clear 속성은 float이 더 이상 주변 엘리먼트의 배치에 영향을 미치지 않도록 설정하는 속성이다

## Animation

* setInterval 보다는 requestAnimationFrame을 이용하는 것을 권장. setInterval은 설정한 시간마다 무조건  함수를 실행시키므로 성능이 좋지 않을 수 있는 반면, requestAnimationFrame은 브라우저가 스스로 상태를 판단하여 동작하므로 좀 더 유연한 대처가 가능하다.
* css 애니메이션을 가급적 사용하고, 좀 더 세밀한 제어가 필요한 경우 자바스크립트 애니메이션 사용을 하는 것을 권장한다
* `opacity`나 `transform`을 이용한 애니메이션 제어를 권장. (잦은 Reflow로 인한 성능 이슈가 발생할 수 있으므로)
* https://developers.google.com/web/fundamentals/design-and-ux/animations/css-vs-javascript?hl=ko
* https://developers.google.com/web/fundamentals/design-and-ux/animations/animations-and-performance?hl=ko#css-vs-javascript-performance
* [velocity.js](http://velocityjs.org)는 자바스크립트 애니메이션 라이브러리이다. 

# Javascript

## Event Loop

* https://meetup.toast.com/posts/89
* 자바스크립트는 **단일 스레드**기반의 언어이다.
* 단일 스레드 기반의 자바스크립트가 멀티 스레드처럼 동작하는 것처럼 보여지게 하는 것이 **이벤트 루프**이다.
* 비동기 api는 `task queue`에 추가한다.
* promise는 `micro task queue`를 사용하며 일단 task queue보다 높은 우선순위를 가진다.
* 이벤트 루프는 호출 스택이 비워질 때마다 큐에 쌓인 것을 꺼내와서 실행하는 역할을 수행한다.

## 함수형 프로그래밍(Function Programming)

* 함수형 프로그래밍에 대해 설명해달라
  * *공통화, 모듈화* 하기 위한 개발 스타일(?) 중의 하나로, side effect를 최소화하기 위한 프로그래밍 스타일 (ex. underscore)
* 함수형 프로그래밍에 개념에서 순수함수란 무엇인가
  * 전달받은 아규먼트를 이용하여 결과를 리턴하는 함수

```javascript
function add(x, y) {
    return x + y;
}
```

* OOP와 함수형 프로그래밍의 가장 큰 차이점은 무엇인가
  * 함수형프로그래밍은 상태를 저장하지 않는다.

## 비동기 프로그래밍(Asynchronous)

* AJAX란 무엇인가
  * XMLHttpRequest 객체를 이용하여 비동기식 프로그래밍을 위한 라이브러리

* Promise란 무엇이며 코드가 어떻게 구성되어있는가
  * 콜백 중첩을 해소하기 위한 패턴
  * 콜백 함수는 resolve와 reject 함수를 인자로 전달받는다.

```javascript
new Promise(function (resolve, reject) {
}
```

* Promise와 Callback의 차이점은 무엇이며 각각의 장단점에 대해 설명해달라
  * Promise
    * 단일 비동기 처리에 유리하다.
    * 진행 상태 표시를 위해 얼만큼 진행되었는 지를 요청할 수 없다.
    * promise를 취소할 수 없다.
  * Callback
    * 에러처리가 쉽지 않다.
    * 중첩 콜백의 경우 가독성이 떨어진다. (콜백 헬)

* Async, Await가 무엇이며, 사용해본 경험이 있는가
  * 비동기 프로그램을 비교적 쉽고 명확하게 작성할 수 있게 해준다.
  * ES8에서 공식 스펙으로 지정되었음

* https://blueshw.github.io/2018/02/27/async-await/

## Vue.js

* 면접관을 Vue.js 비사용자라고 가정하고 Vue.js에 설명하고 장단점을 말해달라
  * 프론트엔드 자바스크립트 프레임워크
  * react, angular에 비하여 초반 러닝커브가 낮다.
  * 3rd-party 라이브러리와 같이 사용하기 쉽다.
  * 공식 문서의 한글화가 잘 되어있음
  
  * 단점
    * react나 타 프레임워크에 비해 생태계가 아직은 좁다
    * 타입스크립트를 완벽히 지원하지 않는다. (vue.js 3 부터는 공식 지원한다는데...)
    * 하나의 템플릿에서 조건을 처리하려면 내부에서 자바스크립트 변수로 생성할 수 없고, 별도의 템플릿 파일을 생성해야한다. (jsx를 시용하면 되지만...권고사항이 아니라서...)

* Vue.js의 Life-cycle에 대해 아는대로 말해달라
  * https://medium.com/witinweb/vue-js-%EB%9D%BC%EC%9D%B4%ED%94%84%EC%82%AC%EC%9D%B4%ED%81%B4-%EC%9D%B4%ED%95%B4%ED%95%98%EA%B8%B0-7780cdd97dd4

* Vue.js 에서 DOM은 어느 시점에 생성되나
  * Mounting 단계

* Computed와 Methods의 차이점은 무엇인가
  * https://beomy.tistory.com/49
  * 둘의 차이는 데이터가 변동되지 않을 때에 발생한다.
  * Computed
    * 이전의 계산된 값을 캐시해두었다가 사용.
    * 매개변수를 받을 수 없음.
  * Methods
    * 호출될 때마다 함수의 계산을 다시한다.

* 가상돔(Virtual DOM) 개념은 무엇이며, DOM과의 차이점 가상돔의 개념이 사용되게된 배경은 무엇인가
  * 크고 다양한 웹어플리케이션이 늘어나면서 DOM 트리를 수정할 일이 많아짐. - 잦은 reflow가 발생
  * 가상 돔은 HTML DOM의 추상화 개념.

* DOM을 직접 조작하는 D3.js 같은 라이브러리와의 결합시에 예상되는 문제점이 있는가

## AMP

* AMP의 개념은 무엇이고 기존의 것에 비해 장점은 무엇인가
  * Accelerated Mobile Pages
  * 모바일 전용 빠른 웹페이지

최근의 프레임워크들과의 조합을 고려해 본적이 있는가 ex) vue-amp..

## 자바스크립트의 원시 타입(Primitive Data Type)은 몇가지이며, 전부 말해달라

* Number, String, Boolean, Null, Undefined, (Symbol)

## 자바스크립트의 Number Type은 다른 언어들과 차이점이 무엇인가, 왜 하나만 존재하는가

## 실행 컨텍스트(Execution Context)에 대해 설명해달라

## 자바스크립트의 호이스팅(Hoisting)은 어떻게 이루어져 있는가

## 클로저(Closure)란 무엇이며, 왜 이러한 패턴을 사용하는가

## This

자바스크립트에서 This는 몇가지로 추론 될수 있는가, 아는대로 말해달라
Call, Apply, Bind 함수에 대해 설명해달라

## ES6

크롬 정도의 브라우저를 제외하곤 ES6 스펙에 대한 지원이 완벽하지 않다. 해결방법은 무엇인가
Babel의 기능을 한 단어로 말해달라
ES6 에서 추가된 스펙에 대해 아는대로 다 말해달라(let, const, rest parameter, class, arrow function...)
var 와 let, const의 가장 큰 차이점은 무엇인가 (function scope와 block scope의 개념에서)
Class 는 무엇이고, Prototype, fucntion의 ES5 스펙만으로 Class를 구현할수 있는가

## RESTful API 가 무엇인가, 아는대로 다 말해달라

## 클라이언트 개발시 보안 관련 이슈

보안은 서버쪽에서 많이 신경쓰고 있지만, 프론트엔드 개발에서 보안관련 이슈는 어떠한 것들이 있는가
Wireshark 에 대해 알고 있는가
HTTP 통신의 문제점에 대해서 아는대로 말해달라
CORS(Cross-Origin Resource Sharing)는 무엇인가 왜 이러한 방법이 정의 되었으며, 본인이 코드를 작성하면서 CORS와 관련하여서 경험하였던 이슈는 무엇인가
간단한 데이터를 클라이언트로만 관리 할수 있는가, 이와 관련해서 브라우저 에서 어떠한 것들을 지원하고 있는가, 예를 들면 소셜 로그인같은 것들에 대한 브라우저 종료시 발생하는 문제에 대응 경험이 있는가

# 자료구조

자료구조에 대해 공부한 적이 있는가
Binary Search Tree 에 대해 알고 있는가, 설명해달라
Graph 에서 다른 노드를 참조하는 구조를 코드로 구현 할수 있는가