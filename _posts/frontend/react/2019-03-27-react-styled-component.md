---
layout: post
title: "(React) styled-components"
date: 2019-03-27 20:35:00
author: gloria
categories: frontend
tags: javascript frontend react
---

* TOC
{:toc}

css style을 javascript 코드와 같은 형태로 정의하고 component와 같은 형태로 사용할 수 있게 해준다.

## Installation

```bash
yarn add styled-components
# or 
npm install styled-components
```

## Usage

```javascript
import React from 'react';
import styles from 'styled-components';

const List = styles.ul`
    display: flex;
    &:hover{
        background: green;
    }
`;

export default () => (
    <header>
        <List>
            <li>
                <a href="/">Movies</a>
            </li>
            <li>
                <a href="/tv">TV</a>
            </li>
            <li>
                <a href="/search">Search</a>
            </li>
        </List>
    </header>
)
```

## styled-reset

기본적으로 브라우저의 내장된 css 스타일을 reset 해준다

```javascript
import { createGlobalStyle } from 'styled-components';
import reset from 'styled-reset';

export default () => createGlobalStyle`
    ${reset};
    a{
        text-decoration:none;
        color:inherit;
    }
    *{
        box-sizing: border-box;
    }
    body{
        font-family:-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
        font-size:14px;
        background-color:rgba(20, 20, 20, 1);
    }
`;
```
