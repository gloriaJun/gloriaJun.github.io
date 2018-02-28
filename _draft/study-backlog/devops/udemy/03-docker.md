# DevOps 첫걸음: Docker에서 Rancher를 이용한 CD까지

## Docker에 대한 이해 및 사용법 실습
[강의 링크-1부](https://www.udemy.com/devops-docker-rancher-cd/learn/v4/t/lecture/6929924?start=0)
[강의 링크-2부](https://www.udemy.com/devops-docker-rancher-cd/learn/v4/t/lecture/7134754?start=0)

#### Docker ?
일반적으로 Docker를 LXC(Linux Container)라고 함.
Host Server의 Kernel을 공유하는 방식
- [Manual](https://docs.docker.com)

###### 기본 명령어
- 이미지 다운
```
docker pull [image file]
```
- 컨테이너 실행
```
docker run -d [image file]
```
- docker compose 에서 경로를 주어서 실행하기
```
docker-compose -f [파일 경로]
```

> docker-compose의 경우에는 rancher와 같은 도구에서 연동하여 사용이 가능하다.
