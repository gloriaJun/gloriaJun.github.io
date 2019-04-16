---
layout: post
title: "(React) React.memo() : Prevent unnecessary re-renders"
date: 2019-04-12 12:35:00
author: gloria
categories: frontend
tags: javascript frontend react
---

`React.memo()`는 React v16.6에서 소개된 새로운 기능이다.

- `React.PureComponent`와 유사하게 동작한다
- functional components를 이용하여 PureComponent의 메모이제이션 기능을 사용할 수 있게 해준다.

> **memoization - wikipedia**
> In computing, memoization or memoisation is an optimization technique used primarily to speed up computer programs by storing the results of expensive function calls and returning the cached result when the same inputs occur again.

## 예제

[example - CodeSandbox](https://codesandbox.io/s/mo96j5xvk9)

```javascript
import React from "react";
import ReactDOM from "react-dom";

const View = ({ name }) => {
  console.log("render..");
  return `Hi, I'm ${name}`;
};

class App extends React.Component {
  names = ["Peter", "Bruce", "Clark"];
  state = { name: "Anonymous" };

  componentDidMount() {
    setInterval(() => {
      const name = this.generateName();
      this.setState({ name });
    }, 1000);
  }

  generateName = () =>
    this.names[Math.floor(Math.random() * this.names.length)];

  render() {
    return <View name="Sam" />;
  }
}

const rootElement = document.getElementById("root");
ReactDOM.render(<App />, rootElement);
```

위의 예제 코드를 실행해보면 `View` 컴포넌트는 부모 컴포넌트의 state가 변경될 때마다 전달받은 props의 값이 변경되지 않았음에도 re-rendering이 발생한다.
즉, 불필요한 re-rendering 발생하고 있다는 뜻이다,.

`React.memo`를 이용하여 해당 문제를 해결할 수 있다.

`View` 컴포넌트를 생성하는 부분을 아래와 같이 수정해주면, 더 이상 불필요한 re-rendering이 발생하지 않는다.

```javascript
const View = React.memo(({ name }) => {
  console.log("render..");
  return `Hi, I'm ${name}`;
});
```

또한 `View` 컴포넌트에 전달하는 값을 아래와 같이 수정하더라도, `generateName`에서 동일한 값이 설정된 경우에는 rendering이 발생하지 않는다.
```javascript
return <View name={this.state.name} />;
```

## Reference

- [React - React.memo](https://reactjs.org/docs/react-api.html#reactmemo)
- [Using React Memo and memoization – Sam Pakvis – Medium](https://medium.com/@trekinbami/using-react-memo-and-memoization-1970eb1ed128)
