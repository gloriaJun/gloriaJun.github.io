---
layout: post
title: "(알고리즘) 피보나치 수열"
date: 2017-05-26 09:53:00
author: gloria
categories: algorithm
tags: fibonacci
---

피보나치는 수학에서 점화식으로 정의되는 수열.   
0과 1로 시작하고, 다음에 오는 피보나치 수는 바로 앞에 오는 두 수의 합이 된다.
즉, 아래와 같은 수이다..
```
1, 2, 3, 5, 8, 13, 21, 34, ...
```

이것을 재귀함수나 반복문으로 표현하면 아래와 같다.
* 재귀함수
    ```java
    public long fibonacci_recursion(int num) {
        long answer = 0;

        if (num == 0) answer = 0;
        else if (num == 1) answer = 1;
        else answer = fibonacci_recursion(num - 1) + fibonacci_recursion(num - 2);

        return answer;
    }
    ```

* 반복문
    ```java
    public long fibonacci_loop(int num) {
        long answer = 0;

        long f0 = 0;
        long f1 = 1;

        for (int i = 1; i < num; i++) {
            answer = f0 + f1;
            f0 = f1;
            f1 = answer;
        }

        return answer;
    }
    ```


## Reference
- [피보나치 수 - 위키백과, 우리 모두의 백과사전](https://ko.wikipedia.org/wiki/%ED%94%BC%EB%B3%B4%EB%82%98%EC%B9%98_%EC%88%98)
- [자연 속에 숨은 피보나치 수, 피보나치 수열 : 네이버 블로그](http://blog.naver.com/PostView.nhn?blogId=forfriend5&logNo=220472225501)
