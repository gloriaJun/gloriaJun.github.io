---
layout: post
comments: true
title: "[Spring] HATEOAS"
date: 2017-04-14 17:00:00
categories: Spring
tags: spring hateoas
---

Hypermedia As The Engine Of Application State의 약어로 RESTful API 디자인에 대한 가이드? 규약 으로 이해하면 될 듯함.

예를 들어서..customer라는 같은 객체가 있다고 할 때에
```java
class Customer {
    String name;
}
```

간단히 json 방식으로 표현하면 아래와 같은데…
```json
{ 
    "name" : "Alice"
}
```

HATEOAS 기반으로 표현하면 다음과 같다.
```json
{
    "name": "Alice",
    "links": [ {
        "rel": "self",
        "href": "http://localhost:8080/customer/1"
    } ]
}
```

hateoas를 spring에 적용하는 방법은 다음과 같다.
###### Dependency
`build.gradle` 에 hateoas를 추가한다.
```
compile("org.springframework.boot:spring-boot-starter-hateoas")
```

###### domain 객체 생성
ResourceSupport에서 상속받아 생성한다.
```java
package study.todo.core.domain;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import org.springframework.hateoas.ResourceSupport;


@Data
@Getter
@Setter
public class ToDo extends ResourceSupport{
    long todoId;
    String text;
    boolean completed;

    public ToDo() {}
    public ToDo(long todoId, String text, boolean completed) {
        this.todoId = todoId;
        this.text = text;
        this.completed = completed;
    }
}
```

###### controller 생성
```java
    @GetMapping("/todo")
    public HttpEntity<List<ToDo>> getToDoList() {
        List<ToDo> toDoList = new ArrayList<ToDo>();

        ToDo toDo = new ToDo(1, "aaa", false);
        toDo.add(linkTo(methodOn(ToDoController.class).getToDoList()).withSelfRel());
        toDoList.add(toDo);

        return new ResponseEntity<List<ToDo>>(toDoList, HttpStatus.OK);
    }
```

###### 테스트 결과
해당 url을 호출하면 아래와 같은 형태로 객체가 리턴된다.
```json
[
  {
    "todoId": 1,
    "text": "aaa",
    "completed": false,
    "links": [
      {
        "rel": "self",
        "href": "http://localhost:8080/todo"
      }
    ]
  }
]
```
