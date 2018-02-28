## 컴포넌트 구조

```javascript
<template lang="html">
	<div>
		<!-- ... -->
	</div>
</template>

<script type="text/javascript">
  export default {
    name: 'VipContent',
    // compose new components
    extends: {},
    // 컴포넌트 어트리뷰트 그룹
    props: { // 알파벳 순으로 작성
		contentData: {
 			type: Object,
			required: true
		},
		value: {
        	type: Number,
        	default: 100
      	},
		obj: {
        	type: Object,
      		default () { return {} }
      	}
	},
    // 컴포넌트 변수 그룹
    data() {},
    computed: {},
    // 컴포넌트가 다른 컴포넌트를 사용할 경우
    components: {},
    // 컴포넌트 메서드 그룹
    watch: {},
    methods: {},
    // 컴포넌트 라이프사이클 메서드 그룹
    beforeCreate() {},
    mounted() {},
};
</script>

<style lang="scss" scoped>
</style>
```
