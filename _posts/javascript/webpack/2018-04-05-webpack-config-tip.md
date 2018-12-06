---
layout: post
title: "(Webpack) Tip - webpack configuration"
date: 2018-04-05 13:35:00
author: gloria
categories: language
tags: javascript webpack
---

* TOC
{:toc}

webpack의 설정파일 정의를 위한 내용들 정리

## FriendlyErrorsWebpackPlugin
[Friendly-errors-webpack-plugin](https://github.com/geowarin/friendly-errors-webpack-plugin)을 적용하면 깔끔한 빌드 로그와 에러를 확인할 수 있다

**Install**   
```bash
npm install friendly-errors-webpack-plugin --save-dev
```

#### Basic Usage
```javascript
const FriendlyErrorsWebpackPlugin = require('friendly-errors-webpack-plugin');

var webpackConfig = {
  // ...
  plugins: [
    new FriendlyErrorsWebpackPlugin(),
  ],
  // ...
}
```

**적용 전**     
```bash
$ npm run dev

> webpack-4-vuejs@1.0.0 dev /Volumes/data/private/vuejs-webpack4
> webpack-dev-server --progress --config build/webpack.dev.conf.js
```

**적용 후**    
```bash
$ npm run dev

> webpack-4-vuejs@1.0.0 dev /Volumes/data/private/vuejs-webpack4
> webpack-dev-server --progress --config build/webpack.dev.conf.js

 95% emitting CopyPlugin                       

 DONE  Compiled successfully in 6148ms    
```

#### 커스텀
빌드 시의 메시지와 에러 발생 시의 포맷팅을 커스텀을 하기 위해서는 아래와 같이 정의하면 된다

```javascript
new FriendlyErrorsWebpackPlugin({
  compilationSuccessInfo: {
    messages: [`You application is running here http://${HOST}:${PORT}`],
    notes: [`To create production build, use npm run build`]
  }
})
```

**적용 결과**   
```bash
DONE  Compiled successfully in 129ms

 I  You application is running here http://localhost:8080

 N  To create production build, use localhost         
```

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


## Reference
