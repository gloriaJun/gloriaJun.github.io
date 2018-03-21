---
layout: post
title: "(VueJS) vuex를 이용하여 data를 로딩하여 meta 정보 출력하기"
date: 2018-03-19 22:35:00
author: gloria
categories: language
tags: javascript vuejs nuxt vuex
---

Nuxt.js를 이용하여 기존에 SPA로 구현한 코드를 SSR로 리팩토링을 하고 있다.
static page로 generate 해주는 기능도 있어 공부삼아 리팩토링 중~~

그러다가 현재의 메인 경로에 따라서 head에 출력되는 정보를 동적으로 변경하기 위해서 vue.js에서 route를 이용하던 부분을 vuex를 이용하도록 수정해보았다.
> 기존에 route를 이용하여 동적반영하던 부분의 예제는 [(VueJs) vue-router"]({{ post.url }}/2018-03-01-vuejs-route)를 참고


#### 데이타 정의
```javascript
module.exports = {
  app: {
    meta: {
      title: 'TEST',
      favicon: 'favicon.ico'
    }
  }
}
```

#### vuex 코드
```javascript
import Vuex from 'vuex'
import contentData from '~/assets/data.js'

export default () => {
  return new Vuex.Store({
    state: {
      contents: {}
    },
    getters: {
      getContents: state => state.contents
    },
    mutations: {
      setContents: (state, payload) => {
        state.contents = payload.contents
      }
    },
    actions: {
      content: ({commit}, key) => {
        return new Promise((resolve, reject) => {
          let contents = contentData[key]
          commit('setContents', { contents })
          resolve(contents.meta)
        })
      }
    }
  })
}
```

#### index.vue
```javascript
// pages/index.vue
import { mapActions } from 'vuex'

export default {
  name: 'Test',
  components: {
  },
  data () {
    return {
      meta: {}
    }
  },
  /**
   * header 정보 설정
   */
  head () {
    return {
      title: this.meta.title,
      link: [
        { rel: 'icon', type: 'image/x-icon', href: this.meta.favicon }
      ]
    }
  },
  async created () {
    this.meta = await this.content('app')
  },
  methods: {
    ...mapActions([
      'content'
    ])
  }
}
```

#### 다른 컴포넌트에서 store 데이타 가져다 쓰기
```javascript
// layouts/default.vue
import { mapGetters } from 'vuex'

export default {
  name: 'App',
  components: {
  },
  data () {
    return {
      navbar: {}
    }
  },
  computed: {
    ...mapGetters([
      'getContents'
    ])
  },
  mounted () {
    this.navbar = this.getContents.navbar
  }
}
```
