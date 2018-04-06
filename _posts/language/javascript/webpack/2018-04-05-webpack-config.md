---
layout: post
title: "(Webpack) webpack configuration"
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


## Reference
