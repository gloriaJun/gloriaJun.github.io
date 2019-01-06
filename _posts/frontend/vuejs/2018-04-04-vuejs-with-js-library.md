---
layout: post
title: "(VueJS) javascript library 사용하기"
date: 2018-04-04 14:35:00
author: gloria
categories: frontend
tags: javascript vuejs
---

## Vue prototype으로 정의
`main.js` 파일에 사용하고자 하는 라이브러리를 Vue의 pprototype으로 선언한다.
```javascript
// main.js
import lodash from 'lodash'
import moment from 'moment'

Vue.prototype.$_ = lodash
Vue.prototype.$moment = moment
```
> vue의 prototype으로 선언된 객체들을 보면 `$store, $route ...`와 같이 '$'로 prefix를 정의하여 사용하고 있으므로 해당 규칙을 따라서 정의해준다.

## plugin으로 정의하여 사용
#### plugin 파일 생성
```javascript
// moment.js
import moment from 'moment'

export default {
  install: (Vue, name = '$moment') {
    Vue.prototype.$moment = moment
  }
}
```

#### main.js에서 import
```javascript
// main.js
import vipMoment from 'plugins/moment.js'
Vue.use(vipMoment, '$moment')
```

## Vue에서 사용하기
`this`로 접근하여 사용한다
```javascript
console.log(this.$moment.locale())
```

## Reference
- [Use Any JavaScript Library With Vue.js](https://dzone.com/articles/use-any-javascript-library-with-vuejs)
- [Mixins and Plugins in VueJS](https://medium.com/@denny.headrick/mixins-and-plugins-in-vuejs-ecee9b37d1bd)
- [VueJs-플러그인](https://kr.vuejs.org/v2/guide/plugins.html)
