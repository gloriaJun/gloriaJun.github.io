---
layout: post
title: "(Cloud) Iaas vs Paas vs Saas 개념 잡기"
date: 2018-01-04 18:28:00
author: gloria
categories: os
tags: cloud
---

매번 Iaas, Paas, Saas의 차이와 개념이 헷갈렷는데 아래의 그림을 보니 각 차이점이 눈에 들어온다는..
![]({{ site.baseurl }}/assets/images/post/2018/0104-cloud-overview.png)


#### Infrastructure as a Service (IaaS)
- 서버, 스토리지, 데이터베이스 등과 같은 시스템이나 서비스를 구축하는데 필요한 IT 자원을 서비스 형태로 제공
- 각 자원에 대해 사용한 만큼만 비용을 지불
- 자원의 할당과 해제는 사용자가 직접, 즉시 수행 가능
- 자원은 실제 물리적인 자원이 제공되는 것이 아니라 가상 서버의 자원이 제공되는 경우가 많음
- Amazon Web Service의 EC2(Elastic Cloud Computing), S3(Simple Storage Service) 등

#### Platform as a Service (PaaS)
- 사용자는 애플리케이션이나 서비스가 실행되는 실행 환경을 서비스 제공자로부터 제공 받아 사용
- 실행 환경은 서비스 제공자가 제공해주는 환경만 사용할 수 있으며, 인프라 자원에 대해 사용자는 알 필요도 없으며 제어할 수 있는 권한도 없음
- Google의 AppEngine

#### Software as a Service (SaaS)
- 사용자는 네트워크로 접속해 메일, CRM, 워드 프로세서 등과 같은 애플리케이션을 사용
- 소프트웨어를 설치하는 것이 아니라 서비스 형태로 제공한다는 의미
- 사용자는 실행되는 소프트웨어를 설치할 필요가 없으며, 실행되는 컴퓨터나 디스크 등에 대해서 알 필요가 없음
- 모든 것은 소프트웨어 제공자에 의해 관리됨


Iaas는 기존의 Vmware에서 OS까지만 설치해서 가상화 환경 제공해주던 걸 생각하면 되는 듯하고..
Paas는 운영환경까지 만들어줄 테니 그 위는 니가 알아서 관리해라.
Saas는 그냥 내가 다 해줄게 ..넌 너한테 필요한 거만 신경써...
이건가???
