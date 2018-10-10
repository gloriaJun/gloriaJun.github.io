---
layout: post
title: "(TypeScript) Overview"
date: 2018-10-10 18:35:00
author: gloria
categories: language
tags: typescript

---

[TOC]

## TypeScript

- JavaScript의 슈퍼셋이다.
- 프로그래밍 언어이다.
- Javascript는 Interpreted 언어 (컴파일 필요없음)이나, TypeScript는 Compiled 언어(컴파일이 필요)이다.
  - 컴파일 시점에 타입을 체크한다.

> 아래의 사이트에서 작성한 타입스크립트가 자바스크립트로 컴파일 된 결과를 확인 및 테스트 해볼 수 있다.
>
> http://www.typescriptlang.org/play/index.html

#### 장단점을 정리해보면..

- 장점

  타입이 명확해진다. 별도의 문서가 필요없을 수도

- 단점

  초반의 구조 잡는 시간이 필요



#### 알아야하는 것

- typescript 문법
- typescript가 javascript로 변환되는 과정과 커스터마이징 방법



## Basic Types

ECMAScript 표준에 따른 기본 자료형 외에 아래의 타입이 추가로 제공된다.

- Any 
  - 어떤 타입이어도 상관없는 타입니다. 컴파일 타임에 타입 체크가 정상적으로 이뤄지지 않으므로  최대한 사용하지 않는 것을 권장
- Void
- Never
- Enum
- Tuple - Object type



## Type Assertion

타입스크립트 컴파일러에게 정확히 어떤 타입인지 알려주는 것으로 주로 *넓은 타입에서 좁은 타입으로 강제하는 경우가 많다*

문법적으로는 두 가지 방법이 있음

- 변수 as 강제할 타입  — 주로 이 방법으로 사용됨
- <강제할 타입>변수

```typescript
let some: any = "this is a string";
let len: number = (some as string).length;
```



## Type Alias

- 이미 정의된 타입의 refer로 사용하는 것이지 타입을 생성하는 것은 아니다.

```typescript
let b: string | number;

// 매번 'string | number'과 같이 반복해서 사용하게 되는 경우 임시로 해당 타입에 대해 별칭을 정의하여 사용
type StringOrNumber = string | number;

function test(arg: StringOrNumber): StringOrNumber {
    return arg;
}
```



##  Interface

Java의 interface와 유사하다.

```typescript
interface Person {
    name: string;
    age?: number; // 필수 아님
}

const person: Person = {
    name: 'Mike',
    age: 20,
};

function hello(person: Person): void {
    console.log(`Hello, ${person.name}.`);
}

// 컴파일 결과
/*
var person = {
    name: 'Mike',
    age: 20,
};
function hello(person) {
    console.log("Hello, " + person.name + ".");
}
*/
```



#### indexable type

interface의 미리 정의하지 않은 프로퍼티를 사전에 정의하는 optional type으로 `string`또는 `number`만 정의하여 사용이 가능하다.

*array* 또는 *dictionary* 와 같은 두 가지 형태로 제공된다

```typescript
// ex1) like dictionary
interface Person {
    name: string;
    [index: string]: string;
}

const person: Person = {
    name: 'Mike',
};
person.job = 'student';
person.address = 'Seoul';

// ex2) like array
interface Person2 {
    [index: number]: Person;
}

const p2: Person2 = {};
p2[0] = { name: 'Jay' };
p2[10] = { name: 'Jane' };
```



#### function in interface

```typescript
interface Person {
    name: string;
    hello(): void;
    hello2(): string;
}

const person: Person = {
    name: 'Mike',
    hello: () => {
        console.log('hello');
    },
    hello2: (): string => {
        return 'Hello2';
    }
};
```



#### class implements interface

가장 많이 사용되는 형태이다

```typ
 interface IPerson {
    name: string;
    hello(): void;
}

class Person implements IPerson {
    name: string = null;
        
    constructor(name: string) {
        this.name = name;
    }

    hello(): void {
        console.log(`Hello, ${this.name}`);
    }
}

const person: Person = new Person('Mike');
person.hello();
```



#### interface extends interface

```typescript
interface IPerson {
    name: string;
    hello(): void;
}

interface IPerson2 extends IPerson {
    city: string;
}
```



#### function interface

함수 정의 시점이 아니라 사용 시점에 타입을 체크한다.

```typescript
interface IHelloPerson {
    (name: string, age?: number): void;
}

let helloPerson: IHelloPerson = function (name: string) {
    console.log(`Hello, ${name}`);
}

helloPerson('Jake');
```



## Class

https://www.youtube.com/watch?v=eSaeHFD0aJA&list=PLV6pYUAZ-ZoEBNDzOxzToMqv-V1QGlU0T&index=9





## 유투브 강좌

https://www.youtube.com/watch?v=fgIHrsgvBH4&list=PLV6pYUAZ-ZoEBNDzOxzToMqv-V1QGlU0T