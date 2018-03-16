---
layout: post
title: "(Javascript) base64로 인코딩된 이미지를 file object로 변환하기"
date: 2018-03-13 13:35:00
author: gloria
categories: language
tags: javascript base64 image
---

base64로 인코딩된 이미지 파일을 file object로 변환하기 위해서는 먼저 blob으로 변환 후에 formData에 담아서 파일로 변환

```javascript
export default {
  /**
   * 전달받은 이미지를 base64로 인코딩한다
   * @param file - 이미지 파일 또는 이미지 URL
   * @param maxWidth - 인코딩 시의 이미지 max width 사이즈
   * @returns {Promise<any>}
   */
  encode (file, maxWidth) {
    let src, name, type

    // 전달된 이미지 파일의 객체 타입에 따른 파일 추출
    if (typeof file === 'string') {
      const re = new RegExp('.(gif|jpg|jpeg|tiff|png|ico)$', 'i')
      src = file
      name = (/[^(/|\\)]*$/).exec(file)[0]
      type = re.test(name) ? re.exec(name) : 'jpg'
    } else {
      src = URL.createObjectURL(file)
      name = file.name
      type = file.type.replace('image/', '')
    }

    return new Promise((resolve, reject) => {
      let image = new Image()
      image.onload = function (event) {
        let canvas = document.createElement('canvas')

        // set image size
        let width, height
        if (maxWidth === undefined || image.naturalWidth <= maxWidth) {
          width = image.naturalWidth
          height = image.naturalHeight
        } else {
          width = maxWidth
          height = image.naturalHeight * (maxWidth / image.naturalWidth)
        }
        // error check
        if (width + height === 0) {
          this.onerror()
          return false
        }

        // set image size
        canvas.width = width
        canvas.height = height
        // draw canvas
        canvas.getContext('2d').drawImage(image, 0, 0, width, height)

        resolve({
          name: name,
          type: type,
          width: canvas.width.toString(),
          height: canvas.height.toString(),
          dataUrl: canvas.toDataURL('image/' + type).split(',')[1]
        })
      }
      image.onerror = function () {
        let msg = `"${file}"을 로딩하는 데 오류가 발생하였습니다. 이미지 파일을 확인해주세요.`
        alert(msg)
        console.error(msg)
      }
      image.src = src
    })
  },
  /**
   * 이미지 url을 blob 파일로 변환하여 전달한다
   * @param url
   * @returns {Promise<any>}
   */
  toBlob (url) {
    return new Promise((resolve, reject) => {
      this.encode(url)
        .then(res => {
          let byteString = atob(res.dataUrl)
          let ab = new ArrayBuffer(byteString.length)
          let ia = new Uint8Array(ab)

          for (let i = 0; i < byteString.length; i++) {
            ia[i] = byteString.charCodeAt(i)
          }

          // write the array buffer to blob
          let blob = new Blob([ab], {type: 'image/' + res.type})

          let formData = new FormData()
          formData.append('file', blob, res.name)
          resolve(formData.get('file'))
        })
    })
  }
}
```

## 예제
<p data-height="265" data-theme-id="0" data-slug-hash="JLKpxm" data-default-tab="js,result" data-user="gloriaJun" data-embed-version="2" data-pen-title="image url to file" class="codepen">See the Pen <a href="https://codepen.io/gloriaJun/pen/JLKpxm/">image url to file</a> by gloria (<a href="https://codepen.io/gloriaJun">@gloriaJun</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>
