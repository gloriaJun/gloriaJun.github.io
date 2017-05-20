---
layout: post
comments: true
title: "[Angular2] Angular 프로젝트 구조"
date: 2017-03-31 22:30:00
categories: Frontend
tags: javascript AngularJS Angular2
---

[Angular Doc](angular.io)에서 *[Setup]( [Setup for local development - ts - GUIDE](https://v2.angular.io/docs/ts/latest/guide/setup.html) )* 문서를 참고해서 정리한 내용

> **사전 조건**  
> Node 와 npm이 설치되어 있어야 한다.  

### QuickStart 프로젝트 다운받기
git을 통해 다운받거나 angular 사이트에서 [다운로드](https://v2.angular.io/docs/ts/latest/guide/setup.html#download) 받는다.

불필요한 파일들을 삭제한다 (옵션)
```
xargs rm -rf < non-essential-files.osx.txt
rm src/app/*.spec*.ts
rm non-essential-files.osx.txt
```

### 프로젝트 구조
해당 프로젝트의 구조를 확인해보면 아래와 같이 구성되어 있다.

```
$ tree quickstart/
quickstart/
├── bs-config.json
├── package.json
├── src
│   ├── app
│   │   ├── app.component.ts
│   │   └── app.module.ts
│   ├── favicon.ico
│   ├── index.html
│   ├── main.ts
│   ├── styles.css
│   ├── systemjs-angular-loader.js
│   ├── systemjs.config.extras.js
│   ├── systemjs.config.js
│   └── tsconfig.json
└── tslint.json
```

###### src/app
angular application 파일들이 위치하는 디렉토리
/스프링 폴더 구조에서(?)   `wepapp` 폴더에 해당하는 듯/

###### package.json 
npm 패키지 의존관계에 대해 정의되어있는 파일.
`npm packages`에 대해서는 [github page]( [quickstart/README.md at master · angular/quickstart · GitHub](https://github.com/angular/quickstart/blob/master/README.md#install-npm-packages))를 참고.
```json
{
  "name": "study-angular",
  "version": "1.0.0",
  "description": "QuickStart package.json from the documentation, supplemented with testing support",
  "scripts": {
    "build": "tsc -p src/",
    "build:watch": "tsc -p src/ -w",
    "build:e2e": "tsc -p e2e/",
    "serve": "lite-server -c=bs-config.json",
    "serve:e2e": "lite-server -c=bs-config.e2e.json",
    "prestart": "npm run build",
    "start": "concurrently \"npm run build:watch\" \"npm run serve\"",
    "pree2e": "npm run build:e2e",
    "e2e": "concurrently \"npm run serve:e2e\" \"npm run protractor\" --kill-others --success first",
    "preprotractor": "webdriver-manager update",
    "protractor": "protractor protractor.config.js",
    "pretest": "npm run build",
    "test": "concurrently \"npm run build:watch\" \"karma start karma.conf.js\"",
    "pretest:once": "npm run build",
    "test:once": "karma start karma.conf.js --single-run",
    "lint": "tslint ./src/**/*.ts -t verbose"
  },
  "keywords": [],
  "author": "",
  "license": "MIT",
  "dependencies": {
    "@angular/common": "~4.0.0",
    "@angular/compiler": "~4.0.0",
    "@angular/core": "~4.0.0",
    "@angular/forms": "~4.0.0",
    "@angular/http": "~4.0.0",
    "@angular/platform-browser": "~4.0.0",
    "@angular/platform-browser-dynamic": "~4.0.0",
    "@angular/router": "~4.0.0",

    "angular-in-memory-web-api": "~0.3.0",
    "systemjs": "0.19.40",
    "core-js": "^2.4.1",
    "rxjs": "5.0.1",
    "zone.js": "^0.8.4"
  },
  "devDependencies": {
    "concurrently": "^3.2.0",
    "lite-server": "^2.2.2",
    "typescript": "~2.1.0",

    "canonical-path": "0.0.2",
    "tslint": "^3.15.1",
    "lodash": "^4.16.4",
    "jasmine-core": "~2.4.1",
    "karma": "^1.3.0",
    "karma-chrome-launcher": "^2.0.0",
    "karma-cli": "^1.0.1",
    "karma-jasmine": "^1.0.2",
    "karma-jasmine-html-reporter": "^0.2.2",
    "protractor": "~4.0.14",
    "rimraf": "^2.5.4",

    "@types/node": "^6.0.46",
    "@types/jasmine": "2.5.36"
  },
  "repository": {}
}
```


###### tsconfig.json
TypeScript를 javascript로 컴파일할 때 적용할 옵션에 대해 명시한 파일
컴파일 시 제외하고 싶은 폴더나 파일, 파일 옵션 등에 대해서도 설정할 수 있다.
```json
{
  "compilerOptions": {
    "target": "es5",
    "module": "commonjs",
    "moduleResolution": "node",
    "sourceMap": true,
    "emitDecoratorMetadata": true,
    "experimentalDecorators": true,
    "lib": [ "es2015", "dom" ],
    "noImplicitAny": true,
    "suppressImplicitAnyIndexErrors": true
  }
}
```

###### tslint.json
TypeScript의 코딩컨벤션 체크를 위한 규칙을 정의한 파일
```json
{
  "rules": {
    "class-name": true,
    "comment-format": [
      true,
      "check-space"
    ],
    "curly": true,
    "eofline": true,
    "forin": true,
    "indent": [
      true,
      "spaces"
    ],
    "label-position": true,
    "label-undefined": true,
    "max-line-length": [
      true,
      140
    ],
    "member-access": false,
    "member-ordering": [
      true,
      "static-before-instance",
      "variables-before-functions"
    ],
    "no-arg": true,
    "no-bitwise": true,
    "no-console": [
      true,
      "debug",
      "info",
      "time",
      "timeEnd",
      "trace"
    ],
    "no-construct": true,
    "no-debugger": true,
    "no-duplicate-key": true,
    "no-duplicate-variable": true,
    "no-empty": false,
    "no-eval": true,
    "no-inferrable-types": true,
    "no-shadowed-variable": true,
    "no-string-literal": false,
    "no-switch-case-fall-through": true,
    "no-trailing-whitespace": true,
    "no-unused-expression": true,
    "no-unused-variable": true,
    "no-unreachable": true,
    "no-use-before-declare": true,
    "no-var-keyword": true,
    "object-literal-sort-keys": false,
    "one-line": [
      true,
      "check-open-brace",
      "check-catch",
      "check-else",
      "check-whitespace"
    ],
    "quotemark": [
      true,
      "single"
    ],
    "radix": true,
    "semicolon": [
      "always"
    ],
    "triple-equals": [
      true,
      "allow-null-check"
    ],
    "typedef-whitespace": [
      true,
      {
        "call-signature": "nospace",
        "index-signature": "nospace",
        "parameter": "nospace",
        "property-declaration": "nospace",
        "variable-declaration": "nospace"
      }
    ],
    "variable-name": false,
    "whitespace": [
      true,
      "check-branch",
      "check-decl",
      "check-operator",
      "check-separator",
      "check-type"
    ]
  }
}
```

### Dependency 파일 내려 받기
해당 프로젝트가 위치한 곳으로 이동해서 ` npm install`을 실행하여 `package.json`에 정의된 패키지 파일들을 내려받는다.
```
$ npm install
⸨    ░░░░░░░░░░░░░⸩ ⠧ fetchMetadata: sill mapToRegistry uri https://registry.npmjs.org/rxjs
(...중략...)
```

패키지 파일들을 정상적으로 다운을 받으면 `node_modules` 이라는 디렉토리가 추가로 생성된다.

해당 폴더 안에 정상적으로 패키지가 설치되었는 지는 다음과 같이 확인할 수 있다.
```
$ npm list --depth=0
study-angular@1.0.0 /Users/gloria/Documents/project/study-angular
├── @angular/common@4.0.1
├── @angular/compiler@4.0.1
├── @angular/core@4.0.1
├── @angular/forms@4.0.1
├── @angular/http@4.0.1
├── @angular/platform-browser@4.0.1
├── @angular/platform-browser-dynamic@4.0.1
├── @angular/router@4.0.1
├── @types/jasmine@2.5.36
├── @types/node@6.0.68
├── angular-in-memory-web-api@0.3.1
├── canonical-path@0.0.2
├── concurrently@3.4.0
├── core-js@2.4.1
├── jasmine-core@2.4.1
├── karma@1.5.0
├── karma-chrome-launcher@2.0.0
├── karma-cli@1.0.1
├── karma-jasmine@1.1.0
├── karma-jasmine-html-reporter@0.2.2
├── lite-server@2.3.0
├── lodash@4.17.4
├── protractor@4.0.14
├── rimraf@2.6.1
├── rxjs@5.0.1
├── systemjs@0.19.40
├── tslint@3.15.1
├── typescript@2.1.6
└── zone.js@0.8.5
```

