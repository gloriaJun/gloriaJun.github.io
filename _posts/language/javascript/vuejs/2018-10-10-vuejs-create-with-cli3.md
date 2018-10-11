---
layout: post
title: "(VueJS) 개발 환경 구성하기 (vue-cli3)"
date: 2018-10-10 14:35:00
author: gloria
categories: language
tags: javascript vuejs vuecli3 typescript

---

* TOC
{:toc}


## Vue CLI 3 Installation

#### 이전 버전 삭제

이전 버전(1.x or 2.x)이 설치되어 있는 경우 npm 또는 yarn을 이용하여 삭제를 한다

```bash
npm uninstall vue-cli -g
## or
yarn global remove vue-cli
```



#### Installation

```bash
npm install -g @vue/cli
# OR
yarn global add @vue/cli

## version check
vue --version
```



## Project 생성

`vue create {프로젝트명}`과 같이 터미널에 입력하면 프로젝트 생성을 위한 프롬프트가 출력이 된다.

TypeScript를 이용한 프로젝트를 생성할 것이므로 아래와 같이 설정하여 프로젝트를 생성하였다.

```bash
$ vue create vue-cli3-sample

Vue CLI v3.0.5
? Please pick a preset: Manually select features
? Check the features needed for your project: Babel, TS, Router, Vuex, CSS Pre-p
rocessors, Linter, Unit
? Use class-style component syntax? Yes
? Use Babel alongside TypeScript for auto-detected polyfills? Yes
? Use history mode for router? (Requires proper server setup for index fallback
in production) Yes
? Pick a CSS pre-processor (PostCSS, Autoprefixer and CSS Modules are supported
by default): Sass/SCSS
? Pick a linter / formatter config: TSLint
? Pick additional lint features: Lint on save
? Pick a unit testing solution: Mocha
? Where do you prefer placing config for Babel, PostCSS, ESLint, etc.? In dedica
ted config files
? Save this as a preset for future projects? No
```

성공적으로 프로젝트가 생성이 되면 해당 폴더로 들어가서 `yarn serve`를 입력하면, 샘플로 작성된 화면이 출력되는 것을 확인할 수 있다.

> **Typescript**
>
> microsoft에서 개발하고, 유지보수하는 오픈소스 프로그래밍 언어로써, javascript의 슈퍼셋이다.

#### 프로젝트 구조

```bash
$ tree -L 2 -I "node_modules"
.
├── README.md
├── babel.config.js
├── package.json
├── postcss.config.js
├── public
│   ├── favicon.ico
│   └── index.html
├── src
│   ├── App.vue
│   ├── assets
│   ├── components
│   ├── main.ts
│   ├── router.ts
│   ├── shims-tsx.d.ts
│   ├── shims-vue.d.ts
│   ├── store.ts
│   └── views
├── tests
│   └── unit
├── tsconfig.json
├── tslint.json
└── yarn.lock

7 directories, 15 files
```

typescript로 정의한 경우에 생성된 파일에 대한 설명은 다음과 같다.

###### tsconfig.json

Typescript 환경설정 파일

http://json.schemastore.org/tsconfig를 보면 사용 가능한 옵션에 대하여 확인할 수 있다.

```json
{
  "compilerOptions": {
    "target": "esnext", // 빌드의 결과물을 어떠한 버전으로 할 것이냐 (기본 값은 es3)
    "module": "esnext", // 컴파일된 결과물을 어떤 모듈 시스템으로 할지를 결정 (target이 es6이면 es6, 그 외에는 commonjs가 기본 값)
    "strict": true,
    "jsx": "preserve",
    "importHelpers": true,
    "moduleResolution": "node",
    "experimentalDecorators": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "sourceMap": true,
    "baseUrl": ".", // 모듈을 import 할 때의 기준 폴더 정의
    "types": [
      "webpack-env",
      "mocha",
      "chai"
    ],
    "paths": {
      "@/*": [
        "src/*"
      ]
    },
    "lib": [
      "esnext",
      "dom",
      "dom.iterable",
      "scripthost"
    ]
  },
  "include": [
    "src/**/*.ts",
    "src/**/*.tsx",
    "src/**/*.vue",
    "tests/**/*.ts",
    "tests/**/*.tsx"
  ],
  "exclude": [
    "node_modules"
  ]
}
```



###### tslint.json

Typescript에서의 정적분석 도구에 대한 설정파일

```json
{
  "defaultSeverity": "warning",
  "extends": [
    "tslint:recommended"
  ],
  "linterOptions": {
    "exclude": [
      "node_modules/**"
    ]
  },
  "rules": {
    "quotemark": [true, "single"],
    "indent": [true, "spaces", 2],
    "interface-name": false,
    "ordered-imports": false,
    "object-literal-sort-keys": false,
    "no-consecutive-blank-lines": false
  }
}
```



###### src/shims-vue.d.ts

Typescript가 `.vue` 파일이 어떠한 인터페이스인지 이해할 수 있도록 미리 정의해놓은 파일이다.

```typescript
declare module '*.vue' {
  import Vue from 'vue';
  export default Vue;
}
```



###### src/shims-tsx.d.ts

*이건 무엇에 대해 정의한 건지 모르겠다..ㅠㅠ*

```typescript
import Vue, { VNode } from 'vue';

declare global {
  namespace JSX {
    // tslint:disable no-empty-interface
    interface Element extends VNode {}
    // tslint:disable no-empty-interface
    interface ElementClass extends Vue {}
    interface IntrinsicElements {
      [elem: string]: any;
    }
  }
}
```



## Reference

- https://cli.vuejs.org/guide/installation.html
- 