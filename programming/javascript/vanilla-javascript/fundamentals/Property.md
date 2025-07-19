#javascript #typescript #vanilla-javascript #operator #object-oriented-programming #functional-programming #high-order-function 

# in keyword
- `in` keyword checks whether a property exists in a Javascript object.
- `in` check both inherited properties and the object's own properties.
```javascript title='in operator syntax'
prop in object
#prop in object
```

```javascript title='in operator in Javascript'
const car = { make: 'Honda', model: 'Accord', year: 1998 };

console.log('make' in car);
// Expected output: true

delete car.make;
if ('make' in car === false) {
  car.make = 'Suzuki';
}

console.log(car.make);
// Expected output: "Suzuki"
```

- `in obj` is not the same as `obj.x !== undefined` because a property may be present in an object but have value `undefined`.
- You can also use the `in` operator to check whether a particular [private class field or method](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes/Private_properties) has been defined in an object. The operator returns `true` if the property is defined, and `false` otherwise. This is known as a _branded check_, because it returns `true` if and only if the object was created with that class constructor, after which you can safely access other private properties as well.
```javascript title='in operator for private properties'
class C {
  #x;
  static isC(obj) {
    return #x in obj;
  }
}

let c = new C();
console.log(C.isC(c)); // returns true;

class C1 {
  #x;
  static isC(obj) {
    return '#x' in obj;
  }
}
let c1 = new C1();
console.log(C1.isC(c1)); // returns false;
```

# for ... in statement
- `for ... in` statement iterates over all enumerable string properties of a Javascript object and ignores properties keyed by symbols.
```javascript title='for in loop to iterate properties in object'
const object = { a: 1, b: 2, c: 3 };

for (const property in object) {
  console.log(`${property}: ${object[property]}`);
}

// Expected output:
// "a: 1"
// "b: 2"
// "c: 3"
```
---
# References
1. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/in for `in` operator in Javascript.
2. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/for...in for `for...in` loop in Javascript.
3. ECMAScript ® 2020 Language Specification - 11th June, 2020.