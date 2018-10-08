---
layout: post
title: "(알고리즘) 해시 - 완주하지 못한 선수"
date: 2018-10-05 22:53:00
author: gloria
categories: algorithm
tags: hash

---



#### 문제 설명

스파이들은 매일 다른 옷을 조합하여 입어 자신을 위장합니다.

예를 들어 스파이가 가진 옷이 아래와 같고 오늘 스파이가 동그란 안경, 긴 코트, 파란색 티셔츠를 입었다면 다음날은 청바지를 추가로 입거나 동그란 안경 대신 검정 선글라스를 착용하거나 해야 합니다.

| 종류 | 이름                       |
| ---- | -------------------------- |
| 얼굴 | 동그란 안경, 검정 선글라스 |
| 상의 | 파란색 티셔츠              |
| 하의 | 청바지                     |
| 겉옷 | 긴 코트                    |

스파이가 가진 의상들이 담긴 2차원 배열 clothes가 주어질 때 서로 다른 옷의 조합의 수를 return 하도록 solution 함수를 작성해주세요.

##### 제한사항

- clothes의 각 행은 [의상의 이름, 의상의 종류]로 이루어져 있습니다.
- 스파이가 가진 의상의 수는 1개 이상 30개 이하입니다.
- 같은 이름을 가진 의상은 존재하지 않습니다.
- clothes의 모든 원소는 문자열로 이루어져 있습니다.
- 모든 문자열의 길이는 1 이상 20 이하인 자연수이고 알파벳 소문자 또는 '_' 로만 이루어져 있습니다.
- 스파이는 하루에 최소 한 개의 의상은 입습니다.



##### 입출력 예

| clothes                                                      | return |
| ------------------------------------------------------------ | ------ |
| [[yellow_hat, headgear], [blue_sunglasses, eyewear], [green_turban, headgear]] | 5      |
| [[crow_mask, face], [blue_sunglasses, face], [smoky_makeup, face]] | 3      |



#### 풀이 결과

> 해당 문제의 경우, *동시에* 옷을 선택하는 경우이므로, 
>
> 경우의 수 **곱의 법칙**을 이용하여 해당 과정을 풀이할 수 있음. 
>
> - **곱의 법칙**: 경우의 수를 구해야 할 여러 사건들이 서로 **영향을 주지 않거나** 일어나는 상황이 **구조가 닮은** 경우, 경우의 수를 뭉쳐서 계산하게 된다. and가 곱의 법칙이다.
>   두 사건 A, B의 경우의 수를 따진다면, 사건 A가 일어나는 경우의 수가 m가지, 사건 B가 일어나는 경우의 수는 n가지라면 A와 B가 동시에 일어나는 경우의 수는 m*n 가지다.



다음과 같은 순서로 풀어나감.

- 종류별로 구분하기
- 경우의 수 구하기
  - 각 종류 별로 한 번도 선택하지 않는 경우도 있으므로 구한 경우의 수에 *1*씩 더해준다.
  - 최종적으로 구해진 수에서 적어도 한 가지 옷은 선택하므로 *1*을 빼준다. (즉, 모든 옷을 선택하지 않을 경우의 수를 뺀다.)

###### javascript

```javascript
function solution(clothes) {
    let answer = 1;
    let clothesObj = new Object();
    
    clothes.map(arr => {
        if(!clothesObj[arr[1]]) 
            clothesObj[arr[1]] = [];
        clothesObj[arr[1]].push(arr[0]);   
    })
    
    Object.keys(clothesObj).map(key => {
        answer = answer * (clothesObj[key].length + 1);
    })
    
    return answer - 1;
}
```



###### java

```java
import java.util.*;

class Solution {
    public int solution(String[][] clothes) {
        int answer = 1;
        HashMap<String, Integer> map = new HashMap<>();
        for (String[] cloth : clothes) {
            map.put(cloth[1], map.getOrDefault(cloth[1], 0) + 1);
        }

        for (Map.Entry<String, Integer> entry : map.entrySet()) {
            answer = answer * (entry.getValue() + 1);
        }
        return answer - 1;
    }
}
```





