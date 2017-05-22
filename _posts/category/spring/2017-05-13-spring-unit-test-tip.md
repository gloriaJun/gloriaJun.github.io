---
layout: post
comments: true
title: "[Spring Boot] Unit Test Tip 정리"
date: 2017-05-13 11:10:00
categories: Spring
tags: spring spring-boot unit-test
---

단위테스트 작성 관련되어서 참고했던 부분들 정리하기...

## MockMvc 
#### Object를 파라미터로 전달하는 경우
spring boot에서는 `com.fasterxml.jackson.databind`의  `ObjectMapper`를 의존라이브러리로 포함하고 있어서 해당 객체를 파라미터 전달을 위해 object를 json으로 변환하기 위해 사용하면 됨.
```java
    @Test
    public void testsaveToDo() throws Exception {
        ObjectMapper objectMapper = new ObjectMapper();
        mockMvc.perform(MockMvcRequestBuilders
                    .post("/todo").accept(MediaType.APPLICATION_JSON_UTF8)
                    .content(objectMapper.writeValueAsString(new ToDo(1, "go shopping", false)))
                    )
                .andExpect(status().isOk())
                .andExpect(MockMvcResultMatchers.content().contentType(MediaType.APPLICATION_JSON_UTF8))
                .andDo(print());
    }
```

> 참고 링크<br/>
> [Using custom arguments in Spring MVC controllers](https://sdqali.in/blog/2016/01/29/using-custom-arguments-in-spring-mvc-controllers/)  