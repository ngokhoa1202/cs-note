#number-theory #cryptography #asymmetric-cipher #primality-testing
# Fermat's Little Theorem

Fermat's Little Theorem is a fundamental result in number theory about ==modular arithmetic with prime moduli==. It is a special case of [[Euler theorem]] and has important applications in cryptography and primality testing.

## Statement

**Theorem**: If $p$ is prime, then for any integer $a$:

$$a^p \equiv a \pmod{p}$$

**Corollary**: If $p$ is prime and $\gcd(a,p)=1$, then:

$$a^{p-1} \equiv 1 \pmod{p}$$

***

# Proof

## Proof 1: Using Euler's Theorem

Fermat's little theorem is a ==special case of Euler's theorem==.

For prime $p$:
$$\phi(p) = p - 1$$

By [[Euler theorem]], when $\gcd(a, p) = 1$:
$$a^{\phi(p)} \equiv 1 \pmod{p}$$

Therefore:
$$a^{p-1} \equiv 1 \pmod{p}$$

Multiplying both sides by $a$:
$$a^p \equiv a \pmod{p}$$

**Q.E.D.**

## Proof 2: Direct Combinatorial Proof

We prove $a^p \equiv a \pmod{p}$ by induction on $a$.

**Base case**: $a = 0$
$$0^p = 0 \equiv 0 \pmod{p}$$ ✓

**Inductive step**: Assume $a^p \equiv a \pmod{p}$. Prove $(a+1)^p \equiv a+1 \pmod{p}$.

By binomial theorem:
$$(a+1)^p = \sum_{k=0}^{p} \binom{p}{k} a^k$$

For $0 < k < p$:
$$\binom{p}{k} = \frac{p!}{k!(p-k)!}$$

Since $p$ is prime and $0 < k < p$, the numerator contains factor $p$ but the denominator doesn't.

Therefore $p \mid \binom{p}{k}$ for $0 < k < p$.

This means:
$$(a+1)^p \equiv \binom{p}{0}a^0 + \binom{p}{p}a^p \pmod{p}$$
$$(a+1)^p \equiv 1 + a^p \pmod{p}$$

By inductive hypothesis $a^p \equiv a \pmod{p}$:
$$(a+1)^p \equiv 1 + a \equiv a + 1 \pmod{p}$$

**Q.E.D.**

## Proof 3: Using Group Theory

Consider the ==multiplicative group== $(\mathbb{Z}_p^*, \times)$ of non-zero elements modulo $p$.

For prime $p$, this group has order $p - 1$.

By Lagrange's theorem, for any element $a \in \mathbb{Z}_p^*$:
$$a^{p-1} \equiv 1 \pmod{p}$$

**Q.E.D.**

***

# Examples

## Example 1: Basic Verification

**Problem**: Verify $2^6 \equiv 1 \pmod{7}$

**Solution**:

Since $7$ is prime and $\gcd(2, 7) = 1$:
$$2^{7-1} = 2^6 \equiv 1 \pmod{7}$$

Calculate:
$$2^6 = 64 = 9 \times 7 + 1 \equiv 1 \pmod{7}$$ ✓

## Example 2: Computing Large Exponents

**Problem**: Compute $5^{100} \bmod 7$

**Solution**:

Since $7$ is prime, by Fermat's little theorem:
$$5^6 \equiv 1 \pmod{7}$$

Express $100 = 16 \times 6 + 4$:
$$5^{100} = (5^6)^{16} \times 5^4 \equiv 1^{16} \times 5^4 \equiv 5^4 \pmod{7}$$

Calculate $5^4 \bmod 7$:
$$5^2 = 25 \equiv 4 \pmod{7}$$
$$5^4 \equiv 4^2 = 16 \equiv 2 \pmod{7}$$

**Answer**: $5^{100} \equiv 2 \pmod{7}$

## Example 3: Finding Modular Inverse

**Problem**: Find $3^{-1} \bmod 11$

**Solution**:

Since $11$ is prime and $\gcd(3, 11) = 1$:
$$3^{10} \equiv 1 \pmod{11}$$

Therefore:
$$3^{-1} \equiv 3^{9} \pmod{11}$$

Calculate using successive squaring:
- $3^2 = 9$
- $3^4 \equiv 9^2 = 81 \equiv 4 \pmod{11}$
- $3^8 \equiv 4^2 = 16 \equiv 5 \pmod{11}$
- $3^9 = 3^8 \times 3 \equiv 5 \times 3 = 15 \equiv 4 \pmod{11}$

**Answer**: $3^{-1} \equiv 4 \pmod{11}$

**Verification**: $3 \times 4 = 12 \equiv 1 \pmod{11}$ ✓

## Example 4: Wilson's Theorem Application

**Problem**: Use Fermat's little theorem to prove that for prime $p$:
$$(p-1)! \equiv -1 \pmod{p}$$

**Solution**:

For each $a$ with $1 < a < p-1$, there exists unique $a^{-1} \bmod p$ with $1 < a^{-1} < p-1$.

By Fermat's little theorem: $a \cdot a^{-1} \equiv 1 \pmod{p}$

Pairing each element with its inverse in $(p-1)!$:
$$(p-1)! = 1 \times 2 \times 3 \times \cdots \times (p-1)$$

Only $a = 1$ and $a = p-1$ are self-inverse:
- $1^2 \equiv 1 \pmod{p}$
- $(p-1)^2 \equiv 1 \pmod{p}$

All other elements pair up to give $1$:
$$(p-1)! \equiv 1 \times (p-1) \equiv -1 \pmod{p}$$

**Q.E.D.**

***

# Applications

## 1. Primality Testing

**Fermat Primality Test**: If $a^{n-1} \not\equiv 1 \pmod{n}$ for some $a$ coprime to $n$, then $n$ is ==composite==.

**Algorithm**:
```Python
def fermat_primality_test(n, k=5):
    """
    Fermat primality test with k rounds
    Returns: True if probably prime, False if composite
    """
    import random

    if n < 2:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False

    for _ in range(k):
        a = random.randint(2, n - 1)
        if pow(a, n - 1, n) != 1:
            return False  # Definitely composite

    return True  # Probably prime

# Test
print(fermat_primality_test(17))  # True
print(fermat_primality_test(15))  # False
```

**Limitation**: ==Carmichael numbers== are composite but pass Fermat test for all $a$ coprime to $n$.

Example: $561 = 3 \times 11 \times 17$ passes Fermat test but is composite.

## 2. Computing Modular Inverses

For prime modulus $p$:
$$a^{-1} \equiv a^{p-2} \pmod{p}$$

This is simpler than using [[Extended Euclidean algorithm]] when $p$ is prime.

## 3. RSA Cryptography

In RSA with prime moduli, Fermat's theorem helps prove correctness:
$$M^{ed} \equiv M \pmod{p}$$

Combined with [[Chinese Remainder Theorem]], this proves RSA works.

## 4. Simplifying Modular Arithmetic

Reduce large exponents: $a^k \bmod p = a^{k \bmod (p-1)} \bmod p$ when $\gcd(a, p) = 1$

***

# Carmichael Numbers

A ==Carmichael number== is a composite number $n$ such that:
$$a^{n-1} \equiv 1 \pmod{n}$$

for all integers $a$ coprime to $n$.

**Examples**:
- $561 = 3 \times 11 \times 17$
- $1105 = 5 \times 13 \times 17$
- $1729 = 7 \times 13 \times 19$ (Ramanujan number)

**Implication**: Fermat primality test alone is insufficient. Use ==Miller-Rabin== test instead.

***

# Python Implementation

```Python
def fermat_little_theorem_verify(a, p):
    """Verify Fermat's little theorem: a^(p-1) ≡ 1 (mod p)"""
    if not is_prime_simple(p):
        return False, f"{p} is not prime"

    result = pow(a, p - 1, p)
    return result == 1, f"{a}^{p-1} mod {p} = {result}"

def is_prime_simple(n):
    """Simple primality check"""
    if n < 2:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False
    for i in range(3, int(n**0.5) + 1, 2):
        if n % i == 0:
            return False
    return True

def mod_inverse_fermat(a, p):
    """Compute modular inverse using Fermat's little theorem"""
    if not is_prime_simple(p):
        raise ValueError(f"{p} must be prime")
    if a % p == 0:
        raise ValueError(f"{a} must be coprime to {p}")

    # a^(-1) ≡ a^(p-2) (mod p)
    return pow(a, p - 2, p)

# Example 1: Verify theorem
print("Example 1: Verify 2^6 ≡ 1 (mod 7)")
valid, msg = fermat_little_theorem_verify(2, 7)
print(f"  {msg}")
print(f"  Valid: {valid}\n")

# Example 2: Compute large exponent
print("Example 2: Compute 5^100 mod 7")
p = 7
exponent = 100 % (p - 1)
result = pow(5, exponent, p)
print(f"  5^100 ≡ 5^{exponent} ≡ {result} (mod 7)\n")

# Example 3: Find modular inverse
print("Example 3: Find 3^(-1) mod 11")
inv = mod_inverse_fermat(3, 11)
print(f"  3^(-1) ≡ {inv} (mod 11)")
print(f"  Verification: 3 × {inv} = {3 * inv} ≡ {(3 * inv) % 11} (mod 11)\n")

# Example 4: Carmichael number
print("Example 4: Test Carmichael number 561")
n = 561
a = 2
result = pow(a, n - 1, n)
print(f"  {a}^{n-1} mod {n} = {result}")
print(f"  561 = 3 × 11 × 17 (composite!)")
print(f"  Fermat test passes but 561 is composite")
```

**Output**:
```
Example 1: Verify 2^6 ≡ 1 (mod 7)
  2^6 mod 7 = 1
  Valid: True

Example 2: Compute 5^100 mod 7
  5^100 ≡ 5^4 ≡ 2 (mod 7)

Example 3: Find 3^(-1) mod 11
  3^(-1) ≡ 4 (mod 11)
  Verification: 3 × 4 = 12 ≡ 1 (mod 11)

Example 4: Test Carmichael number 561
  2^560 mod 561 = 1
  561 = 3 × 11 × 17 (composite!)
  Fermat test passes but 561 is composite
```

***

# Relationship to Other Theorems

| Theorem | Modulus | Condition | Statement |
|---------|---------|-----------|-----------|
| Fermat's Little Theorem | Prime $p$ | $\gcd(a, p) = 1$ | $a^{p-1} \equiv 1 \pmod{p}$ |
| Euler's Theorem | Any $n$ | $\gcd(a, n) = 1$ | $a^{\phi(n)} \equiv 1 \pmod{n}$ |
| Wilson's Theorem | Prime $p$ | - | $(p-1)! \equiv -1 \pmod{p}$ |

**Note**: Fermat's little theorem is the special case of Euler's theorem when $n = p$ (prime).

***

# References

1. [[Euler theorem]] - Generalization to composite moduli
2. [[Euler Phi function]] - φ(p) = p - 1 for primes
3. [[RSA]] - Cryptographic applications
4. **Elementary Number Theory** - David M. Burton - 7th Edition - McGraw-Hill (2010)
   - Chapter 6: Fermat's theorem and primality testing
5. **Introduction to Modern Cryptography** - Jonathan Katz and Yehuda Lindell - 3rd Edition - Chapman & Hall/CRC (2020)
   - Chapter 11: Number-theoretic foundations
6. **A Classical Introduction to Modern Number Theory** - Kenneth Ireland and Michael Rosen - 2nd Edition - Springer (1990)
   - Chapter 3: Fermat's theorem and quadratic reciprocity
