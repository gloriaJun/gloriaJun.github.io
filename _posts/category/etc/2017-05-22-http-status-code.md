---
layout: post
comments: true
title: "[Http] HTTP Status Code"
date: 2017-05-21 21:30:00
categories: Etc
tags: http status-code
---

REST API에서 주로 사용하는 형태의 Http Status Code를 조사할 일이 생겨서 조사한 김에 기록해두기. 

wikipedia를 보면 2xx, 3xx, 4xx 번대에 각각의 세부적인 응답코드가 정의되어 있지만, 웹서비스 또는 API를 개발하는 과정에서는 기본적으로 아래와 같은 응답코드를 가장 많이 사용하는 것 같다.  
     
물론 각 개발하는 API마다 각자 정의해서 사용하므로 사용하는 응답코드와 각 응답코드에 따른 세부 에러 코드는 다르지만, 4xx은 클라이언트 오류, 5xx은 서버 오류 라는 큰 아웃라인 안에서 정의하는 것으로 보여진다.   
   
| status code | type | description |
|:-------:|:-------:|-------|
| 200 | OK | 클라이언트의 요청을 서버가 정상적으로 수신하여 처리한 경우 |
| 400 | Bad Request | 일반적인 오류. 주로 API에 필요한 필수 파라미터와 관련 |
| 401 | Unauthorized | 인증 오류. 주로 사용자 토큰과 관련 |
| 403 | Forbidden | 권한/퍼미션등의 오류 |
| 404 | Not Found | API 요청 URL이 잘못되었을 경우 |
| 500 | Internal Server Error | API 호출은 정상적으로 했지만, API 서버 유지보수나 시스템 오류로 인한 에러가 발생하였을 경우 |
{: rules="groups"}
   
#### 2xx : Success
201, 202 등 추가적인 상태코드가 있지만, 일반적으로 200을 가장 많이 사용하는 것으로 보여짐.
  
#### 4xx : Client errors
주로 클라이언트 오류가 있음을 표현하기 위해 사용
   
###### 400 
- 잘못된 파라미터. 호출 인자값이 잘못되었거나 필수 인자가 포함되지 않은 경우
- 결제승인 API 호출 시 포인트 금액이 잘못된 경우

###### 401
- 로그인 오픈 API를 호출할 때 접근 토큰(access_token) 값이 빠진 경우.
- 사용자 토큰이 잘못되었을 경우. 주로 만료된 토큰에 대한 요청
   
###### 403
- https가 아닌 http로 호출하였을 경우
- 해당 API에 대한 권한/퍼미션이 없는 경우
- 등록되지 않은 appkey사용

###### 404
- API path가 잘못되어 존재하지 않는 API를 호출한 경우
- API 요청 URL이 잘못되었을 경우

#### 5xx : Server error
서버가 유효한 요청을 명백하게 수행하지 못했음을 나타낸다
  

   
> **Reference**   
> [Wikipedia - List of HTTP status codes](https://ko.wikipedia.org/wiki/HTTP_상태_코드)   
> [네이버 오픈 API 에러 코드 목록](https://developers.naver.com/docs/common/common_error/)     
> [다음 - 표준 에러 메시지](https://developers.daum.net/services/apis/docs/errors)    
> [카카오-에러 코드](https://developers.kakao.com/docs/restapi#간편한-참조-응답-코드-에러-코드)   