---
layout: post
title: "(Axios) default 설정"
date: 2018-03-01 10:32:00
author: gloria
categories: language
tags: javascript frontend vuejs axios
---

`main.js`에서 axios 대신에 default 설정을 정의한 스크립트 파일을 import하여 사용한다.
###### main.js
```javascript
import $http from '@/utility/http'

Vue.prototype.$http = $http
```

###### http.js
```javascript
import axios from 'axios'

/**
 * axios default 설정 정의
 * @type {AxiosInstance}
 */
const $http = axios.create({
  baseURL: '/api',
  headers: {
    'content-type': 'application/json;charset=UTF-8',
    'domain': 'aibril'
  }
})

/**
 * error 발생 시에 공통으로 처리하기 위해 정의한 부분
 */
$http.interceptors.response.use(null, function (error) {
  console.error(error)
  if (error.status === 401) {
    console.error('error 401')
  }
  return Promise.reject(error)
})

export default $http
```
