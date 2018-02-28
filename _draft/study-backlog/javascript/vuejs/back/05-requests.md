# HTTP Requests
[강좌 링크](https://www.youtube.com/watch?v=btDfVBPYI-U&index=32&list=PL4cUxeGkcC9gQcYgjhBoeQH7wiAyZNrYa)

## HTTP Requests
http 요청을 위한 라이브러리이다.
npm으로 `vue-resource` 설치한다.
```
npm install vue-resource --save
```

`main.js`에 import 해준다.
```javascript
import VueResource from 'vue-resource'

Vue.use(VueResource);
```


## axios
최근에는 `vue-resource`가 더 이상 업데이트가 되고 있지 않으며, `axios`를 사용하는 것을 가이드 하고 있는 것 같다.


## 참고글
- [VueJs매뉴얼-폼 입력 바인딩](https://kr.vuejs.org/v2/guide/components.html)
- [HTTP 요청을 위한 axios](http://vuejs.kr/update/2017/01/04/http-request-with-axios/)
- [VueJS 공부하기 (2) | vue-resource - $http.get()](https://hanwong.github.io/2017/02/12/vue-resource-firebase02/)
