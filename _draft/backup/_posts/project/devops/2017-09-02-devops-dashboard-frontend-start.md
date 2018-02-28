---
layout: post
comments: true
title: "[devops] dashboard 프로젝트 - Frontend Configuration"
date: 2017-09-02 13:53:00
categories: devops-dashboard
tags: hygieia vuejs material
---

Angularjs로 구성된 부분을 VueJS를 이용하여 만들어보기.    
css는 material design을 이용하기로 ....   

## Install
webpack을 이용하여 프로젝트를 생성하였다.    
```
$ npm install -g vue-cli
```
     
기본만 설치하고 route, lint 등의 옵션은 차후 프로젝트를 진행하면서 공부하면서 설치하기로 했다.    
```
$ vue init webpack hygieia-dashboard

? Project name hygieia-dashboard
? Project description based on Hygieia Open Source
? Author gloria
? Vue build standalone
? Install vue-router? No
? Use ESLint to lint your code? No
? Setup unit tests with Karma + Mocha? No
? Setup e2e tests with Nightwatch? No

   vue-cli · Generated "hygieia-dashboard".

   To get started:

     cd hygieia-dashboard
     npm install
     npm run dev

   Documentation can be found at https://vuejs-templates.github.io/webpack

$ cd hygieia-dashboard
$ npm install
```
    
다음으로는 material을 설치
```
$ npm install vue-material --save
```
    
이렇게 하면 일단 프로젝트 진행을 위한 준비는 완료된 듯.  
