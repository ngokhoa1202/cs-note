#number-theory #cryptography #algorithm #asymmetric-cipher #modular-arithmetic
# Extended Euclidean Algorithm

The ==Extended Euclidean Algorithm== (EEA) is an extension of Euclid's GCD algorithm that not only finds the ==greatest common divisor== of two integers but also expresses it as a ==linear combination== of those integers. This is fundamental for computing modular inverses in RSA cryptography.

## Problem Statement

**Input**: Two positive integers $a, b > 0$

**Output**: Integers $s, t$ and $\gcd(a, b)$ such that:
$$as + bt = \gcd(a, b)$$

This equation is a form of [[Diophantine equation]] known as ==Bézout's identity==.

***

# Algorithm

## Initialization

$$s_0 = 1, \quad t_0 = 0$$
$$s_1 = 0, \quad t_1 = 1$$
$$r_0 = a, \quad r_1 = b$$

## Iteration

Repeat until $r_i = 0$:

$$r_i = r_{i-2} \bmod r_{i-1}$$

$$q_{i-1} = \left\lfloor\frac{r_{i-2}}{r_{i-1}}\right\rfloor$$

$$\begin{cases}
s_i = s_{i-2} - q_{i-1} \times s_{i-1} \\
t_i = t_{i-2} - q_{i-1} \times t_{i-1}
\end{cases}$$

## Termination

When $r_i = 0$:
$$\gcd(a, b) = r_{i-1}$$
$$s = s_{i-1}, \quad t = t_{i-1}$$

***

# Proof of Correctness

## Invariant

At each step $i$, we maintain:
$$as_i + bt_i = r_i$$

**Proof by induction**:

**Base case** ($i = 0, 1$):
- $as_0 + bt_0 = a \times 1 + b \times 0 = a = r_0$ ✓
- $as_1 + bt_1 = a \times 0 + b \times 1 = b = r_1$ ✓

**Inductive step**: Assume $as_{i-1} + bt_{i-1} = r_{i-1}$ and $as_{i-2} + bt_{i-2} = r_{i-2}$.

From the division algorithm:
$$r_{i-2} = q_{i-1} \times r_{i-1} + r_i$$
$$r_i = r_{i-2} - q_{i-1} \times r_{i-1}$$

Substitute invariants:
$$r_i = (as_{i-2} + bt_{i-2}) - q_{i-1}(as_{i-1} + bt_{i-1})$$
$$r_i = a(s_{i-2} - q_{i-1}s_{i-1}) + b(t_{i-2} - q_{i-1}t_{i-1})$$
$$r_i = as_i + bt_i$$

Therefore the invariant holds for all $i$.

**Termination**: When $r_i = 0$, we have $\gcd(a, b) = r_{i-1}$ by Euclidean algorithm.

From the invariant:
$$as_{i-1} + bt_{i-1} = r_{i-1} = \gcd(a, b)$$

**Q.E.D.**

***

# Examples

## Example 1: Step-by-Step Calculation

**Problem**: Find $s, t$ such that $240s + 46t = \gcd(240, 46)$

**Solution**:

| $i$ | $r_{i-2}$ | $r_{i-1}$ | $q_{i-1}$ | $r_i$ | $s_i$ | $t_i$ |
|-----|-----------|-----------|-----------|-------|-------|-------|
| 0 | - | - | - | 240 | 1 | 0 |
| 1 | - | - | - | 46 | 0 | 1 |
| 2 | 240 | 46 | 5 | 10 | $1 - 5 \times 0 = 1$ | $0 - 5 \times 1 = -5$ |
| 3 | 46 | 10 | 4 | 6 | $0 - 4 \times 1 = -4$ | $1 - 4 \times (-5) = 21$ |
| 4 | 10 | 6 | 1 | 4 | $1 - 1 \times (-4) = 5$ | $-5 - 1 \times 21 = -26$ |
| 5 | 6 | 4 | 1 | 2 | $-4 - 1 \times 5 = -9$ | $21 - 1 \times (-26) = 47$ |
| 6 | 4 | 2 | 2 | 0 | $5 - 2 \times (-9) = 23$ | $-26 - 2 \times 47 = -120$ |

**Result**:
- $\gcd(240, 46) = 2$
- $s = -9$, $t = 47$

**Verification**:
$$240 \times (-9) + 46 \times 47 = -2160 + 2162 = 2$$ ✓

## Example 2: Finding Modular Inverse

**Problem**: Find $17^{-1} \bmod 3120$

This means finding $d$ such that $17d \equiv 1 \pmod{3120}$.

**Solution**:

We need: $17d + 3120k = 1$ for some integers $d, k$.

This is equivalent to: $17d + 3120k = \gcd(17, 3120)$

Run Extended Euclidean Algorithm:

```
3120 = 183 × 17 + 9
17 = 1 × 9 + 8
9 = 1 × 8 + 1
8 = 8 × 1 + 0
```

**Backward substitution**:

$$1 = 9 - 1 \times 8$$
$$1 = 9 - 1 \times (17 - 1 \times 9) = 2 \times 9 - 1 \times 17$$
$$1 = 2 \times (3120 - 183 \times 17) - 1 \times 17$$
$$1 = 2 \times 3120 - 367 \times 17$$

Therefore: $-367 \times 17 \equiv 1 \pmod{3120}$

Since we want positive inverse:
$$d = -367 + 3120 = 2753$$

**Verification**: $17 \times 2753 = 46801 = 15 \times 3120 + 1$ ✓

**Answer**: $17^{-1} \equiv 2753 \pmod{3120}$

## Example 3: RSA Key Generation

**Problem**: In RSA with $p = 61, q = 53, e = 17$, find private key $d$.

**Given**:
- $n = 61 \times 53 = 3233$
- $\phi(n) = 60 \times 52 = 3120$
- $e = 17$

**Find**: $d$ such that $ed \equiv 1 \pmod{\phi(n)}$

This is the same as Example 2: $d = 2753$

***

# Python Implementation

## Basic Implementation

```Python
def extended_gcd(a, b):
    """
    Extended Euclidean Algorithm
    Returns: (gcd, x, y) such that ax + by = gcd(a, b)
    """
    if b == 0:
        return a, 1, 0

    gcd, x1, y1 = extended_gcd(b, a % b)

    # Update x and y using results from recursive call
    x = y1
    y = x1 - (a // b) * y1

    return gcd, x, y

# Example 1
a, b = 240, 46
gcd, s, t = extended_gcd(a, b)
print(f"gcd({a}, {b}) = {gcd}")
print(f"{a} × {s} + {b} × {t} = {gcd}")
print(f"Verification: {a * s + b * t}")
```

**Output**:
```
gcd(240, 46) = 2
240 × -9 + 46 × 47 = 2
Verification: 2
```

## Modular Inverse Function

```Python
def mod_inverse(a, m):
    """
    Compute modular inverse of a modulo m
    Returns: a^(-1) mod m, or raises ValueError if inverse doesn't exist
    """
    gcd, x, y = extended_gcd(a, m)

    if gcd != 1:
        raise ValueError(f"Modular inverse does not exist (gcd({a}, {m}) = {gcd})")

    # Ensure positive result
    return x % m

# Example 2: Find 17^(-1) mod 3120
e = 17
phi = 3120
d = mod_inverse(e, phi)
print(f"\n{e}^(-1) mod {phi} = {d}")
print(f"Verification: {e} × {d} mod {phi} = {(e * d) % phi}")
```

**Output**:
```
17^(-1) mod 3120 = 2753
Verification: 17 × 2753 mod 3120 = 1
```

## Iterative Implementation

```Python
def extended_gcd_iterative(a, b):
    """Iterative version of Extended Euclidean Algorithm"""
    # Initialize
    old_r, r = a, b
    old_s, s = 1, 0
    old_t, t = 0, 1

    while r != 0:
        quotient = old_r // r

        # Update r
        old_r, r = r, old_r - quotient * r

        # Update s
        old_s, s = s, old_s - quotient * s

        # Update t
        old_t, t = t, old_t - quotient * t

    return old_r, old_s, old_t

# Test
a, b = 240, 46
gcd, s, t = extended_gcd_iterative(a, b)
print(f"\nIterative version:")
print(f"gcd({a}, {b}) = {gcd}")
print(f"{a} × {s} + {b} × {t} = {a * s + b * t}")
```

## Complete RSA Example

```Python
def generate_rsa_keys_small(p, q, e):
    """Generate RSA keys for small primes (educational)"""
    import math

    # Compute n and φ(n)
    n = p * q
    phi = (p - 1) * (q - 1)

    # Check e is coprime to φ(n)
    if math.gcd(e, phi) != 1:
        raise ValueError(f"e = {e} is not coprime to φ(n) = {phi}")

    # Compute private exponent d using Extended Euclidean Algorithm
    d = mod_inverse(e, phi)

    return {
        'public': (e, n),
        'private': (d, n),
        'p': p,
        'q': q,
        'phi': phi
    }

# Example: RSA key generation
p, q, e = 61, 53, 17
keys = generate_rsa_keys_small(p, q, e)

print(f"\nRSA Key Generation:")
print(f"  Primes: p = {p}, q = {q}")
print(f"  Modulus: n = {keys['public'][1]}")
print(f"  φ(n) = {keys['phi']}")
print(f"  Public exponent: e = {e}")
print(f"  Private exponent: d = {keys['private'][0]}")
print(f"\nVerification: e × d mod φ(n) = {(e * keys['private'][0]) % keys['phi']}")
```

**Output**:
```
RSA Key Generation:
  Primes: p = 61, q = 53
  Modulus: n = 3233
  φ(n) = 3120
  Public exponent: e = 17
  Private exponent: d = 2753

Verification: e × d mod φ(n) = 1
```

***

# Applications

## 1. Computing Modular Inverses

The primary application is finding $a^{-1} \bmod m$ when $\gcd(a, m) = 1$.

Used in:
- [[RSA]] cryptography (computing private key $d$)
- [[Euler theorem|Euler's theorem]] applications
- Solving linear congruences

## 2. Solving Linear Congruences

Solve $ax \equiv c \pmod{m}$:

1. Find $\gcd(a, m)$ using EEA
2. If $\gcd(a, m) \nmid c$, no solution exists
3. Otherwise, $x \equiv c \cdot a^{-1} \pmod{m/\gcd(a,m)}$

## 3. Chinese Remainder Theorem

EEA is used to compute the ==Garner coefficients== in [[Chinese Remainder Theorem]]:
$$q_{\text{inv}} = q^{-1} \bmod p$$

## 4. Cryptographic Protocols

- **RSA**: Computing private exponent $d$ from public exponent $e$
- **Diffie-Hellman**: Computing shared secrets
- **ElGamal**: Key generation and encryption

***

# Complexity Analysis

| Operation | Complexity |
|-----------|-----------|
| Basic Euclidean Algorithm | $O(\log \min(a, b))$ |
| Extended Euclidean Algorithm | $O(\log \min(a, b))$ |
| Modular Inverse | $O(\log m)$ |

**Space Complexity**:
- Recursive: $O(\log \min(a, b))$ (call stack)
- Iterative: $O(1)$

**Number of Iterations**:

At most $\lceil \log_\phi(\min(a, b)) \rceil$ where $\phi = \frac{1 + \sqrt{5}}{2}$ (golden ratio).

For consecutive Fibonacci numbers $F_n, F_{n+1}$, the algorithm takes exactly $n-1$ steps (worst case).

***

# Comparison with Other Methods

| Method | Use Case | Complexity | Notes |
|--------|----------|-----------|-------|
| Extended Euclidean | General modular inverse | $O(\log m)$ | Works for any modulus |
| [[Fermat little theorem\|Fermat's theorem]] | Prime modulus | $O(\log^2 p)$ | $a^{-1} \equiv a^{p-2} \pmod{p}$ |
| [[Euler theorem\|Euler's theorem]] | Coprime to modulus | $O(\log^2 m)$ | $a^{-1} \equiv a^{\phi(m)-1} \pmod{m}$ |

**When to use EEA**:
- Always works when $\gcd(a, m) = 1$
- More efficient than exponentiation methods
- Needed when modulus is not prime
- Required for RSA key generation

***

# References

1. [[Diophantine equation]] - Linear Diophantine equations and Bézout's identity
2. [[RSA]] - Cryptographic application for computing private keys
3. [[Chinese Remainder Theorem]] - Computing modular inverses for CRT
4. [[Euler theorem]] - Alternative method using Euler's theorem
5. **Elementary Number Theory** - David M. Burton - 7th Edition - McGraw-Hill (2010)
   - Chapter 2: Euclidean Algorithm and its applications
6. **Introduction to Algorithms** - Cormen, Leiserson, Rivest, Stein - 4th Edition - MIT Press (2022)
   - Chapter 31: Number-Theoretic Algorithms
7. **Handbook of Applied Cryptography** - Menezes, van Oorschot, Vanstone - CRC Press (1996)
   - Section 2.1: The integers and division algorithm
   - http://cacr.uwaterloo.ca/hac/
