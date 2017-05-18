---
layout: post
title: "[github blog] Jekyll 블로그 페이징 처리 - step2"
date: 2017-04-11 23:30:00
categories: Git
tags: jekyll github-page
---

블로그의 메인 페이지에 표시되는 최근 포스팅된 글들에 대해 페이징 처리를 추가한다.

### _config.xml 
`_config.xml` 파일에 페이징 처리 관련된 설정을 추가한다.
{% raw %}
```
# 한 페이지에 출력할 글의 갯수
paginate: 5
gems:
  - jekyll-paginate
```
{% endraw %}

### index.html
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

