# ECMAScript6

## 변수 선언
기존 `var 키워드`를 이용한 변수 선언의 단점을 보완하기 위해 `let`과 `const` 키워드가 도입되었음

다음과 같이 사용하는 것을 추천한다고...
- ES6를 사용한다면 var 키워드는 사용하지 않는다.
- 변경이 발생하지 않는(재할당이 필요없는) primitive형 변수와 객체형 변수에는 const를 사용한다.
- 재할당이 필요한 primitive형 변수에는 let를 사용한다.

#### let
1. Block-level scope를 갖는다.
```javascript
let foo = 123;
{
  let foo = 456;
  let bar = 456;
}
console.log(foo); // 123
console.log(bar); // ReferenceError: bar is not defined
```

2. 중복 선언시 SyntaxError가 발생한다.
```javascript
let bar = 123;
let bar = 456;  // Uncaught SyntaxError: Identifier 'bar' has already been declared
```

3. 호이스팅(Hoisting)
let 키워드로 선언된 변수는 선언 단계와 초기화 단계가 분리되어 진행된다.
즉, 스코프에 변수가 등록(선언단계)되지만 초기화 단계는 변수 선언문에 도달했을 때 이루어진다. 초기화 이전에 변수에 접근하려고 하면 ReferenceError 에러가 발생한다. 이는 변수가 아직 초기화되지 않았기 때문인데 스코프의 시작 지점부터 초기화 시작 지점까지를 일시적 사각지대(Temporal Dead Zone; TDZ)라고 부른다.
> **호이스팅**
> var 선언문이나 function 선언문 등을 해당 스코프의 선두로 옮기는 것을 말함.

#### const
상수 선언을 위해 보통 사용하지만, 객체 타입 변수 선언을 위해서도 사용한다.
객체 타입 변수 선언에 const를 사용하는 경우의 장점은 다음과 같다.
- 객체에 대한 참조는 변경될 필요가 없다. 즉, 재할당이 필요없다. 만일 새로운 객체에 대한 참조를 변수에 할당해야 한다면 새로운 변수를 사용하면 된다.
- const를 사용한다 하더라도 객체의 프로퍼티를 변경할 수 있다.


## 템플릿 리터럴(template Literals)
다음과 같이 문자열을 정의하는 표기법을 의미한다.

- 작은 따옴표와 큰 따옴표를 혼용하여 사용 가능
```javascript
const template = `템플릿 리터럴은 '작은따옴표(single quotes)'과 "큰따옴표(double quotes)"를 혼용할 수 있다.`;

console.log(template);
```

- 여러 줄에 걸쳐 문자열을 작성할 수 있음
```javascript
const template = `<ul class="nav-items">
  <li><a href="#home">Home</a></li>
  <li><a href="#about">About</a></li>
</ul>`;

console.log(template);
```
- `${expression}`과 같은 템플릿 대입문을 이용하여 문자열 대입 또는 javascript 표현식을 사용할 수 있다.
```javascript
const first = 'Ung-mo';
const last = 'Lee';

// ES6 String Interpolation
console.log(`My name is ${first} ${last}.`); // My name is Ung-mo Lee.
// 템플릿 대입문에는 문자열뿐만 아니라 표현식도 사용할 수 있다.
console.log(`1 + 1 = ${1 + 1}`); // 1 + 1 = 2
console.log(`Hello ${last.toUpperCase()}`); // Hello LEE
```

#### Tagged Template Literals
함수 이름을 이용하여 작성하는 템플릿 리터럴이다.

```javascript
function sides(literals, ...expressions) {
  console.log(literals);
  console.log(expressions);
}

let name = "James";
let day = "Morning";
sides`Hello, ${name}. Good ${day} !!`;

// ["Hello, ", ". Good ", " !!"]
// ["James", "Morning"]
```
위와 같이 호출하면  `literals` 변수에는 문자열을 expression을 기준으로 split 하여 배열로 넘겨준다.
그리고 `expressions`에는 표현식의 결과를 배열로 넘겨준다.

#### String.raw
특수문자와 유니코드는 문자열 그대로 인식하여 출력한다.
```javascript
let one=1, two =2;
console.log(String.raw `1+2=${one + two}\n 라인개행도 문자열로 표시된다.`);
// 1+2=3\n 라인개행도 문자열로 표시된다.
console.log(`1+2=${one + two}\n 라인개행도 문자열로 표시된다.`);
// 1+2=3
// 라인개행도 문자열로 표시된다.
```

위와 같은 template literals는 아래와 같은 정규식 문자열 생성 시에 유용하게 활용할 수 있다.
```javascript
function createNumberRegExp(english) {
    const PERIOD = english ? String.raw`\.` : '';
    return new RegExp(`[0-9]+(${PERIOD}[0-9]+)?`);
}
```

## Arrow function
Arrow function(화살표 함수)은 function 키워드 대신 화살표(=>)를 사용하여 간략한 방법으로 함수를 선언할 수 있다. 함수로 사용되는 경우에는 익명함수로만 사용할 수 있다.
```javascript
// 매개변수 지정 방법
    () => { ... } // 매개변수가 없을 경우
     x => { ... } // 매개변수가 한개인 경우, 소괄호를 생략할 수 있다.
(x, y) => { ... } // 매개변수가 여러개인 경우

// 함수 몸체 지정 방법
x => { return x * x }  // single line block
x => x * x             // 함수 몸체가 한줄의 표현식이라면 중괄호를 생략할 수 있으며 자동으로 return된다. 위 표현과 동일하다.

() => { return { a: 1 }; }
() => ({ a: 1 })  // 위 표현과 동일하다. 객체 반환시 소괄호를 사용한다.

() => {           // multi line block.
  const x = 10;
  return x * x;
};
```

#### Arrow Function을 사용해서는 안되는 경우
1. 메소드 정의 (객체 내부, prototype 등에 메소드를 정의하는 경우)
2. 생성자 함수
3. addEventListener 함수의 콜백 함수 - 콜백함수 내부의 this가 상위 컨텍스트를 가리키게 된다.


## Extended Parameter Handling
#### 파라미터 초기값 설정
ES5에서는 별도로 파라미터 초기값을 설정할 수 없었으나, ES6 부터는 파라미터에 초기값을 설정할 수 있다.
```javascript
// ES5
function plus(x, y) {
  x = x || 0;
  y = y || 0;
  return x + y;
}

// ES6
function plus(x=0, y=0) {
  return x + y;
}
```

#### Rest 파라미터 (Rest Parameter)
spread 연산자(...)을 사용하여 파라미터를 작성한 형태를 말하며, 반드시 마지막 파라미터로 정의되어야한다.
```javascript
function foo(...rest) {
  console.log(Array.isArray(rest)); // true
  console.log(rest); // [ 1, 2, 3, 4, 5 ]
}
```

ES5에서는 파라미터를 통하여 가변인자 전달을 받기 위한 arguments 프로퍼티가 존재하였으며, 이 전달받은 인자를 배열 메서드로 사용하기 위해 다음과 같이 변환을 해주어야 했다.
```javascript
// ES5
function sum() {
  // 가변 인자 함수의 경우, 파라미터를 통해 인수를 전달받는 것이 불가능하므로 arguments 객체를 활용하여 인수를 전달받는다.
  // arguments 객체를 배열로 변환
  var array = Array.prototype.slice.call(arguments);
  return array.reduce(function (pre, cur) {
    return pre + cur;
  });
}

console.log(sum(1, 2, 3, 4, 5)); // 15
```

하지만, ES6에서는 arguments 프로퍼티가 없으며, rest 파라미터를 사용하도록 가이드하고 있다.

#### Spread 연산자 (Spread Operator)
Spread 연산자(...)는 연산자의 대상 배열 또는 이터러블을 개별 요소로 분리한다.
```javascript
// ...[1, 2, 3]는 [1, 2, 3]을 개별 요소로 분리한다(-> 1, 2, 3)
console.log(...[1, 2, 3]) // -> 1, 2, 3

// 문자열은 이터러블이다.
console.log(...'Helllo');  // H e l l l o
```


## Enhanced Object property
http://poiemaweb.com/es6-enhanced-object-property




## Reference
- [poiemaweb-ECMAScript6](http://poiemaweb.com/es6-block-scope)
- [Spread Operator](http://mollangk.tistory.com/29)
