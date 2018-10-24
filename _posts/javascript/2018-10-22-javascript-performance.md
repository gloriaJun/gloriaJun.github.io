---
layout: post
title: "(Javascript) 성능 최적화를 위한 코드 스타일"
date: 2018-10-22 09:35:00
author: gloria
categories: language
tags: javascript 자바슼크립트성능
---

* TOC
{:toc}

아주 기본적일 수도 있으나, 코드를 어떻게 작성하느냐에 따라 자바스크립트 실행 성능을 약간은 높일 수 있다.


## 객체의 생성 및 접근
객체를 생성할 때에 `new`보다는 리터럴 형식을 사용해 객체를 생성한다.

#### Object
###### 생성 시

|           | DO   | DON'T |
| --------- | ---- | ----- |
| 실행 예제 | let obj2 = {}; | let obj1 = new Object(); |
| 실행 시간 |0.00634765625ms      | 0.010986328125ms |


###### 접근 시
|           | DO   | DON'T |
| --------- | ---- | ----- |
| 실행 예제 | let obj2 = {}; | let obj1 = {};<br/>obj1.a = 'a';
obj1.b = 'b';
obj1.c = 'a';
obj1.d = 'a';
obj1.e = 'a';
obj1.f = 'a';
obj1.g = 'a';
obj1.h = 'a'; |
| 실행 시간 |0.00634765625ms      | 0.031982421875ms |


```javascript

```

####  Array
###### 생성 시
|           | DO   | DON'T |
| --------- | ---- | ----- |
| 실행 예제 | let obj2 = {}; | let obj1 = new Object(); |
| 실행 시간 |0.00634765625ms      | 0.010986328125ms |


```javascript
// DON'T
let arr1 = new Array(); 
// 실행 시간 : 0.005126953125ms

// DO
let arr2 = [];
// 실행 시간 : 0.004150390625ms
```






- [자바스크립트 성능 최적화 팁](https://isme2n.github.io/devlog/2017/07/10/javascript-perfomance-optimization/)



- [성능 덕후를 위한 자바스크립트 코딩 패턴 (중급 이상)](https://joshuajangblog.wordpress.com/2016/11/21/javascript-coding-pattern-for-junior-web-developer/)

- [성능을 높이는 코드 스타일](https://12bme.tistory.com/134)



