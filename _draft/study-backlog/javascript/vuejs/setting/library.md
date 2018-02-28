## Library of VueJS

#### vue-router
링크의 "#" 설정 및 히스토리 관리 관련
https://stackoverflow.com/questions/34623833/how-to-remove-hashbang-from-url

#### Vuex
[Vuex](https://vuex.vuejs.org/kr/intro.html)는 애플리케이션에 대한 상태관리 패턴 라이브러리이다.
http://vuejs.kr/update/2017/01/08/using-vue-with-vuex-vue-rotuer/


#### axios
- npm을 이용하여 설치
```
npm install --save axios
```

- axios를 vue에서 전역으로 사용할 수 있도록 import
```javascript
// main.js
import axios from 'axios'
Vue.prototype.$http = axios
```
