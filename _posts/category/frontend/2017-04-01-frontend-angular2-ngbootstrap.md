---
layout: post
comments: true
title: "[Angular2] angular2에 ng-bootstrap 적용하기"
date: 2017-04-01 23:30:00
categories: Frontend
tags: javascript AngularJS Angular2
---

#### Dependencies
Angular version 2 이상<br/>
Bootstrap CSS 

#### Installation
먼저 ng-bootstrap을 설치한다.
```
$ npm install --save @ng-bootstrap/ng-bootstrap
```
위와 같이 수행하면 해당 패키지가 다운되고, `package.json`에 해당 패키지에 대한 정의가 추가된다.
```
(...중략...)
  "dependencies": {
    "@angular/common": "~4.0.0",
    "@angular/compiler": "~4.0.0",
    "@angular/core": "~4.0.0",
    "@angular/forms": "~4.0.0",
    "@angular/http": "~4.0.0",
    "@angular/platform-browser": "~4.0.0",
    "@angular/platform-browser-dynamic": "~4.0.0",
    "@angular/router": "~4.0.0",
    "@ng-bootstrap/ng-bootstrap": "^1.0.0-alpha.22",
    "angular-in-memory-web-api": "~0.3.0",
(...중략...)
```

#### Configuration
###### app.module.ts
import할 패키지를 정의한다.
```
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { JsonpModule } from '@angular/http';
import {NgbModule} from '@ng-bootstrap/ng-bootstrap';
```

`@NgModule`을 정의한다.
```
@NgModule({
  imports:      [ 
    BrowserModule,
    FormsModule, ReactiveFormsModule, JsonpModule,
    NgbModule.forRoot()  
  ],
  declarations: [ 
    AppComponent,
    CounterComponent,
    NgbdButtonComponent
  ],
  bootstrap:    [ 
    AppComponent 
  ]
})
```

###### index.html
css 파일을 정의
```html
<html>
  <head>
    <title>Angular QuickStart</title>
    <base href="/">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" />
    <link rel="stylesheet" href="styles.css">
(..중략...)
```


이렇게 하면 일단 ng-bootstrap 적용을 위한 기본적인 설정은 완료.

각 components에 대한 사용법은 [document](https://ng-bootstrap.github.io/#/components/accordion)를 참고하면 된다.



