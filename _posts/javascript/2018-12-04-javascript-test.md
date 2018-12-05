---
layout: post
title: "(Javascript) 테스트 케이스 작성하기"
date: 2018-12-04 15:15:00
author: gloria
categories: language
tags: javascript unitTest testing
---


## 테스트 코드 작성을 위한 라이브러리
다양한 테스트 관련 라이브러리들 중에 어떠한 것이 적합한지에 대해 고려하여 판단을 해야하는 데..
일반적으로 다음과 같은 기능을 제공해야한다.
- 구조적인 테스트를 제공한다(Mocha, Jasmine, Jest).
- 테스트 결과를 보여준다(Mocha, Jasmine, Jest, Karma).
- 단언문을 제공한다(Chai, Jasmine).
- 목, 스파이, 스텁 등을 지원한다(Sinon.JS, Jasmine).
- 코드 커버리지 리포트를 생성한다(Istanbul).

이 중에 Frontend 테스트 환경 구축을 위한 대표적인 테스팅 프레임워크로는 [Mocha](https://github.com/mochajs/mocha), [Jest](https://github.com/facebook/jest), [Jasmine](https://github.com/jasmine/jasmine) 이 있다.

테스트 러너(브라우저에서 테스트를 수행하기 위한 것 같음)로는 [Karma](https://karma-runner.github.io/latest/index.html)가 대표적이다.

실제로 검색을 해보거나 웹팩 템플릿을 이용하여 프로젝트를 구성하다보면 아래와 같은 조합들을 확인 가능한 것 같다. (보통 테스트러너 + 프레임워크 조합으로 구성하는 것 같다)
- Jasmine + Karma
- Mocha + Karma

#### Chai
[Chai](https://www.chaijs.com/)를 사용하면 결과 값에 대하여 비교할 때에 Assertion을 이용하여 기대 값을 비교할 수 있다.

## 테스트 코드 작성해보기

**Mocha + Karma** 조합으로 테스트 환경을 구성해보았다.

#### 환경 구축
Mocha와 Chai 라이브러리를 설치한다.
```bash
yarn add -D mocha chai
```

Karma 라이브러리를 설치한다. 
```bash
yarn add -D karma karma-mocha karma-chrome-launcher
```

#### 유틸리티 코드 작성
```javascript
import reduce from 'lodash/reduce';
import find from 'lodash/find';

const role = (() => {
  const ROLES = {
    SUPER_ADMIN: { value: '1', text: 'app.users.role.superAdmin' },
    OPERATOR: { value: '2', text: 'app.users.role.operator' },
    WATCHER: { value: '3', text: 'app.users.role.watcher' },
  };

  return {
    defaultRole: ROLES.WATCHER,

    roleList() {
      return reduce(ROLES, (result, item) => {
        result.push(item);
        return result;
      }, []);
    },

    getRole(val) {
      return find(ROLES, { value: val.toString() });
    },

    getRoleName(val) {
      return find(ROLES, { value: val }).text;
    },

    isSuperAdmin(id) {
      return ROLES.SUPER_ADMIN.value === id;
    },
  };
})();

export default role;
```

#### 테스트 코드 작성
```javascript
import { expect } from 'chai';
import role from '@/utils/role';

describe('util.role', () => {
  describe('roleList', () => {
    it('get all role List', () => {
      const list = role.roleList();
      expect(list.length).to.equal(3);
    });


    it('get role by Id typed Number', () => {
      const roleId = 1;
      const roleName = role.getRole(roleId);
      expect(roleName.value).to.equal(roleId.toString());
      expect(roleName.text).to.include('superAdmin');
    });

    it('get role by Id typed String', () => {
      const roleId = '2';
      const roleName = role.getRole(roleId);
      expect(roleName.value).to.equal(roleId);
      expect(roleName.text).to.include('operator');
    });
  });
});
```

#### 테스트 코드 수행
```bash
$ vue-cli-service test:unit
 WEBPACK  Compiling...
 DONE  Compiled successfully in 1759ms
 WEBPACK  Compiled successfully in 1759ms
 MOCHA  Testing...

  util.role
    roleList
      ✓ get all role List
      ✓ get role by Id typed Number
      ✓ get role by Id typed String


  3 passing (10ms)

 MOCHA  Tests completed successfully

Done in 3.85s.
Process finished with exit code 0
```

#### Karma 설정 파일 생성
```bash
$ karma  init

Which testing framework do you want to use ?
Press tab to list possible options. Enter to move to the next question.
> mocha

Do you want to use Require.js ?
This will add Require.js plugin.
Press tab to list possible options. Enter to move to the next question.
> no

Do you want to capture any browsers automatically ?
Press tab to list possible options. Enter empty string to move to the next question.
> Chrome
> 

What is the location of your source and test files ?
You can use glob patterns, eg. "js/*.js" or "test/**/*Spec.js".
Enter empty string to move to the next question.
> tests/**/*.spec.js
> 

Should any of the files included by the previous patterns be excluded ?
You can use glob patterns, eg. "**/*.swp".
Enter empty string to move to the next question.
> 

Do you want Karma to watch all the files and run the tests on change ?
Press tab to list possible options.
> yes
```



## Reference
- [Testing React application with Karma, Jest or Mocha.](https://sungjk.github.io/2017/03/03/testing-react-application.html)
- [An Overview of JavaScript Testing in 2018](https://medium.com/welldone-software/an-overview-of-javascript-testing-in-2018-f68950900bc3)
- [NodeJS에서 가장 많이 사용하는 테스트 프레임웍, Mocha](http://blog.jeonghwan.net/mocha/)
- [Mocha 로 하는 API Testing](https://inspiredjw.com/entry/Mocha-%EB%A1%9C-%ED%95%98%EB%8A%94-API-Testing)