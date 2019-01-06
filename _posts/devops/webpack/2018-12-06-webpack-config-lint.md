---
layout: post
title: "(Webpack) webpack을 이용한 개발 환경 구성하기 - lint 설정"
date: 2018-12-06 15:35:00
author: gloria
categories: devops
tags: javascript webpack configuration babel
---

* TOC
{:toc}

아래의 글들에 이어서 이번에는 webpack 빌드 시에 lint를 포함하도록 설정을 추가하였다.
- [(Webpack) webpack]({% post_url language/2018-12-06-webpack-config %})
- [(Webpack) webpack을 이용한 개발 환경 구성하기 - babel 설정]({% post_url language/2018-12-06-webpack-config-babel %})


## ESLint 설정

> 참고로 *ESLint 설정 및 간단한 추가적인 내용*은 [(Javascript) Lint 설정하기]({% post_url language/2018-12-05-javascript-lint %})을 확인해보면 된다.

```bash
yarn add -D eslint eslint-loader eslint-config-airbnb-base eslint-plugin-import
```

## webpack.config.js
```javascript
  module: {
    rules: [
      {
        enforce: "pre",
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'eslint-loader',
      },
      // 중략...
    ],
  },
```

## Reference
- [webpack-contrib/eslint-loader](https://github.com/webpack-contrib/eslint-loader)
