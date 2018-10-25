---
layout: post
title: "REST API"
date: 2017-01-15 16:54:00
author: gloria
categories: etc
tags: rest-api
---

* TOC
{:toc}


REST(Representational State Transfer)는 웹의 장점을 최대한 활용할 수 있는 아키텍쳐로 소개되었으며, HTTP 프로토콜을 의도에 맞게 디자인하도록 가이드 하고 있다.
REST의 기본 원칙을 성실히 지킨 서비스 디자인을 Restful하다고 표현한다.


## REST의 특징
1. Uniform(유니폼 인터페이스)
Uniform Interface는 URI로 지정한 리소스에 대한 조작을 통일되고 한정적인 인터페이스로 수행하는 아키텍처 스타일을 말합니다.

2. Stateless(무상태성)
REST는 무상태성 성격을 갖습니다. 다시 말해 작업을 위한 상태정보를 따로 저장하고 관리하지 않습니다. 세션 정보나 쿠키정보를 별도로 저장하고 관리하지 않기 때문에 API서버는 들어오는 요청만을 단순히 처리하면 됩니다. 때문에 서비스의 자유도가 높아지고 서버에서 불필요한 정보를 관리하지 않음으로써 구현이 단순해집니다.

3. Cacheable(캐시 가능)
REST의 가장 큰 특징 중 하나는 HTTP라는 기존 웹표준을 그대로 사용하기 때문에, 웹에서 사용하는 기존 인프라를 그대로 활용이 가능합니다. 따라서 HTTP가 가진 캐싱 기능을 적용할 수 있습니다. HTTP프로토콜 표준에서 사용하는 Last-Modified태그나 E-Tag를 이용하면 캐싱 구현이 가능합니다.

4. Self-descriptiveness(자체 표현 구조)
REST의 또 다른 큰 특징 중 하나는 REST API 메시지만 보고도 이를 쉽게 이해할 수 있는 자체 표현 구조로 되어 있습니다.

5. Client - Server구조
REST 서버는 API제공, 클라이언트는 사용자 인증이나 컨텍스트(세션, 로그인 정보)등을 직접 관리하는 구조로 각각의 역할이 확실히 구분되기 때문에 클라이언트와 서버에서 개발해야 할 내용이 명확해지고 서로간 의존성이 줄어들게 됩니다.

6. 계층형 구조
REST 서버는 다중 계층으로 구성될 수 있으며 보안, 로드 밸런싱, 암호화 계층을 추가해 구조상의 유연성을 둘 수 있고 PROXY, 게이트웨이 같은 네트워크 기반의 중간매체를 사용할 수 있게합니다.



## HTTP Method
4가지의 HTTP Method(GET, POST, PUT, DELETE)를 사용하여 CRUD를 구현한다.

| Method | CRUD   | 설명                                |
| ------ | ------ | ----------------------------------- |
| GET    | Read   | 모든 리소스 또는 특정 리소스를 조회 |
| POST   | Create | 리소스를 생성                       |
| PUT    | Update | 리소스를 수정                       |
| DELETE | Delete | 리소스를 삭제                       |


## REST API ?
REST 구조에 적합한 Web API를 의미한다. 

#### REST API의 구성
REST API는 자원(Resource), 행위(Verb), 표현(Representations)의 3가지 요소로 구성된다.
REST는 자체 표현 구조(Self-descriptiveness)로 구성되어 REST API만으로 요청을 이해할 수 있다.

- 자원(Resource) : HTTP URI
- 행위(Verb) : HTTP Method
- 표현(Representations) : HTTP Message Pay Load

#### REAT API 생성 규칙
REST에서 가장 중요한 기본적인 규칙은 다음과 같이 두 가지이다.

1. URI는 정보의 자원을 표현해야 한다.
리소스명은 동사보다는 명사를 사용한다.
```bash
# bad
GET /getBooks/1
GET /books/show/1

# good
GET /books/1
```

2. 자원에 대한 행위는 HTTP Method(GET, POST, PUT, DELETE 등)으로 표현한다.
```bash
# bad
GET /books/delete/1

# good
DELETE /books/1
```

###### URI 설계 시 주의할 점
1. 슬래시 구분자(/)는 계층 관계를 나타내는데 사용한다.        
```
http://restapi.example.com/user/admin
http://restapi.example.com/animals/mammals/whales
```
2. URI 마지막 문자로 슬래시(/)를 포함하지 않는다.
URI에 포함된 모든 글자는 리소스의 유일한 식별자로 사용된다. 그러므로 URI가 다르다는 것은 리소스가 다르다는 것을 의미한다.
REST API는 분명한 URI를 만들어 통신을 해야하므로 혼동을 주지 않도록 마지막에는 슬래시를 포함하지 않도록 한다.
3. 하이픈(-)은 URI 가독성을 높이는데 사용
4. 밑줄(_)은 URI에 사용하지 않는다.
5. URI 경로에는 소문자가 적합하다.
6. 파일 확장자는 URI에 포함시키지 않는다.
REST API에서는 메시지 바디 내용의 포맷을 나타내기 위한 파일 확장자를 URI 안에 포함시키지 않고, * Accept header*를 사용하여 전달하도록 한다.        
```
GET /hello HTTP/1.1
Host: remotty.com
Accept: text/csv
```
7. 자원을 표현할 때, collection을 표현하는 경우에는 *복수*로 document를 표현할 때는 *단수*를 이용하여 표현한다. (URI만 봐도 좀 더 이해하기 쉽게 도와준다)

## 기타
#### 다국어 지원과 REST
`http://www.site.com/ko`등과 같이 URI에 표현하지 말고, `Accept-Language` 헤더를 이용하자.
다국어 지원을 Accept-Language에 의존한다면, 사용자 환경에 따라 적합한 언어로 응답하여 보여줄 수 있다.
추가로 사용자가 원하는 언어를 설정하게 하여 해당 정보를 세션이나 쿠키에 저장한 뒤, Accept-Language와 우선순위를 조정하여 보여줄 수도 있다.

##### 반응형 웹과 REST
`http://m.site.com` 등과 같이 URI에 표현하지 말고, `User-Agent` 헤어를 활용하자.


> URL ? URI ? URN ?
> URI(Uniform Resource Identifier)은 자원의 식별자로 인터넷 우편물 주소와 같다고 이해하면 된다.
> URL(Uniform Resource Locator)은 자원의 위치를 가르치는 주소로 특정 서버의 리소스에 대한 구체적인 위치를 나타낸다.
> URN(Uniform Resource Name)은 리소스의 위치에 영향을 받지 않는 고유한 이름의 역할을 한다.
> **URI가 좀 더 상위 개념이고 그 안에 URL, URN이 포함된다.**
> 


## Reference
- [poiemaweb-REST API](http://poiemaweb.com/js-rest-api)
- [REST API 제대로 알고 사용하기](http://meetup.toast.com/posts/92)
- [RESTFul이란 무엇인가?](http://blog.remotty.com/blog/2014/01/28/lets-study-rest/)
- [HTTP Status Codes](https://httpstatuses.com/)
- [URL vs URI vs URN](http://nsinc.tistory.com/192)
