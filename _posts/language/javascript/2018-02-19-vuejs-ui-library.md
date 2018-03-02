---
layout: post
title: "(VueJs) UI Library"
date: 2018-02-19 20:55:00
author: gloria
categories: language
tags: javascript frontend vuejs
---

* TOC
{:toc}


## UI Library for VueJS
- [Vuetify](https://vuetifyjs.com/ko/)   
- [element](http://element.eleme.io/#/en-US)   


## UI Library 적용하기
#### Bootstrap
라이브러리 설치하기
```sh
npm install bootstrap --save
```

`main.js`에 해당 스타일 파일 import
```javascript
import '../node_modules/bootstrap/scss/bootstrap.scss';
```

#### Vuetify
vuetify에서 제공하는 [webpack](https://github.com/vuetifyjs/webpack)을 이용하여 프로젝트를 생성한다
```sh
vue init vuetifyjs/webpack project-name
```


## SASS/SCSS 설치
sass를 이용하고자 하면 다음의 패키지들을 설치해준다.
```
npm install sass-loader node-sass style-loader --save-dev  
```
