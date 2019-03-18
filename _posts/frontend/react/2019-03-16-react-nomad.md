---
layout: post
title: "(React) ReactJs로 웹서비스 만들기 (Nomad Coders)"
date: 2019-03-16 22:35:00
author: gloria
categories: frontend
tags: javascript frontend react
---

[강의링크](https://academy.nomadcoders.co/courses/enrolled/216871)
[실습소스](https://github.com/nomadcoders/movie_app)

# Why React ?

1. Just JavaScript
  * Javascript 기반이므로 별도로 다른 프레임워크를 배울 필요가 없다.
2. composition
  * 요소별, 컴포넌트별로 나눠서 작업을 할 수 있다
  * component 별로 나누어 개발을 하므로 재사용성이 향상된다
3. Unidirectional(단방향) 데이터플로우이다.
  * 데이타는 정해진 장소(state)에 정해져있다. 그리고 데이타가 변경에 따라 UI가 변경된다.

> React는 Framework가 아니다! Library이다.

# Let's Do It

## Create Project

만약, `create-react-app`이 설치되어있지 않다면 설치해준다.

```bash
npm install -g create-react-app
# or
yarn global add create-react-app
```

프로젝트를 생성한다.

```bash
create-react-app movie-app
```

## Component 구성

구현을 해야하는 페이지를 기반으로 각 요소를 구분해서 component로 구성하여 구현한다

**모든 component는 render component를 가지고 있다**

```javascript
class App extends Component {
  render() {
    return (
      <div className="App"> 
      </div>
    );
  }
}
```

### ReactDOM

`src/index.js`를 보면 아래와 같이 구성되어 있다.

```javascript
import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import * as serviceWorker from './serviceWorker';

ReactDOM.render(<App />, document.getElementById('root'));

serviceWorker.unregister();
```

* ReactDOM은 리액트를 웹사이트에 rendering할 수 있게 도와주는 모델이다.
* ReactDOM은 1개의 컴포넌트를 render하고, 해당 컴포넌트 안에는 여러 개의 컴포넌트가 포함될 수 있다.

## React Props & State

### props

부모가 자식에게 데이타를 props을 통하여 전달해준다

* 부모 컴포넌트

```javascript
const movies = [
  'Frozen',
]

class App extends Component {
  render() {
    return (
      <div className="App">
        <Movie title={movies[0]}/>
      </div>
    );
  }
}
```

* 자식 컴포넌트

```javascript
class Movie extends Component {
    render() {
        return (
            <h1>{this.props.title}</h1>
        )
    }
}
```

#### propType

props에 대하여 전달받아야 하는 타입을 정의해서 체크할 수 있다.

```javascript
static propTypes = {
    title: React.propTypes.string,
    poster: React.propTypes.string
}
```

### state

React Component 안에 존재하는 Object이다.
컴포넌트 안에 state가 바뀌면 update가 발생한다.

값을 변경하는 경우에 `this.setState({})`를 이용하여 수정해야한다.

## React Life Cycle

* Render
  * componentWillMount() -> render() -> componentDidMount()
* Update
  * componentWillReceiveProps() -> shouldComponentUpdate() -> componentWillUpdate() -> render() -> componentDidUpdate()

### function component

state가 존재하지 않는 컴포넌트이다. 
단지 html 템플릿을 생성하여 return 하기 위해 사용한다.

```javascript
function MoviePoster({poster}) {
    return (
        <img alt="" src={poster}/>
    )
}

MoviePoster.propTypes = {
    poster: propTypes.string.isRequired
}
```