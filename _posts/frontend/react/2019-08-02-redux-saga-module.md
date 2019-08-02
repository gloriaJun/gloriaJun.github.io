---
layout: post
title: "(React) redux-saga 반복 정의되는 부분 모듈화 하기"
date: 2019-08-02 15:35:00
author: gloria
categories: frontend
tags: javascript frontend react redux-saga
---

redux-saga를 이용하여 비동기 로직 처리를 작성하다보면 `로딩 처리 -> try-catch 감싸서 api 호출`하는 로직이 반복되어 작성되어 진다.
이 부분을 어떻게 하면 모듈화 할 수 있을 지 고민한 기록이다.

모듈을 정의하기 전에 기존의 작성된 코드를 파악하고, 아래의 규칙을 나름대로 정의를 하였다.

- 가능한 최소화의 공통화를 가져간다.
    - 로딩처리, 데이타를 put하는 동작, 에러 발생 동작에 대해 반복적인 부분을 공통화한다.
    - 로딩과 에러처리의 경우 보통 공통적으로 처리되는 경우가 대부분이다.
    - 비지니스 로직이 복잡해질 수 있는 reducer로 전달할 데이타를 가공하는 부분은 각각의 saga 로직에서 정의한다.
      - 그 데이타가 가공된 결과를 `resultData`에 담아 전달하도록 처리하기
    - 그리고 각 화면단의 성공/에러 후의 처리에 대해서는 `onSuccess, onError`를 콜백메서드로 전달받음으로써 처리할 수 있다.

그리고 난 뒤에 반복되어지는 부분을 떼어서 아래와 같이 `sagaCreator` 메소드를 생성하였다.
 
```javascript
import { put } from 'redux-saga/effects';

export default function* sagaCreator(actionObject, resultData, onSuccess, onError) {
  const { pending, success, fail } = actionObject;

  yield put(pending());
  try {
    yield put(success(resultData));
    onSuccess && onSuccess();
  } catch (error) {
    yield put(fail({ error }));
    onError && onError(error);
  }
}
```

위와 같이 모듈화를 하게 되면...가져올 수 있는 이점은 아래와 같다고 개인적으로는 생각한다.

- 해당 메서드에서 집중해야하는 부분에 좀 더 집중하여 코드를 작성할 수 있고,
- 코드를 좀 더 간결하게 가져감으로써 불필요한 반복되는 로직은 크게 신경쓰지 않아도 된다.
- 반복되는 코드에 대한 사후 수정 시 깜빡하거나, 오타로 인한 사소한 오류를 줄일 수 있다.

#### 적용 전/후 코드 saga 비지니스 처리 로직 비교

##### AS-IS

```javascript
function* fetchAccounts({ payload }) {
  const { pending, success, fail } = action.fetchAccounts;

  yield put(pending());
  try {
    const result = yield call(api.fetchAccounts, payload);
    yield put(success(result));
  } catch (error) {
    yield put(fail({ error }));
  }
}

function* fetchMain({ payload }) {
  const { pending, success, fail } = action.fetchMain;

  yield put(pending());
  try {
    const [{ content: account }, { content: recentlySent }, { content: history }] = yield all([
      call(api.fetchAccount, payload),
      call(api.fetchRecently),
      call(api.fetchHistory, payload),
    ]);
    yield put(success({ account, recentlySent, history }));
  } catch (error) {
    yield put(fail({ error }));
  }
}
```

##### TO-BE

```javascript
function* fetchAccounts({ onSuccess, onError }) {
  const method = 'fetchAccounts';
  const result = yield call(api[method]);
  yield call(sagaCreator, action[method], result, onSuccess, onError);
}

function* fetchMain({ onSuccess, onError, ...payload }) {
  const result = yield all({
    account: call(api.fetchAccount, payload),
    recentlySent: call(api.fetchRecently, payload),
    history: call(api.fetchHistory, payload),
  });

  yield call(sagaCreator, action.fetchMain, result, onSuccess, onError);
}
```
