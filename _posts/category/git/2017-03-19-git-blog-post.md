---
layout: post
title: "[github blog] 블로그 포스트 등록하기"
date: 2017-03-19 19:30:00
categories: Git
tags: jekyll github-page
---

블로그 디렉토리 하위의 **_post** 디렉토리에 markdown 을 이용하여 작성한 파일을 추가하면된다.
단, 다음과 같은 규칙을 지켜야 한다.
* 파일명은 **YYYY-MM-DD-[영문파일명].md** 로 생성한다.
* 파일명은 반드시 한글로 생성해야한다.

## 블로그 내용 작성
파일을 생성하고 상단에 아래와 같은 헤더를 입력한다.
해당 부분의 값을 이용해서 블로그의 카테고리와 태그를 설정할 수 있다.
```
---
layout: post
title: 제목
date: 2017-03-17 23:00:00
categories: 일상
tags: 행복
---
```

그리고 하단에 markdown을 이용해서 내용을 작성한다.

## 작성한 블로그 내용 확인하기
`jekyll server —watch`  명령을 터미널에서 수행한 뒤에 로컬에서 확인할 수 있다.

## GitHub 에 반영하기
Git 명령어를 이용해서 원격레파지토리에 작성한 내용을 반영해서 올리면 내가 작성한 글이 블로그에 포스팅 된다.

```shell
git add .
git commit -m "commit message"
git push origin master
```
