#javascript #vanilla-javascript #typescript #functional-programming #high-order-function #reactive-programming #data-type 

# Traditional function
- Define a function with `function` keyword.
- The function type is `Function` in Typescript according to ECMAScript 2015. 
- Function in JavaScript is a first-class object.
- Function expressions are not hoisted while function declaration is allowed to be hoisted.
```javascript
console.log(notHoisted); // undefined
// Even though the variable name is hoisted,
// the definition isn't. so it's undefined.
notHoisted(); // TypeError: notHoisted is not a function

var notHoisted = function () {
  console.log("bar");
};


hoisted();

function hoisted() {
  // do something
}
```
- Traditional function is <mark style="background: #e4e62d;">able to bind</mark> to `this` pointer, `arguments` or `super` pointer
## Callback function
- Traditional function can be used as a callback when being bound to an event.
```javascript
button.addEventListener("click", function (event) {
  console.log("button is clicked!");
});
```

## Immediately Invoked Function Expression
- Acronym is IIFE.
- Immediately Invoked Function Expression contains two major parts:
	- A function expression enclosed in parentheses in order to be parsed correctly.
	- Immediately _calling_ the function expression with arguments provided
```Javascript title='Immediately Invoked Function Expression example'
"use strict";

function foo() {
  foo = 1;
}
foo();
console.log(foo); // 1
(function foo() {
  foo = 1; // TypeError: Assignment to constant variable.
})();
```

# Arrow function
- Arrow functions do not bind to `this` pointer, `arguments` or `super` and cannot be neither used as constructor nor method.
```javascript title='Arrow function syntax'
(a, b, ...r) => expression
(a = 400, b = 20, c) => expression
([a, b] = [10, 20]) => expression
({ a, b } = { a: 10, b: 20 }) => expression

() => expression

param => expression

(param) => expression

(param1, paramN) => expression

() => {
  statements
}

param => {
  statements
}

(param1, paramN) => {
  statements
}

```
- Arrow functions are used as <mark style="background: #e4e62d;">anonymous functions</mark> on a regular basis.
```javascript title='Arrow function as an anonymous function''
// Traditional anonymous function
(function (a, b) {
  const chuck = 42;
  return a + b + chuck;
});

// Arrow function
(a, b) => {
  const chuck = 42;
  return a + b + chuck;
};
```

# References
1. https://javascript.info/arrow-functions-basics for arrow function basics.
2. [Scope](Scope.md) for Javascript Scope.
3. https://benalman.com/news/2010/11/immediately-invoked-function-expression/#iife for Immediate Invoked Function Expression.