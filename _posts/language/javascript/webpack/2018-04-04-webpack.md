---
layout: post
title: "(Webpack) webpack4를 이용하여 VueJS 프로젝트 생성하기"
date: 2018-04-04 23:35:00
author: gloria
categories: language
tags: javascript webpack vuejs
---

* TOC
{:toc}

webpack을 매번 템플릿으로 이용하다가 직접 프로젝트를 구성하며 webpack에 대해 공부해보기로 했다.

## webpack 기본 프로젝트 생성
```bash
mkdir study
cd study
npm init
```

**webpack 라이브러리 설치**     
webpack4 부터는 webpack-cli도 설치해주어야 한다.
```bash
npm install --save-dev webpack
npm install --save-dev webpack-cli
```

#### package.json과 webpack config 설정
webpack4 에서는 `mode`라는 옵션이 추가되고, 각각 `development`와 `production`을 지원한다.
`package.json`에 아래와 같이 스크립트를 정의해준다.
```json
"scripts": {
  "dev": "webpack --mode development",
  "build": "webpack --mode production"
},
```

또는 아래와 같이 스크립트 파일을 분리하여 사용하도록 정의할 수 있다.
```json
"scripts": {
  "dev": "webpack --config build/webpack.dev.conf.js",
  "build": "webpack --config build/webpack.prod.conf.js"
},
```

webpack 설정을 merge하기 위해 `webpack-merge`를 설치한다.
```bash
npm install --save-dev webpack-merge
```

다음과 같이 각 파일들을 구성하였다.
**build/webpack.base.conf.js**    
```javascript
'use strict'
const path = require('path')
const webpack = require('webpack')

const resolve = (dir) => path.join(__dirname, '..', dir)

module.exports = {
}
```

**build/webpack.dev.conf.js**    
```javascript
'use strict'
const path = require('path')
const webpack = require('webpack')
const baseWebpackConfig = require('./webpack.base.conf')

module.exports = merge(baseWebpackConfig, {
  mode: 'development'
})
```

**build/webpack.prod.conf.js**    
```javascript
'use strict'
const path = require('path')
const webpack = require('webpack')
const baseWebpackConfig = require('./webpack.base.conf')

module.exports = merge(baseWebpackConfig, {
  mode: 'production',
})
```


## VueJS 설정
최근 VueJS를 관심을 가지고 공부 중이어서 vuejs를 이용하여 프로젝트를 구성하였음.
```bash
npm install --save vue
npm install --save-dev vue-loader vue-template-compiler css-loader
```

#### webpack config 설정
```javascript
// webpack.base.config.js
module.exports = {
  context: resolve('/'),
  entry: {
    app: './src/main.js'
  },
  module: {
    rules: [
      {
        test: /\.vue$/,
        loader: 'vue-loader'
      }
    ]
  }
}
```

간단한 템플릿 파일을 작성한 후에 `npm run dev`를 수행한 후에 `index.html`을 웹브라우저에서 열여보면 정상적으로 렌더링 되는 것을 확인할 수 있다.

## webpack-dev-server 설정
개발한 내용을 브라우저에서 바로 리로딩하여 확인하기 위해 `webpack-dev-server`과 `html-webpack-plugin`를 설치한다.
```bash
npm install --save-dev webpack-dev-server html-webpack-plugin
```

설치한 뒤에 `dev`의 경우에는 `webpack-dev-server`를 이용하도록 수정한다.
```json
"dev": "webpack-dev-server --config build/webpack.dev.conf.js",
```

webpack 설정에 아래와 같이 추가해준다.
`HotModuleReplacementPlugin`은 화면을 refresh 하지 않고 페이지를 로딩하기 위한 플러그인이다.
```javascript
// webpack.dev.conf.js
const HtmlWebpackPlugin = require('html-webpack-plugin')

module.exports = {
  (...SKIP...)
  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new HtmlWebpackPlugin({
      template: 'index.html',
      filename: 'index.html',
      inject: true
    })
  ]
  (...SKIP...)
}
```

다시 `npm run dev`를 수행한 뒤에 `http://localhost:8080/`에 접속하면 정상적으로 동작하는 것을 확인할 수 있다.


## style 설정
style 파일을 적용하기 위한 설정이다.
```bash
npm install --save-dev css-loader style-loader
```

아래는 stylus를 사용하는 경우에 추가로 설치해줘야하는 부분이다.
```bash
npm install --save-dev stylus stylus-loader
```

webpack config를 설정해준다.
```javascript
// webpack.dev.conf.js
{
  test: /\.css$/,
  loaders: [ 'style-loader', 'css-loader' ]
},
{
  test: /\.styl$/,
  loaders: [ 'style-loader', 'css-loader', 'stylus-loader' ]
}
```


## Babel 설정
자바스크립트 트랜스파일러 이다.
```bash
npm install --save-dev babel-core babel-loader babel-preset-env babel-preset-stage-2
```

**.babelrc**    
babel 설정 파일을 정의한다.
```json
{
	"presets": [
		["env", {
			"modules": false,
			"targets": {
				"browsers": ["> 1%", "last 2 versions", "not ie <= 8"]
			}
		}],
		"stage-2"
	],
	"env": {
		"test": {
			"presets": ["env", "stage-2"]
		}
	}
}

```

**webpack.config.base.js**    
webpack 설정 파일을 생성한다.
```javascript
{
   test: /\.js$/,
   exclude: /node-modules/,
   loader: 'babel-loader'
}
```

## static asset 설정
static assets에 정의된 파일들을 dist 로 복사해주기 위한 플러그인을 설정한다.
```bash
npm install --save-dev copy-webpack-plugin
```

> 생성된 템플릿의 최종본은 [gloriaJun/vuejs-prototype-webpack4](https://github.com/gloriaJun/vuejs-webpack4)에서 확인할 수 있다.


## Reference
- [Vue.js and Webpack 4 From Scratch, Part 1](https://itnext.io/vuejs-and-webpack-4-from-scratch-part-1-94c9c28a534a)
- [Vue.js and Webpack 4 From Scratch, Part 2](https://itnext.io/vue-js-and-webpack-4-from-scratch-part-2-5038cc9deffb)
- [Vue.js and Webpack 4 From Scratch, Part 3](https://itnext.io/vue-js-and-webpack-4-from-scratch-part-3-3f68d2a3c127)
- [Webpack 4 Tutorial: from 0 Conf to Production Mode](https://www.valentinog.com/blog/webpack-4-tutorial/)
- [Moving from Webpack 3 to Webpack 4](https://thebrainfiles.wearebrain.com/moving-from-webpack-3-to-webpack-4-f8cdacd290f9)
- [webpack 4: mode and optimization](https://medium.com/webpack/webpack-4-mode-and-optimization-5423a6bc597a)
