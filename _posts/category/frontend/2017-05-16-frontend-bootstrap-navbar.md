---
layout: post
title: "[Bootstrap] navgation bar 예제"
date: 2017-05-16 20:30:00
categories: Frontend
tags: bootstrap
---

bootstrap의 navbar template을 활용하여 커스터마이징한 예제들

#### Example-1
{% raw %}
```html
<script>
.brand-sub-title {
    font-size: .75rem;
    color: #DCE7F2;
    padding-top: .8rem;
}
</script>

<body>
    <nav class="navbar navbar-toggleable-md navbar-inverse fixed-top bg-inverse">
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
    <div class="navbar-brand d-flex">
        <a class="navbar-brand" href="#">Fixed navbar</a>
        <p class="brand-sub-title">Sub-Title</p>
    </div>
      
      <div class="collapse navbar-collapse" id="navbarCollapse">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item active">
            <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Link</a>
          </li>
          <li class="nav-item">
            <a class="nav-link disabled" href="#">Disabled</a>
          </li>
        </ul>
        <form class="form-inline mt-2 mt-md-0">
          <input class="form-control mr-sm-2" type="text" placeholder="Search">
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
      </div>
    </nav>
</body>
```
{% endraw %}

###### 실행결과

<script src="http://codeply.com/js/embed.js"></script><div data-codeply="KLOOdT8IXu" ></div>

