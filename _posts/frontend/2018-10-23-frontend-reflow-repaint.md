---
layout: post
title: "(Frontend) Browser - Reflow & Repaint"
date: 2018-10-23 10:35:00
author: gloria
categories: frontend
tags: frontend javascript 브라우저렌더링 브라우저구조 자바스크립트성능
---

* TOC
{:toc}

Reflow와 Repaint를 이해하려면 브라우저에 대한 이해가 필요하다.

## 브라우저(Browser)

우리가 일반적으로 많이 사용하는 **IE, 크롬, 파이어폭스, 사파리...**와 같은 웹 브라우저는 사용자가 선택한 자원(URL)을 서버에 요청하고 서버로부터 응답받은 결과를 화면에 그려주는 역할을 한다.

#### 브라우저 구조

브라우저의 동작을 좀 더 쉽게 이해하기 위해 해당 구조를 살펴보자.

![browser-structure]({{ site.baseurl }}/assets/images/post/browser-structure.png)



###### User Interface (사용자 인터페이스)
브라우저의 주소 표시줄, 이전/다음 버튼, 북마크 등과 같이 사용자가 직접 조작할 수 있는 영역이다.

###### Browser Engine (브라우저 엔진)
사용자 인터페이스가 렌더링 엔진 사이의 동작을 담당한다

###### Rendering Engine (렌더링 엔진)
사용자가 요청한 내용에 대한 결과를 화면에 표시한다. 즉, HTML과 CSS을 파싱하여 화면에 표시한다.
브라우저마다(IE, 크롬, 사파리, 파이어폭스, …) 각기 다른 렌더링 엔진을 이용하여 동작한다.
> 크롬은 각 탭마다 별도의 렌더링 엔진 인스턴스를 사용하므로 각 탭이 독립된 프로세스로 처리된다.

###### Networking (통신)
HTTP 요청과 같은 네트워크 호출에 사용된다.

###### Javascript Interpreter (자바스크립트 해석기)
자바스크립트 코드를 해석하고 실행한다.

###### UI Backend (UI 백앤드)
브라우저의 select, input, modal 등과 같은 기본 장치를 그릴 때 사용한다.

###### Data Storage (자료 저장소)
Cookie, Local Storage 등과 같이 브라우저의 메모리를 활용하여 데이타를 저장한다.



#### 브라우저의 렌더링 과정

렌더링 엔진은 네트워크로부터 요청한 문서의 내용을 얻는 것으로 시작하며 문서의 내용은 보통 8KB 단위로 전송된다.

브라우저의 동작 과정은 아래와 같다.
![브라우저 동작원리-출처poiemaweb](https://poiemaweb.com/img/client-server.png)

이 중에 브라우저의 렌더링 과정만을 표시하면 아래와 같다.
![browser-rendering]({{ site.baseurl }}/assets/images/post/browser-rendering.png)

###### DOM (Documnet Object Model) Tree
HTML 태그를 파싱하여 DOM 트리를 구성한다.

###### CSSOM (CSS Object Model) 생성
스타일 정보를 통하여 스타일 구조체를 생성한다.
스타일 정보는 다음과 같이 3 단계로 나누어 처리된다.
- 브라우저 자체에 포함된 기본 스타일 정보
- 사용자 정의 스타일 (외부 또는 내부에 정의된 스타일)
- HTML 태그에 style 속성을 이용하여 정의된 인라인 스타일 정보

###### Render tree construction (렌더 트리 생성)
- DOM 트리의 루트(html)에서 시작해서 페이지에 표시되는 각각의 노드에 일치하는 스타일 구조의 규칙을 찾아서 붙여나가며 렌더 트리를 생성한다.
- `<head>, <title>, <script> 등`은 화면에 표시되는 노드는 아니므로 렌더 트리에 포함되지 않는다.
- 스타일이 `display: none`으로 적용된 경우는 렌더 트리에 포함되지 않는다.
- `visibility: hidden`이 적용된 노드는 눈에 보이지는 않지만 렌더 트리에 포함된다.
- 렌더 트리에서 각 노드는 frame이나 box로 불리며, css박스 속성 정보가 있다.

###### Layout of the render tree (렌더 트리 배치)
- 생성된 렌더 트리로부터 엘리먼트의 위치나 크기 정보를 계산하여 생성한다.
- 이 과정에서 상대 값(예. %단위)은 절대 값(예. px단위)으로 변환되어 표현된다.

###### Painting the render tree (페인팅)
- 렌더 트리를 순회하면서 페인트 함수를 호출에 노드를 화면에 표현한다.


## Reflow & Repaint

화면에 모든 요소가 그려지고 나서 사용자 인터랙션 또는 페이지의 기능에 따라 일부 변경이 생기는 경우에 발생하는 현상이다.
![browser-rendering-reflow-repaint]({{ site.baseurl }}/assets/images/post/browser-rendering-reflow-repaint.png)

#### Reflow
노드의 크기 또는 위치가 변경되어 현재 레이아웃에 영향을 미쳐서 배치를 다시 해야하는 경우에 발생한다.

*Repaint 보다 심각한 성능 저하를 유발시킬 수 있다.*

- Reflow가 발생하는 경우 	
  - 윈도우 리사이징
  - 노드의 추가 / 제거 / 수정
  - 요소의 위치 변경
  - 요소의 크기 변경 (margin, padding, border, width, heght ...)
  - 폰트 변경
  - 텍스트 내용 변경
  - 이미지 크기 변경
  - 페이지 초기 렌더링
  - 엘리먼트에 대한 offsetWidth, offsetHeight 등과 같은 위치 값을 계산 시

- Reflow 발생 시의 이벤트 로그

  ![reflow]({{ site.baseurl }}/assets/images/post/reflow.png)

#### Repaint (or Redraw)
Reflow가 발생하거나 배경색 변경 등의 단순한 스타일 변경과 같은 작업에 발생한다. 즉, 화면의 레이아웃에는 영향을 미치지 않는 경우에 발생한다.

- Repaint가 발생하는 경우

  - 특정 엘리먼트의 색상 값 변화

- Repaint 발생 시의 이벤트 로그

  ![repaint]({{ site.baseurl }}/assets/images/post/repaint.png)

#### 리플로 최소화 방법

렌더링 성능 향상을 위해서는 먼저 Reflow를 줄여야한다. *Reflow를 최소화함으로써 렌더링 성능을 향상*시킬 수 있다.

###### 클래스 변화에 따른 스타일 변경 시, 최대한 DOM 구조 상 끝단에 위치한 노드에 준다.
스타일 변화가 발생할 경우, 일부 노드로 제한할 수 있다.

###### 인라인 스타일을 최대한 배제한다.
만약, 인라인 스타일이 없는 경우, 외부 스타일 클래스의 조합으로 단 한번만 Reflow를 발생시킬 수 있다.
즉, 코드 가독성과 Reflow 비용을 줄일 수 있다.

###### 애니메이션이 들어간 노드는 `position: fixed` 또는 `position: absolute`로 지정한다.
position 속성을 "fixed" 또는 "absoute"로 값을 주면 지정된 노드는 전체 노드에서 분리된다.
즉, 전체 노드에 걸쳐 Reflow 비용이 들지 않고, 해당 노드의 Repaint 비용만 든다.
> 또는 노드의 position 값을 초기에 적용하지 않았더라도 에니메이션 시작 시 값을 변경(fixed, absolute)하고 종료 시 다시 원복 시키는 방법을 사용해도 비용을 줄일 수 있다.

###### 퀄리티와 퍼포먼스 사이에서 타협하라.
속도가 빠른 디바이스에서는 큰 차이가 없는 것으로 보일 수 있으나, 속도가 느린 디바이스에서는 그 차이가 클 수 있다.

###### 테이블 레이아웃을 피하라.
테이블로 구성된 페이지 레이아웃은 점진적(progressive) 페이지 렌더링이 적용되지 않으며, 모두 로드되고 계산(Recalculate)된 후에야 화면에 뿌려지게 된다. 
하지만 해당 테이블에 table-layout:fixed 속성을 주는 것이 디폴트값인 auto에 비해 성능면에서 더 좋다

######  IE의 경우, CSS에서의 JS표현식을 피하라.
Reflow가 발생할 때마다 표현식이 다시 계산되므로 비용이 발생할 수 밖에 없다.

###### CSS 하위선택자는 필요한 만큼만 정리하라.

하위 선택자의 룰이 적을 수록 비용이 절감된다.

```css
// DON'T
.section_service .list_service li .box_name .btn_more {display:block;width:100px;height:30px;}

// DO
.section_service .list_service .btn_more {display:block;width:100px;height:30px;}
```



###### position:relative 사용 시 주의하자.
페이지를 새로 열거나 Reflow가 발생되어 CSS Calculation이 발생할 경우, Box model Calculation → Normal Flow 의 순서로 계산이 진행된다. (Normal flow는 Layout 또는 Reflow라 불리는 과정에 속하는 일부임.) 
일반적인 경우, 엘리먼트 들은 margin, border, padding, content(width,height) 등 Box model을 먼저 계산한 후 Normal flow 상태의 레이아웃에 배치된다. (다른말로 선형적 배치)

###### 작업 그룹화 하여 처리하기 (cssText 또는 클래스를 활용하라)
DOM 요소의 정보를 요청하고 변경하는 코드는 같은 형태의 작업끼리 그룹화하여 실행한다.

**예제1 : cssText 또는 클래스명을 이용하여 수정한다.**      

```javascript
// DON'T - 최악의 경우 2번의 Reflow를 발생시킨다
let div = document.getElementById('box');
div.style.padding = '16px';
div.style.width = '600px';

// DO - 한 번만 돔 객체를 수정한다
// 1) cssText를 이용
div.style.cssText = 'padding: 16px; width: 600px;';

// 2) 클래스명을 이용
div.className += ' clsName';
```

**예제2 : 스타일 변경 작업을 그룹화하여 처리한다.**         

```javascript
// DON'T
let width = document.getElementById('box1').style.width;
document.getElementById('box2').style.width = width;
let height = document.getElementById('layer1').style.height;
document.getElementById('layer2').style.height = height;

// DO
let width = document.getElementById('box1').style.width;
let height = document.getElementById('layer1').style.height;
document.getElementById('box2').style.width = width;
document.getElementById('layer2').style.height = height;
```

###### 캐쉬를 활용하여 Reflow를 최소화한다.
브라우저는 레이아웃의 변경을 큐에 저장했다가 한 번에 실행하는 방법으로 Reflow를 줄인다. 하지만, `offset, scrollTop...`과 같은 계산된 스타일 정보를 요청할 때마다 정확한 정보를 제공하기 위해 큐를 비우고 모든 변경을 다시 적용한다. 그러므로 중복되는 수치에 대한 요청 수를 줄임으로 Reflow 비용을 최소화 할 수 있다.        
```javascript
function collect() {
    let el = document.getElementById('box');
	let width = el.style.width;
	return parseInt(cw, 10) * parseInt(cw + document.documentElement.clientWidth, 10);
}
```

###### DOM 사용을 최소화한다.
노드 조각(document.createDocumentFragment), 노드 사본(el.cloneNode)를 활용하여 DOM 접근을 최소화한다.       
```javascript
// DON'T
function ex1BadCase() {
	var el = document.getElementById('container'); 
	for (var i = 0; i < 10; i++) { 
		var a = document.createElement('a'); 
		a.href = '#'; 
		a.appendChild(document.createTextNode('test' + i)); 
		el.appendChild(a);
	}
	return false; 
}

// DO - 노드 조각(document.createDocumentFragment)
function noReflow() {
	var frag = document.createDocumentFragment(); 
	for (var i = 0; i < 10; i++) { 
		var a = document.createElement('a'); 
		a.href = '#'; 
		a.appendChild(document.createTextNode('test' + i)); 
		frag.appendChild(a); 
	} 
	document.getElementById('container').appendChild(frag); 
	return false; 
}

// DO - 노드 사본(el.cloneNode)
function noReflow() {
	var el = document.getElementById('container');
	var clone = el.cloneNode(true);
	
	for (var i = 0; i < 10; i++) { 
		var a = document.createElement('a'); 
		a.href = '#'; 
		a.appendChild(document.createTextNode('test' + i)); 
		clone.appendChild(a); 
	} 
	el.appendChild(clone);
	return false; 
}
```



## 왜 CSS는 head 태그에 script는 아래에 정의하는가?
브라우저가 HTML 문서를 파싱하여 DOM 트리를 만들어도 스타일 규칙이 없으면 렌더링을 할 수가 없다.
즉, *최대한 빨리 스타일 규칙을 알아야 렌더링 트리가 완전히 만들어지므로 head 태그 사이에 정의*하는 것이다.
반면에 자바스크립트 파일이 head 태그 사이에 놓이게 되면 HTML 파서가 파싱을 멈추고 스크립트 파일을 읽기 때문에 스크립트 파일이 많거나 파일 사이즈가 크면 읽는 시간이 오래 걸려 사용자 입장에서 웹페이지가 느리게 보여진다. 
그러므로 `</body>` 태그 상단에 자바스크립트를 정의한다.



## Virtual Dom

화면 하나에는 수천가지의 노드가 존재할 수 있다. 그리고 ajax 등과 같이 화면 조작이 많아지고, SPA가 등장하면서 화면에서 DOM의 변경이 잦아질 수 밖에 없는 현실이다. 이는 자연스레 잦은 Reflow가 발생할 수 밖에 없고 브라우저 성능 저하가 발생할 수 있다.

이러한 배경으로 인하여 Virtual Dom이 탄생하게 되었다. 즉, 빈번한 repaint와 reflow문제를 보안하기 위해 등장했다.

Virtual Dom은 화면 DOM의 변경이 일어날때마다 전체 DOM을 Reflow 하는 것이 아니라 가상의 DOM을 이용하여 한 번만 Reflow를 수행함으로써 화면의 부하를 줄여 빠르게 그릴 수 있게한다. 

즉, 가상 dom의 동작을 간단히 정리하면 다음과 같다.

- 메모리 내에 dom의 복사본을 생성한다.
- dom의 변경이 일어나면 가상 dom에 반영한다.
- 변경된 내용이 반영 완료된 가상dom의 내용을 실제 dom에 반영하여 브라우저가 그리게 한다.

>  React나 Vue(ver2 부터)의 경우, 빠른 화면 렌더링을 위하여 Virtual Dom을 사용한다.




## Reference
- [브라우저는 어떻게 동작하는가?](https://d2.naver.com/helloworld/59361)
- [자바스크립트는 어떻게 동작하는가: 렌더링 엔진과 성능을 최적화하는 방법](https://github.com/codepink/codepink.github.com/wiki/%EC%9E%90%EB%B0%94%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8%EB%8A%94-%EC%96%B4%EB%96%BB%EA%B2%8C-%EB%8F%99%EC%9E%91%ED%95%98%EB%8A%94%EA%B0%80:-%EB%A0%8C%EB%8D%94%EB%A7%81-%EC%97%94%EC%A7%84%EA%B3%BC-%EC%84%B1%EB%8A%A5%EC%9D%84-%EC%B5%9C%EC%A0%81%ED%99%94%ED%95%98%EB%8A%94-%EB%B0%A9%EB%B2%95)
- [브라우저 렌더링](https://12bme.tistory.com/140)
- [Reflow or Repaint(or ReDraw)과정 설명 및 최적화 방법](http://webclub.tistory.com/346)
- [Reflow 원인과 마크업 최적화 Tip](http://lists.w3.org/Archives/Public/public-html-ig-ko/2011Sep/att-0031/Reflow_____________________________Tip.pdf)
- [Virtual dom](https://www.slideshare.net/gyeongseokseo/virtual-dom)
- [Virtual DOM 살펴보기](https://wonism.github.io/deep-dive-into-vdom/)

