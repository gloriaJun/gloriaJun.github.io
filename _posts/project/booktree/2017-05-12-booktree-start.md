---
layout: post
title: "[BookTree] Start Project"
date: 2017-05-12 13:00:00
projects: booktree
tags: spring spring-boot gradle
---

todo 어플리케이션을 스프링부트를 이용하여 만들어보기.

### 프로젝트 생성
나중에 달력을 붙여서 일정관리 부분을 연동할 계획을 하고, 아래와 같이 하나의 프로젝트에 모듈화 하여 구성을 하였음.
![]({{ site.url }}/assets/images/post/my-project/2017/myCalendar/project-todo-structure.png)

### Configuration
gradle을 이용하여 라이브러리들과 모듈에 대한 관계를 설정하였음.

##### settings.gradle
```
rootProject.name = 'todo'
include 'common'
include 'todo-app'
```

###### gradle.properties
```

```
 
##### build.gradle
최상위 루트 모듈에 공통으로 사용되는 부분을 정의하고, 하위 모듈에서 사용되는 패키지들은 각 모듈에 위치한 파일에 정의한다.




