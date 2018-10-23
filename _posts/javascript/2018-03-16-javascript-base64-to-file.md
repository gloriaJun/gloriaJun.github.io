---
layout: post
title: "(Javascript) base64로 인코딩된 이미지를 file object로 변환하기"
date: 2018-03-16 13:35:00
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
    const re = new RegExp('.(gif|jpg|jpeg|tiff|png|ico)$', 'i')      
    let name = (/[^(/|\\)]*$/).exec(url)[0]
    let type = re.test(name) ? re.exec(name)[0].replace('.', '') : 'jpg'

    return new Promise((resolve, reject) => {
      let image = new Image()

      image.onload = function (event) {
        let canvas = document.createElement('canvas')
        // draw canvas
        canvas.width = image.naturalWidth
        canvas.height = image.naturalHeight
        canvas.getContext('2d').drawImage(image, 0, 0)

        let dataUrl = canvas.toDataURL('image/' + type)
        resolve({
          name: name,
          type: type,
          dataUrl: dataUrl.split(',')[1]
        })
      }
      image.onerror = function () {
        let msg = `"${file}"을 로딩하는 데 오류가 발생하였습니다. 이미지 파일을 확인해주세요.`
        alert(msg)
        console.error(msg)
      }
      image.crossOrigin = 'anonymous';
      image.src = url
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
