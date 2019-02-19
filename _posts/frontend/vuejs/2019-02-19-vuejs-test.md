---
layout: post
title: "(VueJS) 테스트케이스 작성하기"
date: 2019-02-19 14:35:00
author: gloria
categories: frontend
tags: javascript test jest tdd
---

* TOC
{:toc}

[realworld](https://github.com/gloriaJun/realworld)를 참고해서 Nuxt 기반으로 한 토이프로젝트에 단위테스트 작성을 하면서 배운 부분과 참고한 링크들 정리하기.

# 살짝쿵 이론적인 부분? 정리

## 왜 테스트 코드를 작성해야하는가?

- 코드의 품질을 보장하기 위해서
- 차후 코드 수정 시에 발생할 수 있는 사이드 이펙트를 조금이나마 예방하기 위해서

### 그 외의 여담으로 내가 생각하는 이유??

내 경험에 의하면...대부분의 관리자나 개발자들은 테스트에 대해, 특히 단위 테스트에 대해 중요하게 생각하지 않는다.
누구나 빠른 결과물을 내기를 원한다. 내부의 코드가 어떻게 작성되어 있던, 작은 코드의 수정으로 미칠 영향도가 어떻든지 간에...
나중에 문제가 될 때서야 문제 제기를 하기도 한다.
하지만 내가 생각하기에 테스트는 어떻게 보면..하나의 건물을 짓는 과정에 있어서 구조를 잘 설계하고, 기초부터 튼튼하게 지은 건물에 문제가 없는 지 확인을 하는 과정이 아닌가 싶다. 
만약, 그 확인하는 과정을 거치지 않고 건물만 설계에 맞추어 쌓아올리기만 한다면...과연 어떻게 될까???
아무튼 개발도 마찬가지 아닌가 싶다. 단지, 사고가 인명사고로 이어질 가능성이 희박(?)하다는 것 뿐..이 아닐까나...

> 즉, 좀 더 견고하고 튼튼한 제품을 만들기 위한 하나의 개발 프로세스 중의 하나가 테스트 코드를 작성하는 것이 아닐까 한다.

## TDD

Test Driven Development의 약자이다.
쉽게 말하면 테스트케이스를 먼저 작성하고, 실제 구현되는 코드를 작성하는 것이다.
- [TDD(Test Driven Development) 를 연습하면서 참고하기 좋은 팁 10가지](https://medium.com/@rinae/tdd-test-driven-development-%EB%A5%BC-%EC%97%B0%EC%8A%B5%ED%95%98%EB%A9%B4%EC%84%9C-%EC%B0%B8%EA%B3%A0%ED%95%98%EA%B8%B0-%EC%A2%8B%EC%9D%80-%ED%8C%81-10%EA%B0%80%EC%A7%80-d8cf46ae1806)

# 단위 테스트 작성하기

- `given, when, then` 단계에 따라 테스트 시나리오를 작성한다.
- 독립적으로 테스트 케이스를 작성한다.
- `stub, mock` 등과 같은 것을 이용하여 의존성을 배제하여 작성한다. (Isolation)

# Vue Component 테스트하기

## 테스트 코드 작성 시 고려해야하는 부분

- 입력 값 : props, user interaction, lifecycle methods
- 출력 값 : events, rendered output, connection with children

## mount vs shallowMount

컴포넌트를 마운트하는 방법으로는 mount(), shallowMount() 두 가지가 있는데 각각의 차이점은 아래와 같다.

### mount

테스트할 컴포넌트의 하위 컴포넌트의 동작까지 함께 테스트 하는 API.
특정 기능의 전체 흐름을 모두 테스트 케이스로 작성할 때 사용.

### shalloMount

테스트 할 컴포넌트의 기능만 테스트하고 하위 컴포넌트와는 분리해주는 테스트 API.
특정 기능의 흐름을 잘게 분할해서 테스트 케이스로 작성할 때 사용.

## Snapshot

스냅샷 테스트를 이용하여 예기치 못한 코드의 변화를 체크할 수 있다.

> Snapshot tests are a very useful tool whenever you want to make sure your UI does not change unexpectedly.

# Reference

- [Working an application in Vue.js with TDD](https://medium.com/magnetis-backstage/working-an-application-in-vue-js-with-tdd-an-extensive-guide-for-people-who-have-time-part-1-3be791dafa2b)
- [Cracking Vue.js-Vue Test Utils](https://joshua1988.github.io/vue-camp/testing/vue-test-util.html)