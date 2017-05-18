---
layout: post
title: "[github blog] github 블로그 만들기 for mac"
date: 2017-03-18 10:30:00
categories: Git
tags: jekyll github-page
---

github 블로그 생성에 앞서. 개념부터 집고 넘어가기.

## What is Jekyll ?
markdown 형식의 텍스트 파일을 html 파일로 변환해주는 변환도구라고 한다.
즉, 사용자 입장에서는 로컬에서 markdown 으로 글을 작성하고 Jekyll을 이용하여 블로그 서버에 올려주면 된다는 말씀!<br/>
( *오호!! 그럼 나는 로컬에서 markdown을 이용해서 정리하고 싶은 내용들을 작성하고, 반영만 하면 되겠군!!* )<br/>
github page가 Jekyll을 자체 지원하고 있으므로 많은 사용자들이 사용하는 거라고....

그리고 또한 git이 형상관리를 제공하는 온라인 저장소이므로...글을 올릴 수 있을 뿐만 아니라 버전관리도 할 수 있다는..거기다 무료!!!!<br/>
(*이거 일석이조 인 듯한 느낌..아닌 느낌..*)
<br/><br/>

---

## github에 블로그 생성을 위한 repository 생성하기
먼저 github에 블로그 생성을 위한 repository를 생성하자.
중요한 것은 repository 이름이다!!
repository 이름에 자신의 github 사용자아이디를 이용하여 *[사용자아이디].github.io* 와 같이 생성해준다.
![]({{ site.url }}/assets/images/post/git/2017/0318-git-blog-create/create-repo.png)



## Jekyll 설치
mac의 경우 기본으로 ruby가 설치되어 있어 별도 설치가 필요없다해서 건너띄었다.
gem 명령어를 통해 jekyll을 설치하므로 아래와 같이 `which gem`을 해서 명령어 위치가 확인되면 그냥 설치를 진행하고...없으면 ruby 부터 설치한다.
```shell
$ which gem
/usr/bin/gem
```
jekyll은 아래와 같이 설치하면 된다.
```shell
$ sudo gem install jekyll
```

## 로컬 저장소 생성
블로그에 올릴 파일에 대한 로컬 저장소를 생성한다.
단, 여기서 생성할 폴더명은 앞에서 레파지토리로 지정한 이름을 사용하여 생성한다.
```shell
$ jekyll new gloriaJun.github.io
```

만약, 폴더를 생성하는 과정에서 아래와 같은 오류가 발생했다면..
bundler 설치를 해주자!!!
```
Dependency Error: Yikes! It looks like you don't have bundler or one of its dependencies installed. In order to use Jekyll as currently configured, you'll need to install this gem. The full error message from Ruby is: 'cannot load such file -- bundler' If you run into trouble, you can find helpful resources at https://jekyllrb.com/help/!
jekyll 3.4.2 | Error:  bundler
```
아래와 같은 명령어를 실행하여 설치를 하면된다.
```shell
$ sudo gem install bundler
```
정상적으로 설치가 완료되었다면 다시 폴더를 생성해준다.
참고로 이전에 명령어 실패 시 폴더가 생성되어 있다면, 삭제 후 다시 실행하면 된다.

## 로컬에 생성된 블로그 확인하기
앞에서 생성한 폴더로 이동한 뒤에 **jekyll server --watch** 를 실행하면 웹브라우저를 이용하여 정상적으로 생성이 되었는 지 로컬 서버를 띄워 확인할 수 있다.
```shell
$ cd gloriaJun.github.io
$ jekyll serve --watch
Configuration file: none
Configuration file: none
            Source: /Users/hyena/Documents/myblog/gloriaJun.github.io
       Destination: /Users/hyena/Documents/myblog/gloriaJun.github.io/_site
 Incremental build: disabled. Enable with --incremental
      Generating...
                    done in 0.021 seconds.
 Auto-regeneration: enabled for '/Users/hyena/Documents/myblog/gloriaJun.github.io'
Configuration file: none
    Server address: http://127.0.0.1:4000/
  Server running... press ctrl-c to stop.
```
>`jekyll serve --watch` 을 수행하면 해당 명령을 수행한 위치의 폴더의 파일들을 변환하여 `./site`에 생성하고, 파일이 변경되면 자동으로 반영해준다.

웹브라우저(http://127.0.0.1:4000/)에 접속해보면 다음과 같은 화면이 출력된다.
![]({{ site.url }}/assets/images/post/git/2017/0318-git-blog-create/test-page.png)


## github 원격 저장소 연결하기
이제는 github에 생성한 remote와 로컬의 디렉토리를 연결하는 작업을 한다. (로컬의 작업한 파일을 git을 이용하여 원격 저장소에 반영하는 것과 동일한 작업이라고 보면 된다.)
아래의 작업들은 블로그에 올릴 파일들을 관리하기 위해 앞에서 생성한 디렉토리로 이동하여 작업한다.

로컬 저장소를 git으로 관리할 수 있도록 저장소를 생성한다
```shell
$ git init
```

원격 저장소와 연결해준다.
```shell
$ git remote add origin https://github.com/gloriaJun/gloriaJun.github.io.git
```
생성한 모든 파일을 반영하기 위해 아래와 같이 명령을 수행한다.
```shell
$ git add .
```
위의 명령을 수행한 뒤에 status 를 확인해보면 아래와 같이 확인된다.
```shell
$ git status
On branch master

Initial commit

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

	new file:   .gitignore
	new file:   Gemfile
	new file:   Gemfile.lock
	new file:   _config.yml
	new file:   _posts/2017-03-18-welcome-to-jekyll.markdown
	new file:   about.md
	new file:   index.md
```
일단 로컬 저장소에 먼저 커밋을 하여 반영한다.
```shell
$ git commit -m 'my blog init files'
[master (root-commit) 2a69990] my blog init files
 7 files changed, 168 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 Gemfile
 create mode 100644 Gemfile.lock
 create mode 100644 _config.yml
 create mode 100644 _posts/2017-03-18-welcome-to-jekyll.markdown
 create mode 100644 about.md
 create mode 100644 index.md
```
원격 저장소에 해당 내용들을 반영한다
```shell
$ git push origin master
```
github에 접속해 해당 레파지토리를 확인하면 아래와 같이 커밋된 내용들을 확인할 수 있다.
![]({{ site.url }}/assets/images/post/git/2017/0318-git-blog-create/first-commit.png)

그리고 웹브라우저에서 레파지토리명으로 생성한 이름(**https://gloriajun.github.io/**)으로 입력하면 앞에서 로컬에서 확인한 웹페이지를 만날 수 있다.
그럼 정상적으로 블로그가 생성된 것이다.
