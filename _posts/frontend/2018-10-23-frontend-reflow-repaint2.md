---
layout: post
title: "(Frontend) Browser - Reflow & Repaint 테스트"
date: 2018-10-23 20:35:00
author: gloria
categories: frontend
tags: javascript 브라우저렌더링
---

* TOC
{:toc}
[(Frontend) Browser - Reflow & Repaint]({% post_url /frontend/2018-10-23-frontend-reflow-repaint %})에서 공부했던 내용을 크롬 디버그 창을 이용해서 성능을 비교해보기



#### 작업 그룹화 하여 처리하기

###### html 코드

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Title</title>
</head>
<body>
	<div id="app" style="border: 1px solid red; width: 100px; height: 200px;"></div>
	<button id="btn">Click Me</button>
</body>
</html>

```



###### Bad Case
동일한 노드에 여러 번에 나누어 스타일을 적용하는 코드

```javascript
function reFlow() {
    let el = document.getElementById('app');
    el.style.width = '600px';
    el.style.height = '150px';
    el.style.backgroundColor = 'blue';
    return false;
}

document.getElementById('btn').addEventListener('click', reFlow);
```

![reflow-test-donot]({{ site.baseurl }}/assets/images/post/reflow-test-ex1-donot.png)



###### Good Case
cssText를 이용하여 스타일을 적용하는 코드
```javascript
function reFlow() {
	let el = document.getElementById('app');
	el.style.width = '600px';
	el.style.height = '150px';
	el.style.backgroundColor = 'blue';
	return false;
}

document.getElementById('btn').addEventListener('click', reFlow);
```

![reflow-test-do]({{ site.baseurl }}/assets/images/post/reflow-test-ex1-do.png)



#### DOM 사용을 최소화하기

###### html 코드

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Title</title>
</head>
<body>
    <button id="btn">Click Me</button>
	<div id="app"></div>
</body>
</html>

```



###### Bad Case
```javascript
  function func() {
    for(let i=0;i<1000;i+=1) {
      let el = document.getElementById('app');
      el.innerHTML += '<div>This is Text</div>'
    }
  }

  document.getElementById('btn').addEventListener('click', func);
```
> 참고로 위의 코드에서 `let el = document.getElementById('app');` 라인을 for 문 위로 올려서 캐싱을 해서 사용하면, 작성된 케이스보다는 성능이 향상된다 (*캐쉬를 활용하여 Reflow를 최소화한다.*)

![reflow-test-donot]({{ site.baseurl }}/assets/images/post/reflow-test-ex2-donot.png)

###### Good Case
```javascript
  function func() {
  	let el = document.getElementById('app');
    let str = '';

    for(let i=0;i<1000;i+=1) {
      str += '<div>This is Text</div>';
    }

    el.innerHTML = str;
  }

  document.getElementById('btn').addEventListener('click', func);
```

![reflow-test-do]({{ site.baseurl }}/assets/images/post/reflow-test-ex2-do.png)
