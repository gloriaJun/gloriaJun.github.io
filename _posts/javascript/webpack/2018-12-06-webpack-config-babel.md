---
layout: post
title: "(Webpack) webpack을 이용한 개발 환경 구성하기 - babel 설정"
date: 2018-12-06 15:35:00
author: gloria
categories: language
tags: javascript webpack configuration babel
---

* TOC
{:toc}

[(Webpack) webpack을 이용한 개발 환경 구성하기]({% post_url language/2018-12-06-webpack-config %})에서 정리한 내용 글에 이어서 webpack을 이용한 기본적인 빌드 설정을 추가하는 과정에 대해서 정리하기.

## babel 설정
ES6 이상으로 작성된 자바스크립트를 ES5 버전으로 변환하기 위한 babel 설정을 추가해준다.

> 참고로 *babel 설정 및 변환 결과에 대한 내용*은 [(Javascript) Babel 설정하기]({% post_url language/2018-12-06-javascript-babel %})을 확인해보면 된다.

####  babel 모듈 설치
```bash
yarn add -D babel-loader @babel/core @babel/preset-env
```
- babel-loader : webpack이 자바스크립트파일들에 대하여 babel을 실행하도록 한다.
- babel-core : babel이 실제로 동작하는 코드
- babel-preset-env : babel이 동작할 때의 지원범위를 지정

#### webpack.config.js
webpack 빌드 시에 babel을 포함시켜 빌드하도록 설정을 추가한다.
```javascript
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


## Trouble Shooting
#### TypeError: Cannot read property 'bindings' of null
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
