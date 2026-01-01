#array #javascript #typescript 
# Primitive value
- Use `Array.prototype.fill` for  primitive values.
```JavaScript title='Initialize an array of primitive value with Array.prototype.fill'
// Create an array of size 5, filled with 0
const arr = new Array(5).fill(0);

console.log(arr); // [0, 0, 0, 0, 0]
```
- However, If  `.fill({})` is used with an object or array, every element will point to the *same reference*.
# Reference value
- Use `Array.from()` to create *unique objects* rather than a single shared reference for each slot in the array.
```JavaScript title='Initialize an array of reference value with Array.from'
// BAD: Shared reference
// const arr = Array(3).fill({}); 

// GOOD: Unique objects
const arr = Array.from({ length: 3 }, () => ({ id: 0 }));

arr[0].id = 99;
console.log(arr); // [{ id: 99 }, { id: 0 }, { id: 0 }]
```
***
# References
1. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/new for `new` keyword.
2. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/fill for `Array.prototype.fill()`.
3. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/from for `Array.from()`.