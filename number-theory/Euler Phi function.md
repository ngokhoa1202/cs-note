#number-theory #multiplicative-function #number-theoretic-function #asymmetric-cipher
# Definition
- The Euler's Totient Function, denoted as $\phi(n)$, counts the number of positive integers up to a given integer $n$ that are relatively prime to $n$.
# Properties

## Formula using Prime Factorization
- If the integer $n$ has a ==canonical factorization form== of $n = p_1^{k_1} p_2^{k_2} \cdots p_r^{k_r}$, the formula is:
  $$\phi(n) = n \prod_{i=1}^{r} \left(1 - \frac{1}{p_i}\right)$$

## For a Prime Number
- If $p$ is a prime number, all integers from 1 to $p-1$ are relatively prime to it.
  $$\phi(p) = p - 1$$

## Multiplicative Property
- The function is multiplicative, which means if two numbers $m$ and $n$ are relatively prime ($gcd(m,n)=1$), then:
  $$\phi(mn) = \phi(m)\phi(n)$$

# Proof
The proof relies on two main steps:
1.  Showing the formula holds for a prime power, $\phi(p^k)$.
2.  Using the multiplicative property of the function to extend the result to any integer $n$.

### For a Prime Power, $\phi(p^k)$
- We want to count the integers from 1 to $p^k$ that are relatively prime to $p^k$.
- An integer is relatively prime to $p^k$ if and only if it is not a multiple of the prime $p$.
- The multiples of $p$ between 1 and $p^k$ are:
  $$p, 2p, 3p, \dots, (p^{k-1})p$$
- There are exactly $p^{k-1}$ such multiples.
- The number of integers that are *not* relatively prime is therefore $p^{k-1}$.
- The total number of integers from 1 to $p^k$ is $p^k$.
- So, $\phi(p^k)$ is the total count minus the count of non-coprime integers:
  $$\phi(p^k) = p^k - p^{k-1}$$
- Factoring out $p^k$, we get:
  $$\phi(p^k) = p^k \left(1 - \frac{1}{p}\right)$$

### Extending to Any Integer $n$
- We start with the canonical factorization of $n$:
  $$n = p_1^{k_1} p_2^{k_2} \cdots p_r^{k_r}$$
- Since the phi function is multiplicative (a property stated earlier), we can write:
  $$\phi(n) = \phi(p_1^{k_1}) \phi(p_2^{k_2}) \cdots \phi(p_r^{k_r})$$
- Now, substitute the result from step 1 for each prime power term:
  $$\phi(n) = \left[p_1^{k_1}\left(1 - \frac{1}{p_1}\right)\right] \times \left[p_2^{k_2}\left(1 - \frac{1}{p_2}\right)\right] \times \cdots \times \left[p_r^{k_r}\left(1 - \frac{1}{p_r}\right)\right]$$
- We can regroup the terms:
  $$\phi(n) = (p_1^{k_1} p_2^{k_2} \cdots p_r^{k_r}) \times \left(1 - \frac{1}{p_1}\right)\left(1 - \frac{1}{p_2}\right)\cdots\left(1 - \frac{1}{p_r}\right)$$
- Recognizing that the first part is just $n$ and the second part is a product:
  $$\phi(n) = n \prod_{i=1}^{r} \left(1 - \frac{1}{p_i}\right)$$
- This completes the proof.

# Calculation Example: $\phi(12)$

### 1. Prime Factorization
- Find the prime factors of 12:
  $$12 = 2^2 \times 3^1$$
- The distinct prime factors are $p_1=2$ and $p_2=3$.

### 2. Apply the Formula
- Substitute the distinct prime factors into the formula $\phi(n) = n \prod (1 - 1/p_i)$:
  $$\phi(12) = 12 \times \left(1 - \frac{1}{2}\right) \times \left(1 - \frac{1}{3}\right)$$
  $$\phi(12) = 12 \times \left(\frac{1}{2}\right) \times \left(\frac{2}{3}\right) = 4$$

### 3. Verify the Result
- List the integers up to 12 that are relatively prime to 12 (i.e., their greatest common divisor with 12 is 1):
  $$\{1, 5, 7, 11\}$$
- There are **4** such integers, which confirms the calculated result.

***
# Reference
1. [Integer ring](Integer%20ring.md) for Integer ring $Z_m$