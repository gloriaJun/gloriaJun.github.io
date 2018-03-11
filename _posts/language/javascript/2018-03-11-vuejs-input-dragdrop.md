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
  <div class="input-group">
    <input
           type="text"
           class="form-control"
           placeholder="Input Image URL or Image File Drag & Drop or Select"
           v-model="filename"
           @dragover.prevent
           @dragenter.prevent
           @drop.prevent="onDrop">
    <div class="input-group-append">
      <span class="input-group-text" @click="onClickFile"><i class="fa fa-paperclip">
        </i></span>
        <button
                class="btn btn-outline-info"
                @click="onClickUpload">URL Image Upload</button>
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
        this.previewFromFile(file)
      }
    },
    onClickUpload () {
      let vm = this
      let xhr = new XMLHttpRequest()
      xhr.onload = () => {
        let reader = new FileReader()
        // on reader load somthing...
        reader.onload = () => {
          vm.imageSrc = reader.result
        }
        // convert the file to base64 text
        reader.readAsDataURL(xhr.response)
      }
      xhr.open('GET', this.filename)
      xhr.onreadystatechange = function (event) {  
        if (xhr.readyState === 4) {  
          if (xhr.status !== 200) {  
            console.log('Error')
            alert('please check image url')
          }  
        }
      }
      xhr.responseType = 'blob'
      xhr.send()
    },
    previewFromFile (file) {
      let vm = this
      let reader = new FileReader()
      reader.onload = () => {
        vm.imageSrc = reader.result
      }
      reader.readAsDataURL(file)
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
