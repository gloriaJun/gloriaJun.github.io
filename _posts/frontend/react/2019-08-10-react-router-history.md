---
layout: post
title: "(React) react-router history.block 적용해보기 - Prevents navigation"
date: 2019-08-10 12:35:00
author: gloria
categories: frontend
tags: javascript frontend react redux-router
---

`history.block`을 이용하면, 사용자의 뒤로 가기 동작 등과 같이 history 객체를 push/pop 하는 동작을 제어할 수 있다.
좀 더 자세한 내용은 https://github.com/ReactTraining/history#blocking-transitions 을 참고

## 컴포넌트 마운드 시점에 수행하도록 등록

```javascript
  useEffect(() => {
    history.block((location, action) => {
      console.log('#### history block', isBlock, action);
      if (isBlock && action === 'POP') {
        console.log('#### blocked ####');
        return false;
      }
    });
  }, []);
```

위와 같이 하고 로그를 확인해보면 `history.block`이 동작하는 시점에 항상 `isBlock`이 mount 시점에 할당된 값에서 변경이 되지 않는다.
그러다보니 중간에 state가 변경이 되어 전달되어져도 의도된 데로 동작을 하지 않는 이슈가 있다.

## 변경된 state가 반영되지 않는 이슈 해결

해당 이슈를 해결하기 위해 `left`가 변경이 되면 함수를 재생성하도록 하였다.

```javascript
  useEffect(() => {
    history.block((location, action) => {
      console.log('#### history block', isBlock, action);
      if (isBlock && action === 'POP') {
        console.log('#### blocked ####');
        return false;
      }
    });
  }, [isBlock]);
```

위와 같이 수정하고 나니 의도한 데로 동작을 하긴하지만 콘솔에 **Warning: A history supports only one prompt at a time** 메시지가 출력이 되었다.
![](https://user-images.githubusercontent.com/25721616/62817130-521cec00-bb6c-11e9-9852-3943d01265b1.png)

디버깅을 해보니 history.block의 메소드를 할당하는 과정에서 전달받은 `prompt`와 `nextPromp`를 비교하는 과정에서 현재의 prompt가 null이 아니면 발생하는 현상이었다.
즉, `isBlock`의 값이 이전의 값에서 변경이 발생하게 되면서 history.block에 전달된 callback 함수가 이전에 전달한 callback 함수와 다름으로써 발생하는 현상으로 유추할 수 있었다.

```javascript
// https://github.com/ReactTraining/history/blob/master/modules/createTransitionManager.js
function createTransitionManager() {
  var prompt = null;

  function setPrompt(nextPrompt) {
    // 이 부분에서 'prompt == null' 조건을 충족하지 않으면 메시지가 출력된다
    process.env.NODE_ENV !== "production" ? warning(prompt == null, 'A history supports only one prompt at a time') : void 0;
    prompt = nextPrompt;
    return function () {
      if (prompt === nextPrompt) prompt = null;
    };
  }
// SKIP
```

## warning 메시지 해결하기

해당 이슈를 해결하기 위해 react-router 문서를 보니 https://github.com/ReactTraining/history#blocking-transitions의 예제코드에 `unblock()` 호출 위의 코멘트에
아래와 같이 작성되어 있었다.

```javascript
// To stop blocking transitions, call the function returned from block().
unblock();
```

그래서 `useEffect`를 아래와 같이 수정하여 해당 이슈를 해결

```javascript
  useEffect(() => {
    const unblock = history.block((location, action) => {
      console.log('#### history block', isBlock, action);
      if (isBlock && action === 'POP') {
        console.log('#### blocked ####');
        return false;
      }
    });

    return () => unblock();
  }, [left]);
```

#### References

- https://github.com/ReactTraining/react-router/blob/master/packages/react-router/docs/api/history.md
- https://github.com/ReactTraining/history#blocking-transitions