#leetcode #number-theory 
# Algorithm
- [[algorithm/number-theory/Sieve of Eratosthenes|Sieve of Eratosthenes]]
# Implementation
## Java
### Optimized approach
```Java title='Problem 204 in Java: Optimized approach'
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