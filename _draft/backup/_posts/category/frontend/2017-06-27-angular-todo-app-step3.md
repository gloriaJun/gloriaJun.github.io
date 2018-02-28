---
layout: post
comments: true
title: "[AngularJS] todo 어플리케이션 만들기 - Step 3 "
date: 2017-06-27 16:30:00
categories: Frontend
tags: javascript AngularJS
---


## todo 추가하기
`submit` 버튼이 클릭되면 해당 이벤트가 발생하도록  `ng-submit` directive를 이용하여 add() 메소드와 연결한다.     
```html
<form ng-submit="add(newToDo)">
  <input type="text" ng-model="newToDo" placeholder="Input New ToDo" autofocus>
  <button type="submit">Add</button>
</form>		
```
     
add() 메소드를 추가한다.
```javascript
$scope.add = function(newToDo) {
  newToDo = newToDo.trim();
  if(!newToDo) 
    return;

  var Idx = !$scope.todos.length ?
            1 : $scope.todos[$scope.todos.length - 1].id + 1;
  var todo = {
    id: Idx,
    title: newToDo,
    completed: false
  };
  
  $scope.todos.push(todo);
	// input 입력 값 초기화
  $scope.newToDo = "";
}
```

## todo 삭제하기
`remove` 버튼을 클릭하면 삭제가 되도록 remove() 메소드를 연결한다
```html
<button type="button" ng-click="remove(todo.id)">Remove</button>	
```
       
전달된 id에 대한 리스트가 삭제되도록 remove() 메소드를 추가한다.
```javascript
$scope.remove = function(id) {
  if(!id)
    return;

  var delIdx = $scope.todos.findIndex(function (todo) {
    return todo.id === id;
  });

  if(delIdx === -1) 
    return;

  $scope.todos.splice(delIdx, 1);
};
```