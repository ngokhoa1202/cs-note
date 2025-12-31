#algorithm #number-theory #array 
# Algorithm
- Sieve of Eratosthenes is an algorithm for finding all the prime numbers in a segment  $[1;n]$  using  $O(n \log \log n)$  operations.
- Initializes an array from $2$ to $n$.
- All the *proper multiples* $x$ of $2$ such that $x > 2$ and $2|x$ are marked as composite. Then, all the proper multiples of the following number that is not marked as composite are marked as composite. In this case, it is $3$; as a result, all proper multiples of $3$ are marked as composite.
- The procedure is repeated until all the numbers are processed.
- ![[assets/Pasted image 20251231202553.png]]
## Naive approach
- For each number $i \in [2,n]$
    - $j \leftarrow 2i$
    - while $j \leq n$:
        - $j$ is marked as composite.
        - $j \leftarrow j + i$. 
## Optimized approach
- Since other proper multiples of $i$ such as $(i-1) \times i, \space (i-2) \times i,...$  is already processed as $i \times (i-1)$ which is a proper multiple of $i-1$ and $i \times (i-2)$ which is a proper multiple of $i-2$, the inner loop can be started from $i \times i$.
- -For each number $i \in [2,\lfloor\sqrt{n}\rfloor]$
    - $j \leftarrow i^2$
    - while $j \leq n$:
        - $j \times i$ is marked as composite.
        - $j \leftarrow j + i$. 
# Implementation
## Java
### Optimized approach
```Java title='Sieve of Eratosthenes in Java: Optimized approach'
class SieveOfEratosthenes {
  public static boolean[] checkPrime(int n) {
    boolean[] isPrime = new boolean[n+1];
    for (int i = 2; i <= n; ++i) {
      isPrime[i] = true;
    }
    for (long i = 2; i <= n; ++i) {
      if (isPrime[(int) i] && i * i <= (long) n-1) {
        for (long j = i * i; j <= n; j += i) {
          isPrime[(int) j] = false;
        }
      }
    }
    return isPrime;
  } 
}
```

***
# References
1. https://www.geeksforgeeks.org/dsa/sieve-of-eratosthenes/
2. https://cp-algorithms.com/algebra/sieve-of-eratosthenes.html
