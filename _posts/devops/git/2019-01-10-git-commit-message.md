---
layout: post
title: "(Git) git commit message"
date: 2019-01-10 10:30:00
author: gloria
categories: devops
tags: git
---

git commit 메시지를 잘 작성하기 위해서 템플릿이나 키워드들을 찾아본 것들을 정리해보았다.

내가 생각하기에는 커밋할 때에...단순하게 `subject`만 적어도 되지만...
적어도 `type: subject`와 같이 작성해주는게 좋은 것 처럼 느껴진다.

그리고 좀 더 부연설명을 추가하여 작성한다면 아래와 같이 작성할 수도.

# git message format

```text
type: subject
body
footer
```

## type

commit message type을 적어줄 수 있다

* feat (feature)
* fix (bug fix)
* docs (documentation)
* style (formatting, missing semi colons, …)
* refactor
* test (when adding missing tests)
* chore (maintain)

## subject

50자를 넘지 않고, 동사 명령형을 사용한다.

## body

필요시에 부연설명을 작성한다.

## footer

관련 이슈가 있다면, 관련 이슈 번호를 적어준다.

# 참고 예시

* ex1)

```text
feat: Summarize changes in around 50 characters or less

More detailed explanatory text, if necessary. Wrap it to about 72
characters or so. In some contexts, the first line is treated as the
subject of the commit and the rest of the text as the body. The
blank line separating the summary from the body is critical (unless
you omit the body entirely); various tools like `log`, `shortlog`
and `rebase` can get confused if you run the two together.

Explain the problem that this commit is solving. Focus on why you
are making this change as opposed to how (the code explains that).
Are there side effects or other unintuitive consequenses of this
change? Here's the place to explain them.

Further paragraphs come after blank lines.

 - Bullet points are okay, too

 - Typically a hyphen or asterisk is used for the bullet, preceded
   by a single space, with blank lines in between, but conventions
   vary here

If you use an issue tracker, put references to them at the bottom,
like this:

Resolves: #123
See also: #456, #789
```