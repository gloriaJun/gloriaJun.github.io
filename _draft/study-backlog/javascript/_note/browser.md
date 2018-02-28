## 브라우저 동작 원리

#### ![](http://poiemaweb.com/img/client-server.png)
HTML 파서는 script 태그를 만나면 DOM 생성 프로세스를 중지하고 자바스크립트 엔진에 제어 권한을 넘긴다. 자바스크립트 엔진의 실행이 완료된 후 브라우저가 중지했던 시점부터 DOM 생성을 재개한다. 이것은 script 태그의 위치에 의해 DOM의 생성이 지연될 수 있음을 의미한다.

브라우저는 위 코드를 아래와 같이 실행할 것이다.
1. script 요소를 만나면 웹페이지의 파싱을 잠시 중단한다.
2. src 어트리뷰트에 정의된 자바스크립트 파일을 로드한 후 파싱하고 실행한다.
3. 중단된 웹페이지의 파싱을 계속 진행한다.

body 요소의 가장 아래에 스크립트를 위치시키는 것은 좋은 아이디어이다. 그 이유는 아래와 같다.
- HTML 요소들이 스크립트 로딩 지연으로 인해 렌더링에 지장 받는 일이 발생하지 않아 페이지 로딩 시간이 단축된다.
- DOM이 완성되지 않은 상태에서 자바스크립트가 DOM을 조작한다면 에러가 발생한다.

#### async / defer
스크립트 로딩 지연으로 인한 병목현상 방지를 위해 HTML5부터 script 태그에 `async`와 `defer` 어트리뷰트가 추가되었음.
```Javascript
<script async src="extern.js"></script>
<script defer src="extern.js"></script>
```
두 어트리뷰트 모두 "웹페이지 파싱과 외부 스크립트 파일의 다운로드가 동시에 진행된다"는 점에서는 동일하지만 아래와 같은 차이가 있다.
#### ![](http://poiemaweb.com/img/script-execution.jpg)
script 태그의 async, defer 어트리뷰트 (출처: Peter Beverloo)

- async
스크립트는 다운로드 완료 직후 실행된다.
- defer
스크립트는 웹페이지 파싱 완료 직후 실행된다.


#### 참고글
[PoiemaWeb](http://poiemaweb.com/js-syntax-basics)
[브라우저는 어떻게 동작하는가?](http://d2.naver.com/helloworld/59361)
