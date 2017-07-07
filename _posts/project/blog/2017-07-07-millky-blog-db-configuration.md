---
layout: post
title: "[Blog] spring boot로 블로그 만들어보기3 - DB"
date: 2017-07-07 18:24:00
projects: blog
tags: spring spring-boot mongodb
---

앞에서 프로젝트 생성 및 UI의 레이아웃은 대충 잡았으니, backend에서 간단한 데이타를 CRUD 하는 로직을 구현해보자.    
      
MongoDB를 요즘 보는 중이라는 이유로 MongoDB로 결정!!     
(MongoDB는 이미 설치되어있다고 가정. 나는 docker를 이용하여 로컬에 설치를 해두었음.)

## build.gradle 수정
db 관련 라이브러리를 추가해준다.    
```
dependencies {
(...SKIP..)
    // database
    compile('org.springframework.boot:spring-boot-starter-data-mongodb')
    
(...SKIP..)
}
```
            
## application.yml 파일 정의
MongoDB 연결을 위한 uri를 정의한다.   
```yaml
spring:
  data:
    mongodb:
      host: 192.168.99.100
      port: 27017
      database: blogdb
```

## 접속 확인을 위한 샘플 코드 작성
MongoDB에 설정한 데로 접속이 되고, 데이터베이스 생성 및 컬렉션이 생성되는 지 확인해본다.    

#### 모델
아래와 같이 모델을 간단히 정의하였음.   
```java
package com.study.blog.model;

import java.util.Date;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@ToString
@NoArgsConstructor
@Document
public class Post {
  @Id
  int id;
  String subject;
  String content;
  Date regDate;

  public Post(String subject, String content, Date regDate) {
    this.subject = subject;
    this.content = content;
    this.regDate = regDate;
  }
}
```

#### Repository
```java
package com.study.blog.repository;

import com.study.blog.model.Post;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface PostRepository extends MongoRepository<Post, Long> {
}

```

#### Application
application 실행 시에 초기 데이타가 입력되도록 수정
```java
package com.study.blog;

import com.study.blog.model.Post;
import com.study.blog.repository.PostRepository;
import java.util.Date;
import java.util.List;
import javafx.geometry.Pos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application implements CommandLineRunner
{
  @Autowired
  private PostRepository postRepository;

  public static void main(String[] args) {
    SpringApplication.run(Application.class, args);
  }

  // for test
  @Override
  public void run(String... args) throws Exception {
    postRepository.deleteAll();
    postRepository.save(new Post("title", "contents", new Date()));

    List<Post> list = postRepository.findAll();

    System.out.println("========================");
    System.out.println(list.toString());
    System.out.println("========================");
  }
}
```

#### 실행
어플리케이션을 실행해보면 실행 로그에 아래와 같은 메시지가 출력되는 것을 통해 정상적으로 MongoDB에 접속되는 것을 확인해볼 수 있다.
```
2017-07-07 18:52:58.563  INFO 5679 --- [           main] org.mongodb.driver.connection            : Opened connection [connectionId{localValue:2, serverValue:20}] to 192.168.99.100:27017
========================
[Post(id=0, subject=title, content=contents, regDate=Fri Jul 07 18:52:58 KST 2017)]
========================
```

      
> **Reference**       
> [Spring Boot + Spring Data MongoDB example](https://www.mkyong.com/spring-boot/spring-boot-spring-data-mongodb-example/)       
> [Getting Started · Accessing Data with MongoDB](https://spring.io/guides/gs/accessing-data-mongodb/)      