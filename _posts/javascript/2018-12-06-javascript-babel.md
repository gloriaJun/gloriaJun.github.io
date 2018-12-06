---
layout: post
title: "(Javascript) Babel 설정하기"
date: 2018-12-06 10:40:00
author: gloria
categories: language
tags: javascript babel configuration
---

* TOC
{:toc}

> Javascript Transpiler
>
> - ES6, ES7 으로 작성된 자바스크립트 코드를 브라우저(특히 구형 브라우저)가 인식할 수 있는 ES5로 변환시켜주는 역할을 수행한다.


## Babel 설치하기
```bash
yarn add -D babel-cli babel-preset-es2015
```


## .babelrc

```
{
  "presets": [
    "es2015"
  ]
}
```


## 수행 결과 확인해보기
```javascript
const template = `<ul class="nav-items">
  <li><a href="#home">Home</a></li>
  <li><a href="#about">About</a></li>
</ul>`;

console.log(template);


class Car {
  constructor(model) {
    this.model = model;
  }

  toString() {
    return this.model;
  }
}

class Santa extends Car {
  constructor(model, year = 2017) {
    super(model);
    this.year = year;
  }
}

const mycar = new Santa('model', 2015);
console.log(mycar.toString());
```

위와 같이 작성된 코드를 babel을 수행한다.
```bash
babel index.js -d lib
```

Transpile이 수행된 `lib/index.js`을 확인하면 아래와 같다.
```javascript
'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var template = '<ul class="nav-items">\n  <li><a href="#home">Home</a></li>\n  <li><a href="#about">About</a></li>\n</ul>';

console.log(template);

var Car = function () {
  function Car(model) {
    _classCallCheck(this, Car);

    this.model = model;
  }

  _createClass(Car, [{
    key: 'toString',
    value: function toString() {
      return this.model;
    }
  }]);

  return Car;
}();

var Santa = function (_Car) {
  _inherits(Santa, _Car);

  function Santa(model) {
    var year = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 2017;

    _classCallCheck(this, Santa);

    var _this = _possibleConstructorReturn(this, (Santa.__proto__ || Object.getPrototypeOf(Santa)).call(this, model));

    _this.year = year;
    return _this;
  }

  return Santa;
}(Car);

var mycar = new Santa('model', 2015);
console.log(mycar.toString());
```



