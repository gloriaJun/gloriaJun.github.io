## REST API
REST(Representational State Transfer)는 웹의 장점을 최대한 활용할 수 있는 아키텍쳐로 소개되었으며, HTTP 프로토콜을 의도에 맞게 디자인하도록 가이드 하고 있다.
REST의 기본 원칙을 성실히 지킨 서비스 디자인을 `Restrul`이라고 표현한다.

#### REAT API 생성 규칙
REST에서 가장 중요한 기본적인 규칙은 다음과 같이 두 가지이다.
**1. URI는 정보의 자원을 표현해야 한다.**
리소스명은 동사보다는 명사를 사용한다.
```
# bad
GET /getBooks/1
GET /books/show/1

# good
GET /books/1
```
**2. 자원에 대한 행위는 HTTP Method(GET, POST, PUT, DELETE 등)으로 표현한다.**
```
# bad
GET /books/delete/1

# good
DELETE /books/1
```

#### HTTP Method
4가지의 HTTP Method(GET, POST, PUT, DELETE)를 사용하여 CRUD를 구현한다.

###### GET
모든 또는 특정 리소스를 조회 (Read)

###### POST
리소스를 생성 (Create)

###### PUT
리소스를 수정 (Update)

###### DELETE
리소스를 삭제 (Delete)

#### REST API의 구성
REST API는 자원(Resource), 행위(Verb), 표현(Representations)의 3가지 요소로 구성된다.
REST는 자체 표현 구조(Self-descriptiveness)로 구성되어 REST API만으로 요청을 이해할 수 있다.

- 자원(Resource) : HTTP URI
- 행위(Verb) : HTTP Method
- 표현(Representations) : HTTP Message Pay Load

#### 참고글
[poiemaweb-REST API](http://poiemaweb.com/js-rest-api)
[RESTFul이란 무엇인가?](http://blog.remotty.com/blog/2014/01/28/lets-study-rest/)
[HTTP Status Codes](https://httpstatuses.com/)
