# Custom Directives
[강좌 링크](https://www.youtube.com/watch?v=btDfVBPYI-U&index=32&list=PL4cUxeGkcC9gQcYgjhBoeQH7wiAyZNrYa)

`v-model`, `v-show`와 같은 디렉티브를 사용자가 정의할 수 있다.

전역으로 사용하기 위해서는 `main.js`에 정의한다.
```javascript
Vue.directive('rainbow', {
  bind(el, binding, vnode) {
    el.style.colr = "#" + Math.random().toString().slice(2, 8);
  }
});
```

아래와 같이 사용한다.
```html
<p v-rainbow>Rainbow Text</p>
```


## 참고글
- [VueJs매뉴얼-사용자 지정 디렉티브](https://kr.vuejs.org/v2/guide/custom-directive.html)
