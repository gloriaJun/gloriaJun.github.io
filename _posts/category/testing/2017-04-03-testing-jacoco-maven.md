---
layout: post
title: "[Jacoco] maven 기반에서 jacoco 설정하기"
date: 2017-04-03 14:50:00
categories: "Testing"
tags: java coverage jacoco maven
---

### Jacoco??
테스트 커버리지를 측정하기 위한 툴이다.
자세한 내용은 [EclEmma - JaCoCo Java Code Coverage Library](http://www.eclemma.org/jacoco/index.html) 를 참고.

<br/>
#### Configuring The JaCoCo Plugin
단위테스트의 코드커버리지 레포트 생성에 Jacoco를 사용하겠다는 설정을 추가해준다.
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
        <execution>
            <id>jacoco-report</id>
            <phase>test</phase>
            <goals>
                <goal>report</goal>
            </goals>
        </execution>
    </executions>
</plugin>
```

위와 같이 설정한 후에 컴파일을 하거나, 테스트를 수행하면..`target/jacoco.exec` 파일이 생성된다.

<br/>
#### Report 파일 확인
test phase 단계에 report를 생성하도록 설정을 하였으므로 `mvn test`를 수행하거나, 별도로 `mvn jacoco:report`을 수행하면 리포트 파일이 생성된다.<br/>
![]({{ site.url }}/assets/images/post/testing/2017/0403-jacoco-maven/report.png)


` index.hmtl`파일을 열면..각 패키지에 대한 코드 커버리지가 확인이 되고…<br/>
![]({{ site.url }}/assets/images/post/testing/2017/0403-jacoco-maven/report2.png)

각 패키지에서 특정 소스를 열어서 보면 아래와 같이 해당 클래스에 대한 각 메소드 또는 분기 조건에 대한 측정 결과를 확인할 수 있다.<br/>
![]({{ site.url }}/assets/images/post/testing/2017/0403-jacoco-maven/report3.png)

각 색상에 대한 설명은 다음과 같다.
* green : 단위 테스트에서 해당 부분이 수행되어 커버되었음.
* yellow : 부분적으로 커버되었음.
* red : 전혀 수행되지 않았음.

#### 특정 클래스에 대해서는 coverage 측정 제외하기
`exclude` 옵션을 주어서 특정 클래스 파일에 대해서는 제외 시킬 수 있다.
```xml
<configuration>
    <excludes>
      <exclude>com/mytest/restAssured/*</exclude>
      <exclude>**/*String*.*</exclude>
    </excludes>
</configuration>
```

#### 테스트가 실패해도 jacoco report가 생성되도록 하기
테스트가 실패하면 테스트 이후의 과정이 실행이 되지 않지만, 별도로 옵션을 주어서 테스트 이후의 과정이 수행되도록 할 수 있다.
```xml
<plugin>
    <artifactId>maven-surefire-plugin</artifactId>
    <version>${maven.surefir.version}</version>
    <configuration>
      <!-- 테스트가 실패해도 이후 작업을 계속 진행 -->
      <testFailureIgnore>true</testFailureIgnore>
    </configuration>
</plugin>
```

