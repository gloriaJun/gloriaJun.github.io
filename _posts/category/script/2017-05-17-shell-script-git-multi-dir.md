---
layout: post
title: "[Shell Script] git clone과 다수 디렉토리의 pull 스크립트"
date: 2017-05-17 18:35:00
categories: "Script"
tags: shell-script git
---

동일 프로젝트 내에 다수의 git 레파지토리가 존재할 때..<br/>
한 번의 스크립트 실행으로 모든 디렉토리를 pull을 하고, 레파지토리명만 아규먼트로 전달함으로써 로컬에 clone하기 위해 작성한 스크립트.

```shell
#!/bin/sh

baseDir="Documents/study/project-name"
baseUrl="레파지토리.git을 제외한 url" # 예시 : https://gloriaJun@bitbucket.org/gloria-study

#############################
# Function
#############################
function _pull() {
# read directory
dirs=`ls -d */`

# git pull
for dir in $dirs;do
    echo "";echo "====================================="
    echo " ==> git pull '$dir'"
    cd $dir
    git pull
    echo "result code : $?"
    cd - > /dev/null
done
}

function _clone() {
    repo=$1
    echo "";echo "====================================="
    echo "==> git clone repository : $repo"

    # check directory
    if [ -d $repo ]; then
    echo "error) alredy exist";echo ""
    exit -1
    fi

    git clone $baseUrl/$repo.git
    if [ $? -eq 0 ]; then
    cd $repo
    echo "";echo "==> set user configuration"
    git config user.name "사용자 이름"
    git config user.email "사용자 이메일"
    echo "DONE"
    cd - > /dev/null
    fi
}

#############################
# Main
#############################
if [ $# -eq 0 ]; then
    echo "usage error"
    exit -1
fi

echo "- Move to Working Directory to '$baseDir'"
cd ~/$baseDir

opt=$1
case $opt in
    pull)
    _pull
    ;;
    clone)
    _clone $2
    ;;
    *)
    echo "usage error"
    ;;
esac

echo "";echo ""
```


