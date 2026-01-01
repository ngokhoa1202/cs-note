#leetcode #number-theory #java #javascript #operating-system #go 
# Algorithm
- [[algorithm/number-theory/Sieve of Eratosthenes|Sieve of Eratosthenes]]
# Implementation
## Java
- Type conversion is used to avoid type overflow.
### Optimized approach
```Java title='Problem 204 in Java: Optimized approach' hl=8,10
class Solution {
  public int countPrimes(int n) {
    boolean[] isPrime = new boolean[n];
    for (int i = 2; i <= n-1; ++i) {
      isPrime[i] = true;
    }
    for (long i = 2; i <= n-1; ++i) {
      if (isPrime[(int) i] && i * i <= (long) n-1) {
        for (long j = i * i; j <= n-1; j += i) {
          isPrime[(int) j] = false;
        }
      }
    }
    int counter = 0;
    for (int i = 2; i <= n-1; ++i) {
      if (isPrime[i]) {
        counter++;
      }
    }
    return counter;
  }
}
```
## JavaScript
- Since JavaScript has only a `Number` type, type conversion is not necessary.
### Optimized approach
```JavaScript title='Problem 204 in JavaScript: Optimized approach'
/**
 * @param {number} n
 * @return {number}
 */
const countPrimes = function(n) {
  const isPrime = new Array(n).fill(true);
  for (let i = 2; i * i < n; ++i) {
    if (isPrime[i] && i*i < n) {
      for (let j = i*i; j < n; j += i) {
        isPrime[j] = false;
      } 
    }
  }
  return isPrime.slice(2, n).filter((ele) => ele).length;
};
```
## Go
- The default range of `int` in 64-bit systems is from $[-2^{63},2^{63}-1]$ , which already exceeds the given input.
- However, the type must be converted to `int64` if the current operating system is 32-bit-based.
### Optimized approach
```Go title='Problem 204 in Go: Optimized approach'
func countPrimes(n int) int {
  isPrime := make([]bool, n)
  for i := range isPrime {
    isPrime[i] = true
  }
  for i := 2; i*i < n; i++ {
    if isPrime[i] && i*i < n {
      for j := i*i; j < n; j += i {
        isPrime[j] = false
      }
    }
  }
  counter := 0
  for i := 2; i < n; i++ {
    if (isPrime[i]) {
      counter++;
    }
  }
  return counter;
}
```
# Complexity
## Time complexity
- The time complexity is $$T(n)=O(n \log \log n)$$
## Space complexity
- $\Theta(n)$.
- The auxiliary space is $\Theta(n)$.
***
# References
1. [[algorithm/number-theory/Sieve of Eratosthenes|Sieve of Eratosthenes]]
2. https://cp-algorithms.com/algebra/sieve-of-eratosthenes.html for algorithm complexity.
3. 