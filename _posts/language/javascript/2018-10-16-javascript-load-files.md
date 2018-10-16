---
layout: post
title: "(Javascript) 모듈 동적 로딩"
date: 2018-01-10 14:35:00
author: gloria
categories: language
tags: javascript

---

## Example1
```javascript
const requireModule = require.context('.', true, /\.js$/);
const locales = {};

requireModule.keys().forEach((fileName) => {
  if (fileName === './index.js') return;

  const path = fileName.replace(/(\.\/|\.js)/g, '');
  const [moduleName, imported] = path.split('/');

  if (!locales[moduleName]) {
    locales[moduleName] = {};
  }
  locales[moduleName][imported] = requireModule(fileName).default;
});

export default locales;

/*
	{en: {…}, ko: {…}}
*/
```



## Reference

[Dependency Management](https://webpack.js.org/guides/dependency-management/)
[Dynamic Loading](https://survivejs.com/webpack/techniques/dynamic-loading/)

