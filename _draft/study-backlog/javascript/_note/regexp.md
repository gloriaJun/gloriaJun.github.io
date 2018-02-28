## Lookaround
Lookhead와 Lookbehind를 합쳐서 Lookaround라고 표현한다.
정규식에서 매칭할 내용 다음 또는 이전에 또 다른 정규식이 포함되는 지에 대해 매칭할 때 사용하며, 해당 부분은 매치된 다음에 버려진다.

#### Positive Lookahead
###### regex1(?=(regex2))
regex1 다음 regex2의 정규표현식이 일치할 경우 반환

#### Negative Lookahead
###### regex1(?!(regex2))
regex1 다음 regex2의 정규표현식이 일치하지 않을 경우 반환

#### Positive Lookbehind
###### (?<=(regex2))regex1
regex2의 정규표현식이 일치하고 regex1가 나올 경우 반환

#### Negative Lookbehind
###### (?<!(regex2))regex1
regex2의 정규표현식이 일치하지 않고 regex1가 나올 경우 반환

#### 관련 예제
http://mysnyc.tistory.com/53


## Group & Referneces
###### (ABC) : capture Group
Groups multiple tokens together and creates a capture group for extracting a substring or using a backreference.

###### (?:ABC) : non-capture Group
Groups multiple tokens together without creating a capture group.

###### \1 : numeric reference
Matches the results of a capture group. For example \1 matches the results of the first capture group & \3 matches the third.
