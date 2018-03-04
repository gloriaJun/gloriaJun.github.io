---
layout: post
comments: true
title: "[Rest Assured] Naver Open API를 이용한 테스트 코드 작성하기"
date: 2017-05-16 18:35:00
categories: "Testing"
tags: java restAssured Rest-API
---

Naver Open API를 이용하여 Rest-Assured 테스트 코드 만들기

#### 애플리케이션 등록
[네이버 Open API](https://developers.naver.com/main/)에 접속해서 API이용을 위해 애플리케이션을 등록해야한다.
“Application -> 애플리케이션 접속” 매뉴로 들어가서 등록을 한다.
어플리케이션을 등록하고 난 뒤에 “Application -> 내 애플리케이션” 으로 들어가면 방금 등록한 애플리케이션 정보를 확인할 수 있다.
여기서 `Client ID`와 `Client Secret`이 있는 데 해당 값을 기억해두어야 한다. (해당 값을 header에 넣어주어야함)

#### API 호출 방법 확인
API에 대한 테스트 코드를 작성하기 전에 먼저 해당 API에 대한 사용법을 [NAVER Developers - API 공통 권한 설정 및 호출 가이드](https://developers.naver.com/docs/common/apicall/) 를 참고하여 확인한다.

#### Rest-API 스펙 확인
[NAVER Developers - 검색 API 영화 검색 개발가이드](https://developers.naver.com/docs/search/movie/) 의 API 스펙을 참고로 하여 테스트 코드를 작성한다.

참고로 json으로 제공되는 api로 호출했을 경우의 응답은 아래와 같다.
* JSON 형태의 응답 예시
{
    “lastBuildDate": "Tue, 16 May 2017 13:16:09 +0900",
    "total": 26,
    "start": 1,
    "display": 1,
    "items": [
        {
            "title": "<b>미녀와 야수</b>",
            "link": "http://movie.naver.com/movie/bi/mi/basic.nhn?code=136872",
            "image": "http://imgmovie.naver.com/mdi/mit110/1368/136872_P12_113639.jpg",
            "subtitle": "Beauty and the Beast",
            "pubDate": "2017",
            "director": "빌 콘돈|",
            "actor": "엠마 왓슨|댄 스티븐스|루크 에반스|",
            "userRating": "8.84"
        }
    ]
}

#### 테스트 코드 작성
검색 외의 다른 api에 대해서도 테스트 코드 작성을 해보기 위해 공통으로 사용이 가능한 부분은 유틸리티성 패키지에 클래스를 생성하여 코드를 작성함.

아래는 작성한 전체 코드
{% gist gloriaJun/1491c7835b8ee25691644f8b8aa03469 %}


> 참고링크   
> [yonoo’s :: REST-Assured 를 사용하여 maven 프로젝트로 간단한 API 테스트](http://yonoo88.tistory.com/886)  
> [yonoo’s :: Rest-assured를 사용하여 간단한 Naver Open API 테스트](http://yonoo88.tistory.com/1003)  
> [Testing RESTful Services in Java: Best Practices](https://blog.philipphauer.de/testing-restful-services-java-best-practices/)