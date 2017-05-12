---
layout: post
title: "[Jacoco] maven 기반 멀티 모듈 프로젝트에서  jacoco 설정하기 "
date: 2017-05-08 17:50:00
categories: "Testing"
tags: junit java coverage jacoco maven
---

아래와 같이 서브 모듈을 가진 프로젝트에서 jacoco로 생성된 코드커버리지 결과를 하나의 리포트로 합쳐서 보기 위해 설정하는 방법
```xml
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.study</groupId>
  <artifactId>module-root</artifactId>
  <version>1.0-SNAPSHOT</version>

  <packaging>pom</packaging>
  <name>module-root</name>

  <!-- sub module -->
  <modules>
    <module>common</module>
    <module>service</module>
    <module>web</module>
  </modules>
```

## parent의 pom.xml에 jacoco 설정
최상위 pom.xml에 jacoco 설정을 한다. <br/>
각 모듈에 jacoco report를 생성할 것은 아니므로 아래와 같이 prepare-agent에 대해서만 선언하였음.
```xml
<plugin>
    <groupId>org.jacoco</groupId>
    <artifactId>jacoco-maven-plugin</artifactId>
    <version>0.7.9</version>
    <executions>
        <execution>
            <id>jacoco-initialize</id>
            <goals><goal>prepare-agent</goal></goals>
        </execution>
    </executions>
</plugin>
```

## 레포트 생성을 위한 하위 모듈 생성
pom.xml에서 dependency로 정의된 서브 모듈에 대해서 report가 merge가 되도록 동작이 되어서..별도로 report 모듈을 생성한 뒤 아래와 같이 pom.xml을 정의해주었음.
```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">

  <modelVersion>4.0.0</modelVersion>

  <parent>
    <artifactId>module-parent</artifactId>
    <groupId>com.study</groupId>
    <version>1.0-SNAPSHOT</version>
    <relativePath>../pom.xml</relativePath>
  </parent>

  <artifactId>module-report</artifactId>
  <packaging>pom</packaging>

  <name>module-report</name>

  <dependencies>
    <dependency>
      <groupId>com.study</groupId>
      <artifactId>module-common</artifactId>
    </dependency>
    <dependency>
      <groupId>com.study</groupId>
      <artifactId>module-service</artifactId>
    </dependency>
    <dependency>
      <groupId>com.study</groupId>
      <artifactId>module-web</artifactId>
    </dependency>
  </dependencies>

  <build>
    <plugins>
      <plugin>
        <groupId>org.jacoco</groupId>
        <artifactId>jacoco-maven-plugin</artifactId>
        <configuration>
          <excludes>
            <exclude>**/*Application.*</exclude>
          </excludes>
        </configuration>
        <executions>
          <execution>
            <id>report-aggregate</id>
            <phase>verify</phase>
            <goals>
              <goal>report-aggregate</goal>
            </goals>
          </execution>
        </executions>
      </plugin>
    </plugins>
  </build>

</project>
```

## Report 파일 생성 확인
빌드를 수행하고 나면 report 모듈 빌드 단계에서 아래와 같이 `report-aggregate`가 동작하는 것을 확인할 수 있음.
```
[INFO] ------------------------------------------------------------------------
[INFO] Building module-report 1.0-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO] 
[INFO] --- maven-clean-plugin:2.6.1:clean (default-clean) @ module-report ---
[INFO] Deleting /Users/*****/Documents/study/springboot-multi-module/report/target
[INFO] 
[INFO] --- jacoco-maven-plugin:0.7.9:report-aggregate (report-aggregate) @ module-report ---
[INFO] Analyzed bundle 'module-common' with 2 classes
[INFO] Analyzed bundle 'module-service' with 1 classes
[INFO] Analyzed bundle 'module-web' with 1 classes
```

그리고 report/target 디렉토리를 확인해보면 각 서브 모듈에 대한 coverage report 파일을 확인할 수 있다.
```
$ ls -l report/target/site/jacoco-aggregate/
total 48
-rw-r--r--   1 *****  staff   4049 May  8 17:32 index.html
drwxr-xr-x  22 *****  staff    748 May  8 17:32 jacoco-resources
-rw-r--r--   1 *****  staff    939 May  8 17:32 jacoco-sessions.html
-rw-r--r--   1 *****  staff    478 May  8 17:32 jacoco.csv
-rw-r--r--   1 *****  staff  11892 May  8 17:32 jacoco.xml
drwxr-xr-x   5 *****  staff    170 May  8 17:32 module-common
drwxr-xr-x   4 *****  staff    136 May  8 17:32 module-service
drwxr-xr-x   4 *****  staff    136 May  8 17:32 module-web
```

> 참고 링크 
> [JaCoCo -jacoco:report-aggregate](http://www.eclemma.org/jacoco/trunk/doc/report-aggregate-mojo.html)
> [JaCoCo Code Coverage and Report of multiple Eclipse plug-in projects | Lorenzo Bettini](http://www.lorenzobettini.it/2017/02/jacoco-code-coverage-and-report-of-multiple-eclipse-plug-in-projects/)
> 

