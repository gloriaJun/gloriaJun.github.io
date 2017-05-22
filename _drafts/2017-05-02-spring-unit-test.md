---
layout: post
comments: true
title: "[Spring Boot] Unit Test Example"
date: 2017-05-02 12:00:00
categories: Spring
tags: spring spring-boot unit-test
---

!!!!!
아래의 글과 합쳐서 정리하자
---
layout: post
title: "[Spring Boot] unit test"
date: 2017-04-07 19:00:00
categories: Spring
tags: spring spring-boot unit-test
---
!!!!!!

Spring Boot 를 이용하여 작성한 코드들에 대한 단위 테스트 작성 예시 정리하기…

## Repository Test
`@DataJpaTest`와 `TestEntityManager` 를 이용하여 작성.
{% gist gloriaJun/deb5b74609dd9fcc709f7b9201997592 BookInfoRepositoryTest %}

참고로 id를 `@GeneratedValue`로 선언을 한 경우, 단 건 테스트 시에는 문제가 없으나 클래스 전체의 테스트 메소드를 한 번에 수행하는 경우에 id가 자동으로 1개씩 증가를 해서 원하는 값을 select하거나, 값을 비교하는 경우에 정상동작을 했음에도 에러가 발생할 수 있다.
그러므로 입력 시점의 id을 이용하여 값을 조회하고, 기대값과 비교하는 경우에는 id 빼고 값을 비교하여 체크하거나, `testFindOneById()`에서와 같이 작성을 해서 검증을 해야 한다.

## Service Test
전체 서비스 모듈을 로딩하지 않고, 테스트 하고자 하는 모듈만 로딩하고자 하는 경우에는 아래와 같이 해당 모듈에 대한 클래스 파일을 명시해준다.
```java
@SpringBootTest (classes = {BookInfoService.class, ...})
```

작성한 테스트 전체 코드
* mock을 사용한 테스트 케이스
{% gist gloriaJun/deb5b74609dd9fcc709f7b9201997592 BookInfoServiceWithMockTest %}

* mock을 사용하지 않은 테스트 케이스
{% gist gloriaJun/deb5b74609dd9fcc709f7b9201997592 BookInfoServiceTest %}


## Controller Test

작성한 테스트 전체 코드
{% gist gloriaJun/deb5b74609dd9fcc709f7b9201997592 BookTreeControllerTest %}


> 참고 링크<br/>
> [Unit and Integration tests in Spring Boot](http://www.lucassaldanha.com/unit-and-integration-tests-in-spring-boot/)
> [SpringAngular2TypeScript/server/src/test/java/ch/javaee/demo/angular2/test at master · marco76/SpringAngular2TypeScript · GitHub](https://github.com/marco76/SpringAngular2TypeScript/tree/master/server/src/test/java/ch/javaee/demo/angular2/test)