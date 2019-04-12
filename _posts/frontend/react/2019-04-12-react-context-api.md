---
layout: post
title: "(React) Context API"
date: 2019-04-12 12:35:00
author: gloria
categories: frontend
tags: javascript frontend react
---

* TOC
{:toc}

# React Context API

> React v 16.3.0 이상에서 release 되는 기능
> Written based on React v16.8.4

기존에는 redux, mobx와 같은 별도의 라이브러리를 이용하여 상태를 관리해야하던 부분을 React Context API를 이용하여 구현할 수 있다.

## Context API Example

### Create Context

아래와 같이 `createContext` 함수를 호출하면 Context가 생성이 되어 반환된다.

```javascript
// context.js
import React from 'react';
const Context = React.createContext(null);

export default Context;
```

> Context는 여러 개를 만들어 사용할 수 있다.

### Provider - Set Value

Provider를 이용하여 값을 저장한다.

Context는 reference identify를 이용하여 re-render 시점을 결정하므로 Provider의 value에 값을 `value={msg: 'hello'}`와 같이 설정한 경우에 의도치 않게 re-render가 발생할 수 있다.

그러므로 해당 문제를 해결하기 위해서는 아래와 같이 state에 담아 전달한다.

```javascript
// App.js
import React from 'react';
import AppPresenter from './AppContainer';
import Context from 'context';

export default class AppContainer extends React.Component {
  state = {
    message: 'Hello',
  };

  render() {
    return (
      <Context.Provider value={this.state.message}>
        <AppPresenter />
      </Store.Provider>
    )
  }
}
```

### Consumer - Get Value

Provider에서 설정된 값을 다른 컴포넌트에서 꺼내어 사용한다.

```javascript
// NotificationPresenter.js
import React from 'react';
import Context from 'context';

const NotificationPresenter = () => (
  <React.Fragment>
    <Context.Consumer>{store => store}</Store.Consumer>
  </React.Fragment>
);

export default NotificationPresenter;
```

## 불필요한 Re-render 피하기

Provider 하위에 직접적으로 컴포넌트를 아래의 예제같이 선언한 경우에는 최상위 부모 노드인 Provder에서 value가 변경될 때마다 하위의 모든 자식 노드가 re-render가 발생한다.
즉, 불필요한 컴포넌트에서도 re-render가 발생한다.
> 아래 예제의 콘솔로그를 확인.

<p class="codepen" data-height="265" data-theme-id="0" data-default-tab="js,result" data-user="gloriaJun" data-slug-hash="GLEqLM" style="height: 265px; box-sizing: border-box; display: flex; align-items: center; justify-content: center; border: 2px solid black; margin: 1em 0; padding: 1em;" data-pen-title="contextApi-re-render">
  <span>See the Pen <a href="https://codepen.io/gloriaJun/pen/GLEqLM/">
  contextApi-re-render</a> by gloria (<a href="https://codepen.io/gloriaJun">@gloriaJun</a>)
  on <a href="https://codepen.io">CodePen</a>.</span>
</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>


그러므로 아래와 같이 별도의 Provider Component를 생성하여 `props.children`을 넘겨줌으로써 Consume을 하고 있는 컴포넌트에서 값이 변경된 경우에만 re-render가 발생하도록 구현하여 불필요한 re-render로 인한 성능 저하를 예방할 수 있다.
> 아래 예제의 콘솔로그를 확인.

<p class="codepen" data-height="265" data-theme-id="0" data-default-tab="js,result" data-user="gloriaJun" data-slug-hash="VNWKjz" style="height: 265px; box-sizing: border-box; display: flex; align-items: center; justify-content: center; border: 2px solid black; margin: 1em 0; padding: 1em;" data-pen-title="contextApi-no-render">
  <span>See the Pen <a href="https://codepen.io/gloriaJun/pen/VNWKjz/">
  contextApi-no-render</a> by gloria (<a href="https://codepen.io/gloriaJun">@gloriaJun</a>)
  on <a href="https://codepen.io">CodePen</a>.</span>
</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>



## References

- [Context – React](https://reactjs.org/docs/context.html)
- [GitHub - diegohaz/awesome-react-context: 😎 A curated list of stuff related to the new React Context API](https://github.com/diegohaz/awesome-react-context)
- [리액트 16.3 에 소개된 새로워진 Context API 파헤치기 \| VELOPERT.LOG](https://velopert.com/3606)
- [[Reactjs] v16.4 Context Api (Korean 한글) – Dongmin Jang – Medium](https://medium.com/@Dongmin_Jang/reactjs-context-api-korean-%ED%95%9C%EA%B8%80-%EC%9E%91%EC%84%B1%EC%A4%91-79edaf18efff)
- [React context and performance – Frontend Armory](https://frontarm.com/james-k-nelson/react-context-performance/)
