---
layout: post
title: "(VueJS) 개발 환경 구성"
date: 2018-03-19 22:35:00
author: gloria
categories: frontend
tags: javascript vuejs nuxt vuex bootstrap
---

* TOC
{:toc}

Nuxt.js를 이용하여 기존에 SPA로 구현한 코드를 SSR로 리팩토링을 하고 있다.
static page로 generate 해주는 기능도 있어 공부삼아 리팩토링 중~~

## Project 생성
원하는 구성의 [Starter Template](https://github.com/nuxt-community/awesome-nuxt#starter-template)을 사용해서 프로젝트를 생성한다.
또는 [Nuxt 가이드](https://ko.nuxtjs.org/guide/installation)에서 제공하는 starter 템플릿을 이용하여 간단하게 생성해도 된다.

## 플러그인 설치
플러그인 정의를 위한 Nuxt의 가이드 내용은 [플러그인](https://ko.nuxtjs.org/guide/plugins)을 참고한다.

#### bootstrap-vue
[bootstrap-vue](https://bootstrap-vue.js.org/docs) 패키지를 설치한다.
```bash
npm i bootstrap-vue --save
npm i node-sass sass-loader --save-dev
```
플러그인을 import 하기 위한 `plugins/bootstrap-vue.js` 파일을 생성한다.
```javascript
// plugins/bootstrap-vue.js
import Vue from 'vue'
import BootstrapVue from 'bootstrap-vue'

Vue.use(BootstrapVue)
```

사용자 style 커스텀을 위한 `assets/style/app.scss`를 생성한다.
```scss
@import '~bootstrap/scss/bootstrap.scss';
```

`nuxt.config.js`에 플러그인와 css 파일에 대한 정의를 추가한다.
```javascript
// nuxt.config.js
plugins: [
    '~/plugins/bootstrap-vue.js'
],
css: [
  {src: '~/assets/style/app.scss', lang: 'scss'},
  {src: 'bootstrap-vue/dist/bootstrap-vue.css', lang: 'css'}
]
```

## 장단점
보름 정도 사용해보고 느낀 내 생각은...경험이 부족해서 느낄 수도 있지만..
**장점**    
- webpack의 자질구레한 설정들이 간편해졌다
- 빠르게 개발을 위한 환경을 구성할 수 있다.

**단점**    
- webpack관련 설정들(예를 들어 proxy..)을 커스터마이징하려고 할 때 관련된 정보를 얻기가 쉽지 않다.
- 빌드 및 배포 설정 관련하여 개발 중 문제가 발생했을 때 구글링해서 관련 정보를 찾기 어려운 경우가 많다.


## Reference
- [Awesome Nuxt.js ](https://github.com/nuxt-community/awesome-nuxt#starter-template)
