---
layout: post
title: "(IntelliJ) Code Coverage"
date: 2017-04-03 16:54:00
author: gloria
categories: etc
tags: jetbrain
---

ntelliJ의 경우, 별도 플러그인을 설치할 필요없이 자체적으로 내장이 되어있음.

#### 기본 설정값 변경
Preference 창에서 커버리지에 대한 색상을 default에서 변경한다. (기존꺼는 흐려서 잘 눈에 띄지 않음)
![]({{ site.baseurl }}/assets/images/post/2017/0403-intellij-configuration.png)

Foreground에 체크된 것을 해제하고, Background로 변경
- Full - 177D24
- Partial - F0FF1F
- Uncovered - 830505

#### 커버리지 측정하기
수행할 테스트 케이스 또는 패키지 선택 후, 우클릭해서 “Run ~~ with Coverage”로 수행한다.
![]({{ site.baseurl }}/assets/images/post/2017/0403-intellij-run-test.png){: .width-50 }

그러면 아래와 같이 커버리지를 확인할 수 있다.
![]({{ site.baseurl }}/assets/images/post/2017/0403-intellij-coverage.png)
