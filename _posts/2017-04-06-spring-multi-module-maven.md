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
그리고 pom.xml에 서브 모듈과 공통으로 사용되는 dependency를 정의해준다.
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
        <maven.compiler.version>3.6.1</maven.compiler.version>
        <maven.surefir.version>2.19.1</maven.surefir.version>
        <junit.jupiter.version>5.0.0-M3</junit.jupiter.version>
        <junit.platform.version>1.0.0-M3</junit.platform.version>
        <junit.vintage.version>4.12.0-M3</junit.vintage.version>
    </properties>

    <dependencyManagement>
        <dependencies>
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-starter-test</artifactId>
            </dependency>
            <dependency>
                <groupId>org.junit.jupiter</groupId>
                <artifactId>junit-jupiter-engine</artifactId>
                <version>${junit.jupiter.version}</version>
                <scope>test</scope>
            </dependency>

            <dependency>
                <groupId>org.junit.platform</groupId>
                <artifactId>junit-platform-runner</artifactId>
                <version>${junit.platform.version}</version>
                <scope>test</scope>
            </dependency>

            <!-- junit 관련 외부 라이브러리 -->
            <dependency>
                <groupId>org.hamcrest</groupId>
                <artifactId>java-hamcrest</artifactId>
                <version>2.0.0.0</version>
                <scope>test</scope>
            </dependency>
        </dependencies>
    </dependencyManagement>
```

##### service
서비스 모듈에서는 parent와 연결을 해주고, 테스트로 만드는 프로젝트라 web을 정의하였음.
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
            <artifactId>spring-boot-starter-web</artifactId>
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
##### Component 생성
```java
package com.study.domain;

import org.springframework.stereotype.Component;

@Component
public class Account {
    private String userid;
    private String username;

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
```

##### Service 생성
```java
package com.study.service;

import com.study.domain.Account;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AccountService {

    public Account getAccount() {
        Account account = new Account();
        account.setUserid("tester");
        account.setUsername("Kay");
        return account;
    }
    
}
```

### web 모듈에 controller 생성
```java
package com.study.app;

import com.study.domain.Account;
import com.study.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Import;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@Import(AccountService.class)
@RestController
public class Application {
    private AccountService service;

    @Autowired
    public Application(AccountService service) {
        this.service = service;
    }

    @GetMapping("/")
    public Account home() {
        return service.getAccount();
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
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
application을 실행 후에 `http://localhost:8080`에 접속하면 아래와 같은 메시지가 화면에 출력되는 것을 확인할 수 있음.
```
{"userid":"tester","username":"Kay"}
```

<br/><br/>
> 참고 사이트  
> [Getting Started · Creating a Multi Module Project](https://spring.io/guides/gs/multi-module/)  
> http://aoruqjfu.fun25.co.kr/index.php/post/601  
> https://idodevjobs.wordpress.com/2014/04/13/maven-multi-module-example/  