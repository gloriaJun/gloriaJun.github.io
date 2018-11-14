---
layout: post
title: "(Javascript) 실행 시간 측정하기"
date: 2018-10-24 14:35:00
author: gloria
categories: language
tags: javascript
---

## Date 객체 이용
```javascript
let sum = 0;

let startTime = new Date().getTime();
for (let i = 1; i <= 1000000; i++) {
	sum += i;
}
let endTime = new Date().getTime();

console.log(endTime - startTime); // 단위는 밀리세컨드
/*
	34 
*/	
```


## console 객체 이용
`console.time()`과 `console.timeEnd()`를 이용하여 시간을 측정하는 방법이다.

```javascript
let sum = 0;

console.time('test');
for (let i = 1; i <= 1000000; i++) {
	sum += i;
}
console.timeEnd('test');
/*
	test: 34.0048828125ms
*/
```
> 해당 함수는 Chrome2, FireFox10, Safari4, IE11에서 사용이 가능하다.       
