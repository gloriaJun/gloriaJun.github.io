---
layout: post
title: "[Spring Boot] multi module project on Maven"
date: 2017-04-06 17:00:00
categories: Spring
tags: spring spring-boot maven
---

intellij를 사용해서 maven 기반의 multi module project 생성하기.

### 프로젝트 생성
먼저 빈 프로젝트를 하나 생성한 뒤, [File - New - Module]을 선택해서 parent, service, web 모듈을 생성한다.

생성된 프로젝트 구조는 다음과 같음.<br/>
![](https://github.com/gloriaJun/gloriaJun.github.io/blob/master/_images/2017-04-06-spring-multi-module-maven.png?raw=true)

### pom.xml 파일 정의
##### parent
기본으로 생성된 src 폴더는 삭제한다.
그리고 pom.xml에 서브 모듈을 정의한다.<br/> 

그리고 공통으로 관리할 패키지들의 버전이 있다면, `dependencyManagement`를 이용하여 정의해주면 된다. <br/>
*(부모 POM 에서 <dependencyManagement> 정의를 통해 자식 POM 에서 버전을 명기하지 않아도 디펜던시를 참조할 수 있다고 함.)*
```xml
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.study</groupId>
    <artifactId>module-parent</artifactId>
    <version>1.0-SNAPSHOT</version>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>1.5.2.RELEASE</version>
    </parent>

    <packaging>pom</packaging>
    <name>sample-multi-module-parent</name>

    <!-- sub module -->
    <modules>
        <module>../module-service</module>
        <module>../module-web</module>
    </modules>

    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
        <java.version>1.8</java.version>
    </properties>
```


```

```

##### service
서비스 모듈에서는 parent와 연결을 해주고, jpa를 이용하여 구현할 예정이므로 관련된 패키지를 정의해준다.
```xml
    <modelVersion>4.0.0</modelVersion>

    <artifactId>module-service</artifactId>
    <packaging>jar</packaging>

    <parent>
        <artifactId>module-parent</artifactId>
        <groupId>com.study</groupId>
        <version>1.0-SNAPSHOT</version>
        <relativePath>../module-parent/pom.xml</relativePath>
    </parent>

    <name>sample-multi-module-service</name>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <scope>runtime</scope>
        </dependency>
    </dependencies>
```

##### web
Web 모듈에서는 실제 어플리케이션이 동작할 것이므로 web을 추가 해주고, service 모듈에 대한 dependency도 정의해준다.
```xml
    <modelVersion>4.0.0</modelVersion>

    <artifactId>module-web</artifactId>
    <packaging>jar</packaging>

    <parent>
        <artifactId>module-parent</artifactId>
        <groupId>com.study</groupId>
        <version>1.0-SNAPSHOT</version>
        <relativePath>../module-parent/pom.xml</relativePath>
    </parent>

    <name>sample-multi-module-web</name>

    <dependencies>
        <dependency>
            <groupId>com.study</groupId>
            <artifactId>module-service</artifactId>
            <version>1.0-SNAPSHOT</version>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
    </dependencies>
```

### service 모듈에 컴포넌트와 서비스 생성
##### Entity class 생성
```java
package com.study.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class ToDo {
    @Id
    @GeneratedValue
    private long id;
    private String text;
    private boolean completed;

    public ToDo() {}
    public ToDo(String text, boolean completed) {
        this.text = text;
        this.completed = completed;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public boolean isCompleted() {
        return completed;
    }

    public void setCompleted(boolean completed) {
        this.completed = completed;
    }
}
```

##### Repositoy class 생성
```java
package com.study.repository;

import com.study.model.ToDo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository("toDoRepository")
public interface ToDoRepository extends JpaRepository<ToDo, Long> {}
```

##### Service interface class 생성
```java
package com.study.service;

import com.study.model.ToDo;

import java.util.List;

public interface ToDoService {

    public List<ToDo> getAllToDo();
    public ToDo getById(long id);
    public ToDo saveToDO(ToDo todo);
    public void deleteToDo(long id);

}
```

##### Service class 생성
```java
package com.study.service;

import com.study.model.ToDo;
import com.study.repository.ToDoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("ToDoService")
public class ToDoServiceImpl implements ToDoService {

    @Autowired
    private ToDoRepository toDoRepository;

    @Override
    public List<ToDo> getAllToDo() {
        return toDoRepository.findAll();
    }

    @Override
    public ToDo getById(long id) {
        return toDoRepository.getOne(id);
    }

    @Override
    public ToDo saveToDO(ToDo todo) {
        return toDoRepository.save(todo);
    }

    @Override
    public void deleteToDo(long id) {
        toDoRepository.delete(id);
    }
}
```

### web 모듈
##### controller 생성
```java
package com.study.controller;

import com.study.model.ToDo;
import com.study.service.ToDoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class ToDoController {

    private static final Logger logger = LoggerFactory.getLogger(ToDoController.class);

    private ToDoService service;

    @Autowired
public ToDoController(ToDoService service) {
        this.service = service;
    }

    @GetMapping("/")
    public List<ToDo> getAllToDo() {
        return service.getAllToDo();
    }
}
```

##### application 생성
`public CommandLineRunner setup(final ToDoRepository toDoRepository) ` 메소드는 application 기동 시에 데이타를 출력하기 위해 초기 샘플 데이타 값을 설정해준 부분이다.
``` java
package com.study;

import com.study.model.ToDo;
import com.study.repository.ToDoRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class Application {

    private static final Logger logger = LoggerFactory.getLogger(Application.class);

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    // set init data
    @Bean
    public CommandLineRunner setup(final ToDoRepository toDoRepository) {
        return (args) -> {
            toDoRepository.save(new ToDo("clean up the room", false));
            toDoRepository.save(new ToDo("study math", true));
        };
    }

}
```


### 빌드
maven으로 빌드를 해보면 아래와 같이 관련 모듈들이 같이 빌드되는 것을 확인할 수 있다.
```
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary:
[INFO] 
[INFO] sample-multi-module-parent ......................... SUCCESS [  0.001 s]
[INFO] sample-multi-module-service ........................ SUCCESS [  0.421 s]
[INFO] sample-multi-module-web ............................ SUCCESS [  0.054 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
```

### 실행
application을 실행 후에 `http://localhost:8080`에 접속하거나, postman을 통해 요청을 날려보면 아래와 같은 메시지가 화면에 출력되는 것을 확인할 수 있음.
```json
[
  {
    "id": 1,
    "text": "clean up the room",
    "completed": false
  },
  {
    "id": 2,
    "text": "study math",
    "completed": true
  }
]
```

<br/><br/>
> 참고 사이트  
> [Getting Started · Creating a Multi Module Project](https://spring.io/guides/gs/multi-module/)  
> http://aoruqjfu.fun25.co.kr/index.php/post/601  
> https://idodevjobs.wordpress.com/2014/04/13/maven-multi-module-example/  
> https://medium.com/@gustavo.ponce.ch/spring-boot-restful-junit-mockito-hamcrest-eclemma-5add7f725d4e