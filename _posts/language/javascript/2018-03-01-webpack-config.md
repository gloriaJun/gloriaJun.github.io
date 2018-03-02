---
layout: post
title: "(Webpack) 설정 모음"
date: 2018-03-01 11:32:00
author: gloria
categories: language
tags: javascript frontend webpack
---

## import 시에 '@'으로 경로 표시하기
스크립트 파일 내에서 '@'으로 경로를 표시하고자 할 때에...
```javascript
import '@/assets/style/style.scss'
```

해당 '@' 표시를 빌드 시에 치환을 해주기 위해서는 `webpack.config.js`
즉, webpack 설정 파일에 아래와 같은 형태로 경로를 치환해줄 수 있게 설정을 해주어야 한다.
```javascript
resolve: {
   alias: {
     'vue$': 'vue/dist/vue.esm.js',
     '@': path.join(__dirname, 'src')
   },
   extensions: ['*', '.js', '.vue', '.json']
 },
```

## css 단일 파일로 추출하기
https://vue-loader.vuejs.org/kr/configurations/extract-css.html

```sh
npm install extract-text-webpack-plugin --save-dev
```

```javascript
// webpack.config.js
var ExtractTextPlugin = require("extract-text-webpack-plugin")

module.exports = {
  // other options...
  module: {
    rules: [
      {
        test: /\.vue$/,
        loader: 'vue-loader',
        options: {
          extractCSS: true
        }
      }
    ]
  },
  plugins: [
    new ExtractTextPlugin("style.css")
  ]
}
```
