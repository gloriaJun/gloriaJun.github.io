---
layout: post
title: "(Webpack) webpack Trouble Shooting"
date: 2018-12-06 15:35:00
author: gloria
categories: devops
tags: javascript webpack configuration trouble-shooting
---

* TOC
{:toc}

## TypeError: Cannot read property 'bindings' of null
webpack 빌드 시에 아래와 같은 에러가 발생하였을 때에...
```bash
Module build failed (from ./node_modules/babel-loader/lib/index.js):
TypeError: Cannot read property 'bindings' of null
```

문제가 발생할 당시의 모듈 버전 
```
  "devDependencies": {
    "@babel/core": "^7.2.0",
    "babel-loader": "^8.0.4",
    "babel-preset-env": "^1.7.0",
    "webpack": "^4.27.1",
    "webpack-cli": "^3.1.2"
  }
```

`babel-preset-env`를 삭제하고 `@babel/preset-env`으로 다시 설치한 뒤에 webpack.config.js에서 preset 설정을 수정하였다.
```
// package.json
"@babel/core": "^7.2.0",
"@babel/preset-env": "^7.2.0",
"babel-loader": "^8.0.4",
```

```javascript
// webpack.config.json
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /(node_modules)/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env']
          },
        }
      }
    ],
  },
```
