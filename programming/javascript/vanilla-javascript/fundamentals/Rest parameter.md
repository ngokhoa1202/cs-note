#operator #functional-programming #high-order-function #javascript #typescript #ecmascript 

# Rest parameter
- Rest parameter (`...`) allows a function to <mark style="background: #e4e62d;">accept multiple arguments</mark> and <mark style="background: #e4e62d;">collect them into a single variable</mark>.
```javascript title='Rest parameter'
function sum(...theArgs) {
  let total = 0;
  for (const arg of theArgs) {
    total += arg;
  }
  return total;
}

console.log(sum(1, 2, 3));
// Expected output: 6

console.log(sum(1, 2, 3, 4));
// Expected output: 10

```
---
# References
1. https://en.wikipedia.org/wiki/Variadic_function for variadic function concepts.
2. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax for Spread operator.
3. *https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/rest_parameters for Rest operator.*
4. ECMAScript ® 2020 Language Specification - 11th June, 2020.
5. https://en.wikipedia.org/wiki/Variadic_function for variadic function definition.