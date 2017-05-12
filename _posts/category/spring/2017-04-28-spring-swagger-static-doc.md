---
layout: post
title: "[Spring Boot] swagger static-doc 설정하기"
date: 2017-04-28 17:00:00
categories: Spring
tags: spring spring-boot gradle swagger
---

swagger로 작성된 문서를 asciidoc, markdown 문서로 변환하는 방법

## 의존성 설정 (build.gradle)
```
ext {
	swaggerVersion=2.6.1
}

dependencies {
    ...(SKIP)...
    // documents
    compile "io.springfox:springfox-swagger2:${swaggerVersion}"
    testCompile "io.springfox:springfox-staticdocs:${swaggerVersion}"
}
```

## Generate Markup during an unit test
생성된 문서를 asciidoc이나 markdown 문서로 변환하는 테스트 코드를 작성한다.
해당 테스트가 수행이 되면 산출물 디렉토리에 변환된 문서가 생성된다.
```java
package com.study.booktree.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import io.github.robwin.markup.builder.MarkupLanguage;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.study.booktree.DemoApplication;
import com.study.booktree.config.SwaggerConfig;

import springfox.documentation.staticdocs.Swagger2MarkupResultHandler;

@WebAppConfiguration
@RunWith(SpringRunner.class)
@SpringBootTest (classes = {DemoApplication.class, SwaggerConfig.class})
public class Swagger2MarkupTest {

  @Autowired
  private WebApplicationContext context;

  private MockMvc mockMvc;

  @Before
  public void setUp() {
    this.mockMvc = MockMvcBuilders.webAppContextSetup(this.context).build();
  }

  @Test
  public void createSpringfoxSwaggerJson() throws Exception {
    this.mockMvc.perform(get("/api-docs?group=booktree")
        .accept(MediaType.APPLICATION_JSON))
        .andDo(Swagger2MarkupResultHandler.outputDirectory("build/docs/asciidoc/generated").build())
        .andExpect(status().isOk());
  }

  @Test
  public void convertSwaggerToMarkdown() throws Exception {
    this.mockMvc.perform(get("/api-docs?group=booktree")
        .accept(MediaType.APPLICATION_JSON))
        .andDo(Swagger2MarkupResultHandler.outputDirectory("build/docs/markdown/generated")
            .withMarkupLanguage(MarkupLanguage.MARKDOWN).build())
        .andExpect(status().isOk());
  }
}
```

해당 테스트 코드를 수행하고 나면 아래와 같은 산출물이 생성된다.
```
$ tree build/docs/
build/docs/
├── asciidoc
│   └── generated
│       ├── definitions.adoc
│       ├── overview.adoc
│       └── paths.adoc
└── markdown
    └── generated
        ├── definitions.md
        ├── overview.md
        └── paths.md

4 directories, 6 files
```

> 참고 사이트    
> [Springfox Reference Documentation](http://springfox.github.io/springfox/docs/current/#springfox-samples)  

