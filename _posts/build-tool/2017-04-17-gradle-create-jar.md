---
layout: post
title: "[gradle] 실행가능한 jar 생성하기"
date: 2017-04-17 17:30:00
categories: build-tool
tags: gradle
---

###  build.gradle 수정
배포하려는 어플리케이션의 메인 메소드가 위치한 클래스와 어플리케이션의 버전을 명시해준다.
```
mainClassName = "hello.HelloWorld"
version = "1.0"
```

그리고 `jar` 설정을 추가해준다.
`manifest` 는 어플리케이션에 대한 메타데이터 설정을 해주고, `archiveName `는 생성될 파일 이름을 정의한다.
```
jar {
	manifest {
		attributes 'Main-Class' : 'hello.HelloWorld', 'Version' : 1.0
	}
	archiveName "HelloWorld.jar"
}
```

만약, 의존성 있는 파일들을 포함시켜 jar로 생성하려면 아래와 같은 부분을 `jar` 설정에 추가하면 된다.
```
dependsOn configurations.runtime
    from {
        configurations.compile.collect {it.isDirectory()? it: zipTree(it)}
    }
```

###  jar 파일 생성
`gradle jar`를 실행하여 jar를 생성한다.
```
$ gradle jar
:compileJava UP-TO-DATE
:processResources NO-SOURCE
:classes UP-TO-DATE
:jar

BUILD SUCCESSFUL

Total time: 0.696 secs
```

