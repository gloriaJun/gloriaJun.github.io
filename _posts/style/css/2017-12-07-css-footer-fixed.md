---
https://www.inflearn.com/course/%ED%95%A8%EC%88%98%ED%98%95-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EB%B0%8D/layout: post
title: "(CSS) footer 항상 하단에 고정 시키기"
date: 2017-12-07 14:21:00
author: gloria
categories: style
tags: css frontend
---

#### htmml
```html
<html>

    <body>

        <div class="wrap" style="min-width:1400px;">

            헤더 및 본문 내용

        </div>



        <div class="footer">Footer</div>

    </body>

</html>
```

#### css
```css
html {

    position: relative;

    min-height: 100%;

    margin: 0;

    background: yellow;

}

body {

    min-height: 100%;

}

.footer {

    position: absolute;

    left: 0;

    bottom: 0;

    width: 100%;

	padding: 15px 0;

	text-align: center;

	color: white;

	background: blue;

}
```

#### 적용 결과
<p data-height="265" data-theme-id="0" data-slug-hash="YEbJoN" data-default-tab="css,result" data-user="gloriaJun" data-embed-version="2" data-pen-title="footer-bottom" class="codepen">See the Pen <a href="https://codepen.io/gloriaJun/pen/YEbJoN/">footer-bottom</a> by gloria (<a href="https://codepen.io/gloriaJun">@gloriaJun</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>
