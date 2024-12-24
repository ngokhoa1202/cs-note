#javascript #vanilla-javascript #typescript #ecmascript 

# Syntax
```javascript title='Destructuring assignment syntax'
const [a, b] = array;
const [a, , b] = array;
const [a = aDefault, b] = array;
const [a, b, ...rest] = array;
const [a, , b, ...rest] = array;
const [a, b, ...{ pop, push }] = array;
const [a, b, ...[c, d]] = array;

const { a, b } = obj;
const { a: a1, b: b1 } = obj;
const { a: a1 = aDefault, b = bDefault } = obj;
const { a, b, ...rest } = obj;
const { a: a1, b: b1, ...rest } = obj;
const { [key]: a } = obj;

let a, b, a1, b1, c, d, rest, pop, push;
[a, b] = array;
[a, , b] = array;
[a = aDefault, b] = array;
[a, b, ...rest] = array;
[a, , b, ...rest] = array;
[a, b, ...{ pop, push }] = array;
[a, b, ...[c, d]] = array;

({ a, b } = obj); // parentheses are required
({ a: a1, b: b1 } = obj);
({ a: a1 = aDefault, b = bDefault } = obj);
({ a, b, ...rest } = obj);
({ a: a1, b: b1, ...rest } = obj);

```
# Destructuring assignment
- Destructuring assignment helps <mark style="background: #e4e62d;">unpack</mark> values from arrays or properties from object <mark style="background: #e4e62d;">into distinct variables</mark>.
- Makes the assignment operator more declarative and succinct.
```javascript title='Destructuring assignment'
let a, b, rest;
[a, b] = [10, 20];

console.log(a);
// Expected output: 10

console.log(b);
// Expected output: 20

[a, b, ...rest] = [10, 20, 30, 40, 50];

console.log(rest);
// Expected output: Array [30, 40, 50]

const obj = { a: 1, b: 2 };
const { a, b } = obj;
// is equivalent to:
// const a = obj.a;
// const b = obj.b;

```

# Use cases
## Array literal
```javascript title='Array literal destructuring assignment'
const x = [1, 2, 3, 4, 5];
const [y, z] = x;
console.log(y); // 1
console.log(z); // 2
```

## Object literal
- Only standalone variables (without `:` following) are destructured and bound to object properties.
```javascript title='Object destrucring assignment'
const obj = { a: 1, b: { c: 2 } };
const {
	a,
	b: { c: d },
} = obj;

// Two variables are bound: `a` and `d`
```

---
# References
1. ECMAScript ® 2020 Language Specification - 11th June, 2020.
2. *https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment for destructuring assignment.*