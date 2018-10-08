---
layout: post
title: "(알고리즘) 해시 - 전화번호 목록"
date: 2018-10-06 10:53:00
author: gloria
categories: algorithm
tags: hash

---



#### 문제 설명

전화번호부에 적힌 전화번호 중, 한 번호가 다른 번호의 접두어인 경우가 있는지 확인하려 합니다.
전화번호가 다음과 같을 경우, 구조대 전화번호는 영석이의 전화번호의 접두사입니다.

- 구조대 : 119
- 박준영 : 97 674 223
- 지영석 : 11 9552 4421

전화번호부에 적힌 전화번호를 담은 배열 phone_book 이 solution 함수의 매개변수로 주어질 때, 어떤 번호가 다른 번호의 접두어인 경우가 있으면 false를 그렇지 않으면 true를 return 하도록 solution 함수를 작성해주세요.

##### 제한사항

- phone_book의 길이는 1 이상 1,000,000 이하입니다.
- 각 전화번호의 길이는 1 이상 20 이하입니다.



##### 입출력 예제

| phone_book                  | return |
| --------------------------- | ------ |
| [119, 97674223, 1195524421] | false  |
| [123,456,789]               | true   |
| [12,123,1235,567,88]        | false  |



#### 풀이 결과

###### java

```java
class Solution {
    public boolean solution(String[] phone_book) {
        boolean answer = true;
        
        for (int i = 0; i < phone_book.length-1; i++) {
            for (int j = i+1; j < phone_book.length; j++) {
                if (phone_book[i].startsWith(phone_book[j]) ||
                   phone_book[j].startsWith(phone_book[i])) {
                    answer = false;
                    break;
                }
            }
            if (!answer) break;
        }
        
        return answer;
    }
}
```



### 문제를 풀고 난 뒤에...

- 전달받은 배열을 정렬을 하고 난 뒤에 비교하는 게 좀더 효율적일 것 같다.

