## EsLint for standard

#### webpack with eslint
webpack 으로 설치할 때 eslint만 설치하고, config에 대한 설정을 정의하지 않은 경우에...

```
npm install --save-dev eslint-config-standard eslint-plugin-import eslint-plugin-node eslint-plugin-promise eslint-plugin-standard
```

```javascript
//.eslintrc.js
// https://eslint.org/docs/user-guide/configuring
module.exports = {
  root: true,
  parserOptions: {
    parser: 'babel-eslint',
    sourceType: 'module'
  },
  env: {
    browser: true,
  },
  // https://github.com/standard/standard/blob/master/docs/RULES-en.md
  extends: 'standard',
  // required to lint *.vue files
  plugins: [
    'html'
  ],
  // add your custom rules here
  rules: {
    // allow async-await
    'generator-star-spacing': 'off',
    // allow debugger during development
    'no-debugger': process.env.NODE_ENV === 'production' ? 'error' : 'off'
  }
}
```

#### webpack-simple with eslint
아래의 패키지들을 설치한다
```
npm install --save-dev eslint eslint-loader babel-eslint
npm install --save-dev eslint-config-standard eslint-plugin-import eslint-plugin-node eslint-plugin-promise eslint-plugin-standard eslint-plugin-html
```

`webpack.config.js` 파일에 아래와 같이 추가한다.
```javascript
// webpack.config.js
module.exports = {
//(...중략...)
  module: {
    rules: [
//(...중략...)
      {
        test: /\.(js|vue)$/,
        exclude: /node_modules/,
        loader: "eslint-loader",
      }
//(...중략...)      
    ]
//(...중략...)    
  }
//(...중략...)
}
```

## EsLint for vue
Vue.js 공식 ESLint 플러그인을 standrd에 추가로 적용
해당 플러그인을 적용하면 Vue.js에서 제안하는 스타일가이드에 따라 프로젝트 진행이 가능하다.
```
npm install --save-dev eslint-plugin-vue
```

설치 후에 아래와 같이 `.eslintrc.js` 파일을 수정한다.
```javascript
//.eslintrc.js
// https://eslint.org/docs/user-guide/configuring
module.exports = {
  root: true,
  parserOptions: {
    parser: 'babel-eslint'
  },
  env: {
    browser: true,
  },
  extends: [
    // https://github.com/standard/standard/blob/master/docs/RULES-en.md
    'standard',
    // https://github.com/vuejs/eslint-plugin-vue
    "plugin:vue/recommended"
  ],
  // required to lint *.vue files
  plugins: [
    'vue'
  ],
  // add your custom rules here
  rules: {
    // allow async-await
    'generator-star-spacing': 'off',
    // allow debugger during development
    'no-debugger': process.env.NODE_ENV === 'production' ? 'error' : 'off'
  }
}
```

`main.js`에서 Vue 선언 부분에 아래와 같이 주석을 추가해주어야 lint error를 방지할 수 있다.
```javascript
// main.js
//
/* eslint-disable no-new */
new Vue({
  el: '#app',
  components: { App },
  template: '<App/>',
  router,
  render: h => h(App)
})
```

만약, `/* eslint-disable no-new */` 주석 구문이 없으면 아래와 같은 에러가 발생한다.
```
[프로젝트 경로]/src/main.js
  16:1  error  Do not use 'new' for side effects  no-new

✖ 1 problem (1 error, 0 warnings)
```
