---
layout: post
title: "(Webpack) webpack을 이용한 개발 환경 구성하기"
date: 2018-12-06 10:35:00
author: gloria
categories: language
tags: javascript webpack configuration
---

* TOC
{:toc}

> Webpack은 자바스크립트 모듈화 도구이다.

웹펙에서의 컴파일은 entry 파일을 기점으로 하여 의존 관계에 잇는 모듈을 엮어서 하나의 번들 파일로 만드는 작업을 말한다.


## webpack 설치
webpack4를 기준으로 아래의 두 가지 모듈을 설치해야한다.
```bash
yarn add -D webpack webpack-cli
```

#### webpack 테스트
간단하게 webpack의 동작을 테스트하기 위해서 `package.json`에 아래와 같이 실행 스크립트를 정의한다.
```
"scripts": {
"build": "webpack --mode development src/index.js"
},
```

#### 테스트를 위한 모듈 작성
`src` 디렉토리를 생성한 뒤에 하위에 아래의 스크립트를 작성한다.

###### utils.js
```javascript
function map(list, predicate) {
  let result;

  if (Array.isArray(list)) {
    result = [];
    const len = list.length;
    for (let i = 0; i < len; i += 1) {
      result[i] = predicate(list[i], i, list);
    }
  } else {
    result = {};
    const keys = Object.keys(list);
    const len = keys.length;
    for (let i = 0; i < len; i += 1) {
      result[i] = predicate(list[keys[i]], keys[i], list);
    }
  }

  return result;
}

export default map;
```

###### index.js
```javascript
import map from './utils';

console.log(map([1, 2, 3, 4, 5], item => item + 10));
```

#### 빌드 수행
`webpack --mode development src/index.js`를 수행하면 `dist/main.js`에 빌드가 수행된 산출물이 생성된다.

> `dist/main.js`는 기본 빌드 산출물 경로와 파일명이다.

생성된 산출물인 `main.js` 스크립트를 수행하면 아래와 같이 확인할 수 있다.
```bash
<프로젝트 경로>/dist/main.js
[ 11, 12, 13, 14, 15 ]

Process finished with exit code 0
```

## webpack.config.js
기본으로 설정된 값들을 커스터마이징을 하기 위한 설정 파일이다.

```javascript
const path = require('path');

module.exports = {
  mode: 'development',
  entry: {
    index: path.resolve(__dirname, 'src', 'index.js'),
  },
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: '[name].bundle.js'
  },
};
```

script를 아래와 같이 수정한다. 
```
"scripts": {
"build": "webpack --config webpack.config.js"
},
```


## Reference
- [JavaScript 모듈화 도구, webpack](https://d2.naver.com/helloworld/0239818)
- [Webpack-Getting Started](https://webpack.js.org/guides/getting-started/#basic-setup)
- [webpack4로 바꾸기](https://showerbugs.github.io/2018-02-26/webpack4%EB%A1%9C-%EB%B0%94%EA%BE%B8%EA%B8%B0)
- [요즘 잘나가는 프론트엔드 개발 환경 만들기(2018): Webpack 4](https://meetup.toast.com/posts/153)
- [요즘 잘나가는 프론트엔드 개발환경 만들기(2018): ES6](https://meetup.toast.com/posts/157 )
