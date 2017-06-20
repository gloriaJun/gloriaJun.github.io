---
layout: post
comments: true
title: "[Hygieia] Configuration"
date: 2017-06-07 15:05:00
categories: devops
tags: ci/cd
---

Dashboard 오픈소스인 [Hygieia](https://github.com/capitalone/Hygieia) 를 Docker 환경에서 구축하는 방법에 대하여 정리   
hygieia dashboard 환경구성을 위해서는 아래와 같은 app 설치 및 연동이 필요하다.   
* Database
* API Layer
* UI Layer
* Tool Collectors
    
![]({{ site.url }}/assets/images/post/2017/0607-hygieia-install.png)  

> Hygieia는 Java 1.8 이상을 지원.   

## 소스 다운로드
[Hygieia](https://github.com/capitalone/Hygieia) 에서 소스를 다운 받는다.

```
git clone https://github.com/capitalone/Hygieia.git
```

## Build Hygieia℠
Hygieia 전체 components를 빌드한다.
```
cd Hygieia
mvn clean install package
```

## Database
Docker를 이용하여 MongoDB container를 생성한 뒤 사용자를 생성한다.   
(docker를 이용하지 않고 로컬에 설치하거나 리모트에 설치된 mongodb를 이용하여도 됨)
```
$ docker run -d -p 27017:27017 --name mongodb mongo:latest  mongod --smallfiles
$ docker exec -it mongodb mongo
> use dashboard
switched to db db
> db.createUser(
  {
    user: "db",
    pwd: "dbpass",
    roles: [ { role: "readWrite", db: "dashboard" }]
  }
)
Successfully added user: {
	"user" : "db",
	"roles" : [
		{
			"role" : "readWrite",
			"db" : "dashboard"
		}
	]
}
``` 
    
사용자 생성 후에 아래와 같이 접속이 되는 지 확인한다.    
``` 
$ docker exec -it mongodb mongo -u "db" -p "dbpass" --authenticationDatabase "dashboard"
MongoDB shell version v3.4.4
connecting to: mongodb://127.0.0.1:27017
MongoDB server version: 3.4.4
Server has startup warnings:
2017-06-07T05:06:52.179+0000 I STORAGE  [initandlisten]
2017-06-07T05:06:52.179+0000 I STORAGE  [initandlisten] ** WARNING: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine
2017-06-07T05:06:52.179+0000 I STORAGE  [initandlisten] **          See http://dochub.mongodb.org/core/prodnotes-filesystem
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten]
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten] ** WARNING: Access control is not enabled for the database.
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten] **          Read and write access to data and configuration is unrestricted.
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten]
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten]
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten] ** WARNING: /sys/kernel/mm/transparent_hugepage/enabled is 'always'.
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten] **        We suggest setting it to 'never'
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten]
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten] ** WARNING: /sys/kernel/mm/transparent_hugepage/defrag is 'always'.
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten] **        We suggest setting it to 'never'
2017-06-07T05:06:52.194+0000 I CONTROL  [initandlisten]
> exit
```
_만약, 아래와 같은 방식으로 사용자 생성 후 접속이 되지 않으면 api 컨테이너를 생성 후에 서비스가 올라가는 과정에서 “Authication failed” 에러가 발생한다_


## API Layer
`src/main/resources/application.properties` 파일을 생성한다.
```
dbname=dashboard
dbusername=db
dbpassword=dbpass
dbhost=192.168.99.100
dbport=27017
dbreplicaset=false
dbhostport=[host1:port1,host2:port2,host3:port3]
server.contextPath=/api
server.port=8080
```
    
api 모듈을 빌드 한 뒤 실행한다.
```
$ mvn clean install
$ java -jar target/api.jar
```
     
컨테이너가 정상적으로 기동된 후에 아래와 같이 접속되는 것을 확인할 수 있다.   
(생성된 dashboard가 없으므로 null이 return 된다.)
```
$ curl http://localhost:8080/api/dashboard
[]
```

## UI Layer
UI 서버를 실행한다.
```
gulp serve
```

> 웹브라우저는 가급적 “크롬”을 사용하여 테스트를 한다.   
> 특히, Safari의 경우에는 정상적으로 설치를 하였으나 로그인 창이 출력되지 않을 수도 있음.   
> (하루를 꼬박 로그인 창이 안떠서 삭제하고 빌드하고를 반복했음..ㅠㅠ)
      
#### 웹페이지 접속 확인 및 로그인 유저 생성
컨테이너가 정상적으로 기동되면 웹브라우라저를 이용하여 `http://localhost:3000`로 접속하면 아래와 같은 페이지를 확인할 수 있다.   
![]({{ site.url }}/assets/images/post/2017/0607-devops-hygieia.png)
    
로그인 버튼을 눌러 사용자를 생성한 뒤 dashboard를 생성한다.
그 뒤에 api 테스트를 해보면 아래와 같은 결과가 확인된다.
```
$ curl http://localhost:8080/api/dashboard
[{"id":"59487b3f9f9dba15bdf2d9bb","template":"capone","title":"TeamBoard","widgets":[],"owners":[{"username":"admin","authType":"STANDARD"}],"type":"Team","application":{"name":"TeamBoard","components":[{"id":"59487b3f9f9dba15bdf2d9ba","name":"TeamBoard","collectorItems":{}}]}}]
```

## Tool Collectors
Hygieia에서 지원하는 collector는 [Hygieia/collectors at master · capitalone/Hygieia · GitHub](https://github.com/capitalone/Hygieia/tree/master/collectors)를 참고하면 알 수 있다.

#### GitHub
`src/main/resources/application.properties` 파일을 생성한다.

```
# Database Name
dbname=dashboard

# Database HostName - default is localhost
dbhost=192.168.99.100

# Database Port - default is 27017
dbport=27017

# MongoDB replicaset
dbreplicaset=false
dbhostport=[host1:port1,host2:port2,host3:port3]

# Database Username - default is blank
dbusername=db

# Database Password - default is blank
dbpassword=dbpass

# Logging File location
logging.file=./logs/github.log

# Collector schedule (required)
github.cron=0 0/5 * * * *

github.host=github.com

# Maximum number of days to go back in time when fetching commits
github.commitThresholdDays=15

#Optional: Error threshold count after which collector stops collecting for a collector item. Default is 2.
github.errorThreshold=1
```

빌드 후에 서비스를 실행한다.
```
$ mvn install
$ java -jar target/github-scm-collector-2.0.5-SNAPSHOT.jar
```

#### Jira
`src/main/resources/application.properties` 파일을 생성한다.

```
# Database Name
dbname=dashboard
# Database HostName - default is localhost
dbhost=192.168.99.100
# Database Port - default is 27017
dbport=27017

# Database Username - default is blank
dbusername=dashuser
# Database Password - default is blank
dbpassword=dbpass


# Logging File location
logging.file=./logs/jira.log

# PageSize - Expand contract this value depending on Jira implementation's
# default server timeout setting (You will likely receive a SocketTimeoutException)
feature.pageSize=100

# Delta change date that modulates the collector item task
# Occasionally, these values should be modified if database size is a concern
feature.deltaStartDate=2016-03-01T00:00:00.000000
feature.masterStartDate=2016-03-01T00:00:00.000000
feature.deltaCollectorItemStartDate=2016-03-01T00:00:00.000000

# Chron schedule: S M D M Y [Day of the Week]
feature.cron=0 * * * * *

# ST Query File Details - Required, but DO NOT MODIFY
feature.queryFolder=jiraapi-queries
feature.storyQuery=story
feature.epicQuery=epic

# JIRA CONNECTION DETAILS:
# Enterprise Proxy - ONLY INCLUDE IF YOU HAVE A PROXY
#feature.jiraProxyUrl=http://proxy.com
#feature.jiraProxyPort=9000

feature.jiraBaseUrl=[Jira URL]
feature.jiraQueryEndpoint=rest/api/2/
# For basic authentication, requires username:password as string in base64
# This command will make this for you:  echo -n username:password | base64
feature.jiraCredentials=YWRtaW46YWRtaW4=

# OAuth is not fully implemented; please blank-out the OAuth values:
feature.jiraOauthAuthtoken=
feature.jiraOauthRefreshtoken=
feature.jiraOauthRedirecturi=
feature.jiraOauthExpiretime=

#############################################################################
# In Jira, general IssueType IDs are associated to various "issue"
# attributes. However, there is one attribute which this collector's
# queries rely on that change between different instantiations of Jira.
# Please provide a string name reference to your instance's IssueType for
# the lowest level of Issues (e.g., "user story") specific to your Jira
# instance.  Note:  You can retrieve your instance's IssueType Name
# listings via the following URI:  https://[your-jira-domain-name]/rest/api/2/issuetype/
# Multiple comma-separated values can be specified.
#############################################################################
feature.jiraIssueTypeNames=Task,Sub-task,Bug,Story

#############################################################################
# In Jira, your instance will have its own custom field created for "sprint" or "timebox" details,
# which includes a list of information.  This field allows you to specify that data field for your
# instance of Jira. Note: You can retrieve your instance's sprint data field name
# via the following URI, and look for a package name com.atlassian.greenhopper.service.sprint.Sprint;
# your custom field name describes the values in this field:
# https://[your-jira-domain-name]/rest/api/2/issue/[some-issue-name]
#############################################################################
feature.jiraSprintDataFieldName=customfield_10005

#############################################################################
# In Jira, your instance will have its own custom field created for "super story" or "epic" back-end ID,
# which includes a list of information.  This field allows you to specify that data field for your instance
# of Jira.  Note:  You can retrieve your instance's epic ID field name via the following URI where your
# queried user story issue has a super issue (e.g., epic) tied to it; your custom field name describes the
# epic value you expect to see, and is the only field that does this for a given issue:
# https://[your-jira-domain-name]/rest/api/2/issue/[some-issue-name]
#############################################################################
feature.jiraEpicIdFieldName=customfield_10001

#############################################################################
# In Jira, your instance will have its own custom field created for "story points"
# This field allows you to specify that data field for your instance
# of Jira.  Note:  You can retrieve your instance's storypoints ID field name via the following URI where your
# queried user story issue has story points set on it; your custom field name describes the
# story points value you expect to see:
# https://[your-jira-domain-name]/rest/api/2/issue/[some-issue-name]
#############################################################################
feature.jiraStoryPointsFieldName=customfield_10006

#############################################################################
# In Jira, your instance will have its own custom field created for "team"
# This field allows you to specify that data field for your instance
# of Jira.  Note:  You can retrieve your instance's team ID field name via the following URI where your
# queried user story issue has team set on it; your custom field name describes the
# team value you expect to see:
# https://[your-jira-domain-name]/rest/api/2/issue/[some-issue-name]
#############################################################################
#feature.jiraTeamFieldName=
```

서비스를 실행한다.
```
$ mvn clean install
$ java -jar target/jira-feature-collector.jar
```

> jira에 대한 위젯 등록 시 "Team Name"이 별도로 등록되지 않은 경우에는 "Any"로 입력하여 생성한다.

   


