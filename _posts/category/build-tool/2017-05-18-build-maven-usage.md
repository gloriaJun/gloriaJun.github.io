---
layout: post
comments: true
title: "[maven] usage 정리"
date: 2017-05-18 20:30:00
categories: build-tool
tags: maven
---

maven의 기본적인 사용법 및 필요로 인하여 검색하여 사용했던 것들에 대하여 정리하기.    
   
## Goal
maven에서 기본으로 제공하는 goal 중 자주 사용한 것들...   

#### mvn clean
기존 컴파일 했던 정보를 정리한다. (예를 들어 빌드 후 생성된 산출물인 `target` 디렉토리를 삭제한다)   
또한 `pom.xml`의 문법적인 검사를 진행하기 위해서 사용하기도 한다.   

#### mvn package
컴파일, 테스트, jar 파일 생성을 위한 과정을 진행한다.   
```shell
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
   
#### mvn compile
컴파일 단계까지만 수행
   
#### mvn install
아래의 과정을 추가로 진행한다.
```shell
[INFO] --- maven-install-plugin:2.4:install (default-install) @ HelloSpring ---
[INFO] Installing /Users/hyena/Documents/study/HelloSpring/target/HelloSpring-1.0-SNAPSHOT.jar to /Users/hyena/.m2/repository/sample/HelloSpring/1.0-SNAPSHOT/HelloSpring-1.0-SNAPSHOT.jar
[INFO] Installing /Users/hyena/Documents/study/HelloSpring/pom.xml to /Users/hyena/.m2/repository/sample/HelloSpring/1.0-SNAPSHOT/HelloSpring-1.0-SNAPSHOT.pom
```

## Tip
maven 사용에 있어 유용한  tip(?)들 정리   

#### mvn dependency:tree
현재 `pom.xml`에 정의된 라이브러리들의 의존관계를 확인할 수 있다.
```shell
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

#### `mvn test` 수행 시 argument 전달하기
```shell
mvn clean test -Dtest=lucy.LucyTest -Dmode=local
```

#### skipTests
테스트 단계를 수행하지 않으려고 하는 경우, 다음과 같은 설정 방법이 있음.  

###### -Dmaven.test.skip=true
아래와 같이 `-Dmaven.test.skip=true`를 추가하여 사용한다.
```shell
$ mvn package -Dmaven.test.skip=true
```
   
또는 아래와 같이 `pom.xml`에 정의하여 사용하면 별도로 옵션을 정의하지 않아도 테스트를 수행하지 않게 할 수 있지만..테스트를 항상 skip하게 되어서 사용하지 않는 것이 좋을 듯함  
```xml
<properties>
    <maven.test.skip>true</maven.test.skip>
</properties>
```

###### skipTests
surefire의 property인 `-DskipTests` 를 명시하여 사용하는 방법이 있음   
```shell
$ mvn package -DskipTests
```
   
또는 아래와 같이 `pom.xml`에 정의하여 사용하면 별도로 옵션을 정의하지 않아도 테스트를 수행하지 않게 할 수 있지만..테스트를 항상 skip하게 되어서 사용하지 않는 것이 좋을 듯함  
```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-surefire-plugin</artifactId>
    <version>2.19.1</version>
    <configuration>
        <skipTests>true</skipTests>
    </configuration>
</plugin>
```
   
   > **Reference**
   > [How to skip Maven unit test](https://www.mkyong.com/maven/how-to-skip-maven-unit-test/)


