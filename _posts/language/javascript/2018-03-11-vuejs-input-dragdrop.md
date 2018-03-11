---
layout: post
title: "(VueJs) Drag&Drop으로 이미지 파일 등록"
date: 2018-03-11 19:35:00
author: gloria
categories: language
tags: javascript frontend vuejs css
---

이미지 파일을 input text에 url을 입력하거나 drag&drop으로 입력하기

#### html
```html
<div id="app">
  <h4>Upload Image File</h4>
  <p>Input Image URL and Click the button or Drag and Drop or Attach an Image File</p>
  <div class="input-group">
    <input
       type="text"
       class="form-control"
       placeholder="Input Image URL or  Drag & Drop or Select"
       v-model="filename"
       @dragover.prevent
       @dragenter.prevent
       @drop.prevent="onDrop">
    <div class="input-group-append">
      <span class="input-group-text" @click="onClickFile"><i class="fa fa-paperclip">
        </i></span>
        <button
          class="btn btn-outline-info"
          @click="onClickUpload">Upload</button>
    </div>
    <input type=file class="file-input" accept="image/*" ref="fileInput" @change="onFileChange">
  </div>
  <div v-show="imageSrc" class="upload-image">
    <img :src="imageSrc">
  </div>
</div>
```

#### javascript
```javascript
var app = new Vue({
  el: '#app',
  data () {
      return {
        filename: '',
        imageSrc: ''
      }
  },
  methods: {
    onDrop (event) {
      this.inputImageFile(event.dataTransfer.files)
    },
    onClickFile(event) {
      this.$refs.fileInput.click()
    },
    onFileChange(event) {
      this.inputImageFile(event.target.files)
    },
    inputImageFile (files) {
      if (files.length) {
        let file = files[0]
        if (!/^image\//.test(file.type)) {
          alert('이미지 파일만 등록이 가능합니다')
          return false
        }
        this.filename = file.name
        this.preview(file)
      }
    },
    onClickUpload () {
      this.preview (this.filename)
    },
    preview (file) {
      if (typeof file === 'string') {
        this.imageSrc = file
      } else {
        let vm = this
        let reader = new FileReader()
        reader.onload = () => {
          vm.imageSrc = reader.result
        }
        reader.readAsDataURL(file)
      }
    }
  }
})
```

#### css
```scss
#app {
  width: 50%;
  padding: 2rem;

  .file-input {
    display: none;
  }
  .upload-image {
    padding-top: 1rem;
    width: 200px;
    height: 200px;
    img {
      width: 100%;
      height: 100%;
    }
  }
}
```

#### 실행 결과
<p data-height="265" data-theme-id="0" data-slug-hash="YaXqdQ" data-default-tab="html,result" data-user="gloriaJun" data-embed-version="2" data-pen-title="input drag&drop" class="codepen">See the Pen <a href="https://codepen.io/gloriaJun/pen/YaXqdQ/">input drag&drop</a> by gloria (<a href="https://codepen.io/gloriaJun">@gloriaJun</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>
