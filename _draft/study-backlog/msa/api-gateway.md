## API Gateway
[출처 - 마이크로서비스, API Gateway로 200배 활용하기|작성자 개발몬스터](http://blog.naver.com/tmondev/220750045191)

Micro Service가 늘어나게 되면 그만큼 늘어나는 API만큼 웹서버(ex. tomcat 인스턴스)가 필요하게 되는데..이러한 전체 api를 관리하기 위한 gateway가 필요하게 됨.

단순하게 그림으로 표현하면 다음과 같다.
![](http://postfiles16.naver.net/20160630_207/tmondev_14672694989393yr4S_PNG/5-2.PNG?type=w2)

API Gateway는 클라이언트로 부터 다수의 요청이 집중될 수 밖에 없는 만큼 성능을 우선시할 수 밖에 없으므로 최대한 간단하면서 gateway 본연의 기능을 잘 추구할 수 있어야한다.

#### gateway에 필요한 것들

###### 필수로 필요한 기능들
1. 서비스의 End Point
API Client의 단일 진입점으로 모든 서비스 API들을 묶어주고 이에 대한 인증, 권한 등을 관리할 수 있어야 합니다.

2. 서비스 API 관리(대시보드)
얼마나 많은 API들이 사용되고 있는지, 각각의 서비스 API들의 현황 및 통계 등을 관리할 수 있는 기능이 필요합니다.

3. 간단한 Business Logic
서비스 API들을 조합해서 새로운 데이터를 내려줄 수 있는 orchestration 기능 등이 필요할 수 있습니다.

4. 서비스 API 모니터링 & 라우팅
단순한 health check 를 통한 라운드 로빙 형태의 로드 벨런싱 기능 뿐만 아니라 실질적으로 각각의 서비스 API 들이 정상 동작하고 있는지 여부 등을 판별하고 이를 로깅할 수 있는 기능 또한 필요합니다.

###### 부가적인 기능들
5. Response data 분석
이를 통한 자동화된 데이터 타겟 선정이 가능하면 좋을 것 같습니다.
예를들어, 10분 이상 response의 변경이 없는 서비스 API에 대해서는 일정 기간 동안 서비스 API를 call 하지 않고, internal cache, 또는 server cache, view 형태의 DB 등을 선택적으로 내릴 수 있도록 하는 기능이 대표적입니다. 또한 서비스 API 리소스의 절감 및 속도 향상 등을 위해 전체 request 중 일부만 직접적인 서비스 API 호출을 통해 처리하고 나머지는 위의 데이터 타겟을 통해 별도로 전송하는 것도 추가될 수 있습니다.

사실 이러한 기능들은 무조건 느슨한 정합성을 가지는 데이터를 제공하는 API를 대상으로 처리되어야 하겠지요. 판매개수, 조회 수 등 실시간성이 중요한 데이터를 제공하는 서비스들은 대상에서 제외되어야 합니다. 이러한 모든 것들이 대시보드를 통해 관리가 되도록 합니다.

6. 비즈니스 로직이 없는 API들
개발을 하다보면 한번쯤은 느껴보셨겠지만 쿼리 결과가 곧 response data 인 경우가 상당히 많습니다. 비즈니스 로직이 없다고 하긴 했지만, 파라이터 유무 & 데이터 유무 말고는 정말로 비즈니스 로직이 없는 경우가 많습니다. 그래서 이런 것들을 간단하게 처리할 수 있는 기능도 제공되면 좋겠죠. 이 모든 기능들을 처리하기 위해서는 무엇보다도 비동기적인 계산을 잘 수행할 수 있고, 많은 수의 request에 대한 concurrency(동시성), parallelism(병렬성)을 만족할 수 있는 언어의 선택이 중요할 것 같습니다.

CPU의 성능보다 개수로 승부하는 요즘, 이러한 형태의 병렬 수행에 장점을 갖는 언어들이 많이 부각되고 있습니다. Erlang 이나 Scala의 Akka, Google에서 만든 Golang을 들 수 있습니다. 물론 언어에 대해서는 다양한 시각들이 존재하겠지만, 개인적으로는 이러한 요구사항을 모두 충족하면서 런닝커브가 낮고 성능이 우수한 Golang이 좋은 선택일 수 있을 것 같습니다.
