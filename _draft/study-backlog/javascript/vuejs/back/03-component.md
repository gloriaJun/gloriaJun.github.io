유투브 강좌 내용 듣고 정리
https://www.youtube.com/watch?v=MBZVDsB4VMA&index=17&list=PL4cUxeGkcC9gQcYgjhBoeQH7wiAyZNrYa

## Nesting Components
#### 전역으로 컴포넌트를 선언
`main.js`에 다음과 같은 형태로 정의
```javascript
import Ninja from './Ninja.vue'

Vue.component('ninjas', Ninja);
```

#### 지역으로 컴포넌트 선언
해당 컴포넌트를 사용하고자 하는 vue 파일 내부에 다음과 같은 형태로 정의
```javascript
import Ninja from './Ninja.vue';

export default {
  components: {
    'ninjas': Ninja
  }
  (...중략...)
};
```

## Component CSS (scope)
각각의 컴포넌트에 대해 style 태그에 scope를 줄 수 있음.
```html
<style scoped>
h1 {
  color: green;
}
</style>
```

## props
각 컴포넌트에서 전달받을 프로퍼티에 대하여 다음과 같이 정의하여 속성과 필수 여부를 정의할 수 있다.
```javascript
props: {
  ninjas: {
    type: Array,
    required: true
  }
},
```

## events
자식 컴포넌트에서 부모 컴포넌트로 이벤트를 전달하기

- 자식 컴포넌트에 아래와 같이 이벤트를 정의
```javascript
methods: {
  changeTitle: function () {
      this.$emit('changeTitle', 'changed')
  }
}
```

- 부모 컴포넌트에서 다음과 같이 해당 이벤트를 받아서 처리한다.
```html
<app-header v-bind:title='title' v-on:changeTitle="updateTitle($event)"></app-header>

(...중략...)
methods: {
  updateTitle: function (newTitle) {
    this.title = newTitle;
  }
}
```

## slots
부모와 자식의 템플릿을 합치기 위한 엘리먼트이다.
- 부모 컴포넌트
```html
<div>
  <h1>나는 부모 컴포넌트의 제목입니다</h1>
  <my-component>
    <p>이것은 원본 컨텐츠 입니다.</p>
    <p>이것은 원본 중 추가 컨텐츠 입니다</p>
  </my-component>
</div>
```

- 자식 컴포넌트
```html
<div>
  <h2>나는 자식 컴포넌트의 제목입니다</h2>
  <slot></slot>
</div>
```
위의 내용은 화면에 아래와 같이 렌더링되어 표현된다.
```html
<div>
  <h1>나는 부모 컴포넌트의 제목입니다</h1>
  <div>
    <h2>나는 자식 컴포넌트의 제목 입니다</h2>
    <p>이것은 원본 컨텐츠 입니다.</p>
    <p>이것은 원본 중 추가 컨텐츠 입니다</p>
  </div>
</div>
```

slot에 이름을 주어서 워하는 위치에 넣을 수도 있다.
- 부모 컴포넌트
```html
<div>
  <h1>나는 부모 컴포넌트의 제목입니다</h1>
  <my-component>
    <p slot="header">헤더 입니다.</p>
    <p slot="footer">바닥글 입니다</p>
  </my-component>
</div>
```
- 자식 컴포넌트
```html
<div>
  <slot name="header"></slot>
  <h2>나는 자식 컴포넌트의 제목입니다</h2>
  <slot name="footer"></slot>
</div>
```

위의 내용은 화면에 아래와 같이 렌더링되어 표현된다.
```html
<div>
  <h1>나는 부모 컴포넌트의 제목입니다</h1>
  <div>
    <p>헤더 입니다.</p>
    <h2>나는 자식 컴포넌트의 제목 입니다</h2>
    <p>바닥글 입니다.</p>
  </div>
</div>
```

## Dynamic components
<component> 엘리먼트를 사용하여 여러 컴포넌트 간에 동적으로 트랜지션하고 is 속성에 동적으로 바인드 할 수 있다.
```html
<component v-bind:is="component"></component>
```
```javascript
import Home from './components/Home'
export default {
    components {
      home: 'Home'
    }
    data() {
      return {
        component: 'home'
      }
    }
}
```


## 참고글
[VueJs매뉴얼-컴포넌트](https://kr.vuejs.org/v2/guide/components.html)
