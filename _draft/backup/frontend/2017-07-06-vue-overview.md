---
layout: post
comments: true
title: "[Vue] Vue.js 시작하기"
date: 2017-07-06 16:30:00
categories: Frontend
tags: vuejs
---

## What is Vue …?
MVVM 패턴의 ViewModel 레이어에 해당하는 View 단 라이브러리      
![]({{ site.url }}/assets/images/post/2017/0706-vue-model.png)  
     
* 데이터 바인딩 과 화면 단위를 컴포넌트 형태로 제공하며, 관련 API 를 지원하는데에 궁극적인 목적이 있음
* Angular 에서 지원하는 2 way data bindings 을 동일하게 제공
* Component 간 통신의 기본 골격은 React 의 1 Way Data Flow (부모 -> 자식) 와 유사
* 다른 Front-End FW (Angular, React) 와 비교했을 때 훨씬 가볍고 빠름.
* 간단한 Vue 를 적용하는데 있어서도 러닝커브가 낮고, 쉽게 접근 가능

> 참고로 Vue.js는 IE9부터 지원한다.      

## Vue 설치 방법
Vue를 설치하는 방법은 추가적인 방법이 있겠지만..일단 다음과 같은 방법들이 있다.    
* CDN을 이용하여 <script> 구문에 추가         
```html
<script src="https://unpkg.com/vue"></script>
```
     
* npm을 이용한 설치      
```
$ npm install vue --save
```
       
* Vue-Cli를 이용

## Vue를 이용한 간단한 샘플 코드 작성해보기
#### Plunker와 같은 온라인 에디터를 이용한 코드 작성
아래와 같은 코드를 작성 후, 실행해보면 화면에 `Hello, Vue` 라는 메시지가 출력되는 것을 확인할 수 있다.
```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=yes">

        <title>Sample App:Main</title>
    </head>
    <body>
        <div id='app'>
            <h2>Hello, {{ name }}</h2>
        </div>

        <!-- vue.js -->
        <script src="https://unpkg.com/vue"></script>
        <script>
          (function () {
        var app = new Vue({
            el: '#app',
            data: {
                name: 'Vue'
            }
        });
      })();
        </script>
    </body>
</html>
```

#### Vue-Cli를 이용한 프로젝트 구성
Vue-Cli 를 설치하여 프로젝트를 생성하는 방법이다.        
        
먼저  vue-cli를 global로 설치한다.     
```
$ npm install -g vue-cli
```
        
vue-cli를 이용하여 프로젝트를 생성한다.   
```
$ vue init webpack study-vue
```
      
생성한 프로젝트의 패키지를 설치하고 실행하면 샘플 웹페이지가 출력되는 것을 확인할 수 있다.      
```
npm install 
npm run dev
```
     
다음과 같은 설정들을 기본으로 제공한다.   
* webpack : Webpack, vue-loader, 정적 분석, 테스트 등 기본 빌드 프로세스 대부분을 설정
* webpack-simple : Webpack과 vue-loader로 구성된 간단한 조합
browserify : Browserify, vueify, 정적 분석, 테스트 등 기본 빌드 프로세스 대부분을 설정
* browserify-simple : Browserify와 vueify로 구성된 간단한 조합
* simple : 특별한 모듈 관리 도구를 사용하지 않고 HTML 파일 1개로 구성하는 제일 간단한 조합
 

> **Reference**       
> [Vue.js 입문서 - 프론트엔드 개발자를 위한 • Captain Pangyo](https://joshua1988.github.io/web_dev/vuejs-tutorial-for-beginner/)     
> [GitHub - pablohpsilva/vuejs-component-style-guide: Vue.js Component Style Guide](https://github.com/pablohpsilva/vuejs-component-style-guide)     
> https://medium.com/tldr-tech/     vue-js-2-vuex-router-yarn-basic-configuration-version-2-7b9c489d43b3    
[Project Structure · GitBook](http://vuejs-templates.github.io/webpack/structure.html)         