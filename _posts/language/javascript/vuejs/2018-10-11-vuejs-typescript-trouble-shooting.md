---
layout: post
title: "(VueJS) TypeScript 적용하며 발생한 문제 해결 기록하기"
date: 2018-10-11 14:35:00
author: gloria
categories: language
tags: javascript typescript


---

[TOC]



Vue + TypeScript 를 적용해보니, 어찌 어찌 프로젝트도 생성하고, 프로그램도 돌아가지만...

Lint 설정이나 외부 라이브러리 로딩 등에서 생각보다 애를 먹고 있다. 관련 레퍼런스도 잘 없고…ㅠㅡㅠ

아주 산 넘어 산인 것 같은 느낌이다…사서 고생하는 느낌???

아무튼 나중에 똑같은 검색을 방지하고자 정답이 아닐 수도 있지만..회피 던 해결한 것이던 내용을 기록해두자.



## 외부 라이브러리 로딩하기

Vue 컴포넌트 라이브러리를 import하여 사용하려고 하면, 'type'이 정의되지 않아서 사용하지 못한다거나 하는 등의 에러가 발생한다.

####Can not resolve definitions for module… 

```typescript
// @/components/Hello.vue
import VueCropper from 'vue-cropperjs'; 
import 'cropperjs/dist/cropper.min.css';

/*
'vue-cropperjs'가 빨간 줄로 표시되고, 
"Can not resolve definitions for module ~~~~" 하는 메시지가 표현이 된다.
*/
```



###### 조치한 내용

해당 문제를 아래와 같이 해결하는 것이 맞는 지는 모르지만...[타입스크립트에서 써드 파티 라이브러리 사용하기](https://blog.martinwork.co.kr/typescript/2018/05/30/how-to-use-third-party-library.html)  글을 참고해서 `shims-vue.d.ts`에 아래의 줄을 추가하니 일단 해당 에러는 해결이 되었다.

```typescript
// src/shims-vue.d.ts
declare module '*.vue' {
  import Vue from 'vue';
  export default Vue;
}

// 아래의 구문을 추가했음
declare module 'vue-cropperjs' {
    import Vue from 'vue';
    export default Vue;
}
```



#### Property 'getCroppedCanvas' does not exist on type 'Vue'. 

외부 컴포넌트 라이브러리를 아래와 같이 사용하려고 하면 발생하는 TsLint에서 출력하는 오류이다.

```typescript
<vue-cropper
    v-if="imgSrc"
    ref="cropper"
	...(중략)
    background>
    </vue-cropper>

...(중략)

@Emit('upload')
private handleClickConfirm(): string | ArrayBuffer | null {
    this.imgSrc = (this.$refs.cropper as Vue).getCroppedCanvas().toDataURL();
    return this.imgSrc;
}
```



`$refs`는 타입이 정의된 파일을 열어서보면..Vue, Element의 타입을 받을 수 있다고 정의되어 있었다.

```typescript
// vue.d.ts
readonly $refs: { [key: string]: Vue | Element | Vue[] | Element[] };
```



`vue-cropper` 컴포넌트의 타입을 Vue로 사용하겠다고 하고 내부 함수를 호출하도록 작성하였는데..Vue 타입에 getCroppedCanvas 메서드가 정의되어 있지 않으니, 에러를 발생시키는 거다..

물론, 동작상에는 문제가 없지만…찜찜하다..빨간 줄 왠지 기분 나쁘다..ㅠㅠ

그래서 어떻게든 해결해보려고 Vue 대신 다른 타입으로도 바꾸고 해봤지만..실패…아직도 답을 못찾았다…(아..Lint 지옥…ㅠㅠ)



## Reference

- [타입스크립트에서 써드 파티 라이브러리 사용하기](https://blog.martinwork.co.kr/typescript/2018/05/30/how-to-use-third-party-library.html)  