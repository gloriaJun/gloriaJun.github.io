#### Constructor Pattern

###### ES6 이전
```javascript
function Car( model, year, miles ) {
  this.model = model;
  this.year = year;
  this.miles = miles;
}
Car.prototype.toString = function () {
  return this.model + " has done " + this.miles + " miles";
};

var civic = new Car( "Honda Civic", 2009, 20000 );
var mondeo = new Car( "Ford Mondeo", 2010, 5000 );

console.log( civic.toString() );
console.log( mondeo.toString() );
```

###### ES6의 class 활용한 코드
```javascript
class Car {
  constructor (model, year, miles) {
    this.model = model; this.year = year; this.miles = miles;
  }

  toString() {
    return this.model + " has done " + this.miles + " miles";
  }
}
```

- 참고링크
[ES6-Classes](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes)
