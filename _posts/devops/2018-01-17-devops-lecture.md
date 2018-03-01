---
layout: post
title: "(DevOps) DevOps 첫걸음-Docker에서 Rancher를 이용한 CD까지"
date: 2018-01-17 13:57:00
author: gloria
categories: devops
tags: rancher docker
---

Udemy에서 수강한 DevOps 온라인 강좌 수강내용 정리

## 사전 준비
참고로 강사님도...내가 실습하는 환경도 모두 Mac OS였다...(실습을 따라하는 내 입장에서는 좀 수월한 느낌...)

- 강좌 링크 : [DevOps 첫걸음: Docker에서 Rancher를 이용한 CD까지](https://www.udemy.com/devops-docker-rancher-cd/)
- 강의에서 사용한 스크립트 : https://github.com/goody80/vagrant_rancher_cluster

#### 사전 조건
- virtualbox 설치 : https://www.virtualbox.org/wiki/Downloads
- vargrant 설치 : https://www.vagrantup.com/downloads.html

> **vargrant**
> 설정 스크립트를 기반으로 특정 환경의 가상 머신을 만들어서 신속하게 개발 환경을 구축하고 공유할 수 있게 만들어진 솔루션
> 참고글 : [Vagrant 란](https://www.lesstif.com/pages/viewpage.action?pageId=24445417)


## Test 환경 구축을 위한 도구(Vagrant/Git)의 설치 및 이해

#### vargrant box 설치
```bash
vagrant box add ubuntu1404 https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box
```

만약, 해당 과정에서 `SSL certificate problem`이 발생하면..box 이미지 다운받아서 아래와 같이 설치
```bash
$ vagrant box add ubuntu1404 trusty-server-cloudimg-amd64-vagrant-disk1.box
```
또는 아래와 같이 `--insecure` 옵션을 주고 실행하면 된다. -> [참고글](https://github.com/hashicorp/vagrant/pull/1712)
```bash
vagrant box add --insecure ubuntu1404 https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box
```

설치 후에 아래와 같이 설치된 box를 확인할 수 있다.
```bash
$ vagrant box list
ubuntu1404 (virtualbox, 0)
```

#### 이미지 생성
**vagrant_rancher_cluster** 디렉토리에서 아래와 같이 이미지를 생성한다. 이미지 생성이 성공하면, virtualbox에서 확인이 가능하다.
```bash
$ vagrant up vmhost01
```

만약, 수행 중 아래와 같은 에러가 발생하면...
```bash
The host path of the shared folder is missing: ~/.ssh/
```
- 원인
위와 같은 형태의 오류는 Vagrantfile에서 호스트와 공유하기 위해 설정한 디렉토리가 존재하지 않아서 발생하는 오류임.
- 해결
Vagrantfile에 `config.vm.synced_folder`에 정의된 폴더의 존재여부 확인 후에 해당 폴더를 생성해준다.


#### ssh를 이용하여 해당 이미지 내부로 접속
```bash
$ vagrant ssh vmhost01
Welcome to Ubuntu 14.04.5 LTS (GNU/Linux 3.13.0-139-generic x86_64)

 * Documentation:  https://help.ubuntu.com/

  System information as of Wed Jan 17 04:47:52 UTC 2018

  System load:  0.57              Processes:           91
  Usage of /:   3.6% of 39.34GB   Users logged in:     0
  Memory usage: 4%                IP address for eth0: 10.0.2.15
  Swap usage:   0%

  Graph this data and manage this system at:
    https://landscape.canonical.com/

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

0 packages can be updated.
0 updates are security updates.

New release '16.04.3 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


vagrant@vmhost01:~$
```


## Test 환경 구축을 위한 Vagrant 설정 및 가상장비 생성
- [Vagrantfile](https://www.vagrantup.com/docs/vagrantfile/)
생성할 가상 이미지에 대한 설정을 정의해놓은 파일이다.
해당 파일의 언어는 Ruby 언어를 이용하여 작성되어있다.

## Rancher - 시작하기
#### 설치
앞에서 다운받은 소스 디렉토리로 이동해서 vagrant를 이용하여 설치하기
```bash
~/vagrant_rancher_cluster $ vagrant up rancher
```

###### rancher 설치
가상머신에 ssh로 접속한다
```bash
$ vagrant ssh rancher
```

- Trouble Shooting
설치 과정에서 "W: Failed to fetch https://download.docker.com/linux/ubuntu/dists/trusty/stable/binary-amd64/Packages server certificate verification failed. CAfile: /etc/ssl/certs/ca-certificates.crt CRLfile: none " 에러 발생 시 해결 방법
  ```bash
  sudo -s
  cp /vagrant/provisioning/sk-ssl.crt /usr/share/ca-certificates/sk-ssl.crt
  echo “sk-ssl.crt” >> /etc/ca-certificates.conf
  sudo update-ca-certificates
  exit
  ```
  참고 링크 - [우분투에서 git clone 시 certificate(인증서) 문제 해결 방법](http://egloos.zum.com/seoz/v/4057299)

rancher를 설치하는 스크립트 (rancher.sh 파일에 포함되어있음)
```bash
mkdir /vagrant/rancher_db
sudo docker run -d -v /vagrant/rancher_db/mysql/:/var/lib/mysql --restart=unless-stopped -p 8080:8080 rancher/server
```

## Rancher - 기본구성 확인 및 host 추가하기
랜처는 기본적으로 cattle을 사용한다. 그 외에 k8s, mesos 등을 지원함.
다양한 환경을 지원한다는 것이 장점이다.

#### host 추가하기
vmhost01을 추가해준다.
```bash
cd agrant_rancher_cluster
vagrant up vmhost01
```
rancher 웹페이지에 접속해서 등록한 vmhost01을 등록해준다.
그리고 rancher를 이용하여 `INFRASTRUCTURE -> Hosts` 매뉴에서 해당 호스트를 등록해준다.
그 뒤에 호스트에 서비스 등록해보기

rancher 페이지를 이용하여 호스트의 상태 모니터링, 등록된 서비스들에 대한 콘솔 로그 확인, 쉘 수행 등이 가능하다.

## Rancher - host 추가 및 LB생성
rancher에서 기본적으로 `docker-compose.yml`을 생성하여 컨테이너를 생성한다.


## docker-compose를 이용한 Rancher 관리
별도로 사용자가 docker-compse와 rancher-compse를 생성하여 컨테이너를 생성할 수 잇다.
Stacks 매뉴를 이용하여 생성.


## Rancher 기반의 Continuous Delivery
- Baker
docker 이미지를 생성, 빌드, 체크 등을 전문화하여 하는 사람 (base image를 생성 및 관리)

- devops for CI
baker가 생성한 docker 이미지를 private repo에서 받아서 개발자가 개발한 소스 코드를 올려서 docker 이미지를 빌드

- devops for CD
devops for CI가 생성한 docker 이미지를 private repo에서 받아서 배포
