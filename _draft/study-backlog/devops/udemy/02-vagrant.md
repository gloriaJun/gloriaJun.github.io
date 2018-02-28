# DevOps 첫걸음: Docker에서 Rancher를 이용한 CD까지

## Test 환경 구축을 위한 도구(Vagrant/Git)의 설치 및 이해
[강의 링크](https://www.udemy.com/devops-docker-rancher-cd/learn/v4/t/lecture/6929912?start=0)

#### vargrant box 설치
```
vagrant box add ubuntu1404 https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box
```
만약, 해당 과정에서 `SSL certificate problem`이 발생하면..box 이미지 다운받아서 아래와 같이 설치
```
$ vagrant box add ubuntu1404 trusty-server-cloudimg-amd64-vagrant-disk1.box
```
또는 아래와 같이 `--insecure` 옵션을 주고 실행하면 된다. ([참고글](https://github.com/hashicorp/vagrant/pull/1712))
```
vagrant box add --insecure ubuntu1404 https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box
```

설치 후에 아래와 같이 설치된 box를 확인할 수 있다.
```
$ vagrant box list
ubuntu1404 (virtualbox, 0)
```

#### 이미지 생성
`vagrant_rancher_cluster` 디렉토리에서 아래와 같이 이미지를 생성한다. 이미지 생성이 성공하면, virtualbox에서 확인이 가능하다.
```
$ vagrant up vmhost01
```
> **The host path of the shared folder is missing: ~/.ssh/**
> - 원인
> 위와 같은 형태의 오류는 Vagrantfile에서 호스트와 공유하기 위해 설정한 디렉토리가 존재하지 않아서 발생하는 오류임.
> - 해결
>  Vagrantfile에 `config.vm.synced_folder`에 정의된 폴더의 존재여부 확인 후에 해당 폴더를 생성해준다.

ssh를 이용하여 해당 이미지 내부로 접속
```
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
[강의 링크](https://www.udemy.com/devops-docker-rancher-cd/learn/v4/t/lecture/6929920?start=0)

###### Vagrantfile
생성할 가상 이미지에 대한 설정을 정의해놓은 파일이다.
해당 파일의 언어는 `Ruby` 언어를 이용하여 작성되어있다.
- 참고 : [https://www.vagrantup.com/docs/vagrantfile/](https://www.vagrantup.com/docs/vagrantfile/)
