#javascript #typescript #vanilla-javascript #operator #object-oriented-programming #functional-programming #high-order-function 

# Properties in Object
- [Property](Property.md)
# <span style="font-family:'JetBrains Mono';">typeof</span> operator
- `typeof` operator checks whether the object is of one of the predefined types.

|Type|Result|
|---|---|
|[Undefined](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/undefined)|`"undefined"`|
|[Null](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/null)|`"object"` ([reason](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/typeof#typeof_null))|
|[Boolean](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Boolean)|`"boolean"`|
|[Number](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number)|`"number"`|
|[BigInt](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/BigInt)|`"bigint"`|
|[String](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String)|`"string"`|
|[Symbol](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Symbol)|`"symbol"`|
|[Function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function) (implements [[Call]] in ECMA-262 terms; [classes](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/class) are functions as well)|`"function"`|
|Any other object|`"object"`|
```javascript title='typeof operator examples'
// Numbers
typeof 37 === "number";
typeof 3.14 === "number";
typeof 42 === "number";
typeof Math.LN2 === "number";
typeof Infinity === "number";
typeof NaN === "number"; // Despite being "Not-A-Number"
typeof Number("1") === "number"; // Number tries to parse things into numbers
typeof Number("shoe") === "number"; // including values that cannot be type coerced to a number

typeof 42n === "bigint";

// Strings
typeof "" === "string";
typeof "bla" === "string";
typeof `template literal` === "string";
typeof "1" === "string"; // note that a number within a string is still typeof string
typeof typeof 1 === "string"; // typeof always returns a string
typeof String(1) === "string"; // String converts anything into a string, safer than toString

// Booleans
typeof true === "boolean";
typeof false === "boolean";
typeof Boolean(1) === "boolean"; // Boolean() will convert values based on if they're truthy or falsy
typeof !!1 === "boolean"; // two calls of the ! (logical NOT) operator are equivalent to Boolean()

// Symbols
typeof Symbol() === "symbol";
typeof Symbol("foo") === "symbol";
typeof Symbol.iterator === "symbol";

// Undefined
typeof undefined === "undefined";
typeof declaredButUndefinedVariable === "undefined";
typeof undeclaredVariable === "undefined";

// Objects
typeof { a: 1 } === "object";

// use Array.isArray or Object.prototype.toString.call
// to differentiate regular objects from arrays
typeof [1, 2, 4] === "object";

typeof new Date() === "object";
typeof /regex/ === "object";

// The following are confusing, dangerous, and wasteful. Avoid them.
typeof new Boolean(true) === "object";
typeof new Number(1) === "object";
typeof new String("abc") === "object";

// Functions
typeof function () {} === "function";
typeof class C {} === "function";
typeof Math.sin === "function";

```

```javascript title='typeof null'
// This stands since the beginning of JavaScript
typeof null === "object";
```

- Type of undeclared and uninitialized object is `undefined`.
# <span style="font-family:'JetBrains Mono';">instanceof</span> operator
- The **`instanceof`** operator checks whether the `prototype` property of a constructor appears anywhere in the prototype chain of an object or not.
```javascript title='instanceof in Javascript'
function Car(make, model, year) {
  this.make = make;
  this.model = model;
  this.year = year;
}
const auto = new Car('Honda', 'Accord', 1998);

console.log(auto instanceof Car);
// Expected output: true

console.log(auto instanceof Object);
// Expected output: true
```

```javascript title='instanceof example in Javascript'
// defining constructors
function C() {}
function D() {}

const o = new C();

// true, because: Object.getPrototypeOf(o) === C.prototype
o instanceof C;

// false, because D.prototype is nowhere in o's prototype chain
o instanceof D;

o instanceof Object; // true, because:
C.prototype instanceof Object; // true

// Re-assign `constructor.prototype`: you should
// rarely do this in practice.
C.prototype = {};
const o2 = new C();

o2 instanceof C; // true

// false, because C.prototype is nowhere in
// o's prototype chain anymore
o instanceof C;

D.prototype = new C(); // add C to [[Prototype]] linkage of D
const o3 = new D();
o3 instanceof D; // true
o3 instanceof C; // true since C.prototype is now in o3's prototype chain

```

- Typescript raises a compilation error if `instanceof` operator works with an interface because interfaces do not have prototype in Typescript.
# Square bracket
- Used to access object's properties which have names that contain spacing, special characters.
```Javascript title='Access object by square bracket'
let user = {};

// set
user["likes birds"] = true;

// get
alert(user["likes birds"]); // true

// delete
delete user["likes birds"];

// key is defined at runtime execution
let key = "likes birds";

// same as user["likes birds"] = true;
user[key] = true;
```
- Used in object literal to define a property whose name is defined at run-time which is known as computed property.
```Javascript title='Computed property'
let fruit = prompt("Which fruit to buy?", "apple");

let bag = {
  [fruit]: 5, // the name of the property is taken from the variable fruit
};

alert( bag.apple ); // 5 if fruit="apple"
```

# Object references & copy
- Primitive types are immutable and stored in stack memory. While object is stored in heap memory and the pointer which refers to the object is stored in stack memory.
- `Object.assign(target, source)` or spread operator (`...`) can be employed to make a shallow copy from a source object to a target object. The property with the same key is overwritten.
```Javascript title='Object's shallow copy in Javascript'
let user = {
  name: "John",
  age: 30
};

let clone = Object.assign({}, user);

alert(clone.name); // John
alert(clone.age); // 30
```
- `structuredClone`, ... are used to perform deep copy on object.
```Javascript title='structuredClone in Javascript'

```
---
# References
1. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/in for `in` operator in Javascript.
2. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/for...in for `for...in` loop in Javascript.
3. [Property](Property.md)  for properties in Javascript.
4. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/typeof for `typeof` operator.
5. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/instanceof for `instanceof` operator.
6. https://javascript.info/object-copy for Object references and copy.
7. https://stackoverflow.com/questions/122102/what-is-the-most-efficient-way-to-deep-clone-an-object-in-javascript for deep copy in Javascript.