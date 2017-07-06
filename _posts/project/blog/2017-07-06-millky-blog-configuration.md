---
layout: post
title: "[Blog] spring boot로 블로그 만들어보기"
date: 2017-07-06 18:00:00
projects: blog
tags: spring spring-boot gradle
---

# 
[블로그개발-Millky](http://millky.com/@origoni/post/1100)의 글들을 참고해서 spring boot 기반의 블로그를 공부할 겸 만들어보려고 한다.    
기존에 booktree나 가계부 프로젝트를 직접 설계하여 하려고 하니 잘 진행도 안되고 지지부진해져서..일단은 블로그의 글을 보면서 차분히 따라가며 진행해보기로…   
단, 해당 블로그에서는 REST-API 기술과 화면 부분이 별도의 웹서버로 구현되어 있지 않아서 그 부분만 변경하여 진행해보고자 한다.   

그 과정들을 기록하기 위해 정리하기…   

## 프로젝트 생성
#### Backend 프로젝트 생성
api 서버 프로젝트를 spring boot 기반으로 생성한다. 생성한 프로젝트 구조는 아래와 같음.    
```
├── build.gradle
├── gradle.properties
├── settings.gradle
└── src
    └── main
        ├── java
        │   └── com
        │       └── study
        │           └── blog
        │               ├── Application.java
        │               └── controller
        │                   └── MainController.java
        └── resources
            └── application.yml

10 directories, 10 files
```   
        
###### gradle
`build.gradle` 파일 정의는 아래와 같이 하였음.    
```
group 'study'

buildscript {
    repositories {
        mavenCentral()
    }
    dependencies {
        classpath("org.springframework.boot:spring-boot-gradle-plugin:1.5.3.RELEASE")
    }
}

apply plugin: 'war'
apply plugin: 'java'
apply plugin: 'idea'
apply plugin: 'eclipse'
apply plugin: 'org.springframework.boot'

war {
    baseName = 'springboot-blog'
    version = '1.0-SNAPSHOT'
}

repositories {
    mavenCentral()
}

sourceCompatibility = 1.8
targetCompatibility = 1.8
compileJava.options.encoding = 'UTF-8'

dependencies {
    compile 'org.springframework.boot:spring-boot-starter-web'

    // database
    compile 'org.springframework.boot:spring-boot-starter-data-jpa'
    runtime 'com.h2database:h2'

    // other
    compileOnly 'org.projectlombok:lombok:1.16.16'

    // logging
    compile("ch.qos.logback:logback-classic:1.1.6")
    compile("ch.qos.logback:logback-core:1.1.6")
    compile("org.slf4j:slf4j-api:1.7.6")

    // test
    testCompile 'org.springframework.boot:spring-boot-starter-test'
    testCompile 'org.assertj:assertj-core:3.6.2'
}

task wrapper(type: Wrapper) {
    gradleVersion = '3.4.1'
}
```

#### Frontend 프로젝트 생성
Frontend는 node 기반으로 프로젝트를 생성하였다.    
> 아직 정확하게 어떤 기술을 사용하여 할 지 고민 중…..  



