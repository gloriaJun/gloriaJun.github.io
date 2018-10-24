---
layout: post
title: "(Frontend) 크로스 브라우징 대응하기"
date: 2018-10-24 22:35:00
author: gloria
categories: frontend
tags: frontend 크로스브라우징
---

* TOC
{:toc}

프론트개발을 하다보니 매번 프로젝트 진행 시마다 마주하게 되는 문제 중 하나가 **크로스 브라우징** 이슈이다.
특정 브라우저의 사용만을 제한하면 좋겠지만, 사용자들은 실제로 내 마음처럼 따라주지 않는다.
해당 이슈를 해결하기 위한 전략과 기반 지식을 정리해보자.

## 이슈에 대응하기 위한 전략 ?!
#### 적용 기능의 지원 브라우저를 파악하기
- 현재 개발할 기능을 정의하고, 해당 기능을 지원할 브라우저를 파악한다.
- 모든 브라우저를 100% 만족하여 대응하려고 하지 마라
- 하위 브라우저에 대해서는 핵심기능만 사용상 불편함 없이 동작하게 한다
- 최신 브라우저를 대상으로는 의도하는 기능들이 잘 동작하게 구현한다

## 라이브러리를 잘 활용한다
호환성 이슈를 해결하기 위해 jQuery, polyfill 등과 같은 라이브러리를 사용한다. 
하지만, 라이브러리의 사이즈가 커질 수 있고, 라이브러리들을 잘 관리해야한다는 비용이 발생한다.

## 직접 구현 시에는 기능 탐지를 이용한다
현재 사용자가 사용하는 브라우저를 파악하여 분기를 태워 실행하기보다는 (브라우저를 구분하여 동작하면, 해당 브라우저 업데이트 시마다 유지보수 비용이 발생하거나 코드 작성 시 업데이트에 대하여 대비를 해야할 수도 있다) , *해당 브라우저에서 제공하는 기능을 파악하여 동작하게 구현*한다.
```javascript
if (element.addEventListener) {
    ...
} else if (element.attachEvent) {
    ...
} else {
    ...
}
```

## 다양한 도구들을 활용한다
#### 웹 표준을 준수한다
- [Can I user?](https://caniuse.com/)

  : 내가 사용하고 싶은 css 나 javascript 명을 넣으면, 어떤 브라우져에서 작동되는지, 작동되지 않는지를 확인할 수 있따.



#### normalize.css를 사용한다
각종 브라우저마다 기본 스타일이 달라서 동일한 스타일을 적용하기 위해서는 기본값을 초기화해주어야 한다.
- [Normalize.css](https://necolas.github.io/normalize.css/)

#### Prefix를 적어준다
아직 웹 표준이 안된 기능을 브라우저들이 지원하므로 각 기능 앞에 브라우저들의 엔진을 prefix로 적어준다.
참고로 postcss를 사용하면 빌드 시에 자동으로 생성해주는 역할을 한다. 
- [PostCSS](https://github.com/postcss/postcss)
```css
#app {
    border-radius: 16px;
    -webkit-border-radius: 16px;
    -moz-border-radius: 16px;
}
```


## Reference
- [크로스 브라우징 총정리](https://hackya.com/kr/%ED%81%AC%EB%A1%9C%EC%8A%A4-%EB%B8%8C%EB%9D%BC%EC%9A%B0%EC%A7%95-%EC%B4%9D%EC%A0%95%EB%A6%AC/)