# DevOps 첫걸음: Docker에서 Rancher를 이용한 CD까지

## Rancher - 시작하기
[강의 링크](https://www.udemy.com/devops-docker-rancher-cd/learn/v4/t/lecture/6934546?start=0)

#### 설치
앞에서 다운받은 소스 디렉토리로 이동해서 vagrant를 이용하여 설치하기
```
~/vagrant_rancher_cluster $ vagrant up rancher
```

#### rancher 설치
가상머신에 ssh로 접속한다
```
$ vagrant ssh rancher
```

###### Trouble Shooting
설치 과정에서 "W: Failed to fetch https://download.docker.com/linux/ubuntu/dists/trusty/stable/binary-amd64/Packages  server certificate verification failed. CAfile: /etc/ssl/certs/ca-certificates.crt CRLfile: none " 에러 발생 시 해결 방법
```
sudo -s
cp /vagrant/provisioning/sk-ssl.crt /usr/share/ca-certificates/sk-ssl.crt
echo “sk-ssl.crt” >> /etc/ca-certificates.conf
sudo update-ca-certificates
exit
```
참고 링크 - [우분투에서 git clone 시 certificate(인증서) 문제 해결 방법](http://egloos.zum.com/seoz/v/4057299)

rancher를 설치하는 스크립트 (rancher.sh 파일에 포함되어있음)
```
mkdir /vagrant/rancher_db
sudo docker run -d -v /vagrant/rancher_db/mysql/:/var/lib/mysql --restart=unless-stopped -p 8080:8080 rancher/server

```


## Rancher - 기본구성 확인 및 host 추가하기
[강의 링크](https://www.udemy.com/devops-docker-rancher-cd/learn/v4/t/lecture/6934548?start=0)
랜처는 기본적으로 cattle을 사용한다. 그 외에 k8s, mesos 등을 지원함.
다양한 환경을 지원한다는 것이 장점이다.

#### host 추가하기
vmhost01을 추가해준다.
```
cd agrant_rancher_cluster
vagrant up vmhost01
```

rancher 웹페이지에 접속해서 등록한 vmhost01을 등록해준다.
그리고 rancher를 이용하여 `INFRASTRUCTURE` -> `Hosts` 매뉴에서 해당 호스트를 등록해준다.
그 뒤에 호스트에 서비스 등록해보기

rancher 페이지를 이용하여 호스트의 상태 모니터링, 등록된 서비스들에 대한 콘솔 로그 확인, 쉘 수행 등이 가능하다.



## Rancher - host 추가 및 LB생성
[강의 링크](https://www.udemy.com/devops-docker-rancher-cd/learn/v4/t/lecture/6934550?start=0)
rancher에서 기본적으로 `docker-compose.yml`을 생성하여 컨테이너를 생성한다.

## docker-compose를 이용한 Rancher 관리
[강의 링크](https://www.udemy.com/devops-docker-rancher-cd/learn/v4/t/lecture/6934554?start=0)
별도로 사용자가 docker-compse와 rancher-compse를 생성하여 컨테이너를 생성할 수 잇다.
`Stacks` 매뉴를 이용하여 생성.

## Rancher 기반의 Continuous Delivery
[강의 링크1](https://www.udemy.com/devops-docker-rancher-cd/learn/v4/t/lecture/7134690?start=0)
[강의 링크2](https://www.udemy.com/devops-docker-rancher-cd/learn/v4/t/lecture/7134782?start=0)

- Baker
docker 이미지를 생성, 빌드, 체크 등을 전문화하여 하는 사람 (base image를 생성 및 관리)

- devops for CI
baker가 생성한 docker 이미지를 private repo에서 받아서 개발자가 개발한 소스 코드를 올려서 docker 이미지를 빌드

- devops for CD
devops for CI가 생성한 docker 이미지를 private repo에서 받아서 배포
