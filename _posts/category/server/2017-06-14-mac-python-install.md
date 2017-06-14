---
layout: post
comments: true
title: "[Mac OS X] python 설치 with pyenv"
date: 2017-06-14 17:40:00
categories: server
tags: mac python
---

`pyenv`를 이용하여 손쉽게 버전 변경해 사용할 수 있도록 설치하는 방법에 대한 정리   

#### pyenv 설치
손쉽게 여러 버전의 Python을 변경하여 사용할 수 있도록 도와주는 도구이다.

```
$ brew install pyenv
Updating Homebrew...
==> Auto-updated Homebrew!
Updated 1 tap (homebrew/core).
==> New Formulae
(... SKIP ...)
```

#### pyenv-virtualenv 설치
`virtualenv` 라는 툴을 이용하여 가상환경을 생성하여 해당 프로젝트에 해당하는 python을 활성화하여 실행시킴으로써 프로젝트 마다의 버전 호환성에 대한 문제를 해결할 수 있다.

```
$ brew install pyenv-virtualenv
Updating Homebrew...
==> Using the sandbox
==> Downloading https://github.com/yyuu/pyenv-virtualenv/archive/v1.0.0.tar.gz
(... SKIP ...)
```

#### profile 설정
`.bash_profile`과 같은 환경설정 파일에 아래의 설정을 추가해준다.

```
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

#### python 설치
`pyenv`를 이용하여 python을 설치한다.   

아래와 같이 설치가 가능한 버전을 확인할 수 있다.
```
$ pyenv install --list python
Available versions:
  2.1.3
  2.2.3
  2.3.7
(... SKIP ...)
```
   
아래와 같이 설치 한다.

```
$ pyenv install 3.6.1
Downloading Python-3.6.1.tar.xz...
-> https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tar.xz
(... SKIP ...)
```
    
설치된 목록은 아래와 같이 확인할 수 있다.

```
$ pyenv versions
* system (set by /Users/gloria/.pyenv/version)
  3.6.1
```
    
###### python 버전 변경
다음과 같이 사용 중인 python의 버전을 변경할 수 있다.   
(현재 사용 중인 버전에 `*` 표시가 된다.)

```
$ pyenv shell 3.6.1
$ pyenv versions
  system
* 3.6.1 (set by PYENV_VERSION environment variable)
```
    
#### pyenv로 virtualenv 생성
`3.6.1`에 해당하는 가상환경 생성하기.

```
$ pyenv virtualenv 3.6.1 virtualenv-test-3.6.1
Requirement already satisfied: setuptools in /Users/gloria/.pyenv/versions/3.6.1/envs/virtualenv-test-3.6.1/lib/python3.6/site-packages
Requirement already satisfied: pip in /Users/gloria/.pyenv/versions/3.6.1/envs/virtualenv-test-3.6.1/lib/python3.6/site-packages

$ pyenv versions
* system (set by /Users/gloria/.pyenv/version)
  3.6.1
  3.6.1/envs/virtualenv-test-3.6.1
  virtualenv-test-3.6.1
```
     
생성한 가상환경을 실행시키기 (가상환경을 실행시키면 해당 가상환경에 대한 명칭이 prompt에 표시된다.)   

```
$ export PYENV_VIRTUALENV_DISABLE_PROMPT=1

$ pyenv activate virtualenv-test-3.6.1
pyenv-virtualenv: version `virtualenv-test-3.6.1' is already activated

(virtualenv-test-3.6.1) $ python -V
Python 3.6.1
```
    
해당 환경에 필요한 패키지들을 설치한다.

```
$ pip install pexpect
Collecting pexpect
  Downloading pexpect-4.2.1-py2.py3-none-any.whl (55kB)
    100% |████████████████████████████████| 61kB 408kB/s
Collecting ptyprocess>=0.5 (from pexpect)
  Downloading ptyprocess-0.5.1-py2.py3-none-any.whl
Installing collected packages: ptyprocess, pexpect
Successfully installed pexpect-4.2.1 ptyprocess-0.5.1
```
    
설치한 패키지들에 대한 `requirements.txt` 파일을 생성한다.

```
$ pip list > requirements.txt
DEPRECATION: The default format will switch to columns in the future. You can use --format=(legacy|columns) (or define a format=(legacy|columns) in your pip.conf under the [list] section) to disable this warning.
(virtualenv-test-3.6.1) [17:45:59] ~/data/private/python-test

$ cat requirements.txt
pexpect (4.2.1)
pip (9.0.1)
ptyprocess (0.5.1)
setuptools (28.8.0)
```
    
해당 환경에서 작업이 완료되면 가상환경을 빠져나온다.

```
$ pyenv deactivate
```
   
참고로 앞에서 생성한 `requirements.txt` 파일을 이용하여 다른 환경에서 간편하게 동일한 패키지를 설치하여 환경을 구성할 수 있다.

```
$ pip install -r requirements.txt  
```
    
#### autoenv
@ToDO
   

> *Reference*   
> [취미로 하는 프로그래밍 !!! :: python — Mac 에서 pyenv, virtualenv 설치하기](http://freeprog.tistory.com/281)     
> [맥에서의 파이썬 개발 환경 자동화(pyenv, virtualenv, autoenv)](http:// guswnsxodlf.github.io/pyenv-virtualenv-autoenv)   
> [Python 개발 환경 구축하기 - pyenv, virtualenv, autoenv – Jihun’s Development Blog](https://cjh5414.github.io/python-%EA%B0%9C%EB%B0%9C%ED%99%98%EA%B2%BD%EA%B5%AC%EC%B6%95/)   
