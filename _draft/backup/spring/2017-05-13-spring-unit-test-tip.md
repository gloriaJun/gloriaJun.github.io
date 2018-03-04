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
 
#### Session에 저장된 정보를 사용하는 경우    
 controller에 대한 단위 테스트 시에 세션에 저장된 값을 가지고 동작하는 api에 대해 테스트를 하는 경우에 `MockHttpSession`을 사용하여 세션에 저장할 정보를 저장하고 api 호출하는 부분에서 세션에 저장한 것을 같이 넘겨주면 된다.    
 ```java
    private MockMvc mockMvc;
    private MockHttpSession mockSession;

    @Autowired private WebApplicationContext wac;
    @Autowired private DashboardService dashboardService;

    private UserInfo userInfo;

    @Before
    public void before() {
        mockMvc = MockMvcBuilders.webAppContextSetup(wac).build();

        // 로그인 사용자 정보 설정
        userInfo = new UserInfo("admin", "관리자", UserRole.Administrator);

        // 로그인 세션에 로그인 사용자의 정보 설정
        mockSession = new MockHttpSession();
        mockSession.setAttribute(UserContext.SESSION_USER, userInfo);
        mockSession.setAttribute(UserContext.SESSION_USER_NAME, userInfo.getUsername());
        mockSession.setAttribute(UserContext.SESSION_DISPLAY_NAME, userInfo.getDisplayName());
    }

    @Test
    public void dashboards() throws Exception {
        Dashboard d1 = makeDashboard("t1", "title", "app", "comp", DashboardType.Team);
        when(dashboardService.all()).thenReturn(Arrays.asList(d1));

        mockMvc.perform(get("/dashboard").session(mockSession))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(1)))
                .andExpect(jsonPath("$[0].template", is("t1")))
                .andExpect(jsonPath("$[0].title", is("title")))
                .andExpect(jsonPath("$[0].application.name", is("app")))
                .andExpect(jsonPath("$[0].application.components[0].name", is("comp")));
    }
```


> 참고 링크<br/>
> [java - Spring mvc 3.1 integration tests with session support - Stack Overflow](https://stackoverflow.com/questions/13687055/spring-mvc-3-1-integration-tests-with-session-support)     