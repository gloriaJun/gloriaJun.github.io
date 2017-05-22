---
layout: post
comments: true
title: "[JUnit] command line으로 argument 전달받기"
date: 2017-05-18 15:24:00
categories: "Testing"
tags: junit arguments
---

테스트 수행 시에 아규먼트 값을 전달하는 방법

## `mvn test`를 수행하여 전달 
maven test 수행 시에 argument로 전달하는 방법
```
mvn test -Dmode=local
mvn test -DargLine="-Dmode=local"

mvn test -Dmode=local -Dname=kay
mvn test -DargLine="-Dmode=local -Dname=kay"
```


## 테스트 코드에서 전달된 아규먼트 값 로딩
아래와 같이 전달된 아규먼트 값을 로딩할 수 있다.
```java
System.getProperty("mode");
```

