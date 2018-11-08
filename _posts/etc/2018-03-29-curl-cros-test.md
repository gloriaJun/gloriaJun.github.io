---
layout: post
title: "Cross Domain(CROS) 테스트하기"
date: 2018-03-29 16:54:00
author: gloria
categories: etc
tags: curl cors
---

서버에서 Cross Domain을 허용하여 이슈가 있는지 여부에 대해 테스트 하는 방법

#### curl
curl을 이용한 테스트 방법은 [cURL 명령어로 하는 초간단 CORS 테스트](http://www.popit.kr/curl-%EB%AA%85%EB%A0%B9%EC%96%B4%EB%A1%9C-%ED%95%98%EB%8A%94-%EC%B4%88%EA%B0%84%EB%8B%A8-cors-%ED%85%8C%EC%8A%A4%ED%8A%B8/)에 작성된 글을 참고했다.

```bash
curl \
--verbose \
--request OPTIONS \
http://localhost:8088/vas/od/ondemand/image/upload-image-file \
--header 'Origin: http://localhost:8000' \
--header 'Access-Control-Request-Headers: Origin, Accept, Content-Type' \
--header 'Access-Control-Request-Method: POST'
--header 'api-key: test-vas'
```

** cros 설정 적용 되지 않은 경우 **     
```bash
* Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 8088 (#0)
> OPTIONS /vas/od/ondemand/image/upload-image-file HTTP/1.1
> Host: localhost:8088
> User-Agent: curl/7.54.0
> Accept: */*
> Origin: http://localhost:8000
> Access-Control-Request-Headers: Origin, Accept, Content-Type
> Access-Control-Request-Method: POST
>
< HTTP/1.1 401
< Allow: GET, HEAD, POST, PUT, DELETE, TRACE, OPTIONS, PATCH
< Content-Length: 0
< Date: Thu, 29 Mar 2018 05:59:41 GMT
<
* Connection #0 to host localhost left intact
```

** cros 설정 적용 되지 않은 경우 **     
```bash
* Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 8088 (#0)
> OPTIONS /vas/od/ondemand/image/upload-image-file HTTP/1.1
> Host: localhost:8088
> User-Agent: curl/7.54.0
> Accept: */*
> Origin: http://localhost:8000
> Access-Control-Request-Headers: Origin, Accept, Content-Type
> Access-Control-Request-Method: POST
>
< HTTP/1.1 200
< Access-Control-Allow-Origin: http://localhost:8000
< Vary: Origin
< Access-Control-Allow-Methods: GET,HEAD,POST
< Access-Control-Allow-Headers: Origin, Accept, Content-Type
< Access-Control-Allow-Credentials: true
< Access-Control-Max-Age: 1800
< Allow: GET, HEAD, POST, PUT, DELETE, TRACE, OPTIONS, PATCH
< Content-Length: 0
< Date: Thu, 29 Mar 2018 06:00:48 GMT
<
* Connection #0 to host localhost left intact
```

#### cors 테스트 웹페이지
https://www.test-cors.org/


#### Reference 
- [cURL 명령어로 하는 초간단 CORS 테스트](https://www.popit.kr/curl-%EB%AA%85%EB%A0%B9%EC%96%B4%EB%A1%9C-%ED%95%98%EB%8A%94-%EC%B4%88%EA%B0%84%EB%8B%A8-cors-%ED%85%8C%EC%8A%A4%ED%8A%B8/)
