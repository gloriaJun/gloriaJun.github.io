## VueJS prototyping
VueJS 프로젝트 시작 시에 공통으로 적용 가능한 기본 프로젝트 구조를 잡기 위한 과정들 정리
- 최대한 심플하게...


#### 프로젝트 생성하기
[webpack-simple](https://github.com/vuejs-templates/webpack-simple)을 이용하여 생성하기   
```
$ vue init webpack-simple my-project
$ cd my-project
$ npm install
$ npm run dev
```
- npm run dev: Webpack + vue-loader with proper config for source maps & hot-reload.
- npm run build: build with HTML/CSS/JS minification.

> **vue-loader**   
> webpack 에서 사용하는 Vue 컴포넌트 로더
> https://vue-loader.vuejs.org/kr/

###### 생성 후 기본 트리 구조
```
vuejs-prototype
├── README.md
├── index.html
├── package.json
├── src
│   ├── App.vue
│   ├── assets
│   │   └── logo.png
│   └── main.js
└── webpack.config.js
```

###### Vue-router 설치
vue-router를 설치한다.
```
npm install vue-router
```

router를 정의한다.
```javascript
// router/index.js
import Vue from 'vue'
import Router from 'vue-router'

import DefaultHome from '../components/DefaultHome'
import Sample from '../components/Sample'

Vue.use(Router)

export default new Router ({
  routes: [
    {
      path: '/',
      name: 'default-home',
      component: DefaultHome
    },
    {
      path: '/sample',
      name: 'sample',
      component: Sample
    }
  ]
})
```
```javascript
// main.js
import Vue from 'vue'

import App from './App.vue'
import router from './router/routes.js'

new Vue({
  el: '#app',
  router,
  render: h => h(App)
})
```

그리고 각 라우터에 대한 링크는 다음과 같이 정의
```HTML
<ul>
  <li>
    <router-link to="/">Home</router-link>
  </li>
  <li>
    <router-link to="/sample">Sample</router-link>
  </li>
</ul>
```

만약, url에 "#"이 붙은 hash mode가 아닌 일반적인 url 형태로 표시가 되길 원한다면 아래의 옵션을 추가해준다.
```javascript
// router/index.js
export default new Router ({
  mode: 'history',
  routes: [
    // 중략
  ]
})
```


###### 기본 레이아웃 구성
header, container, footer로 구성된 기본 레이아웃을 구성한다.
```html
// App.vue
<template>
  <div id="app">
    <layout-header />
    <!-- Begin page content -->
    <main role="main" class="container">
      <router-view></router-view>
    </main>
    <layout-footer />
  </div>
</template>

<script>
  import LayoutHeader from './components/layout/LayoutHeader'
  import LayoutFooter from './components/layout/LayoutFooter'

  export default {
    name: 'app',
    components : {
      'layout-header': LayoutHeader,
      'layout-footer': LayoutFooter,
    }
  };
</script>
```
여기까지 작업한 내용에 대해서는 https://github.com/gloriaJun/vuejs-prototype/tree/v0.1-router 의 디렉토리 구조 및 작성된 코드 참고


#### Directory Structure
프로젝트 시작 시에 폴더 구조 잡을 때에 참고할 링크들
- https://forum.vuejs.org/t/structuring-very-large-applications/840/3
- https://github.com/matthiaswh/budgeterbium
- https://medium.com/tldr-tech/vue-js-2-vuex-router-yarn-basic-configuration-version-2-7b9c489d43b3



#### Reference
- [Vue-CLI 로 Vue.js 시작하기 (browserify / webpack)](https://medium.com/witinweb/vue-cli-%EB%A1%9C-vue-js-%EC%8B%9C%EC%9E%91%ED%95%98%EA%B8%B0-browserify-webpack-22582202cd52)     
- [VueJS 가이드 3 - 설정 및 프로젝트 구조](http://webframeworks.kr/tutorials/weplanet/3project-structure/)   
- [Getting Started With Vue Router](https://scotch.io/tutorials/getting-started-with-vue-router)
