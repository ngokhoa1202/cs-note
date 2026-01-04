#number-theory #prime-factorization #fundamental-theorem
# Statement
- The Fundamental Theorem of Arithmetic states that any integer $n > 1$ can be uniquely represented as a product of prime numbers. This is often expressed in a canonical form: $$n = p_1^{k_1} p_2^{k_2} \cdots p_r^{k_r} = \prod_{i=1}^{r} p_i^{k_i}$$

Where:
- $p_1 < p_2 < \dots < p_r$ are prime numbers.
- $k_i \geq 1$ are positive integers.

The theorem asserts two key properties:
1.  **Existence**: Such a factorization always exists.
2.  **Uniqueness**: The set of prime factors and their corresponding exponents is unique for any given $n$.
# Key Concepts
### Prime Factorization
- This is the process of finding the prime numbers that multiply together to make the original number.
- For example, the prime factorization of 12 is $2^2 \times 3$.
### Canonical Representation
- By convention, the unique factorization is written with the prime factors in increasing order. This is known as the ==canonical representation==.
- For example, the canonical representation of 360 is $2^3 \times 3^2 \times 5$.
# Implications

## Divisor Functions
- The theorem is the foundation for functions related to the divisors of an integer. Given the canonical factorization $n = p_1^{k_1} p_2^{k_2} \cdots p_r^{k_r}$
### Number of divisors
- $\tau(n)$: Any divisor of $n$ must be of the form $p_1^{a_1} p_2^{a_2} \cdots p_r^{a_r}$ where $0 \le a_i \le k_i$. There are $(k_i+1)$ choices for each exponent $a_i$.
  $$\tau(n) = (k_1+1)(k_2+1)\cdots(k_r+1)$$
### Sum of divisors
- $\sigma(n)$: The sum of all positive divisors of $n$.
  $$\sigma(n) = \prod_{i=1}^{r} \frac{p_i^{k_i+1}-1}{p_i-1}$$
# Example
## Prime Factorization
- Start with the integer: 360
- Divide by the smallest prime factor (2) until it is no longer divisible:
    - $360 \div 2 = 180$
    - $180 \div 2 = 90$
    - $90 \div 2 = 45$
- Move to the next prime (3):
    - $45 \div 3 = 15$
    - $15 \div 3 = 5$
- Move to the final prime factor (5):
    - $5 \div 5 = 1$
- The prime factors are three 2s, two 3s, and one 5.
- The canonical representation is:
    $$360 = 2^3 \times 3^2 \times 5^1$$

***
# Reference
1. [Euler Phi function](Euler%20Phi%20function.md).
