---
layout: post
title: "[github blog] 커스터마이징 step3 - Tag 리스트 표시하기"
date: 2017-05-12 14:30:00
categories: Git
tags: jekyll github-page
---

plugin을 사용하지 않고 tag와 category를 사용하는 방법

#### Create your category and tag page
`categories.html`과 `tags.html` 파일을 `/` 디렉토리 하위에 생성한다.

###### tags.html
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


> 참고 링크
> [Use Tags and Categories in your Jekyll based Github Pages without plugins · Codinfox](https://codinfox.github.io/dev/2015/03/06/use-tags-and-categories-in-your-jekyll-based-github-pages/)