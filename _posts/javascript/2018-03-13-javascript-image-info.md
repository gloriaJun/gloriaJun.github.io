---
layout: post
title: "(Javascript) 이미지 파일 크기 구하기"
date: 2018-03-13 13:35:00
author: gloria
categories: language
tags: javascript base64 image
---

이미지 파일의 width, height 구하기

```javascript
function getImageSize (url) {
  return new Promise((resolve, reject) => {
    let image = new Image()
    image.onload = () => {
      resolve({
        width: image.naturalWidth,
        height: image.naturalHeight
      })
    }
    image.src = url
  })
}
```

#### 예제
<p data-height="265" data-theme-id="0" data-slug-hash="GxpBdd" data-default-tab="js,result" data-user="gloriaJun" data-embed-version="2" data-pen-title="get image size" class="codepen">See the Pen <a href="https://codepen.io/gloriaJun/pen/GxpBdd/">get image size</a> by gloria (<a href="https://codepen.io/gloriaJun">@gloriaJun</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>
