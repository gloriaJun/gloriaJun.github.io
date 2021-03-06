---
layout: post
title: "코드 리뷰에 대하여..."
date: 2019-01-03 10:54:00
author: gloria
categories: etc
tags:
---

* TOC
{:toc}

코드 품질 향상을 위한 한 가지 방법으로 **코드 리뷰**가 있다고 생각한다.<br/>
어떻게 하면 좋은 코드 리뷰 문화를 가져갈 수 있을까?? 코드 리뷰를 할 수 있을까?? 싶어서 찾아본 글들...을 읽고 간략히 정리해봤다.

> 코드 리뷰는 *사람의 검토를 통하여 코드 상의 잠재적인 결함을 찾고 개선해나가는 일련의 과정*이다.

# 코드리뷰, GitHub로 바로 적용하기

* https://academy.realm.io/kr/posts/codereview-howto
* 코드 리뷰를 하기 전에 사전에 리뷰할 코드를 읽어와야 불필요한 시간을 낭비하지 않으며, 좀 더 효율적으로 리뷰할 수 있다.

## 모든 코드를 코드리뷰 해야하나

* 반드시, 모든 코드를 리뷰해야하는 것은 아니다.
* 비지니스 로직이나 여러 명이 하나의 프로젝트를 함께 개발하는 프로젝트의 경우 코드 리뷰를 통하여 사이트 이펙트를 미연에 방지하고 코드의 완성도를 높일 수 있다.

## 코드 리뷰는 문화이다

* 타인의 코드를 리뷰하고 토론하는 것은 프로그래밍의 역량을 키울 수 있는 하나의 방법이다.
* 코드를 리뷰할 것이라는 생각을 가지고 코딩을 하게 되면 가독성과 로직을 더 깔끔하게 작성하게 된다.

# 라인 기술 블로그 - 효과적인 코드 리뷰를 위해서

* https://engineering.linecorp.com/ko/blog/effective-codereview/
* 코드 리뷰를 수행할 때에 새롭게 추가된 코드나 버그 수정에 대해 unit test가 충분한지 확인하는 것을 권장한다.
* 페어 프로그래밍은 가장 효과적으로 코드 리뷰를 할 수 있는 방법이다.
* PR(Pull Request)를 이용하는 것도 하나의 방법
* 코드 리뷰 프로세스를 효율적으로 만들어야한다. 코드 리뷰가 주업무가 되지 않도록....

## 변화를 작게 유지한다

* 각각의 PR은 릴리즈 가능한 단위(기능, 버그 수정) 또는 의미있는 단위여야한다.

## 리뷰는 자주 짧은 세션으로 진행한다

* 적절한 양을 천천히, 정해진 시간 동안에 진행할 때 가장 효과적이다.
* 코드의 양이 늘어날 수록 리뷰어는 결함을 찾기 힘들어진다.

## 리뷰를 위해 최대한 빨리 PR을 보낸다

* 큰 문제에 대해서는 작은 문제로 나누어 하나씩 해결한다.

## 의미있는 PR을 만들기에 충분한 정보를 제공한다

* 리뷰어가 코드의 문맥을 빨리 파악할 수 있도록 충분한 정보를 제공한다.
* 무엇을 완료했고, 테스트를 했으며, 어떠한 부분에 리뷰어가 집중해야하는 지 덧붙이는 것도 좋다.
* PR 템플릿을 사용하면 도움이 된다 - [github에서 PR 템플릿 생성하는 방법](https://help.github.com/articles/creating-a-pull-request-template-for-your-repository/)

## 코드 분석 툴을 활용하고 코드 스타일을 확인한다

* 정적 코드 분석과 코딩 스타일 체크는 SonarQube나 ESLint, JSLint 등과 같은 도구를 이용하여 검증한다.

# JavaScript 코드 리뷰 - 코드 리뷰 문화

* https://cimfalab.github.io/deepscan/2016/08/code-review-1
* 해당 글에서 기억해두고 싶은 부분

```markdown
- 당신이 실수하리라는 것을 받아들여라.
- 당신이 만든 코드는 당신이 아니다.
- 당신이 얼마나 많이 알고 있다고 해도, 항상 누군가는 더 많은 것을 알고 있다.
- 권위는 지위가 아니라 지식으로부터 나온다.
- 자신보다 많이 알지 못하는 사람이라 해도 존경과 인내로 대하라.
- 사람이 아니라 코드 그 자체를 비판하라.
```

* 적극적으로 리뷰한다
* 논리적인 근거로 리뷰한다.
  * 코드 수행에 대한 테스트 결과나 수정한 결과를 첨부하여 리뷰하면 좋다.
    * [httpbin.org](http://httpbin.org)와 같은 도구를 활용한다.
      * 웹 서버를 구동하지 않아도 http 클라이언트 테스트를 수행할 수 있다.
    * [JSFiddle](http://jsfiddle.net), [Plunker](https://plnkr.co)와 같이 html/css/javascript 코드를 수행할 수 있는 온라인 에디터 도구를 활용한다.
* 코딩 컨벤션은 내부 가이드를 정하여 ESLint, JSLint와 같은 도구를 이용한다. (감정이 상하기 쉽고, 주요 로직 리뷰 시간을 뺏을 수 있다.)
  * 초기에 명확하게 컨벤션 규칙을 수립하고 코드 커밋 시마다 체크하도록 젠킨스와 같은 도구를 이용하여 자동화한다.
  * [Prettier](https://prettier.io) - 정해진 규칙에 따라 자동으로 코드 스타일을 정리해주는 도구

# 그 외에 참고하면 좋은 링크들

* [매끄러운 ‘코드 리뷰’를 돕는 10가지 방법](https://1boon.kakao.com/bloter/238819?fbclid=IwAR2j_veQ_vxSN3MSsqWvEz4QSszYV6JJCJED7nEiHAO5EKm_ON-wTKjB37A)
* [카카오스토리 팀의 코드 리뷰 도입 사례 - 코드 리뷰, 어디까지 해봤니?](http://tech.kakao.com/2016/02/04/code-review)
* [카카오스토리 웹팀의 코드리뷰 경험](https://www.slideshare.net/OhgyunAhn/ss-61189141)
* [소스코드 리뷰에 대한 짧은 이야기](https://brunch.co.kr/@supims/11)
* [JavaScript 코드 리뷰 - 코드 리뷰 사례로 알아보는 좋은 JavaScript 코드](https://cimfalab.github.io/deepscan/2016/09/code-review-2)

## Pull Request

* [git 초보를 위한 풀리퀘스트(pull request) 방법](https://wayhome25.github.io/git/2017/07/08/git-first-pull-request-story/)
