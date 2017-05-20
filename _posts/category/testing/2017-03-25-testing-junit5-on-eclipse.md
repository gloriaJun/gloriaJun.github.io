---
layout: post
comments: true
title: "[JUnit] JUnit5 for Eclipse"
date: 2017-03-25 18:30:00
categories: "Testing"
tags: junit junit5 eclipse java
---

> 테스트 환경  
> - 이클립스 Neon  
> - Java 8  

이클립스에서 JUnit5를 사용하려면….

<br/>
## 의존 라이브러리 수정
pom.xml에 아래와 같이 정의한다.
(만약, 기존 JUnit4로 작성된 케이스를 JUnit5로 변경하려면…JUnit4에 대한 라이브러리를 제거하고 junit 관련 라이브러리에 대해 아래와 같이 수정해주면 된다.)
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
<!--
		<dependency>
			<groupId>junit</groupId>
			<artifactId>junit</artifactId>
			<version>4.11</version>
		</dependency>
 -->
</dependencies>
```
* JUnit Platform
 IntelliJ IDEA의 경우에는 JUnit Platform에서 테스트가 수행되도록 지원이 되고 있으므로 해당 패키지를 별도로 정의할 필요가 없다.
하지만 이클립스와 같이 JUnit Platform을 지원하지 않는 그 외의 IDE의 경우에는 해당 패키지를 정의한 뒤에 테스트 클래스에 `@RunWith(JUnitPlatform.class)`을 추가해주면, JUnit Platform 을 JUnit4 기반에서 수행할 수 있다.  
(또는 [Console Launcher](http://junit.org/junit5/docs/current/user-guide/#running-tests-console-launcher)를 사용하여 테스트를 수행하면 된다.)

* JUnit Vintage
JUnit3, JUnit4 기반으로 작성된 테스트케이스가 수행할 수 있는 TestEngine을 제공한다. _mvn test 로 console에서 수행하려면 해당 패키지를 정의해줘야하는 것 같음_

<br/>
### Migration Tips
[JUnit Doc](http://junit.org/junit5/docs/current/user-guide/#migrating-from-junit4-tips)에서 언급하는 JUnit4에서 JUnit5 (JUnit Jupiter)로 마이그레이션 하는 가이드는 아래와 같다.
* Annotations reside in the org.junit.jupiter.api package.
* Assertions reside in org.junit.jupiter.api.Assertions.
* Assumptions reside in org.junit.jupiter.api.Assumptions.
* @Before and @After no longer exist; use @BeforeEach and @AfterEach instead.
* @BeforeClass and @AfterClass no longer exist; use @BeforeAll and @AfterAll instead.
* @Ignore no longer exists: use @Disabled instead.
* @Category no longer exists; use @Tag instead.
<br/>_(아래 부분은 아직까지 잘은 이해가 되지 앟음..ㅠㅠ)_
* @RunWith no longer exists; superseded by @ExtendWith.
* @Rule and @ClassRule no longer exist; superseded by @ExtendWith; see the following section for partial rule support.

<br/><br/>
## Example
#### JUnit5 API를 사용하여 테스트 케이스 작성
테스트 코드 예제)
```java
import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.platform.runner.JUnitPlatform;
import org.junit.runner.RunWith;

@RunWith(JUnitPlatform.class)
public class Junit5Demo {
    @DisplayName("이클립스에서 JUnit5 테스트하기")
    @Test
    void firstTest() {
        assertEquals(1, 1);
    }
}
```

실행 결과)
![]({{ site.url }}/assets/images/post/testing/2017/0325-junit5-on-eclipse/eclipse.png)


#### JUnit4 API를 사용하여 작성된 테스트 케이스
테스트 코드 예제)
```java
import static org.junit.Assert.*;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

// 해당 케이스는 junit5 패키지를 사용하여 작성 및 running
public class JUnit4SampleTest {

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		System.out.println("setUpBeforeClass");
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		System.out.println("tearDownAfterClass");
	}

	@Before
	public void setUp() throws Exception {
		System.out.println("setUp");
	}

	@After
	public void tearDown() throws Exception {
		System.out.println("tearDown");
	}

	@Test
	public void test() {
		fail("Not yet implemented");
	}

}
```

