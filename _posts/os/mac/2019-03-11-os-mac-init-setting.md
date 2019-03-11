---
layout: post
title: "(Mac OS X) mac 초기 설정하기 "
date: 2019-03-11 23:00:00
author: gloria
categories: os
tags: mac-OS
---

* TOC
{:toc}

mac 클린 설치 후에 다시 환경을 설정하는 김에 미래에 다시 설정 작업 할 때에 참고하기 위해 기록을 남겨두기...

# Homebrew 설치

[homebrew](https://brew.sh)는 맥os전용 패키지 관리자이다.
홈페이지에 접속 또는 아래의 명령어를 복사해서 붙여서 실행하여 설치한다.

```bash
/usr/bin/ruby -e “$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)”
```

> homebrew를 이용하여 mac에서 필요한 패키지를 설치하고 관리할 수 있다.
> [Homebrew를 사용해서 Mac 패키지를 관리하기 | TutorialPost](https://tutorialpost.apptilus.com/posts/tools/homebrew-for-mac/)

# Terminal 설치
iterm2을 설치 후에 좀 더 편리하게 사용하기 위해 zsh로 변경하여 사용한다.

iterm2는 홈페이지 또는 아래의 명령어를 통해서 설치할 수 있다.

```bash
brew cask install iterm2
```

[item2 테마 다운로드](https://iterm2colorschemes.com/)

## vimrc 설정

```bash
" Vim 전용 기능 사용
set nocp

" 옵션 복원
set all&

" 명령어 기록 갯수
set hi=100

" 백스페이스 사용
set bs=indent,eol,start
" 인코딩 설정
"let &tenc=&enc
"set enc=utf-8
set fenc=utf-8
set fencs=utf-8,cp949,cp932,euc-jp,shift-jis,big5,ucs-2le,latin1

" 커서 위치 항상 보이기
set ru

" 완성중인 명령을 표시
set sc

" 줄번호 표시
set nu

" 줄 번호 표시 너비 설정
set nuw=5

" 탭 크기 설정
set ts=4 sw=4 sts=4 smarttab expandtab
set textwidth=79

" 탭 >> 공백 변환 사용안함
set noet
set sts=0

" 자동 줄바꿈 안함
set nowrap

" 마지막 편집 위치 복원 기능
"au BufReadPost *
"if line("'￦"")>0 && line("'￦"") <= line("$") |
" exe "norm g'￦"" |
"endif

" magic 기능 사용
set magic

" 이동 동작시 줄의 시작으로 자동 이동
set sol

" 비쥬얼 모드 동작 설정
set sel=exclusive

" 괄호짝 찾기에서 <> 도 찾도록 추가
set mps+=<:>

" 새로 추가된 괄호 짝 보여주기
"set sm

" 검색어 강조
set hls

" 검색시 파일 끝에서 되돌리기 안함
set nows

" 검색시 대소문자 구별 안함
set ic

" 스마트한 대소문자 구별 기능 사용
set scs

" 항상 status 라인을 표시
set ls=2

" 커스텀 확장자들에게 파일 형식 설정
"au BufRead,BufNewFile *.dic setl ft=php

"파일 형식에 따른 신택스 하이라이팅 켜기
sy enable

"fetched from /usr/share/vim/vim61/macros/vimrc
"fetched from /usr/share/vim/vim61/macros/vimrc
set term=$TERM
if &term == "screen"
    set term=xterm-color
set t_ti=
endif
```

## zsh 설치

```bash
brew install zsh

# 기본 쉘 변경
chsh -s `which zsh`
```

설치 후에 iterm2를 종료 후 다시 실행 시켜서 기본 쉘이 변경되었는 지 확인해본다.

```bash
echo $SHELL
```

oh-my-zsh는 ZSH를 더 쉽게 사용해주는 플러그인이다. 해당 플러그인도 설치하자.

```bash
# oh my zsh 다운로드
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"  
```

### 테마 설치

개인적으로 [bullet-train](https://github.com/caiogondim/bullet-train.zsh)의 PS1 설정이 맘에 들어서 해당 테마를 설치했다.

```bash
git clone https://github.com/caiogondim/bullet-train.zsh.git
cp bullet-train.zsh/bullet-train.zsh-theme $ZSH_CUSTOM/themes
```

위와 같이 설치한 뒤에 `~/.zshrc`에서 테마 설정을 수정해준다.

```bash
# 아래의 설정 수정 
ZSH_THEME="bullet-train"

# 아래와 같이 적용
source ~/.zshrc
```

### font 설치

폰트를 다운로드한 후에 설치하고서 iterm2의 profile 설정에서 해당 폰트로 수정해준다.

```bash
git clone https://github.com/powerline/fonts.git
cd fonts
sh ./install.sh
```

### 플러그인 설치

#### autosuggestions

[autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)은 history 기반으로 명령어를 추천해준다. 방향키를 이용하여 자동완성을 할 수 있다.

#### syntax highlighting

[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)은 유효한 명령어에 대해 색깔을 변경해서 표현해준다.

#### autojump

[autojump](https://github.com/wting/autojump)는 `j`를 이용하여 디렉토리 이동을 편리하게 할 수 있다.

# IDE 설정

## VSCODE

* vscode를 설치 후에 *Settings Sync*를 설치한다.
* *Shift + option + D*를 클릭한 뒤에 출력되는 창에서 Github Token과 Gist ID를 입력한다.
* 정상적으로 인증이 되면 Git에 공유되어있던 설정들을 다운받아 오면서 설정 정보를 동기화하는 작업이 진행된다.

# Frontend 개발 도구 설치

## Yarn

```bash
brew install yarn

# NVM 같은 버전 관리 툴을 사용해야 한다면 Node.js의 설치를 제외하여 설치한다.
brew install yarn --ignore-dependencies
```
