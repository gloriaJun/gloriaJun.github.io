## 2018.11.15 Web Tech Concert



## CSS 바로잡기 4 - 우선순위와 % 계산
- 정을수 강사

### CSS 우선순위
- 웹페이지는 모두 상자 안에 무언가를 그리는 것으로 시작.
- 검색 엔진이나 웹 크롤링 시에 각각의 tag(h2, h3, section...)를 중요시하게 생각한다.
	- 어느 부분의 tag가 내용이 중요한 것인지 파악할 수가 없다.
- html은 사용자가 마지막으로 받는 코드이다.
- html의 구조를 잘 잡아야한다.
- 요즘은 자동차 네비게이션, 냉장고 판넬 등에 다양하게 html 기술이 사용되고 있다.
- 스케치와 같은 프로토타이핑 도구는 반응형 웹에 대하여 고려하여 디자인이 가능하도록 작업할 수 있다.

#### 어떻게 하면 구조적으로 잘 코드를 작성할 수 있을까?
- 클래스명을 의미있게 짓는 것부터 시작한다.
- 구조적으로 잘 코드를 작성하면 유지보수 시에 수정해야하는 포인트가 줄어들고, side effect를 줄일 수도 있다.

#### CSS 스타일에 이름을 붙이는 방법
- `id`와 `class`가 있음.
	- `id`는 해당 웹 문서에서 고유해야한다.
	- `class`는 여러 개일 수 있다. 

#### CSS 스타일 적용의 우선순위
- 동일한 선택자인 경우에는 마지막에 적용한 것이 우선순위가 높다. (하향 우선)
- 좀 더 자세히 선택자를 정의한 것이 우선순위가 높다. 즉, 선택자가 세분화될 수록 스타일 적용 우선 순위가 높음.           
```css
p { color: blue; } /* 1 */
.service > p { color: red; } /* 2 */
p { color: grey; } /* 3 * /
/* 
최종 반영되는 스타일은 ".service > p { color: red; }" 
우선순위 : 2 - 3 - 1
*/
```
> *그렇다고 선택자가 너무 자세하면 프로세서가 처리하는 시간이 필요하므로 성능에 좋지는 않다.* 하지만 요즘 컴퓨터와 브라우저의 성능이 좋으므로 아주 문제가 되지는 않으나 매우 성능에 민감하다면 고려해야하는 부분일 수도....

- 아래와 같이 있을 때, 우선순위 구분을 위한 레벨 구분 법 ( 아이디 클래스 클래스)      
```css
.service > p { color: red; } /* 0 1 1 */
.magic_com > div.service > p { color: gray; } /* 0 1 2 */
p { color: grey; } /* 0 0 1  * /
#magic p { color: blue; } /* 1 0 1 * /
```
- 아이디보다 우선 순위를 높여서 스타일을 적용하기 어려움. *가급적 id를 이용하여 스타일을 적용하는 것을 잘 사용하지 않는 것이 좋다고..*
	- 해당 부분을 해결할 방법은 html 태그 안에 인라인 스타일 적용하는 것. (제일 우선 순위가 높음. important를 붙이는 방법만 우선순위를 높일 수 있다.)
	- 인라인 스타일에 important를 넣는 방법은 css로 어떻게도 우선순위를 높여 적용할 수 없다.
> css가 구조적으로 잘 정의되고, 설계되어 있는가?

###### 정리하면..
브라우저에서 정의한 기본 스타일 < 일반적인 선언 < 하향우선 < 명시도 우선 < 인라인 스타일 < important


### CSS %계산
- 반응형 웹을 하려면 `em`을 사용해야하나?? -> *정답은 그렇지 않다.!!!!*
- width에 %를 사용한다는 것은 무엇일까? 
	- 브라우저는 내가 현재 포함된 box에 꽉 채우는 것을 100%라고 계산한다. 상위의 상자의 pixel을 가져와서 내 자신의 box에 100%를 계산해서 넣는다.
	- 해당 문제를 해결하려면?? 
		- 사이징하는 기준을 변경해야한다. 
		- `box-sizing: border-box;` 옵션을 넣어주면 의도하는 데로 동작을 한다.
		- `width: auto`와 `width: 100%`는 엄연히 다른 것이다. `auto`는 상황에 따라서 브라우저가 계산해서 적용한다.

#### EM
- `em`은 글자를 위해서 나왔음.??
- `font-size`는 부모로부터 기본으로 상속을 받는다.
- `em`은 부모의 폰트 사이즈를 가져와서 자신에게 설정된 값을 곱하여서 계산한다.      
```css
body {
	font-size: 12px;
}
.box1 {
    font-size: 2em; // 12*2 = 24px
    width: 200px;
    //width: 2em; // 12*2 = 24px
    height: 200px;
    background-color: red;
}
```

#### %
- 폰트에 100%를 입력하면 부모의 폰트를 기준으로 계산 (부모가 12px이면 100%를 설정한 폰트 사이즈는 12px)
- %는 부모에 동일한 스타일에 대하여 해당 비율로 계산하여 적용한다.        
```css
body {
	font-size: 12px;
	width: 400px;
}
.box1 {
    font-size: 100%; // 12px
    width: 50%; // 부모가 400px이므로 200px
    height: 200px;
    background-color: red;
}
```
- 부모의 비율에 맞춰서 적용되게 하려면....`원하는 값 / 부모 * 100` 공식으로 계산하여 %를 적용한다. 계산 시에 가능한 소숫점 6자리까지도 계산된 값을 적용한다.       
```css
body {
	font-size: 12px;
	width: 400px;
}
.box1 {
    font-size: 100%; // 12px
    width: 65.5%; /* 원하는 값 / 부모 * 100 ex. 262 / 400 * 100 = 65.5 */
    height: 200px;
    background-color: red;
}
```

**예제**
<p data-height="265" data-theme-id="0" data-slug-hash="OamREj" data-default-tab="css,result" data-user="gloriaJun" data-pen-title="css-em" class="codepen">See the Pen <a href="https://codepen.io/gloriaJun/pen/OamREj/">css-em</a> by gloria (<a href="https://codepen.io/gloriaJun">@gloriaJun</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>

### 그렇다면, 반응형 웹을 위해 CSS 스타일 작업을 할 때?? 
- 기본적으로 %로 계산을 한 뒤에, 미디어 쿼리를 적용한다.




## 반응형 웹과 새로운 레이아웃 기술 CSS 그리드
- 김운아 강사

#### 레이아웃 이란...?
-  특정 공간 안에 문자, 이미지, 콘텐츠 등을 효율적이게 배치하기 위한 일련의 작업을 의미
- Lay something out
- 즉, 사용자가 보기 쉽게 효과적으로 잘 배치하기 위함
- UI 디자이너가 하는 일 -> 레이아웃을 배치하는 일
- 두서 없이 콘텐츠를 배치하면, 사용자는 혼란을 겪고, 정보를 효과적으로 전달할 수 없다.

> 정보를 규칙적으로 효과적으로 잘 전달하기 위해 배치하려면 --> 그리드를 사용한다

#### 그리드..??
- 수직선과 수평선으로 이루어진 격자 또는 행과 열로 이루어진 반복되는 격자를 말한다
- 그리드를 사용하는 이유는??
	- 규칙을 가질 수 있다.
	- 질서를 가질 수 있다.
- 특정한 규칙과 질서가 필요한 곳에서 다양하게 활용된다.

> 웹의 목표는 **다양한 정보를 네트워크 상에서 여러 사람들에게 전달하고 `공유`**하기 위해 생겨난 개념이다.

- 현재는 그리드가 플렉서블하게 발전되고 있다.


#### CSS 그리드..??
- CSS 언어 차원에서 그리드를 지원하는 것을 말함.
- 기존에는 지원하지 않아서, 그리드 프레임워크를 배워야했음. 그리고 그리드 기능을 사용하기 위해 불필요한 라이브러리도 같이 다운받아야 했었음
- 플렉서블 박스는 1차원. 행/열 중 하나의 축에만 대응
- CSS 그리드는 2차원

- 그리드 컨테이너 : 그리드 영역을 구성할 수 있는 박스 또는 컨테이너를 의미
- 그리드 아이템 : 그리드 컨테이너로 작동하는 박스의 자식 박스들을 의미
- 그리드 라인 : 행과 열로 인해 생성되는 라인을 의미. 그리드 라인을 통하여 특정 라인에 그리드 아이템을 배치하거나 확장 할 수 있다.  각각의 선은 라인 넘버를 가지게 된다.
- 그리드 트랙 : 행과 열의 라인 사이 공간을 말한다.
- 그리드 셀 : 인접하는 행과 열의 그리드 라인이 모여 생성되는 공간을 의미한다. 그리드 영역의 가장 작은 단위를 뜻한다.
- 그리드 공간 : 행과 열의 그리드 라인이 모여 만들어진 공간을 말한다.
- 그리드 간격 : 행 또는 열의 사이 간격을 말한다

###### 그리드의 템플릿을 정의하기
ex1)      
```css
grid-template-rows: 1fr 200px 100px 1fr;
grid-template-columns: [firstline] 200px [line2] 150px [linethird] auto [col4] 350px [five] 100px [end];
```

ex2)      
```css
grid-template-rows: repeat(5, 50px [row]) 1fr;
grid-template-columns: repeat(5, 80px [row]) 1fr;
```
<p data-height="265" data-theme-id="0" data-slug-hash="oQWBOO" data-default-tab="css,result" data-user="gloriaJun" data-pen-title="css-grid" class="codepen">See the Pen <a href="https://codepen.io/gloriaJun/pen/oQWBOO/">css-grid</a> by gloria (<a href="https://codepen.io/gloriaJun">@gloriaJun</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>



ex3)      
```css
grid-template-rows: 200px 200px 200px;
grid-template-columns: 25% 25% 25% 25%;
/* --- 여기까지는 틀을 만든다. */
grid-template-areas:
"header header header header"
"section section . article"
"footer footer footer footer";
/* 
--- 여기까지는 틀안에 배치를 한다. 
"."은 공백을 의미
*/

header {
	grid-area: header;
	background-color: blue;
}

section {
		grid-area: section;
		background-color: yellow;
}

article {
		grid-area: article;
		background-color: orange;
}

footer {
		grid-area: footer;
		background-color: gray;
}
```
<p data-height="265" data-theme-id="0" data-slug-hash="NEjpqj" data-default-tab="css,result" data-user="gloriaJun" data-pen-title="css-grid-layout" class="codepen">See the Pen <a href="https://codepen.io/gloriaJun/pen/NEjpqj/">css-grid-layout</a> by gloria (<a href="https://codepen.io/gloriaJun">@gloriaJun</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>


> fr 단위는 그리드 컨테이너에 남아 있는 사용 가능한 공간의 일정 비율을 나타냅니다. 
> https://developer.mozilla.org/ko/docs/Web/CSS/CSS_Grid_Layout/Basic_concepts_of_grid_layout

- 그리드 관련 예제 사이트 : https://gridbyexample.com/

#### 하위 브라우저 대응
- CSS 그리드를 바로 사용 가능하나, 특정 브라우저에서 작동하지 않을 수 있음.
- 지원하지 않는 브라우저에 대해 어떻게 대응해야하나???
	- 현재로써는 폴리필이 존재하지 않으므로 적절한 타협이 필요하다

#### 플렉서블 박스 vs CSS 그리드??
- 정답은 없다.
- 작업의 성격에 따라 다름
- 예를 들어서, 구조성에 중점을 두는 경우에는 CSS 그리드. 구조성 보다는 정렬에 중점을 두는 경우에는 플렉서블 박스를 사용한다.




## JavaScript 천천히 시작하기 -  애니메이션
- 야무 강사
- CSS에도 애니메이션이 있으나, 제한적이다. 이러한 부족한 부분을 자바스크립트를 이용하여 애니메이션을 구현한다.
- 애니메이션은 시작점에서 끝점으로 진행된다. 
	- 시작점 : from / 끝점 : to / 진행사항 : progress
	- 지속 시간 : duration , 1/1000초 단위로 표현(ms 단위)
```javascript
// 초당 프레임의 개수
var fps = 60;
// 애니메이션 시작점
var from = 0;
// 애니메이션 끝점
var to = 100;
// 지속시간 (단위. 밀리세컨드)
var duration = 600;
// 진행상태
var progress = .34;
// 현재 위치
var current = 34;

/*
TIP!!! 위와 같이 각각 선언하는 것보다는 객체로 묶어서 선언하는 것을 권장
*/
```

#### 내장 타이머 함수
- setInterval      
```javascript
let count = 0;
let intervalId = null;

function intervalFn() {
    count++;
    if (count >= 10) {
        clearInterval(intervalId);
    }
    console.log(count);
}

intervalId = setInterval(intervalFn, 1000);
```


#### FPS 
- 1초 동안에 몇 개의 프레임을 보여줄 것인가.  
```javascript
function fps(frames) {
    return 1000/frames;
}

function render() {
    console.log('초당 60장의 프레임을 표시한다.');
}

setInterval(render, fps(60));
```

<p data-height="265" data-theme-id="0" data-slug-hash="zMwwYY" data-default-tab="html,result" data-user="gloriaJun" data-pen-title="javascript-animation" class="codepen">See the Pen <a href="https://codepen.io/gloriaJun/pen/zMwwYY/">javascript-animation</a> by gloria (<a href="https://codepen.io/gloriaJun">@gloriaJun</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://static.codepen.io/assets/embed/ei.js"></script>


#### 작성한 자바스크립트 코드를 시각적으로 실행해볼 수 있음
- http://www.pythontutor.com/javascript.html#mode=edit


#### requestAnimationFrame & performance.now()
- https://developer.mozilla.org/ko/docs/Web/API/Window/requestAnimationFrame
- https://developers.google.com/web/fundamentals/performance/rendering/optimize-javascript-execution?hl=ko
- requestAnimationFrame : 브라우저에게 수행하기를 원하는 애니메이션을 알리고 다음 그리기가 진행되기 전에 해당 애니메이션을 업데이트하는 함수를 호출하게 한다.

- https://developer.mozilla.org/ko/docs/Web/API/Performance/now
- performance.now() : 좀 더 정밀한 시간을 측정할 수 있다.

- IE10 이상 지원
- setTimeout 또는 setInterval을 사용하면 특정 시점(종료 시)에 실행되고, 종종 프레임이 누락되어 버벅거림 현상이 발생할 수 있다는 단점이 있다.


##### ease out / ease in
- ease out : 시작할땐 빠르지만 끝날 땐 부드럽게
- ease in : 시작할 땐 부드럽게 끝날 땐 빠르게
- https://easings.net/ko

- https://developer.mozilla.org/en-US/docs/Web/API/Web_Animations_API
- https://developer.mozilla.org/en-US/docs/Web/API/Web_Animations_API/Using_the_Web_Animations_API
- https://sculove.github.io/slides/webAnimation/#/
- https://github.com/web-animations/web-animations-js
- http://cubic-bezier.com/

- 강의 자료 : http://slides.com/yamoo9

