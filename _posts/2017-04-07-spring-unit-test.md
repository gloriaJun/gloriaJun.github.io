---
layout: post
title: "[Spring Boot] unit test"
date: 2017-04-07 19:00:00
categories: Spring
tags: spring spring-boot unit-test
---

controller와 service에 대한 단위 테스트.

### Dependency 정의
pom.xml에 unit test를 위한 dependency를 추가한다.
```xml
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
        </dependency>
```

### Controller 테스트 클래스 생성
controller 테스트를 위한 클래스를 생성한 뒤에, MockMVC 객체를 생성하는 코드를 작성한다.
```java
package com.study.controller;

import com.study.Application;
import org.junit.Before;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = Application.class)
@SpringBootTest
public class ToDoControllerTest {
    private MockMvc mockMvc;
    @Autowired
    private WebApplicationContext ctx;

    @Before
    public void setup() {
        this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
    }
}
```

> **MockMVC ??**<br/>
> 실제 was에서 spring MVC가 요청에 응답하는 부분에 대해서 테스트를 할 수 있게 지원해줌.
> <br/><br/>
> **@WebAppConfiguration** <br/>
> WebApplicationContext를 생성할 수 있도록 해줌.


##### get 요청에 대한 테스트 메소드 작성
`@GetMapping("/") public List<ToDo> getAllToDo()`에 대한 테스트 메소드를 작성한다.
```java
    @Test
    public void testgetAllToDo() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.get("/").accept(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$", hasSize(2))).andDo(print());
    }
```

정상적으로 테스트가 수행이 되면 아래와 같은 로그가 출력이 된다.
```
MockHttpServletRequest:
      HTTP Method = GET
      Request URI = /
       Parameters = {}
          Headers = {Accept=[application/json;charset=UTF-8]}

Handler:
             Type = com.study.controller.ToDoController
           Method = public java.util.List<com.study.model.ToDo> com.study.controller.ToDoController.getAllToDo()

Async:
    Async started = false
     Async result = null

Resolved Exception:
             Type = null

ModelAndView:
        View name = null
             View = null
            Model = null

FlashMap:
       Attributes = null

MockHttpServletResponse:
           Status = 200
    Error message = null
          Headers = {Content-Type=[application/json;charset=UTF-8]}
     Content type = application/json;charset=UTF-8
             Body = [{"id":1,"text":"clean up the room","completed":false},{"id":2,"text":"study math","completed":true}]
    Forwarded URL = null
   Redirected URL = null
          Cookies = []
```

##### 에러처리에 대한 테스트 메소드를 작성.
```java
    @Test
    public void testInvalidgetToDobyId() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.get("/0").accept(MediaType.APPLICATION_JSON_UTF8))
                .andExpect(jsonPath("$.errorCode").value(404))
                .andDo(print());
    }

    @Test
    public void testInvalidRequest() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.post("/test").accept(MediaType.APPLICATION_JSON_UTF8))
                .andExpect(jsonPath("$.errorCode").value(400))
                .andDo(print());
    }
```

### Service 테스트 클래스 생성
Mockito를 이용하여 service에 대한 테스트 클래스를 작성한다. 
```java
package com.study.service;

import com.study.repository.ToDoRepository;
import com.study.service.impl.ToDoServiceImpl;
import org.junit.Before;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
public class ToDoServiceTest {
    @Mock
    private ToDoRepository toDoRepository;
    @InjectMocks
    private ToDoServiceImpl toDoService;

    @Before
    public void setup(){
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testGetAllToDo() {
        List<ToDo> toDoList = new ArrayList<ToDo>();
        toDoList.add(new ToDo(1, "go shopping", false));
        toDoList.add(new ToDo(2, "clean up", false));

        when(toDoRepository.findAll()).thenReturn(toDoList);

        List<ToDo> list = toDoService.getAllToDo();
        assertEquals(2, list.size());
    }
}
```


> **참고 링크**
>  https://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-testing.html#boot-features-testing-spring-boot-applications-testing-autoconfigured-rest-docs
> https://medium.com/@gustavo.ponce.ch/spring-boot-restful-junit-mockito-hamcrest-eclemma-5add7f725d4e
