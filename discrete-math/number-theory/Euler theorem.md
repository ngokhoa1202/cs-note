#number-theory #number-theoretic-function #multiplicative-function #cryptography #cybersecurity #asymmetric-cipher
# Euler's Theorem

Euler's Theorem is a ==generalization of Fermat's little theorem== to composite moduli. It is fundamental in RSA cryptography and modular arithmetic.

## Statement

**Theorem**: If $n \geq 1$ and $\gcd(a,n)=1$, then:

$$a^{\phi(n)} \equiv 1 \pmod{n}$$

where $\phi(n)$ is the [[Euler Phi function]].

**Special Case**: When $n$ is prime, $\phi(n) = n-1$, so Euler's theorem reduces to [[Fermat little theorem]]:
$$a^{p-1} \equiv 1 \pmod{p}$$

***

# Proof

Let $\{r_1, r_2, \ldots, r_{\phi(n)}\}$ be the set of all positive integers less than $n$ that are coprime to $n$.

**Step 1**: Consider the set $S = \{ar_1 \bmod n, ar_2 \bmod n, \ldots, ar_{\phi(n)} \bmod n\}$

**Step 2**: Each element in $S$ is coprime to $n$

Since $\gcd(a, n) = 1$ and $\gcd(r_i, n) = 1$, we have:
$$\gcd(ar_i, n) = 1$$

Therefore each $ar_i \bmod n$ is coprime to $n$.

**Step 3**: All elements in $S$ are distinct

Suppose $ar_i \equiv ar_j \pmod{n}$ for some $i \neq j$.

Then: $a(r_i - r_j) \equiv 0 \pmod{n}$

Since $\gcd(a, n) = 1$, we can cancel $a$:
$$r_i - r_j \equiv 0 \pmod{n}$$

This implies $r_i \equiv r_j \pmod{n}$.

But $0 < r_i, r_j < n$, so $r_i = r_j$, contradicting $i \neq j$.

**Step 4**: Therefore, $S$ is a ==permutation== of $\{r_1, r_2, \ldots, r_{\phi(n)}\}$

**Step 5**: Multiply all elements

$$ar_1 \cdot ar_2 \cdots ar_{\phi(n)} \equiv r_1 \cdot r_2 \cdots r_{\phi(n)} \pmod{n}$$

**Step 6**: Simplify

$$a^{\phi(n)} \prod_{i=1}^{\phi(n)} r_i \equiv \prod_{i=1}^{\phi(n)} r_i \pmod{n}$$

**Step 7**: Cancel the product

Since $\gcd(\prod r_i, n) = 1$ (each $r_i$ is coprime to $n$), we can divide both sides:

$$a^{\phi(n)} \equiv 1 \pmod{n}$$

**Q.E.D.**

***

# Examples

## Example 1: Basic Calculation

**Problem**: Compute $3^{100} \bmod 14$

**Solution**:

First, verify $\gcd(3, 14) = 1$ ✓

Calculate $\phi(14)$:
$$14 = 2 \times 7$$
$$\phi(14) = \phi(2) \times \phi(7) = 1 \times 6 = 6$$

By Euler's theorem:
$$3^6 \equiv 1 \pmod{14}$$

Express $100 = 16 \times 6 + 4$:
$$3^{100} = (3^6)^{16} \times 3^4 \equiv 1^{16} \times 3^4 \equiv 81 \pmod{14}$$
$$81 = 5 \times 14 + 11$$
$$3^{100} \equiv 11 \pmod{14}$$

**Verification**: $3^4 = 81 \equiv 11 \pmod{14}$ ✓

## Example 2: Finding Modular Inverse

**Problem**: Find $7^{-1} \bmod 40$

**Solution**:

Since $\gcd(7, 40) = 1$, the inverse exists.

Calculate $\phi(40)$:
$$40 = 2^3 \times 5$$
$$\phi(40) = \phi(2^3) \times \phi(5) = 4 \times 4 = 16$$

By Euler's theorem:
$$7^{16} \equiv 1 \pmod{40}$$

Therefore:
$$7^{15} \equiv 7^{-1} \pmod{40}$$

Calculate $7^{15} \bmod 40$ using fast exponentiation:
- $7^2 = 49 \equiv 9 \pmod{40}$
- $7^4 \equiv 9^2 = 81 \equiv 1 \pmod{40}$

Since $7^4 \equiv 1 \pmod{40}$, we have $15 = 3 \times 4 + 3$:
$$7^{15} = (7^4)^3 \times 7^3 \equiv 1 \times 343 \equiv 23 \pmod{40}$$

**Answer**: $7^{-1} \equiv 23 \pmod{40}$

**Verification**: $7 \times 23 = 161 = 4 \times 40 + 1 \equiv 1 \pmod{40}$ ✓

## Example 3: RSA Application

**Problem**: In RSA, prove that decryption works: $M^{ed} \equiv M \pmod{n}$

**Given**:
- $ed \equiv 1 \pmod{\phi(n)}$
- $n = pq$ where $p, q$ are distinct primes
- $M$ is the message

**Proof for Case 1**: $\gcd(M, n) = 1$

From $ed \equiv 1 \pmod{\phi(n)}$, we have $ed = k\phi(n) + 1$ for some integer $k$.

Therefore:
$$M^{ed} = M^{k\phi(n) + 1} = M \cdot (M^{\phi(n)})^k$$

By Euler's theorem, since $\gcd(M, n) = 1$:
$$M^{\phi(n)} \equiv 1 \pmod{n}$$

Therefore:
$$M^{ed} \equiv M \cdot 1^k \equiv M \pmod{n}$$

**Q.E.D.**

***

# Applications

## 1. RSA Cryptography

Euler's theorem is the ==mathematical foundation of RSA==:
- Key generation: Choose $e, d$ such that $ed \equiv 1 \pmod{\phi(n)}$
- Encryption/Decryption: $M^{ed} \equiv M \pmod{n}$

See [[RSA]] for complete details.

## 2. Modular Exponentiation

Reduce large exponents: $a^k \bmod n = a^{k \bmod \phi(n)} \bmod n$ when $\gcd(a,n)=1$

## 3. Computing Modular Inverses

For $a$ coprime to $n$:
$$a^{-1} \equiv a^{\phi(n)-1} \pmod{n}$$

This provides an alternative to [[Extended Euclidean algorithm]].

## 4. Fermat Primality Test

Based on Fermat's theorem (special case): if $a^{n-1} \not\equiv 1 \pmod{n}$, then $n$ is composite.

***

# Relationship to Other Theorems

| Theorem | Condition | Statement |
|---------|-----------|-----------|
| Euler's Theorem | $\gcd(a, n) = 1$ | $a^{\phi(n)} \equiv 1 \pmod{n}$ |
| Fermat's Little Theorem | $p$ is prime, $\gcd(a, p) = 1$ | $a^{p-1} \equiv 1 \pmod{p}$ |
| Fermat-Euler | $p$ is prime | $a^p \equiv a \pmod{p}$ (for all $a$) |

**Note**: Fermat's little theorem is a ==special case== of Euler's theorem when $n = p$ (prime), since $\phi(p) = p-1$.

***

# Python Implementation

```Python
def euler_phi(n):
    """Compute Euler's totient function φ(n)"""
    result = n
    p = 2
    while p * p <= n:
        if n % p == 0:
            # Remove factor p
            while n % p == 0:
                n //= p
            # Multiply result by (1 - 1/p)
            result -= result // p
        p += 1
    if n > 1:
        # n is a prime factor
        result -= result // n
    return result

def euler_theorem_verify(a, n):
    """Verify Euler's theorem: a^φ(n) ≡ 1 (mod n)"""
    import math

    if math.gcd(a, n) != 1:
        return False, "gcd(a, n) != 1"

    phi_n = euler_phi(n)
    result = pow(a, phi_n, n)

    return result == 1, f"{a}^{phi_n} mod {n} = {result}"

# Example 1: Verify Euler's theorem
print("Example 1: Verify 3^φ(14) ≡ 1 (mod 14)")
valid, msg = euler_theorem_verify(3, 14)
print(f"  {msg}")
print(f"  Valid: {valid}\n")

# Example 2: Compute large exponent
print("Example 2: Compute 3^100 mod 14")
phi_14 = euler_phi(14)
print(f"  φ(14) = {phi_14}")
exponent = 100 % phi_14  # Reduce exponent
result = pow(3, exponent, 14)
print(f"  3^100 ≡ 3^{exponent} ≡ {result} (mod 14)\n")

# Example 3: Find modular inverse
print("Example 3: Find 7^(-1) mod 40")
phi_40 = euler_phi(40)
inverse = pow(7, phi_40 - 1, 40)
print(f"  φ(40) = {phi_40}")
print(f"  7^(-1) ≡ 7^{phi_40-1} ≡ {inverse} (mod 40)")
print(f"  Verification: 7 × {inverse} = {7 * inverse} ≡ {(7 * inverse) % 40} (mod 40)")
```

**Output**:
```
Example 1: Verify 3^φ(14) ≡ 1 (mod 14)
  3^6 mod 14 = 1
  Valid: True

Example 2: Compute 3^100 mod 14
  φ(14) = 6
  3^100 ≡ 3^4 ≡ 11 (mod 14)

Example 3: Find 7^(-1) mod 40
  φ(40) = 16
  7^(-1) ≡ 7^15 ≡ 23 (mod 40)
  Verification: 7 × 23 = 161 ≡ 1 (mod 40)
```

***

# References

1. [[Euler Phi function]] - Definition and computation of φ(n)
2. [[Fermat little theorem]] - Special case when n is prime
3. [[RSA]] - Cryptographic application
4. **Elementary Number Theory** - David M. Burton - 7th Edition - McGraw-Hill (2010)
   - Chapter 7: Euler's theorem and applications
5. **Introduction to Modern Cryptography** - Jonathan Katz and Yehuda Lindell - 3rd Edition - Chapman & Hall/CRC (2020)
   - Chapter 11: Number-theoretic foundations of RSA
