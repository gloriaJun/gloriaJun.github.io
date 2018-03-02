---
layout: post
title: "(Javascript) Arrays"
date: 2018-01-10 14:35:00
author: gloria
categories: language
tags: javascript
---

* TOC
{:toc}

## Arrays.prototype.sort
#### 숫자 정렬
```javascript
let input="2 3 6 6 5"
let nums = input.split(' ').map(Number);

// 오름차순
nums.sort((a,b) => a-b); // [2, 3, 5, 6, 6]

// 내림차순
nums.sort((a,b) => b-a); // [6, 6, 5, 3, 2]
```

#### 문자 정렬
```javascript
let input="a c b e"
let str = input.split(' ');

// 오름차순
str.sort(); // ["a", "c", "b", "e"]

// 내림차순
str.sort((a,b) => (a > b)? -1 : 1); // ["e", "c", "b", "a"]
```
