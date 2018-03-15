---
layout: post
title: "(Javascript) Promise Loop"
date: 2018-03-06 14:35:00
author: gloria
categories: language
tags: javascript promise callback
---

#### 특정 조건을 만족할 때까지 반복하기
```Javascript
function funcPromise (data, percent) {
  return new Promise((resolve, reject) => {
    resolve({
      result: percent === 100? 'ok' : 'no',
      percent: percent
    })
  })
}

function promiseLoop (data, func) {
  let percent = 0
  return new Promise((resolve, reject) => {
    let loop = () => {
      func(data, percent)
        .then(res => {
          if (res.percent >= 100) {
            resolve(res.result)
          } else {
            percent += 25
            console.info('[INFO] api call retry : ', percent)
            setTimeout(loop(data), 30 * 1000)
          }
        })
    }
    loop(data)
  })
}

promiseLoop({key: 10}, funcPromise)
  .then(res => {
    console.log('result : ', res)
  })
```


## Reference
- http://www.datchley.name/promise-patterns-anti-patterns/
- http://han41858.tistory.com/11
- https://lowrey.me/while-loop-with-es6-promises/
