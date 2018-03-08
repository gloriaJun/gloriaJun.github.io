---
layout: post
title: "(VueJS) Storybook with vue"
date: 2018-03-06 14:35:00
author: gloria
categories: language
tags: javascript vuejs storybook
---

* TOC
{:toc}

[Storybook](https://storybook.js.org/)은 컴포넌트 단위의 개발 환경을 지원하는 개발도구이다
독립적인 컴포넌트 개발이 가능하도록 지원해주어 각각의 컴포넌트 개발에 집중할 수 있다.
또한 [AddOn](https://storybook.js.org/addons/introduction/)을 활용하여 각각의 컴포넌트들에 대한 추가적인 정보를 제공할 수 있게도 해주어서 컴포넌트 다큐먼트로도 활용이 가능하지 않을까함

## Installation
생성한 프로젝트에 storybook을 설치한다
```bash
npm i --save-dev @storybook/vue
```

설치 후에 `package.json`에 storybook 실행을 위한 명령어를 script에 추가해준다
```json
{
  "scripts": {
    "storybook": "start-storybook -p 9001 -c .storybook"
  }
}
```

**config 파일 생성**
Story 파일 로딩을 위해 `storybook/config.js`파일에 아래와 같이 설정한다
```javascript
// config.js
import { configure } from '@storybook/vue';

const req = require.context('../stories', true, /\.stories\.js$/)

function loadStories() {
  req.keys().forEach((filename) => req(filename))
}

configure(loadStories, module);
```
`stories` 디렉토리 하위에 `.sotries.js` 확장자가 포함된 모든 파일을 로딩하기 위해서 위와 같이 작성하였음 ([Loading stories dynamically](https://storybook.js.org/basics/writing-stories/#loading-stories-dynamically) 참고)


**stories 작성**
```javascript
// index.js
import { storiesOf } from '@storybook/vue'

// component
import ProgressBar from '../src/components/status/ProgressBar.vue'

storiesOf('status', module) // 상위 카테고리 지정
  .add('progressBar', () => ({ // 하위 내용 지정
    components: { ProgressBar },
    template: `<div style="padding: 2rem;">
      <progress-bar :value=20></progress-bar>
    </div>`
  }))
```

**storybook 실행**
```bash
npm run storybook
```

## style 파일 로딩하기
`.css, .scss ...`과 같은 작성한 스타일 파일 로딩하는 방법

**preview-head.html**
html 태그를 이용하여 import하는 방법이다.
`.stroybook/preview-head.html` 파일을 생성하고 아래와 같은 형태로 작성한다.
```html
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link href="https://use.fontawesome.com/releases/v5.0.8/css/all.css" rel="stylesheet">
```
좀 더 자세한 내용은 [Add Custom Head Tags](https://storybook.js.org/configurations/add-custom-head-tags/)의 내용을 참고


## webpack 빌드 설정
`.storybook/webpack.config.js` 파일을 생성해서 아래와 같이 작성한다.
```javascript
const path = require('path');

module.exports = (storybookBaseConfig, configType) => {
  storybookBaseConfig.module.rules.push({
    test: /\.scss$/,
    loaders: ["style-loader", "css-loader", "sass-loader"],
    include: path.resolve(__dirname, '../')
  });

  // Return the altered config
  return storybookBaseConfig;
};
```
좀 더 자세한 내용은 [Custom Webpack Config](https://storybook.js.org/configurations/custom-webpack-config/)의 내용을 참고

##


## Reference
- [공식가이드 - Storybook for Vue](https://storybook.js.org/basics/guide-vue/)
- [GongZza's Blog - Storybook for Vue](https://gongzza.github.io/javascript/vuejs/storybook-for-vue/)
- [DailyEngineering - Storybook 입문 가이드](https://hyunseob.github.io/2018/01/08/storybook-beginners-guide/)
