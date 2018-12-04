---
layout: post
title: "(Javascript) 객체 속성 존재여부 확인하기"
date: 2018-11-21 15:15:00
author: gloria
categories: language
tags: javascript

---

Object에 속성 값이 존재하는 지 여부를 체크하기 위한 방법들과 차이점(?) 정리

아래와 같이 `obj` 라는 이름의 객체가 있을 때에...
```javascript
const obj = Object.create({
    name: 'Jake',
});
obj.gender = 'male';
```

해당 객체에 특정  속성이 존재하는 지에 대한 여부를 확인하기 위해서는.....
1. 객체의 값을 출력하여 값이 존재하는 지 여부를 가지고 확인      
```javascript
console.log(obj.name, !!obj.name); // Jake true
console.log(obj.gender, !!obj.gender); // male true
console.log(!!obj.toString); // true
```

2. `in` 연산자를 이용하여 확인        
```javascript
console.log('name' in obj); // true
console.log('gender' in obj); // true
console.log('toString' in obj); // true
```

3. Object.prototype.hasOwnProperty
위의 두 가지 방법은 객체 자신의 속성 값인지 여부에 대한 체크는 하지 않는다. 상속 받은 부모나 자신에게 해당 속성 값 존재 여부에 달려있다.
만약, 객체 자신의 포함하고 있는 지에 대하여 확인하려면 `Object.prototype.hasOwnProperty` 메소드를 사용하여 확인하여야 한다.     
```javascript
console.log(obj.hasOwnProperty('name')); // false
console.log(obj.hasOwnProperty('gender')); // true
console.log(obj.hasOwnProperty('toString')); // false
```


## Reference
- [객체 더 알아보기](https://helloworldjavascript.net/pages/240-object-in-depth.html)

###### Object.create
`Object.create`를 이용하여 객체를 생성하면, 해당 프로토타입의 속성을 생성하는 객체에서 재사용할 수 있다. (상속의 개념으로 생각하면 되는 듯)

```javascript
obj = Object.create({ name: 'Jake' });
/*
Object
	__proto__:
		name: "Jake"
 		__proto__: Object
*/
 
obj2 = { name: 'Jake' };
/*
Object
 	name: "Jake"
 	__proto__: Object
*/
```



- [쉽게 이해하는 자바스크립트 프로토타입 체인](https://meetup.toast.com/posts/104)