## UI Framework for VueJS
- [Vuetify](https://vuetifyjs.com/ko/)   
- [element](http://element.eleme.io/#/en-US)   


#### Bootstrap
```
npm install bootstrap --save
```
`main.js`에 해당 스타일 파일 import
```javascript
import '../node_modules/bootstrap/scss/bootstrap.scss';
```

## AdminLTE
adminLTE 템플릿 적용하기
```
npm install --save admin-lte
```

#### Dependency library
jquery 사용을 위해 아래의 라이브러리를 설치
```
npm i --save-dev expose-loader  
```

그 외의 라이브러리 설치
```
npm install --save jquery bootstrap
```
```javascript
//main.js
/*
 plugin
 */
import 'expose-loader?$!expose-loader?jQuery!jquery'
import 'bootstrap'
import 'admin-lte'

/*
  styles
 */
import 'bootstrap/dist/css/bootstrap.min.css';
import 'admin-lte/dist/css/AdminLTE.min.css'
import 'admin-lte/dist/css/skins/_all-skins.min.css'
import 'font-awesome/css/font-awesome.min.css'
```

- font 빌드 설정
```
npm install --save-dev url-loader
```
```javascript
//webpack.config.js
{
  test: /\.(woff|woff2|eot|ttf|svg)(\?.*$|$)/,
  loader: 'url-loader?importLoaders=1&limit=100000'
}
```

###### Reference
[vue.js에서 jQuery, Bootstrap 추가하여 사용하기](http://vuejs.kr/jekyll/update/2017/03/02/vuejs-jquery-bootstrap/)
[vue.js에서 jQuery, Bootstrap 추가하여 사용하기-webpack이용](https://lovemewithoutall.github.io/it/install-bootstrap-for-vue/) --> 잘 안되네..ㅠㅠ

## CoreUI
https://www.laravel-vuejs.com/8-vue-js-templates-admin-dashboard-free-download-premium/
