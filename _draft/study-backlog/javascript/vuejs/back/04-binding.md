# Binding
[강좌 링크](https://www.youtube.com/watch?v=yopDG8t60ko&index=29&list=PL4cUxeGkcC9gQcYgjhBoeQH7wiAyZNrYa)

## Input Binding
폼에 입력하여 입력한 내용을 preview와 같이 보여주려고 하는 경우, input의 포커스가 잃었을 때 바이딩 처리가 하고 싶다면 `lazy`를 추가해주면 된다.
```html
<input type="text" v-model.lazy="name"/>
<p>Name : {{ name }}</p>
```
```javascript
data() {
  return {
    name: ''
  }
}
```

## Checkbox Binding
```html
<input type="checkbox" value='Kay' v-model="teams"/>
<input type="checkbox" value='Judy' v-model="teams"/>
```
```javascript
data() {
  return {
    teams:[]
  }
}
```

## Select Box Binding
```html
<select v-model="blog.author">
  <option v-for="author in authors">{{ author }}</option>
</select>
```
```javascript
data() {
  return {
    blog: {
      author:''
    },
    authors: [/*...*/]
  }
}
```


## 참고글
[VueJs매뉴얼-폼 입력 바인딩](https://kr.vuejs.org/v2/guide/components.html)
