---
layout: post
title: "(React) code splitting을 이용하여 번들된 파일 최적화 하기"
date: 2019-04-11 22:35:00
author: gloria
categories: frontend
tags: javascript frontend react performance
---

* TOC
{:toc}

# Code Splitting

> 아래의 버전 기준으로 테스트 및 작성하였음
> - React 16.8.x
> - React Router 5.x

![](https://jamie.build/img/react-loadable-component-splitting.png)
< Router vs component centric code splitting >


앱의 규모가 커짐에 따라 Bundling 되어 제공되는 파일의 사이즈도 커지게 됨으로써  앱의 로딩 속도가 느려지게 된다.
이러한 문제를 해결하기 위해 `Code Splitting`을 적용하여 현재 필요한 모듈만 로딩(lazy-load) 되도록 하여 성능을 향상시킬 수 있다.


## Dynamic Imports

Code Splitting을 적용하기에 가능 좋은 방법이다.

```javascript
/* 
import { add } from './math';

console.log(add(16, 26));
*/

import("./math").then(math => {
  console.log(math.add(16, 26));
});
```

> - create-react-app을 사용한 경우 webpack에 적용되어 있다.
> - webpack을 직접 설정하고자 하면 [Webpack-Code Splitting](https://webpack.js.org/guides/code-splitting/) 문서를 참고한다.


## Code Splitting in React

React에서 Code Splitting을 적용하기 위해서는 React 16.6.0+버전을 사용하는 경우 React.lazy 또는 Loadable Component를 사용할 수 있다.
만약, 그 이전 버전을 사용하는 경우라면, HOC를 이용하여 asyncComponent를 생성하여 사용하거나 react-lodable 라이브러리를 이용할 수 있다.

### The Async Component HOC

비동기적으로 컴포넌트를 import 하기 위한 HOC(Higher-Order Component)를 작성한다.

```javascript
import React from 'react';

const asyncComponent = importComponent => {
  class AsyncComponent extends React.Component {
    constructor(props) {
      super(props);

      this.state = {
        component: null,
      };
    }

    componentDidMount() {
      importComponent()
        .then(({ default: component }) => this.setState({ component }));
    }

    render() {
      const { component: Component } = this.state;
      return Component ? <Component {...this.props} /> : null;
    }
  }

  return AsyncComponent;
};

export default asyncComponent;
```

위와 같이 작성한 코드를 router에 아래와 같이 적용하여 사용한다.
```javascript
import React from 'react';
import { Switch, Route, withRouter, Link } from 'react-router-dom';
import lazy from "./components/AsyncComponent";

const Card = lazy(() => import('./Card'));

function WithLazyLoad({ match }) {
  const routes = {
    card: `${match.path}/card`,
  };

  return (
    <React.Fragment>
      <ul>
        <li><Link to={routes.card}>card</Link></li>
      </ul>

	  <Switch>
    	    <Route path={routes.card} component={Card} />
      </Switch>
    </React.Fragment>
  );
};

export default withRouter(WithLazyLoad);
```

### React.lazy & Suspend

React 16.6.0 버전에서 릴리즈된 기능이다.

- React.lazy와 Suspend는 서버사이드 렌더링을 지원하지 않는다.
- `Suspense` 컴포넌트를 사용하여, 동적으로 불러온 컴포넌트가 로드되지 않은 경우 **로딩중**과 같은 fallback content 표현이 가능하다.

#### 예제

```javascript
import React, { Suspense, lazy } from 'react';
import { Switch, Route, withRouter, Link } from 'react-router-dom';

const Card = lazy(() => import(
	/* webpackChunkName: "my-chunk-name" */
	/* webpackPrefetch: true */
	'./Card'
));

function WithLazyLoad({ match }) {
  const routes = {
    card: `${match.path}/card`,
  };

  return (
    <React.Fragment>
      <ul>
        <li><Link to={routes.card}>card</Link></li>
      </ul>

	  <Suspense fallback={<div>Loading...</div>}>
	      <Switch>
    	    <Route path={routes.card} component={Card} />
	      </Switch>
	  </Suspense>
    </React.Fragment>
  );
}

export default withRouter(WithLazyLoad);
```

#### Issue with React Router

React.lazy를 React Router와 함께 사용하기 위해서는 `react-router-dom 4.4+`로 업데이트가 필요하다. 
이전 버전과 사용 시 정상적인 동작을 하지 않고, 아래와 같은 에러가 브라우저 콘솔에 출력된다.

```bash
checkPropTypes.js:20 Warning: Failed prop type: Invalid prop `component` of type `object` supplied to `Route`, expected `function`.
    in Route (created by CodeSplit)
    in CodeSplit (created by Route)
    in Route (created by withRouter(CodeSplit))
    in withRouter(CodeSplit) (created by Route)
    in Route (created by App)
    in Switch (created by App)
    in App (created by Route)
    in Route (created by withRouter(App))
    in withRouter(App)
    in Router (created by BrowserRouter)
    in BrowserRouter
```
 
 - [관련 오류에 대한 Stack Overflow 이슈](https://stackoverflow.com/questions/53007905/react-router-with-react-16-6-suspense-invalid-prop-component-of-type-object)


### Loadable Components

[Loadable Components](https://github.com/smooth-code/loadable-components)는 SSR 환경에서도 dynamic import를 사용할 수 있게 지원한다.

- 2019년 1월 이전에는 React 공식문서에서 code splitting을 위해 권장하는 외부 모듈을 [react-loadable](https://github.com/jamiebuilds/react-loadable)에서 **lodable components**로 변경이 되었다. ([문서 변경 이력](https://github.com/reactjs/reactjs.org/commit/5284091bdd21e393fb1ddbee7ebe98a3ad560356#diff-6fc584657241b5ee0532a533ed47aca6))
  - react-loadable이 Webpack v4+과 Babel v7+에 더이상 호환이 되지 않으며, 유지보수가 되지 않는 문제가 있다고함.
- ver 2.x까지는 loadable-components으로 배포되었음.
- ver 3.x부터는 @loadable/component으로 API가 전체적으로 변경되었으며, 모듈명 또한 변경되어 배포되고 있음
- **@loadable/component**를 **react-router-dom 4.3.x 이하 버전**과 사용 시 React.lazy와 브라우저 콘솔에 동일한 오류 메시지가 발생하나 정상적으로 동작은 함. (react-router-dom 4.4+으로 설치하면 해당 에러는 발생하지 않음.)
  - React.lazy의 경우에는 동작도 안하고 브라우저 콘솔에 오류도 발생함.
  - 구 버전 loadable-components을 사용하면 정상 동작 및 에러 로그가 출력되지 않으나, ver 2.x 사용을 권고하지 않고 있음. 
- React.lazy의 경우 SSR을 지원하지 않으므로, SSR로 프로젝트를 구성하는 경우에 lodable을 이용하여 Code Splitting을 적용할 수 있다.


#### 예제

```javascript
import React from 'react';
import { Switch, Route, withRouter, Link } from 'react-router-dom';
import lodable from '@loadable/component';

const Card = lodable(() => import(
  /* webpackChunkName: "card" */
  /* webpackPrefetch: true */
  './Card'
));

function WithLazyLoad({ match }) {
  const routes = {
    card: `${match.path}/lazy/card`,
  };

  return (
    <React.Fragment>
      <ul>
        <li><Link to={routes.card}>card</Link></li>
      </ul>

      <Switch>
        <Route exact path={routes.card} component={Card} />
      </Switch>
    </React.Fragment>
  );
}

export default withRouter(WithLazyLoad);
```

#### Lodable vs React.lazy

| Library               | Suspense | SSR | Library splitting | `` import(`./${value}`) `` |
| --------------------- | -------- | --- | ----------------- | -------------------------- |
| `React.lazy`          | ✅       | ❌  | ❌                | ❌                         |
| `@loadable/component` | ✅       | ✅  | ✅                | ✅                         |

#### 그 외의 Lodable 기능 정리

##### Library Spitting

loadable.lib 함수를 이용하여 moment, lodash, date-fn 등과 같은 라이브러리를 동적으로 import 하여 사용할 수 있다.


_하지만, splitchunks를 이용하여 하나의 vendor 파일로 번들링하여 제공하는 경우에는 해당 기능에 대한 효과가 미비하지 않나 하는 생각이 든다._

```javascript
import Loadable from '@loadable/component'

const DateFns = Loadable.lib(() => import('date-fns'));

const Today = ({ date }) => {
  return (
    <DateFns>
      {({ format }) => format(new Date())}
    </DateFns>
  )
};
```


##### Dynamic Full Import (import(`./${value}`)

import 하고자 하는 모듈명을 동적으로 변수에 받아서 사용할 수 있다.

```javascript
import loadable from '@loadable/component'
const AsyncPage = loadable(props => import(`./${props.page}`))
function MyComponent() {
  return (
    <div>
      <AsyncPage page="Home" />
      <AsyncPage page="Contact" />
    </div>
  )
}
```

##### Suspense

모듈이 아직 로딩되지 않은 경우에 대한 fallback 옵션을  React.Suspense, lodable option, props를 이용하여 구현할 수 있다.

###### React.Suspense

lazy 함수를 이용하여 React.lazy와 유사한 기능을 구현할 수 있다.

```javascript
import React, { Suspense } from 'react'
import { lazy } from '@loadable/component'
const OtherComponent = lazy(() => import('./OtherComponent'))
function MyComponent() {
  return (
    <div>
      <Suspense fallback={<div>Loading...</div>}>
        <OtherComponent />
      </Suspense>
    </div>
  )
}
```

###### lodable option

import 시에 fallback 옵션을 주어 구현할 수 있다.

```javascript
const OtherComponent = loadable(() => import('./OtherComponent'), {
  fallback: <div>Loading...</div>,
})
function MyComponent() {
  return (
    <div>
      <OtherComponent />
    </div>
  )
}
```

###### props

```javascript
const OtherComponent = loadable(() => import('./OtherComponent'))
function MyComponent() {
  return (
    <div>
      <OtherComponent fallback={<div>Loading...</div>} />
    </div>
  )
}
```

##### Preload

webpack의 webpackPreload 옵션을 이용하거나, mouse over와 같은 이벤트에 trigger를 줘서 강제로 미리 리소스를 가져오게 할 수 있다.

```javascript
import loadable from '@loadable/component'
const Infos = loadable(() => import('./Infos'))
function App() {
  const [show, setShow] = useState(false)
  return (
    <div>
      <a onMouseOver={() => Infos.preload()} onClick={() => setShow(true)}>
        Show Infos
      </a>
      {show && <Infos />}
    </div>
  )
}
const OtherComponent = loadable(() =>
  import(/* webpackPrefetch: true */ './OtherComponent'),
)
```

## Code Splitting 적용 전과 후 비교

code splitting을 적용 전과 후에 대해, 빌드 후 산출물에 대한 결과를 콘솔로그를 통해 확인해볼 수 있다.
또한 브라우저의 개발자 도구의 네트워크 탭을 이용하여서도 확인해볼 수 있다.

### 적용 전

```bash
File sizes after gzip:

build/static/js/main.4f770bef.chunk.js
  762 B     build/static/js/runtime~main.a8a9905a.js
```

### 적용 후

- 빌드 후 산출물 결과
```bash
File sizes after gzip:

  64.51 KB (-2.32 KB)  build/static/js/2.83664c0f.chunk.js
  4.04 KB              build/static/js/4.f371891f.chunk.js
  3.89 KB              build/static/js/3.5dd0df58.chunk.js
  3.88 KB              build/static/js/5.a9d90777.chunk.js
  3.53 KB              build/static/js/6.cd5e91ef.chunk.js
  1.66 KB (-1.7 KB)    build/static/js/main.c7be9de0.chunk.js
  1.16 KB (+430 B)     build/static/js/runtime~main.44f277e2.js
```

## webpack을 이용하여 좀 더 번들링된 파일 최적화 하기

React.lazy, lodable을 통하여 컴포넌트에 대한 번들링 파일을 분할한 뒤에 webpack을 이용하여 추가적으로 번들링 파일에 대한 최적화를 적용할 수 있다.

즉, **Dynamic Import**를 이용하여 Code Splitting을 적용한 뒤에 각각의 분할된 소스에 자주 사용되는 모듈들의 경우 각 chunk 파일에 중복되어 번들링이 되어있을 가능성이 높다.
그러므로 중복되어 있는 모듈들을 분리하여 별도의 chunk 파일로 생성하여 파일의 사이즈를 줄이기 위해 webpack의 `SplitChunk`를 적용할 수 있다.

해당 옵션을 적용함으로써...
- 브라우저에서 리소스를 동시에 요청할 수 있어 로딩 시간을 절약할 수 있다.
- lodash, moment 등과 같은 모듈이 번들링된 chunk(ex. vendor~.js)의 경우 캐싱된 데이타를 이용할 수 있다.
- 자주 변경이 일어나지 않는 모듈에 대하여 캐싱된 데이타를 이용할 수 있다.

### Setting ouput filename

chunk 파일명을 `chunkhash`를 이용하여 아래와 같은 패턴으로 설정해준다.

```javascript
// webpack.config.js

output: {
  chunkFilename: mode === 'production' ? '[name].[chunkhash].js' : '[name].[hash].js',
},
```

- `[id]`보다는 모듈명을 구분하기 쉽게 `[name]`을 사용한다.
- `[hash]`보다는 `[chunkhash]`를 사용한다.
  - `[hash]`는 빌드시점마다 고유값이 변경되지만, `[chunkhash]`는 파일의 내용이 변경이 된 경우에만 고유값이 변경된다.

### Magic Comment

Magic Comment는 모듈을 import 시에 comment를 추가함으로써 chunk 파일명을 정의하거나, prefetch/preload 등과 같은 모드를 선택할 수 있다.
import(
  /* webpackChunkName: "my-chunk-name" */
  /* webpackPrefetch: true */
  /* webpackPreload: true */
  'module'
);

> import 시에 추가적으로 사용가능한 comment는 [webpack-Module Methods](https://webpack.js.org/api/module-methods/#magic-comments)를 참고

#### webpackChunkName

모듈을 import할 때에 아래와 같이 chunk 파일명을 명시한다.
만약, 여러 개의 모듈에 동일한 chunk 파일명을 적용하면 해당 파일명으로 합쳐서 번들링이 된다.

```javascript
const DynamicText = Loadable(() => import(/* webpackChunkName: "DynamicText" */ './DynamicText'));
```

#### webpackPrefetch / webpackPreload

- webpackPrefetch : 브라우저가 판단하여 유휴한 시간이 미리 리소스를 받아 놓는다.
- webpackPreload : 필요하지만 당장은 필요하지 않은 리소스를 미리 로드 해놓도록 하기 위한 옵션

> [preload-webpack-plugin](https://github.com/GoogleChromeLabs/preload-webpack-plugin)를 이용하여 webpack config 설정 파일에 적용할 수 있다 (webapck4+ 인 경우에는 `yarn add -D preload-webpack-plugin@next`와 같이 설치한다)


### Splitting Duplicated Chunk


자주 사용되어 중복으로 import된 모듈을 별도의 chunk 파일로 생성하기 위한 설정이다.
번들 파일을 적절히 분리함으로써 브라우저 캐시를 전략적으로 활용할 수 있어 초기 로딩속도를 최적화할 수 있다.

아래와 같은 설정을 지원한다.
- 파일 사이즈, 비동기 요청 횟수 등의 옵션에 따라 자동으로 분리
- 정규식에 따라서 특정 파일들만 분리
- 특정 엔트리 포인트를 분리 

```javascript
optimization: {
  // https://webpack.js.org/plugins/split-chunks-plugin/#optimization-splitchunks
  splitChunks: {
    chunks: 'all',
    cacheGroups: {
      vendor: {
        chunks: 'all',
        name: 'vendor',
        enforce: true,
        test: /[\\/]node_modules[\\/]/,
      },
    },
  },
},
```

- chunk
  - all : 테스트 조건에 해당하는 모든 모듈
  - initial : 초기 로딩에 필요한 경우
  - async : import() 를 이용해 다이나믹하게 사용되는 경우
- 각 chunk 옵션에 대해 잘 설명해놓은 글 : [Webpack 4 — Mysterious SplitChunks Plugin – DailyJS – Medium](https://medium.com/dailyjs/webpack-4-splitchunks-plugin-d9fbbe091fd0)
- 좀 더 자세한 내용은 [SplitChunksPlugin \| webpack](https://webpack.js.org/plugins/split-chunks-plugin/#select-chunks) 참고

> `CommonsChunkPlugin`으로 제공되던 기능을 webpack4부터는 `splitChunks` 옵션을 이용하여 적용할 수 있도록 변경되었다.


#### 적용 전과 후 비교

##### 적용 전

```bash
                       Asset       Size          Chunks             Chunk Names
          index.1.0.0.0.html  635 bytes         [emitted]  
              app.1.0.0.0.js   4.03 MiB   app   [emitted]  app
Entrypoint app = app.1.0.0.0.js
```


##### 적용 후

```bash

                       Asset       Size          Chunks             Chunk Names
          index.1.0.0.0.html  703 bytes                  [emitted]  
            app.1.0.0.0.js    356 KiB               app  [emitted]  app
          vendor.1.0.0.0.js   3.68 MiB          vendor  [emitted]  vendor
Entrypoint app = vendor.1.0.0.0.js app.1.0.0.0.js
```

## Analyze the webpack bundle with Visualizer

추가로 code splitting을 통해 번들 파일을 최적화 하는 과정에서 `webpack-bundle-analyzer` 또는 `source-map-explorer`와 같이 도구의 도움을 받을 수 있다.

### Webpack Bundle Analyzer
[webpack-bundle-analyzer](https://github.com/webpack-contrib/webpack-bundle-analyzer)는 번들 파일을 최적화하기 위한 시각화된 웹 서비스를 제공한다.

#### Installation

해당 기능을 사용하기 위해서는 먼저 플러그인을 설치해준다.
```bash
npm install --save-dev webpack-bundle-analyzer
# or
yarn add -D webpack-bundle-analyzer
```

그리고 webpack config 파일에 아래의 설정을 추가해준다.

```javascript
const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;

module.exports = {
  plugins: [
    new BundleAnalyzerPlugin(),
  ]
}
```

이후 webpack을 실행해보면 아래와 같이 번들링된 결과를 웹 페이지로 확인할 수 있다.
![](https://cloud.githubusercontent.com/assets/302213/20628702/93f72404-b338-11e6-92d4-9a365550a701.gif)

#### Generate Report

아래와 같은 옵션을 설정을 추가하여 보고서를 생성할 수 있다.

```javascript
new BundleAnalyzerPlugin({
      analyzerMode: "static",               // 분석결과를 파일로 저장
      reportFilename: "docs/size_dev.html", // 분설결과 파일을 저장할 경로와 파일명 지정
      defaultSizes: "parsed",
      openAnalyzer: true,                   // 웹팩 빌드 후 보고서파일을 자동으로 열지 여부
      generateStatsFile: true,              // 웹팩 stats.json 파일 자동생성
      statsFilename: "docs/stats_dev.json", // stats.json 파일명 rename
    }),
```

### Source Map Explorer

[source-map-explorer](https://github.com/danvk/source-map-explorer)는 minified된 번들 파일의 source map을 분석하여 보여준다.
해당 기능을 사용하기 위해서는 빌드된 산출물이 존재해야하고, 번들링된 파일은 소스맵을 포하하고 있어야 한다.

## Reference Link

- [React Doc - Code-Splitting](https://reactjs.org/docs/code-splitting.html)
- [Code Splitting in Create React App](https://serverless-stack.com/chapters/code-splitting-in-create-react-app.html)
- [Tinder의 프로그래시브 웹 앱 성능 케이스 스터디 - KYU.IO 🌾](https://kyu.io/ko/tinder%EC%9D%98-%ED%94%84%EB%A1%9C%EA%B7%B8%EB%9E%98%EC%8B%9C%EB%B8%8C-%EC%9B%B9-%EC%95%B1-%EC%84%B1%EB%8A%A5-%EC%BC%80%EC%9D%B4%EC%8A%A4-%EC%8A%A4%ED%84%B0%EB%94%94/)
- [Decrease webpack bunlding file size Jungbin’s Blog](https://blog.jungbin.kim/web/2019/02/16/js-decreaing-webpack-bundle.html)
- [SPA 초기 로딩 속도 개선하기 – little big programming – Medium](https://medium.com/little-big-programming/spa-%EC%B4%88%EA%B8%B0-%EB%A1%9C%EB%94%A9-%EC%86%8D%EB%8F%84-%EA%B0%9C%EC%84%A0%ED%95%98%EA%B8%B0-9db137d25566)
