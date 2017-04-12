---
layout: post
title: "[Spring Boot] multi module project on Maven"
date: 2017-04-06 17:00:00
categories: Spring
tags: spring spring-boot maven
---

intellij를 사용해서 maven 기반의 multi module project 생성하기.

### 프로젝트 생성
먼저 빈 프로젝트를 하나 생성한 뒤, [File - New - Module]을 선택해서 parent, service, web 모듈을 생성한다.

생성된 프로젝트 구조는 다음과 같음.<br/>
![]({{ site.url }}/assets/images/spring/2017/0406-spring-multi-module-maven/project-maven.png)

### pom.xml 파일 정의
##### parent
기본으로 생성된 src 폴더는 삭제한다.
그리고 pom.xml에 서브 모듈을 정의한다.<br/> 

그리고 공통으로 관리할 패키지들의 버전이 있다면, `dependencyManagement`를 이용하여 정의해주면 된다. <br/>
*(부모 POM 에서 <dependencyManagement> 정의를 통해 자식 POM 에서 버전을 명기하지 않아도 디펜던시를 참조할 수 있다고 함.)*
{% gist /gloriaJun/b621d919c20840dc28170252c435d361 parent-pom.xml %}

##### service
서비스 모듈에서는 parent와 연결을 해주고, jpa를 이용하여 구현할 예정이므로 관련된 패키지를 정의해준다.
{% gist /gloriaJun/b621d919c20840dc28170252c435d361 service-pom.xml %}

##### web
Web 모듈에서는 실제 어플리케이션이 동작할 것이므로 web을 추가 해주고, service 모듈에 대한 dependency도 정의해준다.
{% gist /gloriaJun/b621d919c20840dc28170252c435d361 web-pom.xml %}

### service 모듈에 컴포넌트와 서비스 생성
##### Entity class 생성
{% gist /gloriaJun/b621d919c20840dc28170252c435d361 service-ToDo.java %}

##### Repositoy class 생성
{% gist /gloriaJun/b621d919c20840dc28170252c435d361 service-ToDoRepository.java %}

##### Service interface class 생성
{% gist /gloriaJun/b621d919c20840dc28170252c435d361 service-ToDoService.java %}

##### Service class 생성
{% gist /gloriaJun/b621d919c20840dc28170252c435d361 service-ToDoServiceImpl.java %}

### web 모듈
##### controller 생성
{% gist /gloriaJun/b621d919c20840dc28170252c435d361 web-ToDoController.java %}

##### application 생성
`public CommandLineRunner setup(final ToDoRepository toDoRepository) ` 메소드는 application 기동 시에 데이타를 출력하기 위해 초기 샘플 데이타 값을 설정해준 부분이다.
{% gist /gloriaJun/b621d919c20840dc28170252c435d361 Application.java %}


### 빌드
maven으로 빌드를 해보면 아래와 같이 관련 모듈들이 같이 빌드되는 것을 확인할 수 있다.
```
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary:
[INFO] 
[INFO] sample-multi-module-parent ......................... SUCCESS [  0.001 s]
[INFO] sample-multi-module-service ........................ SUCCESS [  0.421 s]
[INFO] sample-multi-module-web ............................ SUCCESS [  0.054 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
```

### 실행
application을 실행 후에 `http://localhost:8080`에 접속하거나, postman을 통해 요청을 날려보면 아래와 같은 메시지가 화면에 출력되는 것을 확인할 수 있음.
```json
[
  {
    "id": 1,
    "text": "clean up the room",
    "completed": false
  },
  {
    "id": 2,
    "text": "study math",
    "completed": true
  }
]
```

또는 `curl`을 설치 후에 아래와 같은 방법으로도 확인이 가능함.
```
$ curl localhost:8080/
[{"id":1,"text":"clean up the room","completed":false},{"id":2,"text":"study math","completed":true}]
```

<br/><br/>
> 참고 사이트  
> [Getting Started · Creating a Multi Module Project](https://spring.io/guides/gs/multi-module/)  
> http://aoruqjfu.fun25.co.kr/index.php/post/601  
> https://idodevjobs.wordpress.com/2014/04/13/maven-multi-module-example/  
> https://medium.com/@gustavo.ponce.ch/spring-boot-restful-junit-mockito-hamcrest-eclemma-5add7f725d4e