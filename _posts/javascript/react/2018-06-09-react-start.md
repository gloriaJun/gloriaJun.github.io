---
layout: post
title: "(React) react 시작하기"
date: 2018-06-09 21:35:00
author: gloria
categories: language
tags: javascript frontend react
---

## create-react-app 설치
`create-react-app`은 페이스북에서 제공하는 리액트 앱을 만들어주는 도구이다
```bash
$ yarn global add create-react-app
```

## create-react-app을 이용한 프로젝트 생성
```bash
$ create-react-app hello-react
$ cd hello-react
$ yarn start
```

프로젝트는 아래와 같이 구성되어 있다.
```bash
$ tree
.
├── README.md
├── package.json
├── public
│   ├── favicon.ico
│   ├── index.html
│   └── manifest.json
├── src
│   ├── App.css
│   ├── App.js
│   ├── App.test.js
│   ├── index.css
│   ├── index.js
│   ├── logo.svg
│   └── registerServiceWorker.js
└── yarn.lock

2 directories, 13 files
```

## LifeCycle
#### componentDidMount
컴포넌트가 화면에 나타났을 때 호출된다.  
DOM 을 사용해야하는 외부 라이브러리 연동을 하거나, 해당 컴포넌트에서 필요로하는 데이터를 요청하기 위해 axios, fetch 등을 통하여 ajax 요청을 하거나, DOM 의 속성을 읽거나 직접 변경하는 작업을 진행한다.
```javascript
componentWillReceiveProps(nextProps) {
  // this.props 는 아직 바뀌지 않은 상태
}
```

#### static getDerivedStateFromProps()
props 로 받아온 값을 state 로 동기화 하는 작업을 해줘야 하는 경우에 사용된다.
```javascript
static getDerivedStateFromProps(nextProps, prevState) {
  // 여기서는 setState 를 하는 것이 아니라
  // 특정 props 가 바뀔 때 설정하고 설정하고 싶은 state 값을 리턴하는 형태로
  // 사용됩니다.
  /*
  if (nextProps.value !== prevState.value) {
    return { value: nextProps.value };
  }
  return null; // null 을 리턴하면 따로 업데이트 할 것은 없다라는 의미
  */
}
```

#### shouldComponentUpdate
컴포넌트를 최적화하는 작업에서 매우 유용하게 사용된다.
이 함수는 기본적으로 true 를 반환합니다.
컴포넌트가 무수히 많이 렌더링되는 경우에 CPU 부하를 줄이기 위해서 해당 함수를 따로 작성한 뒤에 조건에 따라 false 를 반환하면 해당 조건에는 render 함수를 호출하지 않도록 처리함으로써 불필요하게 낭비되고 있는 CPU의 자원을 줄일 수 있다.
```javascript
shouldComponentUpdate(nextProps, nextState) {
  // return false 하면 업데이트를 안함
  // return this.props.checked !== nextProps.checked
  return true;
}
```

#### getSnapshotBeforeUpdate()
애니메이션 효과를 초기화하거나, 이벤트 리스너를 없애는 작업을 한다.
해당 함수가 호출되는 시점이다.
1. render()
2. getSnapshotBeforeUpdate()
3. 실제 DOM 에 변화 발생
4. componentDidUpdate

#### componentDidUpdate
여기서는 주로 등록했었던 이벤트를 제거하고, 만약에 setTimeout 을 걸은것이 있다면 clearTimeout 을 통하여 제거를 한다.
추가적으로, 외부 라이브러리를 사용한게 있고 해당 라이브러리에 dispose 기능이 있다면 여기서 호출해주면 된다.
```javascript
componentDidUpdate(prevProps, prevState, snapshot) {
}
```

#### componentWillUnmount
```javascript
componentWillUnmount() {
  // 이벤트, setTimeout, 외부 라이브러리 인스턴스 제거
}
```

#### componentDidCatch
에러가 발생하면 이런식으로 componentDidCatch 가 실행되게 하고, state.error 를 true 로 설정하게 하고, render 함수쪽에서 이에 따라 에러를 띄워주시면 됩니다.

이 API 를 사용하시게 될 때 주의하실 점이 있는데요, 컴포넌트 자신의 render 함수에서 에러가 발생해버리는것은 잡아낼 수는 없지만, 그 대신에 컴포넌트의 자식 컴포넌트 내부에서 발생하는 에러들을 잡아낼 수 있습니다
```javascript
componentDidCatch(error, info) {
  this.setState({
    error: true
  });
}
```

## 기억해두기!!
- 재사용 가능한 컴포넌트를 만듭니다.
- props 는 부모에게서 전달받는 값입니다.
- state 는 자기 자신이 지니고 있는 데이터입니다.
- props 나 state 가 바뀌면 컴포넌트는 리렌더링 합니다.
- LifeCycle API 를 통해서 컴포넌트 마운트, 업데이트, 언마운트 전후로 처리 할 로직을 설정하거나 리렌더링을 막아줄수도 있습니다.

## 기타 참고할만한 것들
#### 컴포넌트 스타일링
- [리액트 컴포넌트 스타일링 – CSS Module / Sass / styled-components](https://velopert.com/3447)
- [리액트 컴포넌트 스타일링, API 연동 실습 – NASA 에서 오늘의 우주 사진 가져오기](https://velopert.com/3503)

#### 상태관리
- 개념 : [리덕스(Redux)를 왜 쓸까? 그리고 리덕스를 편하게 사용하기 위한 발악 (i)](https://velopert.com/3528)
- 리액트에서 리덕스 적용 : [리덕스(Redux)를 왜 쓸까? 그리고 리덕스를 편하게 사용하기 위한 발악 (ii)](https://velopert.com/3533)
  - 컨테이너 컴포넌트 : 리덕스와 연동된 컴포넌트
  - 프리젠테이셔널 컴포넌트 : 단순히 뷰 만을 보여주기 위하여 만들어진 컴포넌트

#### 불변성
- [React ❤️ Immutable.js – 리액트의 불변함, 그리고 컴포넌트에서 Immutable.js 사용하기](https://velopert.com/3486)

#### 라우팅
- [리액트 라우터, 코드 스플리팅, 그리고 서버사이드 렌더링 :: 목차](https://velopert.com/3411)

## Reference
- [누구든지 하는 리액트 2편: 리액트 프로젝트 시작하기](https://velopert.com/3621)
- [누구든지 하는 리액트 5편: LifeCycle API](https://velopert.com/3631)
- [React-Tutorial](https://reactjs.org/tutorial/tutorial.html#help-im-stuck)
