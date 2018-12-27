---
layout: post
title: "(Q) 프론트앤드 지식 관련 알아두어야 하는 기본적인 것들."
date: 2018-12-26 10:12:00
author: gloria
tags:
---

* TOC
{:toc}


## DocType
- https://www.w3schools.com/tags/tag_doctype.asp
- http://webberstudy.com/html-css/html-2/doctype/
- `<!DOCTYPE>`은 html 문서의 `<html>` 태그 이전에(즉, 최상위에) 선언해야한다. 
- 웹 브라우저에게 해당 페이지의 html 버전이 무엇인지를 알려주는 것이다.

## meta 태그
- https://developer.mozilla.org/ko/docs/Web/HTML/Element/meta
- 웹 페이지의 정보를 제공하기 위해 사용하는 태그이다.
- 페이지의 설명 요약, 작성자, 키워드 등에 대한 데이터를 포함한다.


## Event Loop
- https://meetup.toast.com/posts/89
- 자바스크립트는 **단일 스레드**기반의 언어이다.
- 단일 스레드 기반의 자바스크립트가 멀티 스레드처럼 동작하는 것처럼 보여지게 하는 것이 **이벤트 루프**이다.
- 비동기 api는 `task queue`에 추가한다.
- promise는 `micro task queue`를 사용하며 일단 task queue보다 높은 우선순위를 가진다.
- 이벤트 루프는 호출 스택이 비워질 때마다 큐에 쌓인 것을 꺼내와서 실행하는 역할을 수행한다.


## CSS : Float
- float의 의미인 **뜨다**의 의미처럼. 페이지에서 컨텐츠를 특정 위치에 띄워서 배치할 것인지에 대해 설정하는 속성 값이다.
- float된 자식 엘리먼트의 높이는 부모에게 영향을 미치지 않는다. 이에 대한 해결방법은  http://naradesign.net/wp/2008/05/27/144/ 를 참고.
	- 부모의 속성에 `display: inline-block`을 준다.
	- 부모의 가상 선택자 `:after`로 **content:" "; display:block; clear:both** 속성을 추가한다.
- clear 속성은 float이 더 이상 주변 엘리먼트의 배치에 영향을 미치지 않도록 설정하는 속성이다

## Animation
- setInterval 보다는 requestAnimationFrame을 이용하는 것을 권장. setInterval은 설정한 시간마다 무조건  함수를 실행시키므로 성능이 좋지 않을 수 있는 반면, requestAnimationFrame은 브라우저가 스스로 상태를 판단하여 동작하므로 좀 더 유연한 대처가 가능하다.
- css 애니메이션을 가급적 사용하고, 좀 더 세밀한 제어가 필요한 경우 자바스크립트 애니메이션 사용을 하는 것을 권장한다
- `opacity`나 `transform`을 이용한 애니메이션 제어를 권장. (잦은 Reflow로 인한 성능 이슈가 발생할 수 있으므로)
- https://developers.google.com/web/fundamentals/design-and-ux/animations/css-vs-javascript?hl=ko
- https://developers.google.com/web/fundamentals/design-and-ux/animations/animations-and-performance?hl=ko#css-vs-javascript-performance
- [velocity.js](http://velocityjs.org)는 자바스크립트 애니메이션 라이브러리이다. 