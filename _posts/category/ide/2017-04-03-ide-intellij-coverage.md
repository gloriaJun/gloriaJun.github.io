---
layout: post
comments: true
title: "[IntelliJ] Code Coverage"
date: 2017-04-03 17:00:00
categories: IDE
tags: IntelliJ coverage
---
 
intelliJ의 경우, 별도 플러그인을 설치할 필요없이 자체적으로 내장이 되어있음.

<br/>
#### 기본 설정값 변경
Preference 창에서 커버리지에 대한 색상을 default에서 변경한다.
(기존꺼는 흐려서 잘 눈에 띄지 않음)
![]({{ site.url }}/assets/images/post/ide/2017/0403-ide-intellij-coverage/configuration.png)

Foreground에 체크된 것을 해제하고, Background로 변경<br/>
Full - 177D24<br/>
Partial - F0FF1F<br/>
Uncovered - 830505<br/>

<br/>
#### 커버리지 측정하기
수행할 테스트 케이스 또는 패키지 선택 후, 우클릭해서 “Run ~~ with Coverage”로 수행한다. <br/>
![]({{ site.url }}/assets/images/post/ide/2017/0403-ide-intellij-coverage/run-test.png)

그러면 아래와 같이 커버리지를 확인할 수 있다.
![]({{ site.url }}/assets/images/post/ide/2017/0403-ide-intellij-coverage/coverage.png)