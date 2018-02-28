#### 다른 파일에 정의된 속성을 extend 하기
다음과 같이 두 개의 파일이 있을 때에 다른 파일의 내용을 extend하여 사용하는 방법

```scss
/* modules.scss */
.ruddy {color: red}
.fullwidth {width: 100%; display: block;}

/* homepage.scss */
@import modules.sass

#intro {@extend ruddy; @extend fullwidth}
aside {@extend ruddy;}
.thing {@extend fullwidth;}
```
