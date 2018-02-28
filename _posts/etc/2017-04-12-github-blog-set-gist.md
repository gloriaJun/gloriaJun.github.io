---
layout: post
title: "(github blog) Gist를 블로그에 연동하기"
date: 2017-04-12 14:30:00
author: gloria
categories: etc
tags: jekyll blog gist
#cover:  "/assets/instacode.png"
---

> **사전 조건**  
> Github에 가입된 계정  

### Gist 생성
[Create a new Gist · GitHub](https://gist.github.com)에 접속하여 코드를 작성해서 `Public Gist`로 저장한다. <br/>
![]({{ site.url }}/assets/images/post/2017/0412-gist-create.png)

### jekyll-gist 설치
아래의 html 구문을 삽입하여 코드를 넣을 부분에 복사하여 아래와 같이 사용할 수도 있지만..
{% raw %}
```html
<script src="https://gist.github.com/gloriaJun/5d66127f4f54d61831957fe121baa323.js"></script>
```
{% endraw %}

jekyll-gist를 이용하면 `liquid tag`를 이용할 수 있다고 하여서 해당 플러그인을 설치하기로 했다.
설치 방법은 [jekyll-gist](https://github.com/jekyll/jekyll-gist)에 대한 github 페이지를 참고했다.

`Gemfile`에 추가해주고, 설치를 한다.
```
$ cat Gemfile
source 'https://rubygems.org'
gem 'jekyll'

group :jekyll_plugins do
  gem "jekyll-paginate"
  gem "pygments.rb"
  gem "jekyll-gist"
end

$ bundle install
```

`config.yml`에 추가해준다.
```
gems:
  - jekyll-paginate
  - jekyll-gist
```

### 포스팅에서 사용하기
글에서 해당 코드를 삽입할 부분에 아래와 같이 작성해주면 된다.
{% raw %}
```
{% gist gloriaJun/1c5ab4a539f882e22daccb1fb2a1fe94 %}
```
{% endraw %}

동일한 링크에서 특정 파일만 삽입하는 경우에는 아래와 같이 사용한다.
{% raw %}
```
{% gist gloriaJun/814c7df5ab0bb8600bd3ab459488698b index.html %}
```
{% endraw %}
