---
layout: post
title: "(github blog) 커스터마이징"
date: 2017-04-08 14:30:00
author: gloria
categories: etc
tags: jekyll blog
#cover:  "/assets/instacode.png"
---

* TOC
{:toc}

github에 테마를 가져다 쓰다가 내 입맛대로 구성해보기 위해서 삽질한 내용들을 기록하기 위해서 정리하기.

> 구성 환경  
> ruby 2.0.0p648 (2015-12-16 revision 53162)  
> gem 2.0.14.1  
> jekyll 3.4.3  

## 폴더 구조 생성
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


## configuration
`_config.xml` 파일을 설정한다.
각 설정 파일에 대한 설명은 [Jekyll Bootstrap Doc](http://mistic100.github.io/jekyll-bootstrap-doc/#configuration) 를 참고.

## 페이지 레이아웃 잡기
아래와 같은 디자인에서 좌측 사이드바만 없앤 디자인으로 결정을 하고 레이아웃을 잡기로 했다.<br/>
![]({{ site.baseurl }}/assets/images/post/2017/0408-blog-custom-layout.png)

#### 코드 작성
**index.html**   
블로그 접속 시 메인에 보여지는 화면으로 `index.md`파일을 삭제하고, `index.html`로 생성해준 뒤에 아래와 같이 작성한다.<br/>
 (해당 페이지가 블로그 접속 시의 메인페이지이다…나중에 해당 파일에 메인 페이지이 body에 들어갈 내용들을 작성하기 위해 html 파일로 미리 변경해줌)
{% raw %}
```html
 ---
 layout: default
 title: Home
 ---

 {% for post in site.posts limit:5 %}
 <div class="blog-post">
         <a class="blog-post-title" href="{{ post.url | prepend: site.baseurl }}" class="image featured">
                 <img src="{{ post.banner | prepend: site.baseurl }}" alt="" />{{ post.title }}
         </a>
         <p class="blog-post-meta">{{ post.date | date: "%b %-d, %Y" }}</p>
         <p class="blog-post-excerpt">{{ post.excerpt }}</p>
 </div>

 <hr class="featurette-divider">
 {% endfor %}
```
{% endraw %}

**_layouts/default.html**    
페이지의 레이아웃을 잡기 위한 파일이다. index.html에서 default로 정의하였으므로 해당 파일도 default.html로 생성한다.<br/>
(만약, 다른 파일명으로 정의하고 싶다면, index.html의 layout에 해당 파일명과 일치 시켜 주면 되는 것 같음)
{% raw %}
```html
<!DOCTYPE html>
<html lang="en">

  {% include head.html %}

  <body>

    {% include nav.html %}

    <div class="container-fluid">

        <div class="row">

          <div class="col-sm-9 blog-content">
            {{content}}
          </div>

          <div class="col-sm-3 col-sm-offset-1 blog-sidebar">
            {% include sidebar.html %}
          </div>

        </div>

        <div class="row">
          {% include footer.html %}
        </div>
    </div>

  </body>
</html>
{% endfor %}
```
{% endraw %}
그리고서 default.html 에 포함되는 각각의 파일들을  {% raw %}`{% include head.html %}`{% endraw %} 와 같이 정의하고 `_includes/` 폴더에 해당 파일명으로 넣어주면 된다.


**_includes/head.html**   
`head` tag에 들어갈 내용들을 정의한다.
style에 관련된 css 와 같은 파일들에 대해서도 필요 시 해당 파일에 정의.
{% raw %}
```html
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
  <meta name="description" content="">
  <meta name="author" content="">
  <title>{{site.title}}</title>

  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.0/css/font-awesome.min.css">
  <link rel="stylesheet" href="{{site.github.url}}/assets/css/style.css">
</head>
```
{% endraw %}

**_includes/nav.html**   
페이지의 매뉴 카테고리 등 상단에 위치할 부분에 대해 정의한다.
{% raw %}
```html
<nav class="navbar navbar-toggleable-md navbar-inverse fixed-top bg-inverse">
  <div class="navbar-header">
    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
    </button>
    <a class="navbar-brand mb-0" href="{{site.github.url}}/index.html">{{site.title}}</a>
  </div>
  <div class="collapse navbar-collapse" id="navbarCollapse">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="{{site.github.url}}/index.html">Home</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">About</a>
      </li>
    </ul>
  </div>
</nav>
```
{% endraw %}

**_includes/sidebar.html**    
사이드에 들어갈 매뉴바를 정의한다.
해당 부분에 차후에 카테고리와 tag 리스트를 넣으려고 생각 중임.
{% raw %}
```html
<div id="accordion" class="blog-sidebar-group" role="tablist" aria-multiselectable="true">
  <div class="card">

    <div class="card-header" role="tab" id="headingOne">
      <p class="mb-0 blog-sidebar-header">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapse-category" aria-expanded="true" aria-controls="collapse-category">
          Category
        </a>
      </p>
    </div>

    <div id="collapse-category" class="collapse show " role="tabpanel" aria-labelledby="headingOne">
      <div class="card-block ">
        <ul class="blog-sidebar-menu">
          <li><a href="#">March 2014</a></li>
          <li><a href="#">February 2014</a></li>
          <li><a href="#">January 2014</a></li>
          <li><a href="#">December 2013</a></li>
          <li><a href="#">November 2013</a></li>
          <li><a href="#">October 2013</a></li>
        </ul>
      </div>
    </div>

  </div> <!-- /.card -->
</div>

<div id="accordion" class="blog-sidebar-group" role="tablist" aria-multiselectable="true">
  <div class="card">

    <div class="card-header" role="tab" id="headingOne">
      <p class="mb-0 blog-sidebar-header">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapse-archive" aria-expanded="true" aria-controls="collapse-archive">
          Archives
        </a>
      </p>
    </div>

    <div id="collapse-archive" class="collapse show " role="tabpanel" aria-labelledby="headingOne">
      <div class="card-block ">
        <ul class="blog-sidebar-menu">
          <li><a href="#">March 2014</a></li>
          <li><a href="#">February 2014</a></li>
          <li><a href="#">January 2014</a></li>
          <li><a href="#">December 2013</a></li>
          <li><a href="#">November 2013</a></li>
          <li><a href="#">October 2013</a></li>
        </ul>
      </div>
    </div>

  </div> <!-- /.card -->
</div>

<div class="card card-outline-secondary mb-3 blog-sidebar-group">
  <div class="card-block">
    <p class="card-title blog-sidebar-header">Tag</p>
    <blockquote class="card-blockquote">
      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.</p>
    </blockquote>
  </div>
</div>
```
{% endraw %}

**_includes/footer.htm**    
페이지 하단 부분 정의. include 할 javascript도 해당 파일에서 정의하였음.
{% raw %}
```html
<footer class="blog-footer">
  <p>@2017 by gloria</p>
  <p>
    <a href="#">Back to top</a>
  </p>
</footer>

<!-- javascript -->
<script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
<script src="{{site.github.url}}/assets/js/script.js"></script>
```
{% endraw %}

**assets/css/style.css**    
커스텀 스타일을 정의한다.
```css
/*
  Global
*/
html {
  position: relative;
  min-height: 100%;
}

/*
 * Navbar
 */
.navbar {
  margin-bottom: 0;
  border-radius: 0;
}

/*
 * Sidebar
 */
.blog-sidebar {
  padding-top: 4rem;
  background-color: #f9f9f9;
  border-left: .05rem solid #e5e5e5;
}
.blog-sidebar-header {
  font-weight: 500;
}
.blog-sidebar-group {
  padding: 0;
  margin-bottom: 0.5rem;
}

.blog-sidebar-menu {
  padding-left: 0.5rem;
}

/*
 * Content
 */
.blog-content {
  margin-top: 5rem;
}
/*
 * Blog posts
 */
.blog-post {
  padding-left: 1rem;
}
.blog-post-title {
  margin-bottom: .25rem;
  font-size: 1.8rem;
  color: black;
}
.blog-post-meta {
  margin-bottom: 1.25rem;
  font-size: .8rem;
  color: #999;
}
.blog-post-excerpt {
  color: #6E6E6E;
}

article .blog-post-title {
  font-size: 2rem;
}
article .blog-post-meta {
  margin-bottom: 0.5rem;
  font-size: 1rem;
  color: #999;
}
article .article_body {
  padding-top: 2rem;
  padding-bottom: 2rem;
}

/*
 * Footer
 */
.blog-footer {
  padding: 0.5rem;
  width: 100%;
  color: #999;
  background-color: #f9f9f9;
  border-top: .05rem solid #e5e5e5;
}
```

#### 빌드 및 확인
jekyll 로 빌드해서 오류가 없는지 및 정상적으로 페이지가 출력이 되는 지 확인해본다.<br/>
![]({{ site.baseurl }}/assets/images/post/2017/0408-blog-custom.png)


## 페이징 처리
블로그의 메인 페이지에 표시되는 최근 포스팅된 글들에 대해 페이징 처리를 추가한다.

**_config.xml**    
`_config.xml` 파일에 페이징 처리 관련된 설정을 추가한다.
{% raw %}
```
# 한 페이지에 출력할 글의 갯수
paginate: 5
gems:
  - jekyll-paginate
```
{% endraw %}

**index.html**    
블로그의 메인 페이지에 해당하는 파일을 수정한다.
{% raw %}
```html
---
layout: default
title: Home
---

<!-- This loops through the paginated posts -->
{% if paginator.total_pages > 1 %}
<nav aria-label="Page navigation">
  <ul class="pagination justify-content-center">
    {% if paginator.previous_page %}
    <li class="page-item">
    {% else %}
    <li class="page-item disabled">   
    {% endif %}
      <a class="page-link" href="{{ paginator.previous_page_path | prepend: site.baseurl | replace: '//', '/' }}" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
        <span class="sr-only">Previous</span>
      </a>
    </li>
    {% for page in (1..paginator.total_pages) %}
        {% if page == paginator.page %}
          <li class="page-item active"><span class="page-link">{{ page }}<span class="sr-only">(current)</span></span></li>
        <!-- 1번 링크는 루트 링크로 설정 -->
        {% elsif page == 1 %}
          <li class="page-item"><a class="page-link" href="/">{{ page }}</a></li>
        {% else %}
          <li class="page-item"><a class="page-link" href="{{ site.paginate_path | prepend: site.baseurl | replace: '//', '/' | replace: ':num', page }}">{{ page }}</a></li>
        {% endif %}
      {% endfor %}

    {% if paginator.next_page %}
    <li class="page-item">
    {% else %}
    <li class="page-item disabled">   
    {% endif %}
      <a class="page-link" href="{{ paginator.next_page_path | prepend: site.baseurl | replace: '//', '/' }}" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
        <span class="sr-only">Next</span>
      </a>
    </li>
  </ul>
</nav>
{% endif %}
```
{% endraw %}


## Category와 Tag 리스트 출력하기
github page에 tag와 category를 적용하는 방법

#### Frontmatter 정의
각각의 post의 frontmatter에 category와 tag에 대하여 정의가 되어있어야한다.<br/>
사전 정의된 tag는 jekyll doc의 [사전-정의 전역변수](http://jekyllrb-ko.github.io/docs/frontmatter/)를 참고하면 된다.   
{% raw %}
```
---
layout: post
title: "[github blog] 커스터마이징 step3 - Tag 리스트 표시하기"
date: 2017-05-12 14:30:00
categories: Git
tags: jekyll github-page
---
```
{% endraw %}


#### Create your category and tag page
`categories.html`과 `tags.html` 파일에 대하여 `_config.yml`에 정의한다.

```yml
# Where are tags and categories displayed
tag_page: '/tags/'
category_page: '/categories/'
```

아래는 각 tags.html과 categories.html 파일에 대한 예시...

**tags.html**     
{% raw %}
```html
---
layout: default
title: Tag
---

<div class="tags-expo">
  <div class="tags-expo-section">
    {% for tag in site.tags %}
    <h2 id="{{ tag[0] | slugify }}">{{ tag[0] }}</h2>
    <ul class="tags-expo-posts">
      {% for post in tag[1] %}
        <a class="post-title" href="{{ site.baseurl }}{{ post.url }}">
      <li>
        {{ post.title }}
      <small class="post-date">{{ post.date | date_to_string }}</small>
      </li>
      </a>
      {% endfor %}
    </ul>
    {% endfor %}
  </div>
</div>
```
{% endraw %}

**categories.html**     
{% raw %}
```html
{% for category in site.categories %}
  {% assign cate = category | first %}
  {% assign posts = category | last %}
<h2 id="{{ cate | slugify }}">{{ cate }}</h2>
<ul>
  {% for post in posts %}
    <a class="post-title" href="{{ site.baseurl }}{{ post.url }}">
  <li>
    {{ post.title }}
  <small class="post-date">{{ post.date | date_to_string }}</small>
  </li>
  </a>
  {% endfor %}
</ul>
{% endfor %}
```
{% endraw %}

화면에 출력된 형태는 tag와 동일한 패턴으로 출력된다.


## Reference
-  https://www.w3schools.com/bootstrap/bootstrap_templates.asp  
- [Blog Template for Bootstrap](http://getbootstrap.com/examples/blog/#)  
- [Use Tags and Categories in your Jekyll based Github Pages without plugins · Codinfox](https://codinfox.github.io/dev/2015/03/06/use-tags-and-categories-in-your-jekyll-based-github-pages/)
