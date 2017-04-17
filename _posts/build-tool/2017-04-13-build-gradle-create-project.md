---
layout: post
title: "[gradle] gradle project 생성 on terminal"
date: 2017-04-13 20:30:00
categories: build-tool
tags: gradle
---

### gradle 설치 확인
```
$ gradle -v

------------------------------------------------------------
Gradle 3.4.1
------------------------------------------------------------

Build time:   2017-03-03 19:45:41 UTC
Revision:     9eb76efdd3d034dc506c719dac2955efb5ff9a93

Groovy:       2.4.7
Ant:          Apache Ant(TM) version 1.9.6 compiled on June 29 2015
JVM:          1.8.0_111 (Oracle Corporation 25.111-b14)
OS:           Mac OS X 10.12.3 x86_64
```

### 프로젝트 생성
폴더를 생성 한 뒤에 해당 폴더에서 gradle을 적용한다.
```
$ cd gradle-sample-project/
$ gradle wrapper
:wrapper

BUILD SUCCESSFUL

Total time: 0.837 secs
```

`gradle wrapper`를 실행하고 나면 아래와 같은 폴더와 파일들이 생성된다.
```
$ tree
.
├── gradle
│   └── wrapper
│       ├── gradle-wrapper.jar
│       └── gradle-wrapper.properties
├── gradlew
└── gradlew.bat

2 directories, 4 files
```

###### gradlew & gradlew.bat
gradle을 별도로 설치하거나 연동을 하지 않아도 사용할 수 있게 해주는 스크립트 파일.
`gradle/wrapper/gradle-wrapper.properties`에 정의된 설정값을 통하여 자동으로 다운 받아 프로젝트 별로 독립적으로 실행되어질 수 있도록하여 동작시켜줌.
```
$ cat gradle/wrapper/gradle-wrapper.properties
#Tue Apr 11 11:26:23 KST 2017
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-3.4.1-bin.zip
```

### gradle version upgrade
프로젝트의 gradle 버전을 명시하여 업그레이드 하는 방법
```
$ gradle wrapper --gradle-version 2.4.7
```

### gradle init
다음과 같은 파일들이 추가로 생성됨.
```
build.gradle
settings.gradle
```

### Build
gradle은 `task` 라는 이름으로 정해진 빌드 기능이 제공됨.
어떤 plugin을 선언하느냐에 따라 의존성에 맞게 관리되고 있으며, `build.gradle` 이라는 파일에 선언함.

java로 개발하는 경우, 아래와 같이 선언해주면 됨.
```
apply plugin: 'java'
```

그리고 빌드를 실행해보면  task가 다음과 같이 실행됨을 확인할 수 있음.
```
$ gradle build
:compileJava NO-SOURCE
:processResources NO-SOURCE
:classes UP-TO-DATE
:jar
:assemble
:compileTestJava NO-SOURCE
:processTestResources NO-SOURCE
:testClasses UP-TO-DATE
:test NO-SOURCE
:check UP-TO-DATE
:build

BUILD SUCCESSFUL

Total time: 0.742 secs
```

### 설정파일
##### build.gradle
빌드 기능에 대해 관리하는 파일

###### Repository 주소 정의
의존 라이브러리들이 관리되고 있는 저장소의 주소를 정의한다.
메이븐 저장소를 사용 시에는 `mavenCentral()`를 추가로 정의해준다.
```
repositories {
    //mavenCentral()
    jcenter()
}
```

##### settings.gradle
싱글 또는 멀티 프로젝트 구성에 대해 정의하는 파일. 
```
rootProject.name = 'todo'
include 'common'
include 'service'
include 'web'
```

### 멀티 프로젝트 생성 시 Tip
멀티 프로젝트 생성 시에 그룹 디렉토리가 없으면 생성하고, 하위 모듈이 존재하는 경우 디렉토리를 생성하고 서브 모듈로 등록하는 스크립트 

##### settings.gradle
```
// 그룹 디렉터리를 돌면서 하위 디렉터리가 있으면 서브프로젝트로 등록하는 스크립트한다
// 만약 그룹 디렉터리가 없으면 해당 디렉터리도 생성한다
['common', 'todo-app', 'calendar-app', 'web'].each {
    def projectDir = new File(rootDir, it)

    // 그룹 디렉터리가 없으면 생성
    if (!projectDir.exists()) {
        projectDir.mkdirs()
    }

    // 모듈 그룹 디렉터리 하위에 디렉터리가 있으면 서브 프로젝트로 등록
    projectDir.eachDir { dir ->
        include ":${it}-${dir.name}"
        project (":${it}-${dir.name}").projectDir = new File(projectDir.getAbsolutePath(), dir.name);
    }
}
```


##### build.gradle
각각 모듈에 기본 폴더인 `src, src/java, src/main, src/test `을 생성하기 위한 부분에 대한 스크립트
```
task initSourceFolders {
    subproject.sourceSets*.java.srcDirs*.each {
        if( !it.exists() ) {
            it.mkdirs()
        }
    }
 
    subproject.sourceSets*.resources.srcDirs*.each {
        if( !it.exists() ) {
            it.mkdirs()
        }
    }
}
```