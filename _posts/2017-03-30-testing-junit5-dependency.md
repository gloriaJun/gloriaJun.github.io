---
layout: post
title: "[JUnit] JUnit5 의존 라이브러리 설정"
date: 2017-03-30 18:30:00
categories: "Testing"
tags: junit junit5 java
---

JUnit5 테스트를 위한 의존 라이브러리 설정 방법 정리.
> 이클립스에서도 사용할 수 있게 하기 위해서 `junit-platform-runner`을 추가로 정의하였음.

### maven (pom.xml)
```xml
  <properties>
      <java.version>1.8</java.version>
        <maven.compiler.version>3.6.1</maven.compiler.version>
        <maven.surefir.version>2.19.1</maven.surefir.version>
        <junit.jupiter.version>5.0.0-M3</junit.jupiter.version>
        <junit.platform.version>1.0.0-M3</junit.platform.version>
        <junit.vintage.version>4.12.0-M3</junit.vintage.version>
  </properties>

  <build>
        <plugins>
            <plugin>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>${maven.compiler.version}</version>
                <configuration>
                    <source>${java.version}</source>
                    <target>${java.version}</target>
                </configuration>
            </plugin>
            <plugin>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>${maven.surefir.version}</version>
                <dependencies>
                    <dependency>
                        <groupId>org.junit.platform</groupId>
                        <artifactId>junit-platform-surefire-provider</artifactId>
                        <version>${junit.platform.version}</version>
                    </dependency>
                    <dependency>
                      <groupId>org.junit.vintage</groupId>
                      <artifactId>junit-vintage-engine</artifactId>
                      <version>${junit.vintage.version}</version>
                  </dependency>
                </dependencies>
            </plugin>
        </plugins>
    </build>

  <dependencies>
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
```


### gradle
/확인해보고 추가하기/