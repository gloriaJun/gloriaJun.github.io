---
layout: post
title: "(Frontend) 실시간 데이타 처리를 위한 socket 통신"
date: 2019-01-02 15:35:00
author: gloria
categories: frontend
tags: frontend socket network

---

* TOC
{:toc}

* socket 통신은 서버와 클라이언트 간의 실시간 통신을 위한 기술 중 하나이다.
* http 통신은 클라이언트에서 서버로의 단방향 통신을 위한 기술이나, 실시간 통신을 위해 http request의 트릭을 사용하여 실시간 통신인 것처럼 사용하는 기술들이 존재했었다.
  * polling
  * long polling
  * streaming

# http를 이용한 실시간 통신

http의 request/response를 이용하여 실시간 통신 기술을 구현한다.

> http를 이용한 실시간 통신 방식을 **Comet(코멧)** 이라고 한다.<br/>
> https://en.wikipedia.org/wiki/Comet_(programming)

* 단점
  * 데이터 전송을 위한 과정에서 불필요한 네트워크 비용이 발생할 수 있다.
    * 요청/응답 헤더 데이터
  * 클라이언트에서 요청을 전달 후, 원하는 응답을 받기까지의 대기 시간이 발생한다.

## polling

* 서버로 http request를 날려서 이벤트 내용에 대한 응답을 전달받는다.
* 응답을 받으면 일정 시간 주기로 request를 날린다. 즉, 서버에 데이터를 반복적으로 요청하는 것.
* 주기적으로 이벤트를 받기 위해 request를 날려야하므로 서버의 부담이 증가할 수 있다.
* request가 발생한 시점에 서버에서 해당 데이타가 변경되지 않았다면, 의미없는 데이타가 리턴될 수 있다.
* 매 request 요청이 발생할 때마다 연결을 맺고 끊는 작업이 발생한다.

## long polling

* 서버로 http request를 날리면, 서버에서 데이타 값이 변경이 되는 경우에 response 메시지가 전달되고 연결이 종료된다.
* 응답을 받으면 다시 request를 날린다. 즉, 서버에서 새로운 데이타가 전달될 때마다 반복적으로 요청이 발생한다.
* 매 request 요청이 발생할 때마다 연결을 맺고 끊는 작업이 발생한다.
* 데이타의 변경이 잦은 경우에 빈번한 통신으로 인하여 통신 횟수가 늘어나게 된다.
* 데이타 변경이 일어나기 전까지는 연결이 유지되는 문제로 인하여 동시접속자가 늘어날 수 있다. (예를 들어 불특정 다수가 모니터링할 수 있는 스포츠 실황 중계와 같은 시스템에는 적합하지 않음)

## streaming

* 서버로 http request를 날리면, 서버에서 이벤트에 대한 응답을 요청을 끊지않고, 필요한 메시지만 보내는 동작(flush)을 반복한다.
* 웹서버 응답헤더의 content-length를 이용한 방식. 해당 content-length가 존재하지 않으면 클라이언트는 연결이 종료될 때까지 서버로부터의 응답을 받는다.
* 에러처리가 쉽지 않다.

# webSocket

* 클라이언트와 서버 간의 양방향 통신을 지원하기 위한 html5 에서 지원하는 기술이다.
* 구형 브라우저 및 일부 브라우저에서 미지원한다.

websocket의 크로스브라우징 지원 등과 같은 문제를 해결하기 위한 라이브러리 들이다.

## Socket.io

* https://socket.io
* node.js 기반으로 만들어졌다.
* Socket.io는 WebSocket, FlashSocket, AJAX Long Polling, AJAX Multi part Streaming, IFrame, JSONP Polling을 하나의 API로 추상화한 것이다. 즉, socket.io가 판단하여 가장 적합한 기술을 사용한다.

# Reference

* [MDN-websocket](https://developer.mozilla.org/ko/docs/WebSockets)
* [코멧(Comet)에 대하여](https://vnthf.github.io/blog/Front-What_is_comet/)
* [코멧(Comet) #2 – Ajax 폴링(Ajax polling) 채팅방 예제로 배우기](http://dev.epiloum.net/1395)
* [코멧(Comet) #3 – Ajax 롱폴링(Ajax Long polling) 채팅방 예제로 배우기](http://dev.epiloum.net/1453)
* [Socket.IO 기반 티몬 상담톡 개발기](https://tmondev.blog.me/220982377777)
* [Socket.io를 사용한 실시간 채팅 애플리케이션](https://poiemaweb.com/nodejs-socketio)
