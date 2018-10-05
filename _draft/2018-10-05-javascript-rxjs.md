---
layout: post
title: "(Javascript) Reactive Programming과 RXJS"
date: 2018-10-05 10:12:00
author: gloria
categories: language
tags: javascript rxjs
---

* TOC
{:toc}
## Reactive Programming

반응형 프로그래밍.

- Observable 과 Data Flow 로 표현할 수 있다.

#### Observable

구독자가 있을 때에 이벤트가 발생하면 그 이벤트를 전달하는 동작을 한다. 하지만,  구독자가 없는 경우에 따라 아래와 같이 구분할 수 있다.

- Hot Observable 
  - 구독자가 없더라도 이벤트를 전달하기 위한 로직을 수행한다.
  - Eager Evaluation
- Cold Observable 
  - 구독자가 없으면 이벤트가 발생하더라도 해당 이벤트를 전달하지 않는다. 즉, 로직을 수행하지 않는다. 
  - 페이스북 라이브, 넷플릭스와 같은 VOD 서비스를 예로 들수 있음
  - Lazy Evaluation



#### Data Flow

- Control Flow는 "if/else, switch …"와 같이 값이 변화해가는 방식
- Data Flow는 체이닝을 통하여 값이 변화해가는 방식



## RXJS

> - ReactiveX라는 개념의 구현체
> - 이벤트로부터 스트림을 만들고 상호작용할 수 있도록 도와준다.
> - 어플리케이션 로직을 유지하고, 다른 프레임워크 혹은 라이브러리를 사용할 때보다 코드를 쉽게 작성할 수 있게 도와준다.





## Reference

- [RxJS - Daum영화에 적용하다](http://tech.kakao.com/2017/01/09/daummovie-rxjs/)
- 