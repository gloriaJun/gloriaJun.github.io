---
layout: post
title: "(Javascript) 대량 데이타 처리를 위한 selectbox"
date: 2018-12-18 15:35:00
author: gloria
categories: language
tags: javascript animation
---

* TOC
{:toc}

예를 들어서 다건의 동적 셀렉트박스를 생성할 때에 자바스크립트에서는 싱글 스레드 기반으로 동작을 하므로 긴 작업 시간이 필요한 동작을 수행하게 되면 일명 멈춤현상이 발생하게 된다.
이러한 현상은 사용자에게 브라우저가 느리다는 인식과 불편한을 줄 수 있어 반드시 피해야만 하는 상황이다.

아래는 예제코드이다...
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        #select-box .popup {
            display: none;
            position: absolute;
            overflow: auto;
            width: 300px;
            height: 200px;
            border: 1px solid grey;
        }
        #select-box .popup.show {
            display: block;
        }
        #counter {
            font-size: 24px;
        }
    </style>
</head>
<body>

<span id="counter">0</span>

<div id="select-box">
    <span class="title">This is select box</span>

    <div class="popup">
        <ul class="list"></ul>
    </div>
</div>

<script>
    let counter = 0;

    document.addEventListener('DOMContentLoaded', function() {

      // update count when every second
      const counterText = document.querySelector('#counter');
      setInterval(function () {
        counterText.innerText = ++counter;
      });
    });


    const selelctBox = document.querySelector('#select-box');
    const selelctBoxTitle = selelctBox.querySelector('span.title');
    const selelctBoxPopup = selelctBox.querySelector('.popup');
    const selectBoxItems = selelctBox.querySelector('ul.list');

    // create data
    let data = [];
    for (let i = 0; i < 100000; i++) {
      data.push(`item${i}`);
    }

    // create select box by create data
    let len = data.length;
    for (let i = 0; i < len; i++) {
      selectBoxItems.appendChild(createItem(data[i]));
    }

    // add event handler
    selelctBoxTitle.addEventListener('click', function () {
      selelctBoxPopup.classList.toggle('show');
    });

    function createItem(data) {
      let el = document.createElement('li');
      el.innerText = data;
      el.classList.add('item');

      el.addEventListener('click', function () {
        selelctBoxTitle.innerText = data;
        selelctBoxPopup.classList.toggle('show');
      });

      return el;
    }

</script>
</body>
</html>
```

해당 코드를 수행한 뒤에 프로파일링을 해보면...100000건의 데이터를 조립하여 셀렉트 박스를 출력하는 과정에서 꽤 오랜 시간이 소요되는 것을 확인할 수 있다. (이 시점에 사용자는 버벅 거리는 현상을 체험..)
![데이타 10만건]({{ site.baseurl }}/assets/images/post/selectBoxPerfor-slow.png)

## 성능 개선하기
해당 현상을 아래와 같은 과정을 통하여 개선할 수 있다.

#### 작업을 쪼개어 수행하기
아이템을 큐에 넣어서 매 프레임마다 나누어 수행하도록 처리한다.

#### requestIdleCallback()
[requestIdleCallback()](https://developer.mozilla.org/ko/docs/Web/API/Window/requestIdleCallback) 메서드 - 크롬과 파이어폭스에서 제공하는 함수로써 매 프레임마다 브라우저가 판단하여 시간적 여유가 있는 경우에 등록한 함수를 호출한다.

#### requestAnimationFrame() 
`setInterval()`이나 `setTimeout()`에서 delay에 설정한 값을 해당 값을 정확하게 보장해주지 않는다. 적어도 해당 시간 이내에는 동작을 하지 않는 것을 보장해줄 뿐이다.
[requestAnimationFrame()](https://developer.mozilla.org/ko/docs/Web/API/Window/requestAnimationFrame)은 DOM을 제어하기 위해 자바스크립트에서 제공하는 함수로써, 각 프레임의 스타일 계산, 렌더링 전에 실행되도록 정의되어 있다. 

#### DocumentFragment
[DocumentFragment](https://developer.mozilla.org/ko/docs/Web/API/DocumentFragment)는 하나의 가상 DOM 엘리먼트처럼 동작함으로써 reflow&repaint에 대한 비용을 감소 시키는 효과로 인한 성능을 향상 효과를 기대할 수 있다.

#### 수정된 코드
위의 내용들을 반영하여 코드를 수정하면 아래와 같다.
```javascript
<script>
    let counter = 0;
    let itemQueue = (function () {
      let list = [];

      return {
        enqueue: (item) => list.push(item),
        dequeue: () => list.shift(),
        isEmpty: () => list.length === 0,
      }
    })();

    document.addEventListener('DOMContentLoaded', function() {

      // update count when every second
      const counterText = document.querySelector('#counter');
      setInterval(function () {
        counterText.innerText = ++counter;
      });
    });


    const selelctBox = document.querySelector('#select-box');
    const selelctBoxTitle = selelctBox.querySelector('span.title');
    const selelctBoxPopup = selelctBox.querySelector('.popup');
    const selectBoxItems = selelctBox.querySelector('ul.list');

    // create data
    let data = [];
    for (let i = 0; i < 100000; i++) {
      data.push(`item${i}`);
    }

    console.time();
    // create select box by create data
    let len = data.length;
    for (let i = 0; i < len; i++) {
      itemQueue.enqueue({
        execute: function(fragment) {
          fragment.appendChild(createItem(data[i]));
        }
      })

      window.requestIdleCallback(processChanges);
    }

    // add event handler
    selelctBoxTitle.addEventListener('click', function () {
      selelctBoxPopup.classList.toggle('show');
    });

    function createItem(data) {
      let el = document.createElement('li');
      el.innerText = data;
      el.classList.add('item');

      el.addEventListener('click', function () {
        selelctBoxTitle.innerText = data;
        selelctBoxPopup.classList.toggle('show');
      });

      return el;
    }


    function processChanges(deadline) {
      let fragment = document.createDocumentFragment();

      // deadline.timeRemaining() - 현재 예상되는 남은 시간을 리턴해준다.
      while (deadline.timeRemaining() > 0 && !itemQueue.isEmpty()) {
        let item = itemQueue.dequeue();
        if (item) {
          item.execute(fragment);
        }
      }

      window.requestAnimationFrame(function () {
        selectBoxItems.appendChild(fragment);
      });

      if (!itemQueue.isEmpty()) {
        window.requestIdleCallback(processChanges);
      } else {
        console.timeEnd();
      }
    }

</script>
```

위의 코드로 프로파일링을 해보면...동일 건수에 대하여 아래와 같은 결과가 출력되는 것을 확인할 수 있다.
![데이타 10만건-성능개선]({{ site.baseurl }}/assets/images/post/selectBoxPerfor-refact1.png)
![데이타 10만건-함수호출트리]({{ site.baseurl }}/assets/images/post/selectBoxPerfor-funcTree.png)


#### dequeue 성능 개선
dequeue하는 과정에서 shift() 메소드의 성능이 문제가 되는 것을 확인할 수 있다. 배열을 동적으로 변경하는 작업은 배열이 커질 수록 성능에 영향을 미치므로 다른 자료구조를 이용하여 구현하는 것이 효율적일 수 있다.
일단, 단순하게 배열의 index를 이용하여 접근하는 방식으로 코드를 개선하여 다시 프로파일링을 해보면, dequeue의 수행 시간이 확연하게 줄어든 것을 확인할 수 있다.

```javascript
    let itemQueue = (function () {
      let list = [];
      let index = 0;

      return {
        enqueue: (item) => list.push(item),
        dequeue: () => {
          // list.shift();
          return list[index++];
        },
        isEmpty: () => (list.length - index) === 0,
      }
    })();
```

#### select box 클릭 시의 브라우저 멈춤 현상 개선
`display`를 이용한 css 처리는 reflow&repaint를 발생시킨다. 프로파일링을 확인해보면, 아래와 같이 layout 작업에서 많은 시간이 소요되는 것을 확인할 수 있다.
![데이타 10만건-reflow]({{ site.baseurl }}/assets/images/post/selectBoxPerfor-reflow.png)

해당 부분을 해결하기 위해서는 `display`와 비슷한 속성인 `visibility` 옵션을 사용하면, repaint만 발생하므로 reflow에 대한 비용을 줄일 수 있다.
```css
#select-box .popup {
	/*display: none;*/
	visibility:hidden;
	position: absolute;
	overflow: auto;
	width: 300px;
	height: 200px;
	border: 1px solid grey;
}
#select-box .popup.show {
	/*display: block;*/
	visibility: visible;
}
```

수정한 뒤에 프로파일링 결과를 확인해보면 아래와 같이 성능이 향상된 것과 클릭 시에 화면 멈춤 현상이 기존보다 개선된 것을 확인할 수 있다.
![데이타 10만건-reflow개선]({{ site.baseurl }}/assets/images/post/selectBoxPerfor-reflow2.png)


## Reference
- [100,000개의 아이템도 거뜬한 셀렉트박스 만들기](https://meetup.toast.com/posts/160)
