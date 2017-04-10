---
layout: post
title: "[Jacoco] maven 기반에서 jacoco 설정하기"
date: 2017-04-03 14:50:00
categories: "Testing"
tags: junit java coverage jacoco maven
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
`mvn jacoco:report`을 수행하면 리포트 파일이 생성된다.<br/>
![](https://github.com/gloriaJun/gloriaJun.github.io/blob/master/_images/2017-04-03-testing-jacoco-report.png?raw=true)

` index.hmtl`파일을 열면..각 패키지에 대한 코드 커버리지가 확인이 되고…<br/>
![](https://github.com/gloriaJun/gloriaJun.github.io/blob/master/_images/2017-04-03-testing-jacoco-report2.png?raw=true)

각 패키지에서 특정 소스를 열어서 보면 아래와 같이 해당 클래스에 대한 각 메소드 또는 분기 조건에 대한 측정 결과를 확인할 수 있다.<br/>
![](https://github.com/gloriaJun/gloriaJun.github.io/blob/master/_images/2017-04-03-testing-jacoco-report3.png?raw=true)

각 색상에 대한 설명은 다음과 같다.
* green : 단위 테스트에서 해당 부분이 수행되어 커버되었음.
* yellow : 부분적으로 커버되었음.
* red : 전혀 수행되지 않았음.
<br/>
<br/>

