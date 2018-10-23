---
layout: post
title: "(Frontend) 크롬 개발자 도구 사용하기"
date: 2018-10-23 20:35:00
author: gloria
categories: frontend
tags: frontend 크롬개발자도구
---

* TOC
{:toc}

## Chrome DevTools Panel
#### Elements
![](https://developers.google.com/web/tools/chrome-devtools/images/panels/elements.png)
DOM의 구성과 각 노드에 적용된 CSS Style을 확인할 수 있다. 또한 실시간으로 dom을 편집하거나 스타일을 수정할 수 있다.
dom에도 디버깅을 위한 breakpoint를 걸 수 있다. 
- 디버깅을 하고자 하는 노드를 선택하고, 마우스 우클릭을 한다
- 컨텍스트 매뉴에서 `Break on`을 클릭하면 3개의 서브 매뉴가 출력된다. 각 서브 매뉴가 의미하는 것을 아래와 같다.
  - subtree modifications 
    : 해당 노드의 하위 값이 변경하는 경우에  중단점이 실행된다 (예를 들어 자식 노드의 추가/삭제 등과 같은 변경이 발생하는 경우)

  - attributes Modificattion 
    : 해당 노드의 어트리뷰트가 변경하는 경우에 중단점이 실행된다 

  - Node Removal 
    : 해당노드가 삭제되는 경우에 중단점이 실행된다 


#### Console 패널
![](https://developers.google.com/web/tools/chrome-devtools/images/panels/console.png)
로그를 확인하거나, 스크립트를 실행할 수 있다.

#### Sources 패널
![](https://developers.google.com/web/tools/chrome-devtools/images/panels/sources.png)
브레이크 포인트를 사용해 자바스크립트를 디버깅할 수 있다.

#### Network 패널
![](https://developers.google.com/web/tools/chrome-devtools/images/panels/network.png)
서버와의 통신 내역을 확인할 수 있다.
해당 패널을 이용하여 존재하지 않는 파일을 불러오는 지, 서버와 통신하는 데 문제가 있는 지 등을 확인할 수 있다.

#### Performance 패널 (이전의 Timeline 패널)
![](https://developers.google.com/web/tools/chrome-devtools/images/panels/performance.png)
현재 페이지에서 일어나는 내부 동작들을 1ms단위로 측정하여 보여준다.
현재 페이지의 라이프사이클 동안 발생한 다양한 이벤트를 기록하고 탐색하여 페이지의 런타임 성능을 향상시킬 수 있다.
> Performance 측정 시에는 확장프로그램이 존재하는 경우, 불필요한 노이즈가 추가되어 출력된다.
> 그러므로, 시크릿 모드(incognito) 또는 새 사용자 프로그램을 만들어서 확장 프로그램이 포함되지 않도록 하여 실행한 뒤에 수행하여야 한다.

#### Memory 패널 (이전의 Profiles 패널)
![](https://developers.google.com/web/tools/chrome-devtools/images/panels/memory.png)
메모리 상태의 스냅샷을 찍어서 메모리 누수가 발생하는 부분을 찾을 수 있다.

#### Application 패널 (이전의 Resources 패널)
![](https://developers.google.com/web/tools/chrome-devtools/images/panels/application.png)
IndexedDB와 웹 SQL 데이터베이스, 로컬 및 세션 스토리지, 쿠키, 어플리케이션 캐시, 이미지, 폰트, 스타일시트를 포함한 로딩된 모든 리소스를 검사한다.

#### Security 패널
![](https://developers.google.com/web/tools/chrome-devtools/images/panels/security.png)
Mixed content 이슈, 인증서 문제 등을 디버깅한다.


## Chrome DevTools Tip
#### Blackboxing (`Setting -> Blackboxing`)
자바스크립트 디버깅 시에 3rd party 같은 불필요한 라이브러리 코드를 숨겨주어 디버깅을 편하게 해준다.

#### 커맨드 라인 API
콘솔에서 DOM 요소 선택 및 검사, 데이터를 읽을 수 있는 서식으로 표시, 프로파일러 중지 및 시작, DOM 이벤트 모니터링 등 일반 작업을 수행하는 데 편리한 기능 컬렉션이 포함되어있다.

###### $_
가장 최근에 실행한 내용의 결과를 반환한다.

###### $0-$4
Elements 패널에서 검사한 마지막 다섯 DOM 요소 또는 Profiles 패널에서 선택한 마지막 다섯 자바스크립트 힙 객체에 대한 기록 참조로 작동합니다. 
$0은 가장 최근에 선택한 요소 또는 자바스크립트 객체를 반환하며 $1은 두 번째로 최근에 선택한 항목을 반환한다.

###### $(selector)
`document.querySelector()`의 별칭이다.

###### $(selector)
`document.querySelectorAll()`의 별칭이다.

###### $x(path)
주어진 XPath 식과 일치하는 DOM 요소의 배열을 반환합니다.
ex1)  $x("//p")  - 페이지의 모든 p 요소를 반환
ex2) $x("//p[a]")  - 페이지의 a요소를 포함하는 모든 p 요소를 반환

###### clear()
콘솔에 출력된 로그를 삭제한다

###### copy(object)
copy(object)는 지정된 객체의 문자열 표현을 클립보드에 복사한다
ex1) copy({ name: 'Jake' });
ex2) copy($0);

###### debug(function)
지정된 함수가 호출되면 디버거가 호출된다.

###### dir(object)
`console.dir()` 메서드의 별칭으로 지정된 객체의 속성을 출력한다.

###### inspect(object/function)
지정된 요소 또는 객체를 열고 선택한다.

###### getEventListeners(object)
지정된 객체에 등록된 이벤트 리스너를 반환한다.



## Reference
- [CHROME TIMELINE 사용해보기](http://graykick.tistory.com/3)
- [크롬 개발자 도구를 이용한 자바스크립트 디버깅](https://subicura.com/2018/02/14/javascript-debugging.html)
- [Command Line API 참조](https://developers.google.com/web/tools/chrome-devtools/console/command-line-reference?hl=ko)