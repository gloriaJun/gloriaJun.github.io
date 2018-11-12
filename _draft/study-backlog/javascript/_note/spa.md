## SPA
SPA(Single Page Application)는 기본적으로 단일 페이지로 구성되며 기존의 서버 사이드 렌더링과 비교할 때, 배포가 간단하며 네이티브 앱과 유사한 사용자 경험을 제공할 수 있다는 장점이 있다.

SPA는 기본적으로 **웹 애플리케이션에 필요한 모든 정적 리소스를 최초에 한 번 다운로드하고, 이후 새로운 페이지 요청 시에는 갱신에 필요한 데이타만을 전달받아서 갱신**하므로 전체적인 트래픽을 감소할 수 있다.

#### SPA의 단점

- 초기 구동 속도
SPA는 웹 애플리케이션에 필요한 모든 정적 리소스를 최초에 한번 다운로드하기 때문에 초기 구동 속도가 상대적으로 느리다. 하지만 SPA는 웹페이지보다는 애플리케이션에 적합한 기술이므로 트래픽의 감소와 속도, 사용성, 반응성의 향상 등의 장점을 생각한다면 결정적인 단점이라고 할 수는 없다.

- SEO(검색엔진 최적화) 문제
SPA는 서버 렌더링 방식이 아닌 자바스크립트 기반 비동기 모델(클라이언트 렌더링 방식)이다. 따라서 SEO는 언제나 단점으로 부각되어 왔던 이슈이다. 하지만 SPA는 정보의 제공을 위한 웹페이지보다는 애플리케이션에 적합한 기술이므로 SEO 이슈는 심각한 문제로 볼 수 없다. Angular 또는 React 등의 SPA 프레임워크는 서버 렌더링을 지원하는 SEO 대응 기술이 이미 존재하고 있어 SEO 대응이 필요한 페이지에 대해서는 선별적 SEO 대응이 가능하다.

#### Routing
애플리케이션의 라우팅은 사용자가 태스크를 수행하기 위해 어떤 화면(view)에서 다른 화면으로 화면을 전환하는 내비게이션을 관리하기 위한 기능을 의미한다.

전통적인 웹 방식에서 SPA까지의 발전과정과 SPA의 라우팅에 대해 설명하면 다음과 같다.

###### 전통적인 링크 방식
![](http://poiemaweb.com/img/traditional-webpage-lifecycle.png)
아래와 같이 생성된 링크를 클릭하면 URL에 해당 path가 추가되어 주소창에 출력이 되고, 서버는 해당 경로에 해당하는 리소스를 클라이언트로 응답하는 과정이 발생하게 된다.

```html
<a href="service.html">Service</a>
```

이와 같은 방식은 각 페이지마다 고유의 URL이 존재하므로 히스토리 관리 및 SEO(검색엔진 최적화) 대응에 아무런 문제가 없지만, 중복된 리소스 요청마다 수신해야하고 전체 페이지를 렌더링하는 과정에서 새로고침이 발생하므로 사용성이 좋지 않다는 단점이 있다.

> **서버렌더링**
> html로 화면을 표시하기 위한 리소스를 클라이언트에 응답하면, 브라우저가 이를 수신하고 화면에 표시하는 과정을 말함

###### AJAX 방식
![](http://poiemaweb.com/img/ajax-webpage-lifecycle.png)
전통적인 링크 방식의 단점을 보완하기 위해 등장하였다. ajax는 자바스크립트를 이용하여 비동기적으로 서버와 브라우저가 데이터를 교환할 수 있는 통신 방식을 의미한다.
하지만, ajax의 경우 url을 변경시키지는 않아 주소창의 주소가 변경되지는 않으므로 브라우저의 히스토리 관리가 동작하지 않는다. 또한, 하나의 주소로 동작하므로 SEO 이슈에서도 가지고 있다.

```html
<a id="service">Service</a>
```
```javascript
(function () {
  const root = document.querySelector('.app-root');
  const navigation = document.getElementById('navigation');

  function render(data) {
    const json = JSON.parse(data);
    root.innerHTML = `<h1>${json.title}</h1><p>${json.content}</p>`;
  }

  function renderHtml(html) {
    root.innerHTML = html;
  }

  function get(url) {
    return new Promise((resolve, reject) => {
      const req = new XMLHttpRequest();
      req.open('GET', url);
      req.send();

      req.onreadystatechange = function () {
        if (req.readyState === XMLHttpRequest.DONE) {
          if (req.status === 200) resolve(req.response);
          else reject(req.statusText);
        }
      };
    });
  }

  const routes = {
    'service': function () {
      get('/data/service.json')
        .then(res => render(res));
    },
    otherwise(page) {
      root.innerHTML = `${page} Not Found`;
    }
  };

  function router(page) {
    (routes[page] || routes.otherwise)(page);
  }

  // AJAX 요청은 주소창의 url을 변경시키지 않으므로 history 관리가 되지 않는다.
  navigation.addEventListener('click', e => {
    if (!e.target || e.target.nodeName !== 'A') return;
    e.preventDefault();
    router(e.target.id);
  });

  // DOMContentLoaded은 HTML과 script가 로드된 시점에 발생하는 이벤트로 load 이벤트보다 먼저 발생한다. (IE 9 이상 지원)
  // 새로고침이 클릭되었을 때, 웹페이지가 처음 로딩되었을 때, 현 페이지(예를들어 loclahost:5002)를 서버에 요청한다. 이때 Home에 필요한 리소스를 AJAX 요청한다.
  window.addEventListener('DOMContentLoaded', () => router('home'));
}());
```

###### Hash 방식
URI의 fragment identifier(#service)의 고유 기능인 앵커(anchor)를 사용한다. fragment identifier는 hash mark 또는 hash라고 부르기도 한다.1

```html
<a href="#service">Service</a>
```
사용자가 위와 같은 링크를 클릭하면 해당 hash가 추가된 URI가 주소창에 표시된다. 하지만, URL이 동일한 상태이므로 브라우저는 서버에 새로운 요청을 보내지 않는다.
즉, hash 방식은 서버에 새로운 요청을 보내지 않지만 페이지마다 고유의 논리적 URL이 존재하므로 히스토리 관리가 가능하나, SEO 이슈(크롤러가 hash방식으로 만들어진 사이트의 컨텐츠를 수집할 수 없음)를 가지고 있다.


###### PJAX 방식
hash 방식의 가장 큰 단점은 SEO 이슈이다. 이를 보완한 방법이 HTML5의 Histroy API인 pushState와 popstate 이벤트를 사용한 PJAX 방식이다. pushState와 popstate은 IE 10 이상에서 동작한다.
내비게이션이 클릭되면 path가 추가된 URI가 서버로 요청된다. PJAX 방식은 내비게이션 클릭 이벤트를 캐치하고 preventDefault를 사용하여 서버로의 요청을 방지한다. 이후, href 어트리뷰트에 path을 사용하여 AJAX 요청을 하는 방식이다.

이때 AJAX 요청은 주소창의 URL을 변경시키지 않아 history 관리가 불가능하다. 이때 사용하는 것이 pushState 메소드이다. pushState 메소드는 주소창의 URL을 변경하고 URL을 history entry로 추가하지만 요청하지는 않는다.


```html
<a href="/service">Service</a>
```
```javascript
(function () {
  const root = document.querySelector('.app-root');
  const navigation = document.getElementById('navigation');

  function render(data) {
    const json = JSON.parse(data);
    root.innerHTML = `<h1>${json.title}</h1><p>${json.content}</p>`;
  }

  function renderHtml(html) {
    root.innerHTML = html;
  }

  function get(url) {
    return new Promise((resolve, reject) => {
      const req = new XMLHttpRequest();
      req.open('GET', url);
      // 서버에 JSON을 요청한다.
      req.setRequestHeader('Accept', 'application/json');
      req.send();

      req.onreadystatechange = function () {
        if (req.readyState === XMLHttpRequest.DONE) {
          if (req.status === 200) resolve(req.response);
          else reject(req.statusText);
        }
      };
    });
  }

  const routes = {
    '/': function () {
      get('/data/home.json')
        .then(res => render(res));
    },
    '/service': function () {
      get('/data/service.json')
        .then(res => render(res));
    },
    '/about': function () {
      get('/data/about.html')
        .then(res => renderHtml(res));
    },
    otherwise(path) {
      root.innerHTML = `${path} Not Found`;
    }
  };

  function router(path) {
    (routes[path] || routes.otherwise)(path);
  }

  // history entry가 변경되면 발생하는 이벤트
  // PJAX 방식은 hash를 사용하지 않으므로 hashchange 이벤트를 사용할 수 없다.
  // popstate event는 pushState에 의해 발생시키지 않는다.
  // 이전페이지 / 다음페이지 button 또는 history.back() / history.go(n)에 의해 발생한다.
  window.addEventListener('popstate', e => {
    // e.state는 pushState 메소드의 첫번째 인수
    console.log('[popstate]', e.state);
    // 이전페이지 / 다음페이지 button이 클릭되면 router를 호출
    router(e.state.path);
  });

  // 내비게이션을 클릭하면 주소창의 url이 변경되므로 서버로 요청이 전송된다.
  // preventDefault를 사용하여 이를 방지하고 history 관리를 위한 처리를 실시
  navigation.addEventListener('click', e => {
    if (!e.target || e.target.nodeName !== 'A') return;
    e.preventDefault();

    // 이동 페이지
    const path = e.target.getAttribute('href');

    // pushState 메소드는 주소창의 URL은 변경하지만 요청하지는 않는다.
    history.pushState({ path }, null, path);

    // path에 의한 AJAX 요청
    router(path);
  });

  // 웹페이지가 처음 로딩되었을 때
  router('/');

  // DOMContentLoaded은 HTML과 script가 로드된 시점에 발생하는 이벤트로 load 이벤트보다 먼저 발생한다. (IE 9 이상 지원)
  // window.addEventListener('DOMContentLoaded', router);

  // 새로고침이 클릭되었을 때, 현 페이지(예를들어 loclahost:5004/service)가 서버에 요청된다.
  // 서버측에는 이에 응답하는 기능이 추가되어야 한다.
  // ex) app.get('/service', (req, res) => res.sendFile(path.join(__dirname + '/public/data/service.html')));
}());
```

다만, 브라우저의 새로고침 버튼을 클릭하면 예를들어 loclahost:5004/service와 같은 요청이 서버로 전달된다. 이때 서버는 URL에 따라 해당 리소스를 HTML으로 클라이언트에 응답하여야 한다.

이는 서버 렌더링 방식과 AJAX 방식이 혼재되어 있는 것이다. 서버는 클라이언트의 request hader의 Accept가 ‘text/html’이면 HTML을 응답하고, request hader의 Accept가 ‘application/json’이면 필요 리소스만 JSON으로 응답하도록 구현하여야 한다. 예를 들어, 새로고침으로 브라우저에서 요청이 수행되면 request hader의 Accept는 ‘text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,/;q=0.8’이고 서버는 HTML을 응답한다. AJAX 요청의 경우, setRequestHeader 메소드를 사용하여 응답될 데이터의 mine type을 json으로 지정한다.

이에 대한 구현 예제는 아래와 같다.
```javascript
// Server
const express = require('express');
const app = express();
const fs = require('fs');

app.get('/service', (req, res) => {
  res.format({
    // 새로고침에 의한 브라우저 요청
    'text/html': function(){
      res.sendFile(path.join(__dirname + '/public/data/service.html'));
    },
    // AJAX 요청
    'application/json': function(){
      res.send(JSON.parse(fs.readFileSync('./public/data/service.json', 'utf8')));
    },
    'default': function() {
      // log the request and respond with 406
      res.status(406).send('Not Acceptable');
    }
  });
});

app.listen(3000, function () {
  console.log('listening on http//localhost:3000');
});
```

## 참고자료
[poiemaweb-SPA](http://poiemaweb.com/js-spa)
