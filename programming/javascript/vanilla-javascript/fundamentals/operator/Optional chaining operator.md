#javascript #vanilla-javascript #typescript 

- Also known as safe navigation operator.
# Optional chaining operator
- If the object accessed or function called using this operator is `undefined` or `null`), the expression short circuits and evaluates to `undefined` instead of throwing an error.
```Javascript title='Optional chaining operator'
const adventurer = {
	name: "Alice",
	cat: {
		name: "Dinah",
	},
};

const dogName = adventurer.dog?.name;
console.log(dogName);
// Expected output: undefined

console.log(adventurer.someNonExistentMethod?.());
// Expected output: undefined

```
- Used to attempt to invoke a method which may not exist.
```Javascript title='Optional chaining operator for method invocation'
const result = someInterface.customMethod?.();
```
---
# References
1. https://en.wikipedia.org/wiki/Safe_navigation_operator
2. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Optional_chaining for Optional chaining operator.