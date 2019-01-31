---
layout: post
title: "(DevOps) Github 프로젝트 관리를 위한 도구들 정리"
date: 2019-01-29 13:57:00
author: gloria
categories: devops
tags: github-badge
---

# CI/CD

## Travis CI

- 지속적인 빌드/배포/통합을 위한 도구
- https://docs.travis-ci.com/user/tutorial/

# 의존성 관리 도구

## David

[David](https://david-dm.org)는 package 의존성을 자동으로 체크해주는 도구이다.
현재 내가 사용 중인 버전과 최신 버전들을 리스트로 표현해주고, 각 모듈들의 관계를 트리로도 표현해준다.

- 사용법 : `https://david-dm.org/username/repo.svg`와 같이 한 번 호출했더니..자동으로 David에서 수집을 시작했던 듯. 별다른 설치가이드도 없었다.
- 예제 : https://david-dm.org/gloriaJun/vue2-nuxt-realworld-example-app

## Greenkeeper

- 각 패키지의 의존성을 실시간으로 감시하고 업데이트 할 수 있게 도와주는 도구
- 해당 도구에 대한 설명은 [(DevOps) 패키지 의존성 관리를 위한 GreenKeeper]()를 참고.

## Dependabot

- Greenkeeper와 유사한 의존성 관리를 위한 모니터링 도구
- https://dependabot.com/

# 코드 품질 관리

코드 품질을 측정하기 위한 도구

## Code Climate

- https://codeclimate.com/
- 유료 플랜만 존재

## Codacy

- https://www.codacy.com/
- [MyProject](https://app.codacy.com/projects)에서 연동한 프로젝트 리스트를 확인할 수 있다.
- 예제 : https://app.codacy.com/project/Codacy/codacy-analysis-cli/dashboard

# 코드 커버리지 측정 도구

## Coveralls

- CI 도구와의 연동이 필요
- 커버리지가 측정된 데이타를 받아서 시작적으로 보여주는 역할을 수행 (테스트 수행 시 측정된 커버리지 결과를 coveralls로 전달해야한다.)
- public 레파지토리에 대해서는 무료 플랜으로 사용 가능
- Pull Request를 자동적으로 빌드, 테스트 및 Code Coverge를 분석해서 결과물을 자동적으로 댓글로 결과물을 남겨준다.
- 예시: https://coveralls.io/github/facebook/react

## Codecov

- CI 도구와의 연동이 필요
- coveralls보다 패치의 상태를 좀 더 정확히 보여준다고함
- CI 도구와 연동 시에 coveralls 보다 좀 더 직관적이었던 느낌
- 예시: https://codecov.io/gh/codecov/codecov-node

## 참고할만한 글

- [codecov vs coveralls](http://text.youknowone.org/post/144201220021/codecov-vs-coveralls)

# 기타

## Works on My Machine

- https://github.com/nikku/works-on-my-machine
- 내 머신에서는 잘 돈다는 의미로 붙이는 배지??

## shields.io

[shields.io](https://shields.io)는 다양한 뱃지를 만들수 있는 오픈소스 프로젝트이다.
