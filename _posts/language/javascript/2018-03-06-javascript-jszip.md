---
layout: post
title: "(Javascript) jsZip - 파일 압축하기"
date: 2018-03-06 14:35:00
author: gloria
categories: language
tags: javascript zip
---

javascript에서 이미지나 텍스트 파일을 압축하고자 하는 경우에 [jsZip](https://stuk.github.io/jszip/) 라이브러리를 활용한다.

**Inatall**
```bash
npm install jszip
```

아래는 이미지 파일을 zip으로 압축하는 예제이다
**예제 코드**
```javascript
/**
 * 전달받은 이미지를 zip 파일로 압축한다
 * @param imageInfo {
 * @returns {Promise<any>}
 */
function generateImageZip (imageInfo) {
  let zip = new JSZip()
  const re = /data:image\/(gif|jpg|jpeg|tiff|png);base64,/i

  return new Promise((resolve, reject) => {
    // 압축할 파일을 추가한다
    zip.file(imageInfo.name, imageInfo.uri.replace(re, ''), {base64: true})
    // blob 형태의 압축파일을 생성한다
    zip.generateAsync({type: 'blob'})
      .then(resolve)
  })
}

let imageInfo = {
  name: 'image.jpg',
  // base64 encode string
  uri: 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABA'
}
generateImageZip(imageInfo)
  .then(res => {
    console.log(res)
  })
```

#### 압축한 파일을 다운로드 하기
압축된 파일을 로컬에 다운하고자 하면...[FileSaver](https://github.com/eligrey/FileSaver.js/) 라이브러리를 이용한다

**Inatall**
```bash
npm install file-saver --save
```

**예제 코드**
```javascript
import FileSaver from 'file-saver'

generateImageZip(imageInfo)
  .then(res => {
    FileSaver.saveAs(res, 'test.zip')
  })
```

#### 압축한 파일을 formData에 담아서 업로드하기
```javascript
generateImageZip(imageInfo)
  .then(res => {
    let formData = new FormData()
    formData.append('image_set_file_name', zip)

    let config = {
      headers: {'Content-Type': 'multipart/form-data'}
    }  
    axios.post('/upload-images', formData, config)
      .then(resolve)
  })
```
