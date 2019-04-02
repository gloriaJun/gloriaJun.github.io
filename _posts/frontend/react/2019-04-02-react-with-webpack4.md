---
layout: post
title: "(React) webpack4를 이용하여 react app 구성하기"
date: 2019-04-02 22:35:00
author: gloria
categories: frontend
tags: javascript frontend react webpack
---

* TOC
{:toc}

> Written based on React v16.8.4

# Create React App with webpack step by step

`create-react-app`를 이용하지 않고 webpack4를 이용하여 React App 프로젝트를 생성하고 빌드 환경을 구축한다.

## Create Project

프로젝트 폴더를 생성한 뒤에 `package.json`을 생성한다.
```bash
mkdir webpack-for-react
yarn init -y
```

## Setting up Webpack & React

webpack과 react를 설치하고, 실행 스크립트를 정의한다.

```bash
yarn add -D webpack webpack-cli webpack-dev-server
yarn add react react-dom 
```

- package.json
```json
  "scripts": {
    "start": "webpack-dev-server --mode development",
    "build": "webpack --mode production"
  },
```

#### Create Example Source

- public/index.html
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>React App</title>
</head>
<body>
    <div id="app"></div>
</body>
</html>
```

- src/App.js
```javascript
import React from 'react';

export default class App extends React.Component {
  render() {
    return (
      <div>
        Hello, React!!!
      </div>
    )
  }
}
```

- scr/index.js
```javascript
import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';

ReactDOM.render(<App />, document.getElementById('app'));
```

## Setting up Babel

babel을 설정하고, webpack config 파일에 기본 설정을 해준다.

```bash
yarn add -D @babel/core @babel/preset-env babel-loader @babel/preset-react
```

- babel.config.js
```javascript
// babel.config.js
module.exports = function (api) {
  api.cache(true);

  return {
    presets: [
      "@babel/preset-env",
      "@babel/preset-react",
    ]
  }
}
```

- webpack.config.js
```javascript
// webpack.config.js
const path = require('path');

function resolve(dir) {
  return path.resolve(__dirname, dir);
}

module.exports = {
  entry: {
    main: resolve('src/index.js'),
  },
  output: {
    path: __dirname + '/dist',
    publicPath: '/',
    filename: 'bundle.[hash].js',
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        include: resolve('src'),
        use: {
          loader: "babel-loader"
        }
      }
    ]
  }
}
```

## Create `index.html` with html-webpack-plugin
`public/index.html` 파일을 `dist/index.html`로 복사 및 번들링된 css, js 파일들을 inject 해준다.

```bash
yarn add -D html-webpack-plugin
```

- webpack.config.js
```javascript
const HtmlWebpackPlugin = require('html-webpack-plugin');

// ... 중략

module.exports = {
  // ... 중략
  plugins: [
    new HtmlWebpackPlugin({
      template: resolve('public/index.html'),
      filename: './index.html',
    }),
  ]
};
```

## Setting up Style

style 파일 관련 모듈을 설치하고 webpack 설정 파일을 수정한다.

```bash
yarn add -D css-loader sass-loader style-loader node-sass
```

- `webpack.config.js`에 아래와 같은 설정을 추가해준다.
```javascript
{
  test: /\.s?css$/,
  use: [
    {
      loader: 'style-loader'
    },
    {
      loader: 'css-loader',
      options: {
        modules: true,
        camelCase: true,
        sourceMap: true
      }
    },
    {
      loader: 'sass-loader',
      options: {
        sourceMap: true
      }
    },
  ],
},
```

## 기타 Webpack 설정

### devtool

소스맵을 생성해서 어플리케이션 디버깅을 도와준다.
inline-source-map은 은 개발시에만 사용된다.

```javascript
module.exports = {
  ...
  devtool: 'inline-source-map',
};
```

### 개발서버 설정

```javascript
devServer: {
  host: 'localhost',
  // port: port, // default port is 3000
  historyApiFallback: true,
  open: true
}
```

### react-hot-loader

파일이 변경되면 페이지 전체를 리로드하지 않고, 변경된 부분만 적용하여 리로드한다.

```bash
 yarn add -D react-hot-loader
```

- babel.config.js
```javascript
plugins: [
  "react-hot-loader/babel",
],
```

- webpack.config.js
```javascript
const webpack = require('webpack');

// ...중략

  plugins: [
    // ...중략
    new webpack.HotModuleReplacementPlugin()
  ],
  devServer: {
    // ...중략
    hot: true,
  }
```

- src/index.js
```javascript
import React from 'react';
import ReactDOM from 'react-dom';
import { AppContainer } from "react-hot-loader";
import App from 'components/App';

const render = Component =>
  ReactDOM.render(
    <AppContainer>
      <Component/>
    </AppContainer>,
    document.getElementById('app')
  );

render(App);

if (module.hot) {
  module.hot.accept('components/App', () => render(App));
}
```

## mode에 따라 빌드 파일 분리하기

> 해당 설정된 webpack 파일은 [Github](https://github.com/gloriaJun/webpack-for-react) 에서 확인.

공통으로 사용되는 부분에 대해 정의한 뒤 merge 하기 위해 아래의 모듈을 설치한다.

```bash
yarn add -D webpack-merge
```

공통 부분을 추출 및 빌드 파일 분리를 위해 아래와 같이 파일을 생성한다.
```bash
mkdir build
cd build
touch config.js
touch webpack.base.conf.js
touch webpack.dev.conf.js
touch webpack.prod.conf.js
```

### 배포 빌드 설정하기

#### CSS파일 단일 파일로 추출하기

[GitHub - webpack-contrib/extract-text-webpack-plugin](https://github.com/webpack-contrib/extract-text-webpack-plugin)을 이용하여 css 파일을 js파일에 포함시키지 않고 별도의 하나의 css파일로 생성한다.

```bash
yarn add -D extract-text-webpack-plugin@next 
```

- webpack.prod.conf.js
```javascript
// 중략...
const ExtractTextPlugin = require('extract-text-webpack-plugin');

// 중략...
  module: {
    rules: [
      // 중략...
      {
        test: /\.s?css$/,
        use: ExtractTextPlugin.extract({
            fallback: 'style-loader',
          use: [
            {
              loader: 'css-loader',
              options: {
                modules: true,
                importLoaders: 1,
                camelCase: true,
                sourceMap: true
              }
            },
            {
              loader: 'sass-loader',
              options: {
                sourceMap: true
              }
            },
          ],
        }),
      },
    ]
  },
  plugins: [
    // 중략...
    new ExtractTextPlugin({
      filename: 'styles/styles.[hash].css',
      allChunks: true
    }),
  ],
};

```

#### postcss-loader

css-loader 전에 css 파일을 압축(minify)하고 CSS 룰을 적용하고 자동 전처리(autoprefixer)를 실행하기 위해 postCSS를 적용한다.

```bash
yarn add -D postcss-loader autoprefixer
```

- postcss.config.js
```javascript
module.exports = {
  plugins: [require('autoprefixer')]
};
```

### 빌드 스크립트 수정

빌드 환경 설정과 빌드전 이전에 빌드된 산출물을 삭제하기 위해 `cross-env`, `rimrf` 모듈을 추가로 설치해준다.
```bash
yarn add -D cross-env rimraf
```

빌드 스크립트를 아래와 같이 수정해준다.
```
// package.json
"scripts": {
    "start": "webpack-dev-server --config build/webpack.dev.conf.js",
    "prebuild": "rimraf dist",
    "build": "cross-env NODE_ENV=production webpack -p --config build/webpack.prod.conf.js"
},
```

## Reference

- [[번역] 깊이 있는 리액트 개발 환경 구축하기](https://sujinlee.me/webpack-react-tutorial/)
