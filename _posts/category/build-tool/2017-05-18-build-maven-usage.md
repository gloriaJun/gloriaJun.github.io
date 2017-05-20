---
layout: post
comments: true
title: "[maven] usage 정리"
date: 2017-05-18 20:30:00
categories: build-tool
tags: maven
---

maven 사용 시 검색했던 사용법 정리

### mvn clean
기존 컴파일 했던 정보를 정리해준다.
`pom.xml`의 문법적인 검사를 해주기도 한다.

### mvn package
컴파일, 테스트, jar 파일 생성을 한다.
```
$ mvn package
[INFO] Scanning for projects...
[INFO]
[INFO] ------------------------------------------------------------------------
[INFO] Building HelloSpring 1.0-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ HelloSpring ---
[WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] skip non existing resourceDirectory /Users/hyena/Documents/study/HelloSpring/src/main/resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:compile (default-compile) @ HelloSpring ---
[INFO] Changes detected - recompiling the module!
[WARNING] File encoding has not been set, using platform encoding UTF-8, i.e. build is platform dependent!
[INFO] Compiling 1 source file to /Users/hyena/Documents/study/HelloSpring/target/classes
[INFO]
[INFO] --- maven-resources-plugin:2.6:testResources (default-testResources) @ HelloSpring ---
[WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] skip non existing resourceDirectory /Users/hyena/Documents/study/HelloSpring/src/test/resources
[INFO]
[INFO] --- maven-compiler-plugin:3.1:testCompile (default-testCompile) @ HelloSpring ---
[INFO] Changes detected - recompiling the module!
[WARNING] File encoding has not been set, using platform encoding UTF-8, i.e. build is platform dependent!
[INFO] Compiling 1 source file to /Users/hyena/Documents/study/HelloSpring/target/test-classes
[INFO]
[INFO] --- maven-surefire-plugin:2.12.4:test (default-test) @ HelloSpring ---
[INFO] Surefire report directory: /Users/hyena/Documents/study/HelloSpring/target/surefire-reports

-------------------------------------------------------
 T E S T S
-------------------------------------------------------
Running sample.AppTest
Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.035 sec

Results :

Tests run: 1, Failures: 0, Errors: 0, Skipped: 0

[INFO]
[INFO] --- maven-jar-plugin:2.4:jar (default-jar) @ HelloSpring ---
[INFO] Building jar: /Users/hyena/Documents/study/HelloSpring/target/HelloSpring-1.0-SNAPSHOT.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 1.363 s
[INFO] Finished at: 2017-04-18T10:59:34+09:00
[INFO] Final Memory: 19M/303M
[INFO] ------------------------------------------------------------------------

$ tree target
target
├── HelloSpring-1.0-SNAPSHOT.jar
├── classes
│   └── sample
│       └── App.class
├── maven-archiver
│   └── pom.properties
├── maven-status
│   └── maven-compiler-plugin
│       ├── compile
│       │   └── default-compile
│       │       ├── createdFiles.lst
│       │       └── inputFiles.lst
│       └── testCompile
│           └── default-testCompile
│               ├── createdFiles.lst
│               └── inputFiles.lst
├── surefire-reports
│   ├── TEST-sample.AppTest.xml
│   └── sample.AppTest.txt
└── test-classes
    └── sample
        └── AppTest.class

12 directories, 10 files
```

### mvn compile
컴파일 단계까지만 수행

### mvn install
아래의 과정을 추가로 진행한다.
```
[INFO] --- maven-install-plugin:2.4:install (default-install) @ HelloSpring ---
[INFO] Installing /Users/hyena/Documents/study/HelloSpring/target/HelloSpring-1.0-SNAPSHOT.jar to /Users/hyena/.m2/repository/sample/HelloSpring/1.0-SNAPSHOT/HelloSpring-1.0-SNAPSHOT.jar
[INFO] Installing /Users/hyena/Documents/study/HelloSpring/pom.xml to /Users/hyena/.m2/repository/sample/HelloSpring/1.0-SNAPSHOT/HelloSpring-1.0-SNAPSHOT.pom
```

### mvn dependency:tree
현재 `pom.xml`에 정의된 라이브러리들의 의존관계를 확인할 수 있다.
```
[INFO] +- org.springframework:spring-context:jar:4.2.4.RELEASE:compile
[INFO] |  +- org.springframework:spring-aop:jar:4.2.4.RELEASE:compile
[INFO] |  |  \- aopalliance:aopalliance:jar:1.0:compile
[INFO] |  +- org.springframework:spring-beans:jar:4.2.4.RELEASE:compile
[INFO] |  +- org.springframework:spring-core:jar:4.2.4.RELEASE:compile
[INFO] |  \- org.springframework:spring-expression:jar:4.2.4.RELEASE:compile
[INFO] +- commons-logging:commons-logging:jar:1.1.1:compile
[INFO] \- junit:junit:jar:4.11:test
[INFO]    \- org.hamcrest:hamcrest-core:jar:1.3:test
```

### mvn test
maven으로 테스트 수행 시에 argument를 전달하기 위한 방법
```
mvn clean test -Dtest=lucy.LucyTest -Dmode=local
```


