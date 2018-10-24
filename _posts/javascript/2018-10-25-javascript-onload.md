---
layout: post
title: "(Javascript) 문서가 로딩되는 시점"
date: 2018-10-25 00:15:00
author: gloria
categories: language
tags: javascript

---

자바스크립트에서 프로그래밍적으로 화면을 제어하기 위해서는 브라우저의 모든 요소에 대한 처리가 끝나야 한다. 
해당 시점을 알려주기 위한 이벤트가 `load`, `DOMContentLoaded`이다.

###### load
load 이벤트는 문서 내의 모든 리소스가 다운로드가 완료된 시점에 실행된다.
해당 시점에 실행되는 경우, 어플리케이션의 구동이 지연되는 현상으로 이어질 수 있다.
```javascript
window.addEventListener('load', function() {
  console.log('load');
});
```

###### DOMContentLoaded
DOMContentLoaded 이벤트는 문서에서 스크립트 작업을 할 수 있을 때 실행된다. 그러므로 모든 리소스의 다운로드가 완료되기를 기다릴 필요가 없다.
```javascript
document.addEventListener('DOMContentLoaded', function() {
  console.log('DOMContentLoaded');
});
```
> IE9 이상에서 지원된다.


## Reference

[Dependency Management](https://webpack.js.org/guides/dependency-management/)
[Dynamic Loading](https://survivejs.com/webpack/techniques/dynamic-loading/)