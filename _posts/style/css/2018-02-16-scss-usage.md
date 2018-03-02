---
layout: post
title: "(SCSS) 사용법 정리"
date: 2018-02-16 15:28:00
author: gloria
categories: style
tags: scss frontend
---

* TOC
{:toc}

## 다른 파일에 정의된 속성을 extend 하기
다음과 같이 두 개의 파일이 있을 때에 다른 파일의 내용을 extend하여 사용하는 방법

```css
/* modules.scss */
.ruddy {color: red}
.fullwidth {width: 100%; display: block;}

/* homepage.scss */
@import modules.sass

#intro {@extend ruddy; @extend fullwidth}
aside {@extend ruddy;}
.thing {@extend fullwidth;}
```
