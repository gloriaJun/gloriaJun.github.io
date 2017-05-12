---
layout: post
title: "[github blog] 커스터마이징 step1 - 레이아웃 잡기"
date: 2017-04-08 14:30:00
categories: Git
tags: jekyll github-page
---

github에 테마를 가져다 쓰다가 내 입맛대로 구성해보기 위해서 삽질한 내용들을 기록하기 위해서 정리하기.

> 구성 환경  
> ruby 2.0.0p648 (2015-12-16 revision 53162)  
> gem 2.0.14.1  
> jekyll 3.4.3  

### 폴더 구조 생성
`jekyll new my-blog`와 같이 실행하여  디렉토리와 기본 구조(?)를 생성한 뒤에,
아래와 같이 폴더 구조를 생성하였다.
```
$ tree
.
├── Gemfile
├── Gemfile.lock
├── assets
├── _config.yml
├── _images
├── _includes
├── _layouts
├── _posts
├── about.md
└── index.md

5 directories, 6 files
```


### configuration
`_config.xml` 파일을 설정한다.
각 설정 파일에 대한 설명은 [Jekyll Bootstrap Doc](http://mistic100.github.io/jekyll-bootstrap-doc/#configuration) 를 참고.

### 페이지 레이아웃 잡기
아래와 같은 디자인에서 좌측 사이드바만 없앤 디자인으로 결정을 하고 레이아웃을 잡기로 했다.<br/>
![]({{ site.url }}/assets/images/git/2017/0408-git-blog-custom-step1/layout.png)

##### index.html
블로그 접속 시 메인에 보여지는 화면으로 `index.md`파일을 삭제하고, `index.html`로 생성해준 뒤에 아래와 같이 작성한다.<br/>
 (해당 페이지가 블로그 접속 시의 메인페이지이다…나중에 해당 파일에 메인 페이지이 body에 들어갈 내용들을 작성하기 위해 html 파일로 미리 변경해줌)
{% gist gloriaJun/5d66127f4f54d61831957fe121baa323 index.html %}

##### _layouts/default.html
페이지의 레이아웃을 잡기 위한 파일이다. index.html에서 default로 정의하였으므로 해당 파일도 default.html로 생성한다.<br/>
(만약, 다른 파일명으로 정의하고 싶다면, index.html의 layout에 해당 파일명과 일치 시켜 주면 되는 것 같음)
{% gist gloriaJun/5d66127f4f54d61831957fe121baa323 layouts-default.html %}
그리고서 default.html 에 포함되는 각각의 파일들을  {% raw %}`{% include head.html %}`{% endraw %} 와 같이 정의하고 `_includes/` 폴더에 해당 파일명으로 넣어주면 된다.


###### _includes/head.html
`head` tag에 들어갈 내용들을 정의한다. 
style에 관련된 css 와 같은 파일들에 대해서도 필요 시 해당 파일에 정의.
{% gist gloriaJun/5d66127f4f54d61831957fe121baa323 includes-head.html %}

###### _includes/nav.html
페이지의 매뉴 카테고리 등 상단에 위치할 부분에 대해 정의한다.
{% gist gloriaJun/5d66127f4f54d61831957fe121baa323 includes-nav.html %}

##### _includes/sidebar.html
사이드에 들어갈 매뉴바를 정의한다.
해당 부분에 차후에 카테고리와 tag 리스트를 넣으려고 생각 중임.
{% gist gloriaJun/5d66127f4f54d61831957fe121baa323 includes-sidebar.html %}

##### _includes/footer.htm
페이지 하단 부분 정의. include 할 javascript도 해당 파일에서 정의하였음.
{% gist gloriaJun/5d66127f4f54d61831957fe121baa323 includes-footer.html %}

### assets/css/style.css
커스텀 스타일을 정의한다.
{% gist gloriaJun/5d66127f4f54d61831957fe121baa323 assets-css-styles.css %}

### 빌드 및 확인
jekyll 로 빌드해서 오류가 없는지 및 정상적으로 페이지가 출력이 되는 지 확인해본다.<br/>
![]({{ site.url }}/assets/images/git/2017/0408-git-blog-custom-step1/myblog-step1.png)


> 참고한 사이트  
> https://www.w3schools.com/bootstrap/bootstrap_templates.asp  
> [Blog Template for Bootstrap](http://getbootstrap.com/examples/blog/#)  

