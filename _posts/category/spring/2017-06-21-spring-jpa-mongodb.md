---
layout: post
comments: true
title: "[Spring Boot] Spring Boot JPA - MongoDB"
date: 2017-06-21 12:10:00
categories: Spring
tags: spring spring-boot jpa mongodb
---

mongoDB를 이용한 spring jpa 연동 방법에 대한 정리
 
#### 의존성 정의 (gradle 기준)
`build.gradle` 파일에 아래의 의존성을 정의한다.
```
dependencies {
    compile("org.springframework.boot:spring-boot-starter-web")
    compile("org.springframework.boot:spring-boot-starter-data-jpa")
    compile('org.springframework.boot:spring-boot-starter-data-mongodb')
    testCompile("junit:junit")

    compile("org.springframework.boot:spring-boot-starter-test")
    compileOnly ("org.projectlombok:lombok:1.16.16")
}
```

#### 환경설정 파일 정의
mongoDB의 접속정보에 대한 환경설정을 `application.yml` 파일에 추가한다.
```
spring.data.mongodb.uri: mongodb://db:dbpass@192.168.99.100:27017/dashboard
```

#### Model 
```
(collection="user_info")
@CompoundIndexes({
    // 복합인덱스 "username_authType"를 생성 (1 : 오름차순 , -1 : 내림차순)
    @CompoundIndex(name = "username_authType", def = "{'username' : 1, 'authType': 1}")
})
public class UserInfo {
  @Id
  private ObjectId id;
  private String username;
  private Collection<UserRole> authorities;
  private AuthType authType;
  private String firstName;
  private String middleName;
  private String lastName;
  private String displayName;
  private String emailAddress;

	(...SKIP...)
}
```

#### Repository
```
public interface UserInfoRepository extends CrudRepository<UserInfo, ObjectId> {
  UserInfo findByUsername(String username);
}
```

#### Service
```
@Service
public class UserInfoService {

  private UserInfoRepository userInfoRepository;

  @Autowired
  public UserInfoService(UserInfoRepository userInfoRepository) {
    this.userInfoRepository = userInfoRepository;
  }

  public Collection<UserInfo> getUsers() {
    return Sets.newHashSet(userInfoRepository.findAll());
  }

  public UserInfo getUserInfoByUsername(String username) {
    return userInfoRepository.findByUsername(username);
  }

}
```

#### Controller
```
@RestController
@RequestMapping("/users")
public class UserInfoController {

  private UserInfoService userInfoService;

  @Autowired
  public UserInfoController(UserInfoService userInfoService) {
    this.userInfoService = userInfoService;
  }

  @GetMapping
  public ResponseEntity<Collection<UserInfo>> getUsers() {
    Collection<UserInfo> list = userInfoService.getUsers();
    return new ResponseEntity<Collection<UserInfo>>(list, HttpStatus.OK);
  }

  @GetMapping("/{username}")
  public ResponseEntity<UserInfo> getUserInfo(@PathVariable String username) {
    UserInfo userInfo = userInfoService.getUserInfoByUsername(username);
    return new ResponseEntity<UserInfo>(userInfo, HttpStatus.OK);
  }
}
```