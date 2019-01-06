---
layout: post
title: "(VueJs) 이미지 위에 박스를 그리고 해상도에 따라 반응하게 하기"
date: 2018-03-11 11:35:00
author: gloria
categories: frontend
tags: javascript frontend vuejs css
---

해상도에 따라 이미지 사이즈가 변경되게 하려면, resize 이벤트를 이용하여 해상도의 크기를 구하고 그에 따라 다시 출력하고자 하는 이미지의 크기를 설정해준다.

#### html
```html
<div id="app" :style="customStyle">
  <div class="image-wrapper" :style="customStyle">
    <img :src="imageUrl">
  </div>
  <div class="rectangle-wrapper" :style="customStyle">
    <div class="rectangle" :style="styleObject(position)"></div>
    </div>
</div>
```

#### javascript
```javascript
var app = new Vue({
  el: '#app',
  data () {
      return {
        imageSize: { width: 580, height: 400 },
        imageUrl: 'https://images.pexels.com/photos/708392/pexels-photo-708392.jpeg',
        position: {x: 8, y: 20, w: 16.6291, h: 33.0335}
      }
  },
  computed: {
    isResultEmpty () {
      const obj = this.positionList
      return !obj.length || (obj.length === 1 && this.isObjectEmpty(this.positionList[0]))
    },
    customStyle () {
      return {
        maxWidth: this.imageSize.width + 'px',
        maxHeight: this.imageSize.height + 'px',
        width: this.imageSize.width + 'px',
        height: this.imageSize.height + 'px'
      }
    }
  },
  methods: {
    styleObject (obj) {
      let mig = (val) => { return `${val}%` }
      return {
        left: mig(obj.x),
        top: mig(obj.y),
        width: mig(obj.w),
        height: mig(obj.h)
      }
    },
    isObjectEmpty (obj) {
      return !Object.values(obj).some(x => x > 0)
    },
    setImageSize () {
      let el = document.documentElement.querySelector('body')
      let style = window.getComputedStyle ? getComputedStyle(el, null) : el.currentStyle
      // padding은 빠진 넓이를 구함
      let paddingWidth = parseInt(style.paddingLeft) + parseInt(style.paddingRight)

      let pageContentWidth = el.clientWidth - paddingWidth
      // 검출 결과 이미지 사이즈 정의
      let baseSize = pageContentWidth / 2
      this.imageSize = {
        width: baseSize,
        height: baseSize * 0.7
      }
    }
  },
  mounted () {
    this.$nextTick(function () {
      window.addEventListener('resize', this.setImageSize)
      // init
      this.setImageSize()
    })
  }
});
```

#### css
```scss
body {
  padding: 1rem;
}
#app {
  position: relative;
  background-color: #eee;
  .image-wrapper img {
    width: 100%;
    height: 100%;
  }
  .rectangle-wrapper {
    position: absolute;
    left: 0;
    top: 0;
    .rectangle {
      position: absolute;
      border: solid 2px #FF1744;
    }
  }
}
```

#### 실행 결과
<p data-height="265" data-theme-id="0" data-slug-hash="mxJbyr" data-default-tab="js,result" data-user="gloriaJun" data-embed-version="2" data-pen-title="mxJbyr" class="codepen">See the Pen <a href="https://codepen.io/gloriaJun/pen/mxJbyr/">mxJbyr</a> by gloria (<a href="https://codepen.io/gloriaJun">@gloriaJun</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

## Reference
- [Getting width and height of an element]( https://plainjs.com/javascript/styles/getting-width-and-height-of-an-element-23/)
