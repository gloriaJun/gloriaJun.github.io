---
layout: post
title: "[github blog] 커스터마이징 step3 - Tag 리스트 표시하기"
date: 2017-05-12 14:30:00
categories: Git
tags: jekyll github-page
---

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

###### tags.html
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

실행 결과
![]({{ site.url }}/assets/images/post/git/2017/0512-git-custom-step3/tag.png)

###### categories.html
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


> **참고 링크**<br/>
> [Use Tags and Categories in your Jekyll based Github Pages without plugins · Codinfox](https://codinfox.github.io/dev/2015/03/06/use-tags-and-categories-in-your-jekyll-based-github-pages/)