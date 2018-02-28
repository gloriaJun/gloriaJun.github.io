---
layout: post
title: "(github blog) 웹페이지에서 검색 가능하게 하기"
date: 2017-05-13 18:30:00
author: gloria
categories: etc
tags: jekyll blog
#cover:  "/assets/instacode.png"
---

github page를 이용하여 블로그를 생성한 경우에 작성한 글이 구글이나 네이버 등과 같은 사이트에서 검색이 되지 않는다.<br/>
이런 경우에 해당 사이트에서 글이 검색이 되도록 하기 위해서는 별도로 설정을 해주어야 한다.

## 구글 검색 가능하게 하기
먼저 [Google Search Console](https://www.google.com/webmasters/tools/home?hl=ko)를 자신의 블로그를 등록을 한다.

## sitemap.xml 파일 생성
sitemap을 google에 등록을 하여 구글에서 주기적으로 크롤링이 되도록 해야한다.<br/>
그러기 위해서는  `sitemap.xml` 파일을 생성한다.<br/>
해당 파일을 생성하는 방법은 `jekyll-sitemap` 플러그인을 이용하거나 직접 sitemap.xml을 생성하는 방법이 있다.

#### 직접 sitemap.xml 파일 생성
`_config.yml`과 동일한 경로에 `sitemap.xml`을 생성한 뒤 아래의 내용을 복사해서 붙여넣는다.
{% raw %}
```
---
layout: null
---
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  {% for post in site.posts %}
    <url>
      <loc>{{ site.url }}{{ post.url }}</loc>
      {% if post.lastmod == null %}
        <lastmod>{{ post.date | date_to_xmlschema }}</lastmod>
      {% else %}
        <lastmod>{{ post.lastmod | date_to_xmlschema }}</lastmod>
      {% endif %}
      <changefreq>weekly</changefreq>
      <priority>1.0</priority>
    </url>
  {% endfor %}
  {% for page in site.pages %}
    {% if page.sitemap != null and page.sitemap != empty %}
      <url>
        <loc>{{ site.url }}{{ page.url }}</loc>
        <lastmod>{{ page.sitemap.lastmod | date_to_xmlschema }}</lastmod>
        <changefreq>{{ page.sitemap.changefreq }}</changefreq>
        <priority>{{ page.sitemap.priority }}</priority>
       </url>
    {% endif %}
  {% endfor %}
</urlset>
```
{% endraw %}

#### plugin 설치하여 생성하기
`jekyll-sitemap` 플러그인을 설치한다.
1. Gemfile에 `em 'jekyll-sitemap'`를 추가한 뒤  `bundler install`로 설치한다.
2.  `_config.yml`에 아래의 내용을 추가한다.
```
gems:
  - jekyll-sitemap
```

## Google Search Console에 sitemap 주소 등록
github page를 빌드한 뒤에 먼저 `http://localhost:4000/sitemap.xml`로 접속하여 xml의 내용이 출력이 되는 지 확인한 뒤, git에 push를 하고 자신의 github page에 접속하여 다시 확인한다.<br/>
(참고로 blog 내용이 변경이 되거나 추가되면 jekyll에서 sitemap.xml도 같이 갱신이 된다)<br/>
Search Console에 접속하여 해당 주소를 등록하면 약 일주일 정도 안에 google로 부터 작성된 글에 대해 구글에서 검색이 될 거라는 메일을 수신받는다.</br>
그 뒤에 구글에서 검색을 해보면 내가 작성한 글이 검색되는 것을 확인할 수 있다.

## 특정 글의 변경 주기나 우선순위를 변경하고 싶은 경우
아래와 같은 속성을 해당 글에 추가해주면 된다.
{% raw %}
```
sitemap :
  changefreq : daily
  priority : 1.0
  lastmod : 2016-03-15 12:00:00
```
{% endraw %}



## 참고 링크  
- [Generating a Sitemap in Jekyll without a Plugin – Development, design, and more by @DavidEnsinger](http://davidensinger.com/2013/03/generating-a-sitemap-in-jekyll-without-a-plugin/)  
- [Sitemaps for GitHub Pages - User Documentation](https://help.github.com/articles/sitemaps-for-github-pages/)  
- [GitHub - jekyll/jekyll-sitemap: Jekyll plugin to silently generate a sitemaps.org compliant sitemap for your Jekyll site](https://github.com/jekyll/jekyll-sitemap)  
