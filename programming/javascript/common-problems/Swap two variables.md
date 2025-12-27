#javascript #typescript #object-oriented-programming 
- Variable assignment is always actually copy-on-value and parameter passing is always pass-by-value in JavaScript.
# Assignment destructuring
```JavaScript title='Swap two variables with assignment destructuring'
[a, b] = [b, a]
```
# Temporary variable
- The logic of variable swapping must be performed in an <mark class="hltr-yellow">inline</mark> manner.
```JavaScript title='Swap two variables with temporary variable'
// This must be inline
const tmp = a;
a = b;
b = tmp;
```
## Swap two elements in an array
- In case, two elements in the same array need swapping, the logic of swapping can be separated into a method.
```JavaScript title='Swap two elements in the same array with temporary variable'
function swap(nums, i, j) {
  const tmp = nums[i];
  nums[i] = nums[j];
  nums[j] = tmp;
}
```
***
# References
1. https://www.geeksforgeeks.org/javascript/how-to-swap-two-variables-in-javascript/
2. 