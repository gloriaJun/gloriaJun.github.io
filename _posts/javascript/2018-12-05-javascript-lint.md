---
layout: post
title: "(Javascript) Lint 설정하기"
date: 2018-12-05 10:15:00
author: gloria
categories: language
tags: javascript eslint lint configuration
---

* TOC
{:toc}

> ESLint = ES + Lint
> ESLint는 자바스크립트 문법 중에 에러가 있는 곳에 표시를 해주기 위한 도구이다.

자바스크립트 코드와 코딩스타일 점검을 위한 도구가 ESLint 외에도 JSHint, JSLint 등이 있지만, ESLint는 현재 다양한 플러그인과의 확장성으로 인하여 대표적인 코드스타일 점검을 위한 라이브러리로 사용되고 있다.


## ESLint 설치하기
```bash
yarn add -D eslint 
```

## eslintrc
`.eslintrc` 파일을 생성하여 아래와 같이 작성한다.
```
{
  "env": {
    "browser": true,
    "es6": true,
    "node": true
  },
  "extends": [],
  "rules": {
    "semi": [2, "always"]
  }
}
```

#### lint가 올바르게 설정된 것인지 확인해보기
위와 같이 설정한 뒤에 다음과 같이 함수를 생성하고 lint를 수행해보면 에러가 발생하는 것을 확인할 수 있다.
```javascript
function map(list, predicate) {
  console.log('ttt')
}
```

```bash
$ eslint .

/Volumes/data/private/javascript-fp/src/utils.js
  9:21  error  Missing semicolon  semi

✖ 1 problem (1 error, 0 warnings)
  1 error, 0 warnings potentially fixable with the `--fix` option.
```


## 코드스타일 라이브러리 적용하기
일일히 코딩 규칙을 만들어서 `rules`에 적용하기는 현실적으로 어렵다. 그리고 고맙게도 코드스타일이 어느정도 적용된 라이브러리를 설치하여 적용할 수 있다. (airbnb, javascript standard ....)
사람들이 많이 사용하거나 추천해주는 코드 스타일을 적용하고, 그 뒤에 `rules`에서 커스터마이징하여 사용하면 된다.

#### airbnb style guilde 설치
airbnb가 가장 널리 사용되는 코딩 컨벤션 도구이기도 해서 해당 플러그인을 설치해서 적용해보았다.
```bash
yarn add -D eslint-config-airbnb-base eslint-plugin-import
```

설치 후에 아래와 같이 설정파일을 수정한다.
```bash
{
  "env": {
    "browser": true,
    "es6": true,
    "node": true
  },
  "extends": "airbnb-base",
  "rules": {
  }
}
```


## Reference
- [PoiemaWeb-14.2 ESLint](https://poiemaweb.com/eslint)