---
layout: post
title: "[Blog] spring boot로 블로그 만들어보기4 - Post CRUD API "
date: 2017-07-08 19:24:00
projects: blog
tags: spring spring-boot mongodb
---

Post를 “작성, 수정, 조회, 삭제”를 위한 REST-API를 만들자.    

[spring boot로 블로그 만들어보기3 - DB]({% post_url project/blog/2017-07-07-project-blog-step3 %})에서 생성한 Model과 Repository를 그대로 사용하므로 Controller와 Service를 생성한다.    

## Service



> *Project 과정에 대한 글 리스트*    
> 1. [spring boot로 블로그 만들어보기]({% post_url project/blog/2017-07-06-project-blog-step1 %})
> 2. [spring boot로 블로그 만들어보기2 - UI 테마 적용]({% post_url project/blog/2017-07-07-project-blog-step2 %})
> 3. [spring boot로 블로그 만들어보기3 - DB]({% post_url project/blog/2017-07-07-project-blog-step3 %})