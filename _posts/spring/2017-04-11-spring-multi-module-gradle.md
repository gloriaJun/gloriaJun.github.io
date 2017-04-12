---
layout: post
title: "[Spring Boot] multi module project on Gradle"
date: 2017-04-11 17:00:00
categories: Spring
tags: spring spring-boot gradle
---

Maven 기반으로 생성했던 multi porject를 gradle 기반으로 생성하기.

### Project 생성
메인 프로젝트 하위로 모듈을 생성한다.<br/>
![](https://github.com/gloriaJun/gloriaJun.github.io/blob/master/_images/2017-04-11-spring-multi-project-on-gradle.png?raw=true)

### Root Project 설정
Root Project 레벨에는 프로젝트 전역에 공통으로 적용되는 부분에 대해 설정을 한다.

##### settings.gradle
Root project 명과 하위 모듈에 대해 정의한다. (_Root Project명은 해당 프로젝트의 디렉토리명과는 무관함_)
```
rootProject.name = 'todo'
include 'common'
include 'todo-app'
```

참고로 하위 모듈에 대해 정의하는 방법은 다음과 같은 방법들이 있음.
```gradle
# 케이스-1
include 'common'
include 'service'
include 'web'

# 케이스-2
include "common", "service", "web"

# 케이스-3
String[] modules = ['common", "service", "web"]
```

##### gradle.properties
공통으로 사용하는 버전 정보 등과 같은 상수 값들을 정의한다.
```
todoVersion=1.0-SNAPSHOT
gradleVersion=3.4.1
javaVersion=1.8
springBootVersion=1.5.2.RELEASE
logbackVersion=1.1.2
slf4jVersion=1.7.6
```

##### build.gradle
하위 프로젝트의 공통된 설정 값들을 정의한다.
```
// Gradle이 동작하기 위한 repositories와 dependencies를 정의
buildscript {
    // 라이브러리 저장소 정의
    repositories{
        mavenCentral()

    }
    dependencies {
        classpath "org.springframework.boot:spring-boot-gradle-plugin:${springBootVersion}"
    }
}

// 모든 모듈이 공통적으로 사용하기 위한 repositories와 dependencies를 정의
allprojects {
    task hello << { task -> println "I'm $task.project.name" }

    group = 'com.study.todo'
    version = todoVersion

    apply plugin: 'eclipse'
    apply plugin: 'idea'
}

// 하위 모듈이 공통적으로 사용하기 위한 repositories와 dependencies를 정의
subprojects {
    apply plugin: 'java'
    apply plugin: 'org.springframework.boot'

    sourceCompatibility = javaVersion
    targetCompatibility = javaVersion

    // 라이브러리 저장소 정의
    repositories {
        mavenCentral()
    }

    dependencies {
        compile("ch.qos.logback:logback-classic:${logbackVersion}")
        compile("ch.qos.logback:logback-core:${logbackVersion}")
        compile("org.slf4j:slf4j-api:${slf4jVersion}")
        testCompile("org.springframework.boot:spring-boot-starter-test")
    }
}

// gradle 버전 정의 (명시해주는 것을 권고한다고 함)
task wrapper(type: Wrapper) {
    gradleVersion = gradleVersion
}
```

### Sub Module 설정
각각의 서브 모듈에서 사용되는 라이브러리의 의존 관계를 설정한다.

##### common’s build.gradle
```
jar {
    baseName = 'common'
    version = todoVersion
}
```

##### todo-app’s build.gradle
`common` 모듈을 참조하여 사용할 것이므로 해당 모듈과의 연결을 해주고, 그 외의 필요한 라이브러리들에 대하여 정의한다.
```
apply plugin: 'war'

jar {
    baseName = 'todo-app'
    version = todoVersion
}

dependencies {
    compile project(':common')
    compile ('org.springframework.boot:spring-boot-starter-web')
}
```

### spring boot sampler 프로젝트 생성
###### application
```java
package com.study.todo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


@SpringBootApplication
public class ToDoApplication {

    private static final Logger logger = LoggerFactory.getLogger(ToDoApplication.class);

    public static void main(String[] args) {
        SpringApplication.run(ToDoApplication.class, args);
        logger.debug("Spring boot ToDoApplication Start~!!");
    }
}
```

###### controller
```java
package com.study.todo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ToDoController {

    @GetMapping("/")
    public String home() {
        return "test";
    }
}
```

