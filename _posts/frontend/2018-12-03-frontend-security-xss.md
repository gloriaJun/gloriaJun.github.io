---
layout: post
title: "(Frontend) XSS(크로스 사이트 스크립팅)"
date: 2018-12-03 10:35:00
author: gloria
categories: frontend
tags: frontend security

---

[TOC]


## Cross-Site Scripting
크로스 사이트 스크립팅은 사용자가 입력한 정보를 출력할 때 스크립트가 실행되도록 하는 공격기법이다. 다른 사이트로 어떤 정보를 전송하는 행위가 주로 일어나기 때문에 사이트간 스크립팅이라는 이름을 가지고 있다.   

XSS 공격은 브라우저로 전달되는 데이터에 악성 스크립트가 포함되어 개인의 브라우저에서 실행되면서 해킹을 하는 것이며, 이 공격용 악성 스크립트는 공격자가 웹 서버에 구현된 웹 애플리케이션의 XSS 취약점을 이용하여 서버 측 또는 URL에 미리 삽입을 해놓은 것이다.

공격에 성공하면 사이트에 접속한 사용자는 삽입된 코드를 실행하게 되며, 보통 의도치 않은 행동을 수행시키거나 쿠키나 세션 토큰 등의 민감한 정보를 탈취한다.

> “크로스 사이트 스크립팅(XSS)는 애플리케이션에서 브라우저로 전송하는 페이지에서 사용자가 입력하는 데이터를 검증하지 않거나, 출력 시 위험 데이터를 무효화 시키지 않을 때 발생한다”


## 공격방법
XSS 취약점을 이용한 공격방법은 3가지로 분류된다.

#### 저장 XSS 공격
접속자가 많은 웹 사이트를 대상으로 공격자가 XSS 취약점이 있는 웹 서버에 공격용 스크립트를 입력시켜 놓으면, 방문자가 악성 스크립트가 삽입되어 있는 페이지를 읽는 순간 방문자의 브라우저를 공격하는 방식이다.
![저장 XSS 공격]({{ site.baseurl }}/assets/images/post/xss1.png)

게시판과 같은 html 문서에 `<script>` 태그를 이용하여 악성 스크립트를 저장하는 방식이 대표적인 예이다. 해당 방식은 사용자들이 많이 방문하는 사이트가 공격 대상으로 가장 적합할 수 있다. (유명 온라인 게시판, 웹 기반 이메일 및 사용자 프로필 등...) 
```html
<script>alert(document.cookie);</script>
```


#### 반사 XSS 공격
악성 스크립트가 포함된 URL을 사용자가 클릭하도록 유도하여 URL을 클릭하면 클라이언트를 공격하는 방식이다. 
웹 어플리케이션의 지정된 변수를 이용할 때 발생하는 취약점을 이용하는 것으로, '검색 결과, 에러 메시지 등...' 서버가 외부에서 입력받은 값을 받아 브라우저에게 응답할 때 전송하는 과정에서 입력되는 변수의 위험한 문자를 사용자에게 그대로 돌려주면서 발생한다.
![반사 XSS 공격]({{ site.baseurl }}/assets/images/post/xss2.png)

일반적인 공격 단계는 
1. 공격자는 먼저 A사이트에 XSS 취약점이 있는 것을 발견한다.
2. 민감한 정보를 획득할 수 있는 공격용 악성 URL을 생성한다.
3. 공격자는 이 URL을 이메일 메시지에 포함하여 배포한다.
```
http://www.server.com/search/?q=<script>alert(document.cookie)</script>&x=0&y=0
```

4. 피해자가 URL을 클릭하면, 바로 공격 스크립트가 피해자로 반사되어 A 사이트에 관련된
민감한 정보(ID/패스워드, 세션 정보)를 공격자에게 전송한다.
```html
// 서버가 반사한 HTML 데이터
<html>
<body>
	<div id="pageTitleTxt">
	<h2><span class="highlight">Search Results</span><br />
Search: "<script>alert(document.cookie)</script>"</h2>
</body>
</html>
```


#### DOM 기반 XSS 공격
DOM 환경에서 악성 URL을 통해 사용자의 브라우저를 공격하는 방식이다.
피해자의 브라우저가 HTML 페이지를 구문 분석할 때마다 공격 스크립트가 DOM 생성의 일부로 실행되면서 공격한다. 페이지 자체는 변하지 않으나, 페이지에 포함되어 있는 브라우저측 코드가 DOM 환경에서 악성코드로 실행된다.
해당 공격은 서버와 관계없이 브라우저에서 발생하는 공격이다. 
![DOM 기반 XSS 공격]({{ site.baseurl }}/assets/images/post/xss3.png)



## 예방 방법
#### 입출력 값 검증 및 무효화
입력 값에 대하여 유효성을 검사한다. XSS 공격은 `<script>` 태그를 기본적으로 사용하므로 해당 공격을 차단하기 위해 태그 문자 등에 대해 필터링 하고 서버에서 브라우저로 전송 시 문자를 인코딩한다. 
하지만, 일일이 많은 태그의 입력 문자를 검증하기 위해 코딩 시에 작업할 수 없으므로 입출력 값을 자동으로 검증해주는 라이브러리를 사용하면 좀 더 효과적인 대응이 가능하다.

###### 관련 라이브러리
- AntiXSS      
:  마이크로소프트사에서 개발한 공개용 XSS 취약점 예방 라이브러리

- OWASP       
: 포괄적인애플리케이션보안을위해웹응용취약점을대응할수있는 오픈소스 ESAPI 라이브러리를 개발하여 제공하고 있다. ESAPI에는 총 14개의 API가 있으며, 이 중 XSS 취약점을 예방하기 위해 API는 validator와 encoder가 있다. validator는 입력 값을 필터링하는 기능을 하고 있으며, encoder는 출력 값을 인코딩 및 디코딩 기능을 가지고 있다.
이 라이브러리는 자바, PHP, .NET, ASP, 자바스크립트 및 파이썬 등 다양한 애플리케이션 개발 언어를 지원하고 있다.

- 브라우저 확장 프로그램     
: NoScript는 파이어폭스 등 모질라 기반의 브라우저에서 실행되는 오픈 소스 확장 프로그램으로, 화이트 리스트 기반으로 신뢰된 사이트의 자바스크립트, 플래쉬, 실버라이트 및 액티브X 등 동적 스크립트만 브라우저에서 실행하도록 하여 XSS 공격을 예방할 수 있다.



## Reference
- [Cross-Site Scripting (XSS)](https://opentutorials.org/course/692/3961)
- [크로스 사이트 스크립팅(XSS) 공격 종류 및 대응 방법](http://www.kisa.or.kr/uploadfile/201312/201312161355109566.pdf)