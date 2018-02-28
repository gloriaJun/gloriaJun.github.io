mongodb
crowd


개발환경 도커 구성하기
https://www.slideshare.net/raccoonyy/docker-compose-usages


## mongodb
```
docker run -d -p 27017:27017 -v /Volumes/data/docker/db/mongodb/:/data/db --name mongodb mongo

docker run -d -p 27017:27017 -v /Volumes/data/docker/db/mongodb/:/data/db --name mongodb mongo -auth
```

#### docker-compose.yml
```docker-compose-mongodb.yml
version: '3'

services:
  mongodb:
    image: mongo:latest
    container_name: "mongodb"
    environment:
      - MONGO_DATA_DIR=/data/db
      - MONGO_LOG_DIR=/dev/null
    ports:
      - 27017:27017
    volumes:
      - /Volumes/data/docker/db/mongodb/:/data/db

```

```
docker-compose -f docker-compose-mongodb.yml up -d
```

## Docker image 만들기



##### docker 이미지 공유하기
docker image 공유방법
- docker push로 docker hub에 등록
- Dockerfile을 git 레파지토리와 연동

여기서 Docekrfile을 git과 연동하여 Docker hub에 등록하는 방법을 실습해보았다.

###### github에 docker 이미지 등록
github에 repository를 생성하여 Dockerfile을 업로드한다.

###### docker hub와 github 연동
[Docker Hub](https://hub.docker.com)에 접속해서 `Creat -> Create Automated Build` 매뉴를 선택한 뒤에 github 계정 정보를 입력하여 연동한다.
Docker 이미지가 저장된 레파지토리를 선택하여 생성한 뒤에 `Build Settings` 매뉴를 선택하여 `Trigger` 버튼을 누른 뒤 `Build Details` 매뉴에 들어가면 잠시 뒤 이미지 파일을 빌드가 진행되는 것을 확인할 수 있다.

####### 빌드된 이미지 다운
아래와 같은 명령어를 이용하여 이미지를 다운받을 수 있다.
```
docker pull gloriajun/my-mongo
```

## 참고글
http://www.marshalling.net/yard/wordpress/?p=99
https://novemberde.github.io/2017/04/02/Docker_8.html


## Dockerfile

###### FROM
어떤 이미지를 기반으로 할지 설정한다.

###### RUN
쉡 스크립트 또는 명령어를 실행한다.

###### VOLUME
호스트와 공유할 디렉터리 목록
`docker run` 명령에서 `-v`로 지정하는 옵션으로도 설정할 수 있다.

###### CMD
컨테이너가 기동될 때 수행할 명령어 또는 스크립트

###### WORKDIR
CMD에서 지정한 명령어가 수행될 디렉터리

###### EXPOSE
호스트와 연결할 포트 번호 설정
