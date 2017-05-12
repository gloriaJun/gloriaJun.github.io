---
layout: post
title: "[Spring Boot] Swagger2Markup (asciidoc to html/pdf)"
date: 2017-04-28 18:00:00
categories: Spring
tags: spring spring-boot gradle swagger
---

[Swagger2Markup](https://github.com/Swagger2Markup/swagger2markup) 을 이용하면 AsciiDoc으로 생성된 파일을 HTML, PDF로 변환할 수 있다. 

참고로…swagger로 생성한 문서를 ascii로 변환한 뒤에 html 문서를 생성하는 과정으로 테스트 해보고 있음.
앞의 과정들은 아래의 글들을 참고하면 됨<br/>
[1. [Spring Boot] swagger2 설정하기]({% post_url /spring/2017-04-12-spring-swagger-setting %})<br/>
[2. [Spring Boot] swagger static-doc 설정하기]({% post_url /spring/2017-04-28-spring-swagger-static-doc %})

## 의존 라이브러리 설정
```
apply plugin: 'org.asciidoctor.convert'

buildscript {
	...(SKIP)...
	dependencies {
		...(SKIP)...
 		classpath "org.asciidoctor:asciidoctor-gradle-plugin:1.5.3"
      classpath 'org.asciidoctor:asciidoctorj-pdf:1.5.0-alpha.10.1'
	}
}
```

## index.adoc 파일 생성
`src/docs/asciidoc/index.adoc` 파일을 생성해준다.
```
include::{generated}/overview.adoc[]
include::{generated}/paths.adoc[]
include::{generated}/definitions.adoc[]
```

##  grade task 정의
`build.gradle` 파일에 asciidoctor 에 대한 task 수행 시 동작을 정의한다<br/>
(해당 스크립트를 통하여 asciidoc 으로 생성된 문서를 html, pdf 파일로 생성해주는 동작을 하는 것으로 추측됨)
```
asciidoctor {
    dependsOn test
    sources {
        include 'index.adoc'
    }
    outputDir file("$buildDir/docs")
    backends = ['html5', 'pdf']
    attributes = [
            doctype: 'book',
            toc: 'left',
            toclevels: '3',
            numbered: '',
            sectlinks: '',
            sectanchors: '',
            hardbreaks: '',
            generated: file("$buildDir/docs/asciidoc/generated")
    ]
}
```
`dependsOn test`을 정의해준 것은 테스트를 수행하면서 adoc파일이 생성이 되고, 해당 파일을 html, pdf로 변환해주어야 하기 때문임.

## 문서 생성
`$ gradle asciidoctor`을 수행하면 아래와 같이 문서가 생성이 된다.
```
$ tree build/docs/
build/docs/
├── asciidoc
│   └── generated
│       ├── definitions.adoc
│       ├── overview.adoc
│       └── paths.adoc
├── html5
│   └── index.html
├── markdown
│   └── generated
│       ├── definitions.md
│       ├── overview.md
│       └── paths.md
└── pdf
    └── index.pdf

6 directories, 8 files
```


> 참고 링크  
> [Swagger2Markup](https://github.com/Swagger2Markup/swagger2markup)   
> [asciidoctor-gradle-plugin](https://github.com/asciidoctor/asciidoctor-gradle-plugin)  
