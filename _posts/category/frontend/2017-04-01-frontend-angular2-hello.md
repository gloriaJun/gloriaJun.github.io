---
layout: post
comments: true
title: "[Angular2] Hello Angular!!"
date: 2017-04-01 01:30:00
categories: Frontend
tags: javascript AngularJS Angular2
---

[Angular Doc](angular.io)에서 *[Setup]( [Setup for local development - ts - GUIDE](https://v2.angular.io/docs/ts/latest/guide/setup.html) )* 문서를 참고해서 정리한 내용

[Angular 프로젝트 구조](https://gloriajun.github.io/mac/2017/03/31/frontend-angular2-project-arch.html)에서 생성한 프로젝트에서 이제 서버를 실행해서 확인해보기.

### 소스 파일 구조
src 폴더에 위치한 아래의 파일들에 대해 설명을 하면…
```
src
├── app
│   ├── app.component.ts
│   └── app.module.ts
├── index.html
├── main.ts
```

##### index.html
`my-app` 이라고 선언된 tag가 component에서 해당 selector에 정의된 template을 가져와서 화면에 보여주는 부분

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Angular QuickStart</title>
    <base href="/">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="styles.css">

    <!-- Polyfill(s) for older browsers -->
    <script src="node_modules/core-js/client/shim.min.js"></script>

    <script src="node_modules/zone.js/dist/zone.js"></script>
    <script src="node_modules/systemjs/dist/system.src.js"></script>

    <script src="systemjs.config.js"></script>
    <script>
      System.import('main.js').catch(function(err){ console.error(err); });
    </script>
  </head>

  <body>
    <my-app>Loading AppComponent content here ...</my-app>
  </body>
</html>
```



##### app.component.ts
component는 기본적으로 트리 구조를 가지는 데,  최상위 컴포넌트의 이름을  관례적으로  `AppComponent` 라고 지어서 사용한다고 한다.

component 에서는...
해당 컴포넌트가 들어갈 tag명과 html 템플릿에 대해 정의를 하고, 
export class 로 선언을 해줌으로써 외부에서도 해당 컴포넌트를 사용할 수 있게 된다.

```typescript
import { Component } from '@angular/core';

@Component({
  selector: 'my-app',
  template: `<h1>Hello {{name}}</h1>`
})
export class AppComponent { name = 'Angular'; }
```


##### app.module.ts
어플리케이션들을 어떻게 angular가 조립할 지에 대해 정의하는 파일.
`@ NgModule`에 공통으로 사용하는 component, module, service를 설정한다. 
해당 설정 항목에서 `bootstrap`에는 최상위 component(즉, 가장 먼저 실행할 component)를 등록한다.

```typescript
import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent }  from './app.component';

@NgModule({
  imports:      [ BrowserModule ],
  declarations: [ AppComponent ],
  bootstrap:    [ AppComponent ]
})
export class AppModule { }
```


##### main.ts
app 실행 시의 시작점에 대해 정의한 파일.
브라우저에서 컴파일할 방식에 대해서도 해당 파일을 통해 설정이 가능한 듯. (? 이건 좀 더 확인해보고 테스트 해봐야 할 듯)

```typescript
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';

import { AppModule } from './app/app.module';

platformBrowserDynamic().bootstrapModule(AppModule);
```


### App 실행하기
터미널에서 해당 프로젝트 위치로 이동해서 `npm start`를 실행하면 어플리케이션이 구동된다.
그리고  자동으로 웹브라우저를 실행시켜서 해당 페이지를 출력해 준다.

```
$ npm start

> study-angular@1.0.0 prestart /Users/gloria/Documents/project/study-angular
> npm run build


> study-angular@1.0.0 build /Users/gloria/Documents/project/study-angular
> tsc -p src/
```