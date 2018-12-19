---
layout: post
title: "(interview) 프론트엔드 개발자 면접 질문들"
date: 2018-11-08 10:12:00
author: gloria
categories: etc
tags: 
---

* TOC
{:toc}

[원글](https://github.com/h5bp/Front-end-Developer-Interview-Questions/tree/master/Translations/Korean)

## 일반적인 질문들
#### 어제/이번 주에 무엇을 공부하셨나요?
#### 코딩을 할 때 당신을 들뜨게 하거나 흥미를 끄는 것들은 무엇은 가요?
- 어제보다 더 낳은 코드를 작성할 수 있을 지?? 문제의 해결점을 찾고, 한 단계 성장했음을 느낄때..

#### 최근에 당신이 경험한 기술적인 문제는 무엇이고 그것을 어떻게 해결했나요?
- cors 이슈
- spring boot 와 연동하는 이슈

#### 웹 애플리케이션이나 사이트를 만들 때 고려해야 할 UI, Security, Performance, SEO, Maintainability에 대해서 설명해주세요.
- UI : 웹표준성? 접근성? 사용자가 친숙하게 잘 사용할 수 있고 사용하고 싶은 디자인인지?
- Security : 토큰 ??
- Performance : repaint, reflow, for-in 사용안하기,  try-catch 시에 도우미 함수 사용하기??
- SEO : 사전 렌더링이나 SSR을 이용하여 해결
- Maintainability : 함수형 프로그래밍? 모듈화??

#### 선호하는 개발 환경에 대해 자유롭게 이야기해 주세요.
#### 버전 관리 시스템은 어떤 것들을 사용해보셨습니까?

#### 당신이 웹 페이지를 만들 때의 과정을 설명해주실 수 있을까요?
- 화면을 파워포인트, 카카오 오븐, figma 등과 도구를 이용하여 프로토타이핑
- 관련 동료들과 작성한 내용으로 리뷰
- 필요한 기술요소가 있다면 조사 및 적용 가능여부에 대하여 테스트
- 화면을 컴포넌트화 해서 각 모듈별로 구현
- 페이지를 구현할 때, 라우팅, 레이아웃 등 공통적인 부분 부터 정의 및 구현하고 시작
- 실제 개발을 하고 나면, 실 사용자라는 입장에서 1차적으로 테스트와 에러를 발생해보고 문제점이나 개선사항이 있다면 주변 동료와 같이 이야기 해보고 개선 사항을 도출한 뒤 반영 여부를 결정
- 개발을 하다가 반복적으로 사용이 되거나, 공통으로 추출이 가능한 부분이 있다면 중간 중간 리팩토링을 한다.

#### 당신에게 5가지 다른 stylesheet가 있습니다. 어떤 방법으로 사이트에 제공하는 게 가장 효과적일까요?
- webpack을 이용해서 빌드해서. css로 변환한 뒤에 압축해서 제공??


#### 만약 당신이 올해 기술적 책임자가 되었다면 무엇을 먼저 하시겠습니까?
- 주변 동료들과 조직의 방향성이나 생각하는 것들을 물어보는 시간을 갖고 책임자로서 경험이 있는 선배들에게 조언을 구하여 판단할 것이다.

#### 표준의 중요성에 관해 설명해주세요.
- 규칙이 없다면 세상이 어지러울 것처럼, 표준이 없다면 
- 코드의 경우 유지보수가 어렵다. 그 말을 수정사항이 생기면 영향도가 클 수 있다.
- 어느 부분에 맞추어 개발을 해야할 지 방향성을 정하기 어렵다.

#### CORS는 무엇의 약자이고 어떤 문제에 대해서 언급하는 것인가요?
- Cross Origin Resource Sharing
- 서로 다른 도메인 간의 자원 요청 시에 발생하는 이슈. (자원 접근성 이슈)

#### 점진적 향상법(progressive enhancement)과 우아한 성능저하법(graceful degradation)의 차이를 설명하실 수 있습니까?
- 점진적 향상법 - 오래된 기기 혹은 낮은 버전의 브라우저에 맞추고, 여러 테스트를 통해 기능을 점진적으로 향상시키는 것.
- 우아한 성능저하 -  최신 기술에 맞춘 후 오래된 기기 혹은 기술에서도 동작하도록 하기 위해 최적화시키는 방법.

#### 웹사이트에서 assets/resources를 최적화하는 방법에 관해 설명해주세요.
- 압축을 해서 로딩 시간을 최소화 시키는 것. 브라우저 캐쉬 기능을 이용하여 캐싱하는 것??. cdn 활용?


#### 브라우저가 한 번에 1개의 도메인에서 내려받는 자원은 몇 개인가요?
    * 예외에는 어떤 것들이 있나요?
- 브라우저마다 다르다.
- 브라우저 벤더별로, 버전별로 상이하지만 메이저 브라우저들은 평균 6~8개의 리소스를 동시에 받을 수 있다. 크로스 브라우징을 고려하면 평균적으로 6개라고 생각하면 된다.
- https://medium.com/@ipark/%EB%B8%8C%EB%9D%BC%EC%9A%B0%EC%A0%80%EB%8A%94-%ED%95%9C-domain%EC%97%90%EC%84%9C-%EB%8F%99%EC%8B%9C%EC%97%90-%EB%A6%AC%EC%86%8C%EC%8A%A4%EB%A5%BC-%EB%AA%87%EA%B0%9C-%EB%B0%9B%EC%9D%84-%EC%88%98-%EC%9E%88%EC%9D%84%EA%B9%8C-41dec9835e6c


#### 페이지 로드 시간을 줄이는 세 가지 방법에 관해서 이야기 해 보세요.
- 자바스크립트 소스를 </body> 위에 선언한다.
- minify 하여 제공한다.
- 압축하여 제공한다. (이미지, 자바스크립트)
- HTTP 요청 최소화
- 정적 파일은 브라우저 캐시에 저장

#### 당신이 프로젝트에 합류했습니다. 근데 그들은 Tab을 이용하고, 당신은 Space를 사용했습니다. 어떻게 하실 건가요?
- 내부 동료들과 둘 중 하나로 통일을 하여 vim이나 ide 등과 같은 도구를 이용하여 기존 프로젝트를 통일하기로 한 것으로 수정한 뒤 재발을 방지하고 싶다면, 도구의 설정 파일을 공유하여 적용이 가능하다면 적용하고 또한 lint 등과 같은 도구를 이용하는 것을 고려한다.


#### 간단한 Slideshow 페이지를 만드는 방법에 관해서 이야기해 보세요.
- position: absolute; left: width; 를 기반으로 모든 페이지를 좌측으로 정렬 시키고, 자바스크립트로 left 값을 변경하는 식. 
- 직접 스타일을 조작하는데 리플로우, 리드로우와 같이 퍼포먼스 문제가 있다면 CSS3 transform을 사용할 것.

#### Flash of Unstyled Content에 관해 설명해주세요. 또 FOUC를 피하기 위해선 어떻게 해야 하나요?
- FOUC(Flash Of Unstyled Content)는 외부의 CSS가 불러오기 전에 잠시 스타일이 적용되지 않은 웹 페이지가 나타나는 현상이다.
- FOUC를 최소화하기 위해서는 기본적으로 <head> 요소안에 CSS를 링크하고, @import의 사용을 자제해야 한다.
- 자바스크립트의 선언순서, 위치를 변경함으로써 극복 가능하거나, 매우 짧아질 수 있다.(성능을 위해 </body> 요소 앞에 자바스크립트를 위치시키곤 하는데 이를 <head> 안으로 위치를 변경해 본다.)
- FOUC를 유발하는 구역을 숨겼다가 문서의 스타일이나 스크립트가 모두 적용되면 보여준다.
-  http://uzulab.tistory.com/4

#### ARIA와 screenreader에 대해 설명해주세요. 또 접근성을 지원하는 웹사이트를 어떻게 만드는지에 대해도 설명해주세요.
- Web Accessibility Initiative - Accessible Rich Internet Applications
- 웹접근성.
: https://www.slideshare.net/mctenshi/waiaria-55186130

#### CSS 애니메이션과 JavaScript 애니메이션의 차이점에 관해 설명해주세요.
- 애니메이션을 세밀하게 표현해야할 경우 자바스크립트
-  간단한 전환은 CSS 애니메이션 사용
-  자바스크립트에서 애니메이션 구현 시 requestAnimationFrame메서드를 사용하는 것을 권장
- jQuery의 경우 setInterval을 사용하기 때문에 퍼포먼스 문제가 있을 수 있음.
- http://web-engineer.org/2017/06/20/css-animation-vs-js-animation/
- https://developers.google.com/web/fundamentals/design-and-ux/animations/css-vs-javascript?hl=ko


## JS 관련 질문
#### this는 JavaScript에서 어떻게 작동하는지 설명해주세요.
- 함수의 현재 실행 문맥
- https://gloriajun.github.io/language/2018/10/29/javascript-this.html
- https://github.com/FEDevelopers/tech.description/wiki/%EC%9E%90%EB%B0%94%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8%EC%97%90%EC%84%9C-%EC%82%AC%EC%9A%A9%EB%90%98%EB%8A%94-this%EC%97%90-%EB%8C%80%ED%95%9C-%EC%84%A4%EB%AA%85-1

#### prototype 기반 상속은 어떻게 하는지 설명해주세요.
- prototype : 자신이 다른 객체의 원형이 되는 객체
```javascript
function Parent() {
  this.hello ='hello';
}

function Child() {
  this.world = 'world'; 
  this.helloworld = this.hello+' '+this.world;
}

Child.prototype = new Parent();
Child.prototype.constructor = Child;

var Obj = new Child();

console.log(Obj.helloworld);
```
- ES6에서는 클래스 개념이 도입되어서 extends를 이용하여 상속 구현할 수 있음
- https://meetup.toast.com/posts/104


#### AMD와 CommonJS는 무엇이고, 이것들에 대해 어떻게 생각하시나요?
- JavaScript 모듈화를 위한 라이브러리?
- https://programmingsummaries.tistory.com/321
- https://d2.naver.com/helloworld/12864


#### 다음 코드가 즉시 호출 함수 표현식(IIFE)로 동작하지 않는 이유에 관해서 설명해보세요: 
function foo(){ }();.
​    * IIFE로 만들기 위해서는 어떻게 해야 하나요? -> (function foo(){ })();
- http://chanlee.github.io/2014/01/11/understand-javascript-iife/
- IIFE를 사용하는 주된 이유 - 변수를 전역(global scope)으로 선언하는 것을 피하기 위해서 입니다. 
- 함수 선언(declaration)은 미리 자바 스크립트의 실행 컨텍스트(execution context)에 로딩 되어 있으므로 언제든지 호출할 수 있지만, 표현식(Expression)은 인터프리터가 해당 라인에 도달 하였을때만 실행이 됩니다.


#### 익명함수(anonymous functions)는 주로 어떤 상황에서 사용하나요?
- 함수표현식을 이용하는 방법
- 전역변수를 더럽히지 않거나, 은닉화를 위해서??


#### function foo() {}와 var foo = function() {}에서 foo 의 차이가 무엇인지 설명해보세요.
- function foo() {} : 함수 선언문. 호이스팅이 발생함
- var foo = function() {} : 함수 표현식, 익명함수. 호이스팅 발생안함


#### null과 unedefined 그리고 undeclared의 차이점은 무엇인가요?
    * 두개를 구분하기 위해서는 어떻게 하면 될까요?
- null : 객체 참조의 연결을 해지하는 것. 값이 비어있음.
- undefined : 선언만 되고, 값이 할당되지 않은 경우.
- undeclared : 선언하지 않고도 사용가능한 변수. javascript 의 scope 개념에서 따져보면 유효범위를 지정하지 않은 변수다.


#### 클로져(Closure)는 무엇이며, 어떻게/왜 사용하는지 설명해주세요.
    * 클로져를 만들 때 선호하는 패턴은 무엇인가요? argyle (IIFEs에만 적용할 수 있다)
- https://gloriajun.github.io/language/2018/10/24/javascript-closure.html
- 콜백함수, promise, settimeout, ajax ...


#### 당신의 코드를 어떻게 구성하는지? (모듈 패턴, 전통적 상속)

#### 호스트 객체(Host Objects)와 네이티브 객체(Native Objects)의 차이점은 무엇인가요?
- 호스트 객체(Host Objects) : 사용자에 의해 생성된 객체
- 네이티브 객체(Native Objects) : 브라우저 혹은 구동 엔진에 내장되어 있는 객체


#### 다음 코드의 차이점은 무엇인가요?
```javascript
function Person(){} 
var person = Person()  // 함수를 수행한 뒤 결과를 person에 저장
var person = new Person() // Person 객체를 생성하여 person에 저장
```

#### Function.prototype.bind을 설명하세요.
###### .call과 .apply의 차이점은 무엇인가요?
- https://gloriajun.github.io/language/2018/10/29/javascript-this.html#bind--apply--call
- this에 강제로 해당 메서드를 호출한 함수를 바인딩 시킨다.
- bind : 바인딩 후 새로운 함수를 반환
-  apply: 해당 함수를 호출한다.
-  call :  apply 메서드와 동일하나 여러 개의 파라미터를 전달받을 수 있다.
```javascript
// bind
var hongSpeakNation = speakNation.bind(person);
hongSpeakNation();

// apply
speakNation.apply(person);
```


#### document.write()는 언제 사용하나요?
- 화면에 문자를 출력할 때에 사용
```javascript
document.write('hello');
```

#### UA 문자열을 이용하여 기능 검출(feature detection)과 기능 추론(feature inference)의 차이점을 설명하세요.
- 기능 검출: 스크립트가 호출하는 기능을 사용자의 브라우저가 지원하는지 체크하는 것을 말합니다. 
- 기능 추론 : 
- ?????????

#### AJAX에 관해 가능한 한 자세히 설명하세요.
###### AJAX를 사용했을 때의 장단점에 대해 설명해주세요.
- Asynchronous JavaScript and XML
- XMLHttpRequest 객체를 이용하여 비동기 방식으로 서버와 통신을 하는 것을 말한다.
- 브라우저의 url 주소의 변경을 이용하지 않고 내부적으로 통신하여 response 를 받아오기 때문에 특정 데이터만 불러오거나 비동기로 데이터를 불러와야하는 경우 사용된다.
- Same Origin Policy 정책으로 인해 cross domain 을 허용하지 않기 때문에 외부 도메인을 사용하여야 하는경우 JSONP, XML 등을 이용하여야 한다.


###### JSONP가 어떻게 동작 되는지 설명하세요. (그리고 AJAX와 어떻게 다른지 설명하세요.)
- cors 이슈를 해결할 수 있는 방법 중의 하나이다.
- JSONP 는 GET 요청만이 가능하다.

###### JavaScript의 "동일출처정책(the same-origin policy)"에 대해서 설명하세요.
- https://gloriajun.github.io/etc/2018/10/28/cors.html


#### 기존에 JavaScript 템플릿을 사용한 적이 있나요? 만약에 있다면, 어떠한 방식으로 사용했는지 말씀해주세요.
- handlebar


#### "호이스팅(Hoisting)"에 대해서 설명하세요.
- 자바스크립트 엔진이 실행 컨텍스트를 생성하면서 scope 를 정의 할때 기술된 순서에 상관없이 선언부에 대한 처리를 해석 우선순위 최우선으로 끌어올려 먼저 해석하는 것
- 선언에만 적용되고 할당구문에는 적용되지 않는다.


#### event delegation에 관해 설명해주세요.
- https://joshua1988.github.io/web-development/javascript/event-propagation-delegation/#%EC%9D%B4%EB%B2%A4%ED%8A%B8-%EB%B2%84%EB%B8%94%EB%A7%81---event-bubbling
- 이벤트 위임
- 동적으로 노드를 생성하고 삭제할 때 '각 노드에 대해 이벤트를 추가하지 않고, 상위 노드에서 하위 노드의 이벤트들을 제어하는 방식'
- 이 패턴은 다수의 HTML에 이벤트를 걸어야할 때, 그리고 활발한 이벤트 처리가 필요할 때 구성하면 좋다.
- 다수의 DOM 모두에 이벤트리스너를 부여하는 것이 아니라, 대표 DOM에만 이벤트를 걸어서 처리하는 패턴이다.

###### 이벤트 버블링(Event Bubbling)에 대해서 설명하세요.
- 이벤트 전파
- 이벤트 버블링은 특정 화면 요소에서 이벤트가 발생했을 때 해당 이벤트가 더 상위의 화면 요소들로 전달되어 가는 특성을 의미

###### 이벤트 캡쳐링(Event Capturing)에 대해서 설명하세요.
- 이벤트 버블링과 반대 방향으로 진행되는 이벤트 전파 방식



#### "속성(Attribute)"와 "요소(property)"의 차이가 무엇인가요?
- 속성(Attribute) :  엘리먼트가 가지고 있는 것들. HTML 요소에 추가적인 정보 전달  (ex. id, href, target, class ...)
- 요소(property) : object가 가지고 있는 것들. Attribute에 대한 HTML DOM tree에서의 표현


#### 내장된 JavaScript 객체를 확장하는 것이 좋지 않은 이유는 무엇인가요?
- 참조한 모든 객체가 확장한 구문을 따라가기 때문에 ?????

#### ==와 ===의 차이점은 무엇인가요?
- `==` :  값만 검사
-  `===` : 값과 데이터 타입도 같이 검사
```javascript
console.log('3' == 3) // true
console.log('3' === 3) // false
```


#### 다음 코드를 동작하게 만드세요.
duplicate([1,2,3,4,5]); // [1,2,3,4,5,1,2,3,4,5]
```javascript
function duplicate(arr) {
    return arr.concat(arr);
}
```

#### 삼항식(Ternary statement)을 사용하는 이유는 무엇이고, 그것을 표현하기 위한 연산자 단어는 무엇인가요?
- 조건문의 간소화
```javascript
a ? b :c
```

#### use strict;은 무엇이고, 사용했을 때 장단점에 관해서 설명해주세요.
- 문법을 좀 더 엄격하게 체크한다.
- 안전한 코딩을 위한 가이드라인


#### 100번 반복되는 반복문이 있습니다. 3의 배수일 때는 fizz, 5의 배수일 때는 buzz, 3과 5의 공배수일 때는 fizzbuzz가 출력되는 코드를 작성해보세요.
```javascript
for (let i = 1; i <= 100; i++) {
    let msg = `${(i % 3) ? '' : 'fizz'}${(i % 5) ? '' : 'buzz'}`;
	console.log(i, msg);
}
```


#### 전역 scope를 사용했을 때 장단점에 관해 설명해주세요.
- 어디서나 쉽게 접근할 수 있다.
- 범위가 넓어서 프로그램이 복잡하고 커질 수록  어떠한 문제가 생길 지 예측하기가 어렵다.
- 변수명이 겹칠 위험이 크다. 
- 등등~~


#### 때때로 load event를 사용하는 이유에 관해 설명해주세요. 또 단점이 있다면 대안에 대해서도 설명해주세요.
- dom의 로딩이 완료된 후에 이벤트를 등록해야하는 경우
- ????

#### document load event와 DOMContentLoaded event의 차이점은 무엇인가요?
- document load : 페이지에 정의된 모든 리소스의 다운로드가 완료될경우 (더 느림)
- DOMContentLoaded : D.O.M 트리가 만들어지면 발생


#### SPA에서 SEO에 유리하도록 만들기 위한 방법에 대해 설명해주세요.
- 사전렌더링
- 서버사이드렌더링
- sitemap.xml


#### Promise를 사용해 본 경험이 있나요?
###### Promise가 콜백 대비 장/단점은 무엇인지 설명해주세요.
- 체이닝을 이용하여 가독성이 높아질 수 있음.
- promise 내부에서 에러가 발생하는 경우에 에러를 처리하기 어려울 수 있다.
- promise에서 발생한 에러스택에서 정확한 에러의 발생 위치를 파악하기 어렵다.


#### JavaScript의 작동방식의 장단점에 관해 설명해주세요.
- 싱글스레드 기반. 이벤트 루프.
- 점점 더 많은 동시에 발생하는 클라이언트의 요청을 처리하는 것이 쉽다.
- 동시에 발생하는 클라이언트의 요청이 증가할 때, 이벤트 루프를 이용하기 때문에 많은 스레드를 이용하지 않는다.
- 멀티 스레드 방식보다 스레드를 덜 이용하기 때문에 메모리 또는 자원 소모가 작다.
- 오래걸리는 작업의 경우, 무한 대기 상태에 빠질 수 있다 (-> 비동기함수를 이용하여 문제를 해결할 수 있음)
- https://engineering.huiseoul.com/%EC%9E%90%EB%B0%94%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8%EB%8A%94-%EC%96%B4%EB%96%BB%EA%B2%8C-%EC%9E%91%EB%8F%99%ED%95%98%EB%8A%94%EA%B0%80-%EC%9D%B4%EB%B2%A4%ED%8A%B8-%EB%A3%A8%ED%94%84%EC%99%80-%EB%B9%84%EB%8F%99%EA%B8%B0-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D%EC%9D%98-%EB%B6%80%EC%83%81-async-await%EC%9D%84-%EC%9D%B4%EC%9A%A9%ED%95%9C-%EC%BD%94%EB%94%A9-%ED%8C%81-%EB%8B%A4%EC%84%AF-%EA%B0%80%EC%A7%80-df65ffb4e7e

#### event loop이란 무엇인가요?
- https://meetup.toast.com/posts/89
-  event loop이 : 현재 실행중인 태스크가 없는지'와 '태스크 큐에 태스크가 있는지'를 반복적으로 확인하는 것

###### call stack과 task queue에 관해 설명해주세요.
- call stack : 함수가 호출되면 스택에 쌓인다. 
- task queue: 모든 비동기 API들은 작업이 완료되면 콜백 함수를 태스크 큐에 추가한다. 콜스택이 비워지면 수행된다.

#### JavaScript를 디버깅할 때 사용하는 도구가 있으면 설명해주세요.
- 크롬 개발자도구, 콘솔 로그


#### 객체 안의 속성과 배열의 아이템을 순회할 때 사용하는 문법에 관해 설명해주세요.
- map, reduce, forEach, for

#### mutable object와 immutable object에 관해 설명해주세요.
- mutable : 변경 가능
- immutable: 객체가 생성된 이후 그 상태를 변경할 수 없는 디자인 패턴. 함수형 프로그래밍의 핵심 원리.
- https://poiemaweb.com/js-immutability

###### JavaScript에서 immutable 객체의 예를 들어보세요. 
- Boolean, Number, String, ...

###### immutability의 장/단점은 무엇인가요?
- 변경점 찾기 및 디버깅이 쉬움
- mutable한 코드보다 훨씬 느림

###### 자신의 코드에서 불변성(immutability를) 어떻게 달성할 수 있나요?
- 객체의 방어적 복사(defensive copy) : Object.assign
- 불변객체화를 통한 객체 변경 방지 : Object.freeze


#### 동기방식과 비동기 방식 함수의 차이에 관해서 설명해주세요.


#### let, var, const의 차이점에 관해서 설명해주세요.
- let : ES6이후, 블럭 스코프. 
- const : ES6이후, 상수 선언. 선언된 값을 변경할 수 없음. 블럭 스코프
- var : 함수 스코프


## 코딩 질문
#### foo의 값은 무엇인가요?
```javascript
var foo = 10 + '20';
// 1020
```

#### 아래 코드의 결과값은 무엇인가요?
```javascript
console.log(0.1 + 0.2 == 0.3);
// false —> 이건 이해가 필요!!!!
```

#### 아래 코드가 동작하게 하기 위해선 어떻게 해야할까요?
```javascript
add(2, 5); // 7
add(2)(5); // 7 
// ????? —> 이건 이해가 필요!!!!
```


#### 아래 구문의 반환값은 무엇인가요?
```javascript
"i'm a lasagna hog".split("").reverse().join("");
//  "goh angasal a m'i"
```


#### window.foo의 값은 무엇인가요?
```javascript
( window.foo || ( window.foo = "bar" ) );
// ??? —> 이건 이해가 필요!!!!
```

####아래 두 alert의 결과값은 무엇인가요?
```javascript
var foo = "Hello";
(function() {
  var bar = " World";
  alert(foo + bar); // hello world
})();
alert(foo + bar); // bar undefined error
```


#### foo.length의 값은 무엇인가요?
```javascript
var foo = [];
foo.push(1);
foo.push(2);
// 2
```

#### foo.x의 값은 무엇인가요?
```javascript
var foo = {n: 1};
var bar = foo;
foo.x = foo = {n: 2};
// undefined ?  —> 이건 이해가 필요!!!!
```


#### 아래 코드의 출력값은 무엇인가요?
```javascript
console.log('one');
setTimeout(function() {
  console.log('two');
}, 0);
console.log('three');
// one, three, two
```

## HTML 관련 질문:
* doctype이 무엇을 하는 것인가요?
* 표준모드(standards mode)와 쿽스모드(quirks mode)의 다른 점은 무엇인가요?
* XML과 XHTML의 다른 점은 무엇인가요
* XHTML을 이용한 페이지의 한계점은 무엇이 있나요?
* application/xhtml+xml으로 지정한 페이지에 어떠한 문제가 있나요?
* 다국어가 포함된 페이지는 어떤 방식으로 제공하나요?
* 다국어 페이지를 제공하는 여러 방법에 관해 설명해주세요.
* data-속성은 무엇을 하는 것인가요? 사용했을 때 이점은 무엇인가요?
* HTML5를 오픈 웹 플랫폼(open web platform)으로 생각해본다면, 어떤 것들로 구성돼 있을까요?
* 쿠키(Cookies)와 세션저장소(sessionStorage)와 로컬저장소(localStorage)의 차이점을 설명해주세요.
* <script>, <script async>와 <script defer>의 차이점에 관해 설명해주세요.
* CSS<link>를 <head></head>사이에 쓰는 것과 JS<script>를 <body></body>뒤에 사용하는 것은 좋은 사용법일까요? 어디에 배치하는 게 좋을까요?
* Progressive rendering이란 무엇인가요?
* 이미지 태그에 srcset 속성을 사용하는 이유는 무엇인가요? 브라우저가 이 속성을 가진 콘텐츠를 평가할 때 사용하는 과정을 설명해보세요.
* HTML templating language를 사용해 본 경험이 있나요?


## CSS 관련 질문:
* class와 id의 차이점에 관해서 설명해주세요.
* "reset" CSS가 무엇인지, 어떻게 유용한지 설명해주세요.
* Floats가 어떻게 동작하는지 설명해주세요.
* z-index에 관해 설명해주세요.
* BFC(Block Formatting Context)에 관해 설명해주세요
* 클리어링(Clearing) 기술에는 어떤 것들이 있으며, 어떨 때 어떻게 사용하는 것이 적절한지 설명하세요.
* CSS 스프라이트(CSS Sprites)를 설명하고, 페이지나 사이트를 어떻게 향상하는지 설명하세요.
* Image Replacement를 사용해야 할 때, 선호하는 기술과 언제 사용하는지를 설명해주세요.
* 브라우저 스펙 차이에 따른 스타일링 이슈를 수정하기 위해서 어떻게 접근하나요?
* 기능이 제약된 브라우저를 위해서 어떤 방식으로 페이지를 만드나요?
    * 어떠한 기술과 절차를 거치는지 설명하세요.
* 시각적으로 보이지 않고 스크린 리더에서만 가능하게 하는 방법에 관해 설명해주세요.
* 그리드 시스템(Grid system)을 사용한 적이 있나요? 있다면 어떠한 것을 선호하나요?
* 미디어 쿼리(media queries)를 사용한 적이 있나요? 혹은 모바일에 맞는 layout과 CSS를 사용한 적이 있나요?
* SVG를 스타일링하는데 익숙하신가요?
* 인쇄하기 위해 웹페이지를 어떻게 최적화 하나요?
* 효율적인 CSS를 작성하기 위한 "비법(gotchas)"은 어떤 게 있나요?
* CSS 전처리(CSS preprocessors)를 사용해보셨나요?
    * 그렇다면, 사용 경험에 기반을 둬 좋았던 점과 나빴던 점을 설명해주세요.
* 페이지에서 표준 폰트가 아닌 폰트 디자인을 사용할 때 어떤 방식으로 처리하시나요? (웹폰트를 제외하고)
* CSS Selector가 어떠한 원리로 동작하는지 설명해주세요.
* pseudo-elements에 관해서 설명하고 어디에서 사용되는지 이야기해보세요.
* box model에 관해 설명하고 브라우저에서 어떻게 동작하는지 설명해주세요.
* * { box-sizing: border-box; }은 무엇이고 사용했을때 이점은 무엇인가요?
* 기억나는 display 속성에 대한 값들을 나열해보세요.
* inline과 inline-block의 차이점은 무엇인가요?
* 요소를 배치하는 방법(relative, fixed, absolute, static) 간의 차이는 무엇인가요?
* CSS에서 'C'는 Cascading을 의미합니다. Cascading에 관해서 설명해주세요. 또 cascading system의 장점은 무엇인가요?
* CSS framework를 사용해본 적이 있으신가요? 실무에서 사용해보았다면 어떤 이점이 있었나요?
* 새로운 CSS Flexbox 혹은 Grid 스펙을 사용해 보신 적 있나요?
* 반응형(Responsive) 디자인은 적응형(Adaptive) 디자인과 어떤 차이점이 있나요?
* 레티나 그래픽 환경에서 작업해 보신 적이 있나요? 하셨다면 어떤 기술을 사용하셨나요?
* 절대 좌표대신 translate() 혹은 반대로 사용하는 이유가 있나요? 있다면 이유에 관해서 설명해주세요.



## 성능 관련 질문들:
* 성능관련 이슈들을 발견하기 위해서 사용하는 방법은 무엇인가요?
* 웹사이트 scrolling 성능을 향상시키기 위한 몇가지 방법에 대해 설명해보세요.
* 브라우저의 layout, painting, compositing에 대해 설명해보세요.

## 네트워크 질문들:
* 전통적으로, 웹사이트의 assets을 여러 도메인으로 서빙했을 때 장점은 무엇인가요?
* URL로 접속했을 때 어떤 플로우로 화면에 웹사이트가 그려지는지 네트워크 관점에서 설명해주세요.
* Long-Polling과 Websocket, Server-Sent Event에 대해 설명해주세요.
* 다음 request header들에 대해 설명해주세요.
    * Diff. between Expires, Date, Age and If-Modified-...
    * Do Not Track
    * Cache-Control
    * Transfer-Encoding
    * ETag
    * X-Frame-Options
* HTTP와 HTTPS에 대해 설명해주세요.
* HTTP Method들에 대해 설명해주세요.


## 테스트 관련 질문들:
* test code를 작성하면서 개발하는 방식의 장점과 단점에 대해 설명해주세요.
* test code를 테스트하는 툴을 사용해보신 경험이 있나요?
* 유닛 테스트와 함수테스트의 차이점은 무엇인가요?
* code style linting tool을 사용했을때 장점은 무엇인가요?


## 기타
* 최근에 수행했던 흥미로운 프로젝트는 무엇인가요?
* 사용하는 개발 도구에서 마음에 드는 부분은 무엇인가요?
* 프론트엔드 커뮤니티에서 당신에게 영감을 준 사람이 있다면 누구인가요?
* 애완동물 관련 프로젝트를 해 보았나요? 해보았다면 어떤 종류의 프로젝트인가요?
* IE에서 가장 좋아하는 기능은 무엇인가요?
* 어떤 커피를 좋아하시나요?

