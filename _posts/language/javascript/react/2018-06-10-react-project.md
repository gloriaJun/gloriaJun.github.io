---
layout: post
title: "(React) react 프로젝트 만들기"
date: 2018-06-10 15:35:00
author: gloria
categories: language
tags: javascript frontend react
---

## create-react-app을 이용한 프로젝트 생성
```bash
$ create-react-app glria-ui
```

프로젝트의 webpack 설정 커스터마이징을 위해 내부 설정을 꺼내준다.
```bash
$ cd glria-ui
$ yarn eject
```

## 모듈 설치
#### sass 설치
프로젝트에서 Sass 를 사용하기 위하여 필요한 도구
```bash
sass-loader, node-sass
```

###### webpack 설정
**config/webpack.config.dev.js**   
```javascript
{
  test: /\.s?css$/, // modified
  use: [
    require.resolve('style-loader'),
    {
      loader: require.resolve('css-loader'),
      options: {
        importLoaders: 1,
      },
    },
    { // added
      loader: require.resolve('sass-loader')
    },
    {
      loader: require.resolve('postcss-loader'),
      options: {
        // Necessary for external CSS imports to work
        // https://github.com/facebookincubator/create-react-app/issues/2677
        ident: 'postcss',
        plugins: () => [
          require('postcss-flexbugs-fixes'),
          autoprefixer({
            browsers: [
              '>1%',
              'last 4 versions',
              'Firefox ESR',
              'not ie < 9', // React doesn't support IE8 anyway
            ],
            flexbox: 'no-2009',
          }),
        ],
      },
    }
  ],
},
```

file-loader에서 scss 확장자는 처리하지 않도록 설정해준다.
```javascript
{
  exclude: [/\.(js|jsx|mjs)$/, /\.html$/, /\.json$/, /\.s?css$/],
  loader: require.resolve('file-loader'),
  options: {
    name: 'static/media/[name].[hash:8].[ext]',
  },
},
```

###### sass에서 공통으로 사용되는 유틸함수 호출 설정
sass 에서 공통적으로 사용되는 유틸 함수들을 필요할 때 `import ../../styles/utils` 형식으로 작성 할 필요 없이 `@import 'utils'` 형태로 불러 올 수 있게 해주는 설정을 추가해준다.
```javascript
{ // added
  loader: require.resolve('sass-loader'),
  options: {
   includePaths: [paths.styles]
  }
},
```

`paths.styles` 값 설정을 위해 ` config.paths.js`을 열어 수정해준다.
```javascript
// config after eject: we're in ./config/
module.exports = {
  // (...중략...)
  servedPath: getServedPath(resolveApp('package.json')),
  styles: resolveApp('src/styles')
};
```

###### css-loader 의 options에서 CSS Module 을 사용하도록 설정
```javascript
{
  loader: require.resolve('css-loader'),
  options: {
    importLoaders: 1,
    modules: true,
    localIdentName: '[name]__[local]__[hash:base64:5]'
  },
},
```

#### style 관련 모듈 설치
style 관련 모듈을 추가로 설치한다.
```bash
$ yarn add --dev classnames include-media open-color
```
- [classnames](https://github.com/JedWatson/classnames): CSS Module 과 조건부 className 을 설정 하는 것을 도와주는 라이브러리
- [include-media](https://include-media.com/): 반응형 디자인 Sass 라이브러리
- [open-color](https://yeun.github.io/open-color/): 색상 팔레트를 위한 Sass 라이브러리
