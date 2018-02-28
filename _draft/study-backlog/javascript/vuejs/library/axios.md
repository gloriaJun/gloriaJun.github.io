# axios

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

###### main.js
```javascript
import $http from '@/utility/http'

Vue.prototype.$http = $http
```
