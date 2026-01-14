#number-theory #algorithm #cryptography #modular-arithmetic #asymmetric-cipher
# Fast Modular Exponentiation

==Fast Modular Exponentiation== (also called ==binary exponentiation== or ==exponentiation by squaring==) is an efficient algorithm for computing $a^b \bmod n$ in $O(\log b)$ time. This is crucial for RSA cryptography where exponents can be thousands of bits long.

## Problem Statement

**Input**: Base $a$, exponent $b$, modulus $n$

**Output**: $a^b \bmod n$

**Naive approach**: $O(b)$ multiplications - impractical for $b \approx 2^{2048}$

**Fast approach**: $O(\log b)$ multiplications using binary representation

***

# Algorithm: Square-and-Multiply

## Mathematical Principle

Express exponent in binary: $b = (b_k b_{k-1} \cdots b_1 b_0)_2$

Then:
$$a^b = a^{\sum_{i=0}^{k} b_i \cdot 2^i} = \prod_{i=0}^{k} (a^{2^i})^{b_i}$$

For each bit position, we can compute:
- $a^{2^0} = a$
- $a^{2^1} = (a^{2^0})^2 = a^2$
- $a^{2^2} = (a^{2^1})^2 = a^4$
- $a^{2^i} = (a^{2^{i-1}})^2$

Multiply together only where $b_i = 1$.

## Iterative Algorithm

```
result = 1
base = a mod n

while b > 0:
    if b is odd:
        result = (result × base) mod n
    base = (base × base) mod n
    b = b >> 1  // Right shift (divide by 2)

return result
```

## Right-to-Left Binary Method

Process bits from least significant to most significant:

**Example**: Compute $7^{13} \bmod 11$

$13 = (1101)_2 = 2^3 + 2^2 + 2^0 = 8 + 4 + 1$

| Iteration | $b$ | Binary | Bit | result | base | Note |
|-----------|-----|--------|-----|--------|------|------|
| Initial | 13 | 1101 | - | 1 | 7 | - |
| 1 | 13 | 1101 | 1 (odd) | $1 \times 7 = 7$ | $7^2 = 49 \equiv 5 \pmod{11}$ | $b \to 6$ |
| 2 | 6 | 0110 | 0 (even) | 7 | $5^2 = 25 \equiv 3 \pmod{11}$ | $b \to 3$ |
| 3 | 3 | 0011 | 1 (odd) | $7 \times 3 = 21 \equiv 10 \pmod{11}$ | $3^2 = 9 \pmod{11}$ | $b \to 1$ |
| 4 | 1 | 0001 | 1 (odd) | $10 \times 9 = 90 \equiv 2 \pmod{11}$ | $9^2 \equiv 4 \pmod{11}$ | $b \to 0$ |

**Result**: $7^{13} \equiv 2 \pmod{11}$

**Verification**: $7^{13} = 96889010407 = 8808091855 \times 11 + 2$ ✓

## Left-to-Right Binary Method

Process bits from most significant to least significant:

**Example**: Compute $5^{13} \bmod 11$

$13 = (1101)_2$

| Bit | result | Operation |
|-----|--------|-----------|
| 1 | 1 | $result = (1^2 \times 5) \bmod 11 = 5$ |
| 1 | 5 | $result = (5^2 \times 5) \bmod 11 = 125 \equiv 4 \pmod{11}$ |
| 0 | 4 | $result = (4^2 \times 1) \bmod 11 = 16 \equiv 5 \pmod{11}$ |
| 1 | 5 | $result = (5^2 \times 5) \bmod 11 = 125 \equiv 4 \pmod{11}$ |

**Result**: $5^{13} \equiv 4 \pmod{11}$

***

# Examples

## Example 1: RSA Encryption

**Problem**: Encrypt message $M = 123$ with public key $(e=17, n=3233)$

Compute: $C = 123^{17} \bmod 3233$

**Solution**:

$17 = (10001)_2 = 16 + 1 = 2^4 + 2^0$

Compute powers of 2:
- $123^1 = 123$
- $123^2 = 15129 \equiv 1527 \pmod{3233}$
- $123^4 \equiv 1527^2 = 2331729 \equiv 2221 \pmod{3233}$
- $123^8 \equiv 2221^2 = 4932841 \equiv 2088 \pmod{3233}$
- $123^{16} \equiv 2088^2 = 4359744 \equiv 2790 \pmod{3233}$

Combine (bits 0 and 4 are set):
$$123^{17} = 123^{16} \times 123^1 \equiv 2790 \times 123 \pmod{3233}$$
$$= 343170 \equiv 855 \pmod{3233}$$

**Answer**: $C = 855$

## Example 2: Large Exponent Reduction

**Problem**: Compute $3^{100} \bmod 14$

**Solution**:

Using [[Euler theorem]]: $\phi(14) = 6$, so $3^6 \equiv 1 \pmod{14}$

Reduce exponent: $100 = 16 \times 6 + 4$

Compute $3^4 \bmod 14$:

$4 = (100)_2$

| Iteration | Bit | result | base |
|-----------|-----|--------|------|
| Initial | - | 1 | 3 |
| 1 | 0 | 1 | $3^2 = 9$ |
| 2 | 0 | 1 | $9^2 = 81 \equiv 11 \pmod{14}$ |
| 3 | 1 | $1 \times 11 = 11$ | - |

But we need $3^4 = 81 \equiv 11 \pmod{14}$

Actually, let's compute properly:
- $3^2 = 9$
- $3^4 = 9^2 = 81 = 5 \times 14 + 11 \equiv 11 \pmod{14}$

**Answer**: $3^{100} \equiv 11 \pmod{14}$

## Example 3: Computing $2^{256} \bmod 100$

**Problem**: Compute $2^{256} \bmod 100$

**Solution**:

Use [[Euler theorem]]: $\phi(100) = \phi(4) \times \phi(25) = 2 \times 20 = 40$

Since $\gcd(2, 100) \neq 1$, we can't directly apply Euler's theorem.

Use repeated squaring:

$256 = (100000000)_2$

- $2^1 = 2$
- $2^2 = 4$
- $2^4 = 16$
- $2^8 = 256 \equiv 56 \pmod{100}$
- $2^{16} \equiv 56^2 = 3136 \equiv 36 \pmod{100}$
- $2^{32} \equiv 36^2 = 1296 \equiv 96 \pmod{100}$
- $2^{64} \equiv 96^2 = 9216 \equiv 16 \pmod{100}$
- $2^{128} \equiv 16^2 = 256 \equiv 56 \pmod{100}$
- $2^{256} \equiv 56^2 = 3136 \equiv 36 \pmod{100}$

**Answer**: $2^{256} \equiv 36 \pmod{100}$

***

# Python Implementation

## Basic Implementation

```Python
def mod_exp(base, exponent, modulus):
    """
    Fast modular exponentiation: base^exponent mod modulus
    Complexity: O(log exponent)
    """
    result = 1
    base = base % modulus

    while exponent > 0:
        # If exponent is odd, multiply base with result
        if exponent % 2 == 1:
            result = (result * base) % modulus

        # Square the base and halve the exponent
        exponent = exponent >> 1  # Divide by 2
        base = (base * base) % modulus

    return result

# Example 1: RSA encryption
print("Example 1: 123^17 mod 3233")
c = mod_exp(123, 17, 3233)
print(f"  Result: {c}\n")

# Example 2: Large exponent
print("Example 2: 3^100 mod 14")
result = mod_exp(3, 100, 14)
print(f"  Result: {result}\n")

# Example 3: Very large exponent
print("Example 3: 2^256 mod 100")
result = mod_exp(2, 256, 100)
print(f"  Result: {result}")
```

**Output**:
```
Example 1: 123^17 mod 3233
  Result: 855

Example 2: 3^100 mod 14
  Result: 11

Example 3: 2^256 mod 100
  Result: 36
```

## Left-to-Right Binary Method

```Python
def mod_exp_left_to_right(base, exponent, modulus):
    """Left-to-right binary exponentiation"""
    if exponent == 0:
        return 1

    # Get binary representation (without '0b' prefix)
    binary = bin(exponent)[2:]

    result = 1
    for bit in binary:
        result = (result * result) % modulus
        if bit == '1':
            result = (result * base) % modulus

    return result

# Test
print("\nLeft-to-right method:")
print(f"7^13 mod 11 = {mod_exp_left_to_right(7, 13, 11)}")
```

## Recursive Implementation

```Python
def mod_exp_recursive(base, exponent, modulus):
    """Recursive fast modular exponentiation"""
    if exponent == 0:
        return 1

    if exponent % 2 == 0:
        # Even exponent: a^(2k) = (a^k)^2
        half = mod_exp_recursive(base, exponent // 2, modulus)
        return (half * half) % modulus
    else:
        # Odd exponent: a^(2k+1) = a × a^(2k)
        return (base * mod_exp_recursive(base, exponent - 1, modulus)) % modulus

# Test
print("\nRecursive method:")
print(f"5^13 mod 11 = {mod_exp_recursive(5, 13, 11)}")
```

## Complete RSA Example

```Python
def rsa_encrypt_decrypt_example():
    """Complete RSA encryption/decryption using fast modular exponentiation"""

    # RSA parameters (small example)
    p, q = 61, 53
    n = p * q  # 3233
    phi = (p - 1) * (q - 1)  # 3120

    e = 17  # Public exponent
    d = 2753  # Private exponent (from Extended Euclidean Algorithm)

    # Message
    message = 123

    # Encrypt: C = M^e mod n
    ciphertext = mod_exp(message, e, n)
    print(f"Original message: {message}")
    print(f"Encrypted: {ciphertext}")

    # Decrypt: M = C^d mod n
    decrypted = mod_exp(ciphertext, d, n)
    print(f"Decrypted: {decrypted}")

    # Verify
    assert message == decrypted
    print("✓ Encryption/Decryption successful!")

print("\nRSA Example:")
rsa_encrypt_decrypt_example()
```

**Output**:
```
RSA Example:
Original message: 123
Encrypted: 855
Decrypted: 123
✓ Encryption/Decryption successful!
```

***

# Complexity Analysis

| Method | Time Complexity | Space Complexity | Multiplications |
|--------|----------------|------------------|-----------------|
| Naive | $O(b)$ | $O(1)$ | $b$ |
| Fast Exponentiation | $O(\log b)$ | $O(1)$ iterative | $\approx 1.5 \log_2 b$ |
| | | $O(\log b)$ recursive | |

**Detailed Analysis**:

For $b$-bit exponent:
- **Squarings**: Exactly $b$ squarings (one per bit)
- **Multiplications**: Average $b/2$ multiplications (for half the bits that are 1)
- **Total**: $\approx 1.5b$ modular multiplications

**Example**: For RSA-2048 with 2048-bit exponent:
- Naive: $2^{2048}$ multiplications (impossible!)
- Fast: $\approx 3072$ multiplications (feasible)

***

# Optimizations

## 1. Montgomery Multiplication

For many exponentiations with same modulus, precompute ==Montgomery form==:
- Speedup: $\approx 2\times$ for large moduli
- Used in production RSA implementations

## 2. Sliding Window Method

Instead of processing 1 bit at a time, process $k$ bits:
- Window size $k = 4$ typical
- Precompute $a^1, a^3, a^5, \ldots, a^{2^k-1}$
- Speedup: $\approx 20\%$

## 3. Chinese Remainder Theorem

For RSA decryption with known $p, q$:
- Compute $M_p = C^{d_p} \bmod p$ and $M_q = C^{d_q} \bmod q$
- Combine with CRT
- Speedup: $\approx 4\times$ (see [[Chinese Remainder Theorem]])

## 4. Constant-Time Implementation

To prevent ==timing attacks==, always perform same number of operations:

```Python
def mod_exp_constant_time(base, exponent, modulus):
    """Constant-time modular exponentiation (timing attack resistant)"""
    result = 1
    base = base % modulus

    # Process all bits of maximum size
    bit_length = exponent.bit_length()

    for i in range(bit_length):
        # Always multiply, conditionally use result
        bit = (exponent >> i) & 1
        temp = (result * base) % modulus

        # Constant-time conditional: avoid branching
        result = (bit * temp + (1 - bit) * result) % modulus

        # Always square
        base = (base * base) % modulus

    return result
```

***

# Applications

## 1. RSA Cryptography

- **Encryption**: $C = M^e \bmod n$ where $e \approx 2^{16}$
- **Decryption**: $M = C^d \bmod n$ where $d \approx 2^{2048}$
- Without fast exponentiation, RSA would be impractical

## 2. Diffie-Hellman Key Exchange

Compute $g^a \bmod p$ where $a$ is secret, $g, p$ are public.

## 3. Digital Signatures

- **Sign**: $S = H(M)^d \bmod n$
- **Verify**: $H(M) \stackrel{?}{=} S^e \bmod n$

## 4. Primality Testing

- **Fermat test**: Check if $a^{n-1} \equiv 1 \pmod{n}$
- **Miller-Rabin**: Repeated squaring to detect non-trivial square roots

## 5. Discrete Logarithm

Computing $g^x \bmod p$ for various cryptographic protocols.

***

# Security Considerations

## Timing Attacks

**Vulnerability**: Execution time reveals secret exponent bits.

**Attack**: Measure decryption time for many ciphertexts.

**Mitigation**:
- Constant-time implementation (always same operations)
- Blinding (randomize ciphertext before decryption)
- Montgomery ladder

## Side-Channel Attacks

**Vulnerabilities**:
- Power consumption varies during multiplication
- Cache timing reveals memory access patterns

**Mitigations**:
- Hardware countermeasures
- Algorithmic blinding
- Constant-time algorithms

***

# References

1. [[RSA]] - Primary application in RSA cryptography
2. [[Euler theorem]] - Reducing exponents modulo φ(n)
3. [[Chinese Remainder Theorem]] - CRT optimization for RSA
4. [[Fermat little theorem]] - Primality testing application
5. **The Art of Computer Programming, Volume 2** - Donald Knuth - 3rd Edition - Addison-Wesley (1997)
   - Section 4.6.3: Evaluation of powers
6. **Handbook of Applied Cryptography** - Menezes, van Oorschot, Vanstone - CRC Press (1996)
   - Section 14.6: Exponentiation
   - http://cacr.uwaterloo.ca/hac/
7. **Introduction to Algorithms** - Cormen, Leiserson, Rivest, Stein - 4th Edition - MIT Press (2022)
   - Chapter 31.6: Powers of an element
8. **Modern Computer Arithmetic** - Richard Brent and Paul Zimmermann - Cambridge University Press (2010)
   - Chapter 2: Modular arithmetic
