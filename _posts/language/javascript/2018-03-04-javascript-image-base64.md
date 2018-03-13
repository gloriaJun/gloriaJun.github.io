---
layout: post
title: "(Javascript) 이미지 파일 base64 인코딩/디코딩"
date: 2018-03-04 16:35:00
author: gloria
categories: language
tags: javascript base64 image
---

#### image file을 base64로 인코딩
input tag를 통하여 입력받은 이미지 파일을 base64로 인코딩
```javascript
function encodeBase64ImageFile (image) {
  return new Promise((resolve, reject) => {
    let reader = new FileReader()
    // convert the file to base64 text
    reader.readAsDataURL(image)
    // on reader load somthing...
    reader.onload = (event) => {
      resolve(event.target.result)
    }
    reader.onerror = (error) => {
      reject(error)
    }
  })
}
```

**예제**   
```html
<input
  type="file"
  accept="image/*"
  @change="onFileChange">
```
```javascript
onFileChange (event) {
  let fileList = event.target.files
  if (file    onClickImage (event) {
      utils.encodeBase64ImageTagviaCanvas(event.currentTarget.src)
        .then(data => {
          console.log(data)
        })
    }List.length) {
    // 한 번에 하나의 파일만 선택하여 업로드 할 수 있으므로 무조건 0번 index
    let file = fileList[0]
    if (!/^image\//.test(file.type)) {
      alert('이미지 파일만 등록이 가능합니다')
      return false
    }
    // encode image file to base64
    encodeBase64ImageFile(file)
      .then((data) => {
        console.log(data)
      })
  }
},
```

#### image url을 이용하여 base64로 인코딩
image url을 읽어서 base64로 인코딩하는 방법은 두 가지가 있다

###### Canvas
```javascript
function encodeBase64ImageTagviaCanvas (url) {
  return new Promise((resolve, reject) => {
    let image = new Image()
    image.onload = () => {
      let canvas = document.createElement('canvas')
      // or 'width' if you want a special/scaled size
      canvas.width = image.naturalWidth
      // or 'height' if you want a special/scaled size
      canvas.height = image.naturalHeight
      canvas.getContext('2d').drawImage(image, 0, 0)

      let uri = canvas.toDataURL('image/png')
      resolve(uri)
    }
    image.src = url
  })
}
```

###### FileReader
```javascript
function encodeBase64ImageTagviaFileReader (url) {
  return new Promise((resolve, reject) => {
    let xhr = new XMLHttpRequest()
    xhr.onload = () => {
      let reader = new FileReader()
      reader.onloadend = function () {
        resolve(reader.result)
      }
      reader.readAsDataURL(xhr.response)
    }
    xhr.open('GET', url)
    xhr.responseType = 'blob'
    xhr.send()
  })
}
```

**예제**
```html
<img
  src="http://upload.wikimedia.org/wikipedia/commons/4/4a/Logo_2013_Google.png"
  @click="onClickImage">
```
```javascript
onClickImage (event) {
  encodeBase64ImageTagviaCanvas(event.currentTarget.src)
    .then(data => {
      console.log(data)

    })
}
```

#### image file 또는 url을 입력받아서 base64 인코딩
file 또는 url 두 가지 방식 모두 사용 가능한 메소드
```javascript
function imageEncodeToBase64 (file, maxWidth, maxHeight) {
  let src = ''

  // 전달된 이미지 파일의 객체 타입에 따라서 호출할 메소드 선택 및 파일 타입 추출
  if (typeof file === 'string') {
    src = file
  } else {
    src = URL.createObjectURL(file)
  }

  return new Promise((resolve, reject) => {
    let image = new Image()
    image.onload = function (event) {
      let canvas = document.createElement('canvas')

      // set image size
      canvas.width = (image.naturalWidth > maxWidth) ? maxWidth : image.naturalWidth
      canvas.height = (image.naturalWidth > maxHeight) ? maxHeight : image.naturalHeight

      // draw canvas
      canvas.getContext('2d').drawImage(image, 0, 0, image.width, image.height)
      resolve(canvas)
    }
    image.src = src
  })
}
```

## Reference
- http://jsfiddle.net/handtrix/YvQ5y/
