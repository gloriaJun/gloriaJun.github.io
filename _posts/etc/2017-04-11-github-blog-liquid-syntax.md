---
layout: post
title: "(github blog) Jekyll Liquid Syntax 사용법 정리"
date: 2017-04-11 12:30:00
author: gloria
categories: etc
tags: jekyll github
#cover:  "/assets/instacode.png"
---

Jekyll 에서 템플릿 처리 작업을 위해 제공하는 [Liquid 템플릿 언어](http://jekyllrb-ko.github.io/docs/templates/) 에 대한 정리

### 포스팅된 다른 글 링크하기
{% raw %}
```
[post]({% post_url 2017-04-07-spring-exception-handler %})
```
{% endraw %}

만약, 하위 디렉토리에 넣고 관리하는 경우에는, 해당 디렉토리의 경로도 아래와 같이 포함시켜주어야함.
{% raw %}
```
[post]({% post_url /spring/2017-04-07-spring-exception-handler %})
```
{% endraw %}

### markdown 파일 안에서 Liquid Syntax 포함시키기
예제를 작성하거나 할 때에 liquid syntax를 포함시켜야 하는 경우가 있는데..
그대로 작성하게 되는 경우에 해당 tag가 동작을 해서 `Liquid Exception: Liquid syntax error (line 47): Tag`과 같은 에러가 발생을 하거나  원하지 않는 동작을 하는 경우가 발생한다.
이런 경우에는 raw tag를 이용하면 된다.
![]({{ site.url }}/assets/images/post/2017/0412-raw-tag.png)

### 이미지와 자원 삽입하기
글을 작성하는 중간에 이미지나 파일의 링크를 삽입하는 경우에, 사이트의 루트 경로를  `site.url`이라는 변수를 이용하여 사용할 수 있다.
{% raw %}
```
### 이미지를 삽입하는 경우
![친절한 스크린샷]({{ site.url }}/assets/screenshot.jpg)

### 파일의 다운로드 링크를 삽입하는 경우
… PDF 를 직접 [다운로드]({{ site.url }}/assets/mydoc.pdf)할 수 있습니다.
```
{% endraw %}
/단, 해당 파일이 `assets` 디렉토리 하위에 위치해야한다./
