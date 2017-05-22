---
layout: post
comments: true
title: "[gradle] Usage 정리"
date: 2017-05-02 17:30:00
categories: build-tool
tags: gradle
---

### gradle tasks
코드 컴파일 및 테스트. Jar 파일 생성 등을 수행.

### gradle build 시 생성되는 파일들
빌드가 정상적으로 수행이 되면 `build` 디렉토리가 생성되고, 하위에 프로젝트 컴파일, 테스트에 대한 수행 결과(report), 프로젝트 라이브러리 파일 들이 생성됨.
예시)
```
$ tree build
build
├── classes
│   └── main
│       └── hello
│           ├── Greeter.class
│           └── HelloWorld.class
├── libs
│   └── hello.jar
└── tmp
    ├── compileJava
    └── jar
        └── MANIFEST.MF

7 directories, 4 files
```

### build.gradle
#### description
project에 대한 설명을 작성
```
description ="""
Example project for a Gradle build
Project name: ${project.name}
More detailed information here... """
```

`gradle project` 를 수행하면 아래와 같이 출력된다.
```
$ gradle project
:projects

------------------------------------------------------------
Root project -
Example project for a Gradle build

Project name: com.vogella.gradle.first

More detailed information here...
------------------------------------------------------------

Root project 'com.vogella.gradle.first' -
Example project for a Gradle build

Project name: com.vogella.gradle.first

More detailed information here...
No sub-projects

To see a list of the tasks of a project, run gradle <project-path>:tasks
For example, try running gradle :tasks

BUILD SUCCESSFUL

Total time: 0.672 secs
```

#### dependencies 
* compile : 해당 의존성 라이브러리가 컴파일 시점에 사용되어짐을 의미
* providedCompile : 프로젝트의 코드가 컴파일되는데 필요로 되는 의존성 라이브러리를 정의. 
단 실제 런타임시에 컨테이너로부터 제공받기 때문에 빌드 결과물에 포함될 필요는 없는 라이브러리임을 뜻한다. 
예를 들어서, Java ServletAPI나 JSTL 라이브러리가 있습니다.
* testCompile : 테스트 실행시에 필요한 의존성을 정의

###### exclude
의존관계에 있는 특정 라이브러리 제외하기
```
// 구성 단위 제외
configurations {
    compile.exclude module: 'commons' // compile configuration에서 특정 모듈 제외
    all*.exclude group: 'org.gradle.test.excludes', module: 'reports' // 모든 configuration에서 특정 모듈 제외
}
 
// 의존성 단위 제외
dependencies {
    compile("org.gradle.test.excludes:api:1.0") { 
        exclude module: 'shared' // 특정 의존성에 대해선만 모듈 제외.
        exclude group: 'groupId', module: 'artifactId'
    }
}
```

의존성 제외가 필요한 경우
* 의존성 제외가 아닌 다른 방식으로 해결 가능한지 항상 고려한다.
* 라이센스 때문에 해당 모듈을 빼야한다.
* 어떠한 원격 리포지토리에서도 받아 올 수 없는 모듈이다.
* 실행 시점에는 필요 없는 모듈이다.
* 의존성에 지정된 버전이 다른 버전과 충돌한다. 이때는 버전 충돌 부분으로 해결하도록 한다.

#### task
특정 작업(?)에 대해서 task로 정의할 수 있다.
별도로 생성된 task는 `gradle tasks --all`을 수행하면 아래와 같이 확인이 된다.
```
Other tasks
-----------
hello
```

###### task 정의하기
특정 task를 group으로 묶어서 표시할 수 있고, 또한 해당 task에 대한 설명을 추가할 수 있다.
```
task hello {
    group 'TestGroup'
    description "This is hello task"

    doFirst {
       println 'Hello Gradle'
    }

    doLast {
       println 'Bye Gradle'
    }
}
```

위와 같이 정의하면…아래와 같이 지정한 그룹과 설명이 함께 확인이 된다.
```
TestGroup tasks
---------------
hello - This is hello task
```

###### Tip
* 생성된 jar 을 특정 경로로 복사하기. 
```
task deleteJar(type: Delete) {
    delete ('release/hello.jar')
}

task exportJar(type: Copy) {
    from('build/libs/hello.jar')
    into('release/')
}
```


> 참고 링크  
> [gradle:dependencies 권남](http://kwonnam.pe.kr/wiki/gradle/dependencies)  
>   