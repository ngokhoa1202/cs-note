#cybersecurity #asymmetric-cipher #cryptography #rsa #number-theory #public-key
# RSA Cryptosystem
- RSA is the ==backbone of asymmetric cryptography==, invented in 1977 by Ron Rivest, Adi Shamir, and Leonard Adleman. It is a ==public-key cryptosystem== used for secure data transmission and digital signatures.

## Key Characteristics
- **Algorithm Type**: Asymmetric block cipher
- **Key Sizes**: 1024, 2048, 3072, 4096 bits (2048+ recommended)
- **Security Basis**: Computational hardness of ==integer factorization==
- **Block Size**: $i$ bits where $2^i < n \leq 2^{i+1}$
- **Applications**: Encryption, digital signatures, key exchange
- **Standards**: PKCS#1, RFC 8017, FIPS 186-4
# Algorithm

## Key Generation

- The security of RSA depends on proper key generation.
### 1. Select Two Large Prime Numbers
- Choose distinct primes $p$ and $q$
- Typically 1024 bits each for 2048-bit RSA
- Must be ==cryptographically random== and sufficiently large
- Should satisfy: $|p - q|$ is not too small (avoid Fermat factorization)

### 2. Calculate modulus
$$n = p \times q$$

- This is the ==RSA modulus==. The size of $n$ (in bits) is the ==key size==.

### 3. Compute Euler's Totient
$$\phi(n) = (p-1)(q-1)$$

- This value must be kept ==secret== (knowing $\phi(n)$ allows factoring $n$).

### 4. Choose public Exponent
- Select $e$ such that:
    - $1 < e < \phi(n)$
    - $\gcd(e, \phi(n)) = 1$
- Common choices:
    - $e = 3$ (fast, but requires careful padding)
    - $e = 17$
    - $e = 65537 = 2^{16} + 1$ (F4, most common - fast and secure)

### 5. Calculate private exponent 
- Find $d$ such that:
$$d \equiv e^{-1} \pmod{\phi(n)}$$
$$ed \equiv 1 \pmod{\phi(n)}$$

- Use the ==Extended Euclidean Algorithm== to find $d$.

### Output
- Public key: $(e, n)$
- Private key: $(d, n)$ or $(d, p, q)$ for CRT optimization
## Encryption

- Given plaintext $M$ where $0 \leq M < n$:

$$C = M^e \bmod n$$

- Deterministic (same plaintext always produces same ciphertext)
- Requires padding for semantic security
- Message must be smaller than modulus
## Decryption

- Given ciphertext $C$: $$M = C^d \bmod n$$$$M = (M^e)^d \bmod n = M^{ed} \bmod n$$

# Mathematical proof
## Statement
-  The equation needs proving $M^{ed} \equiv M \pmod{n}$
## Proof
- From key generation: $ed \equiv 1 \pmod{\phi(n)}$. This means: $ed = k\phi(n) + 1$ for some integer $k$. Therefore:
$$M^{ed} = M^{k\phi(n) + 1} = M \cdot (M^{\phi(n)})^k$$

**Case 1**: $\gcd(M, n) = 1$

By Euler's theorem: $M^{\phi(n)} \equiv 1 \pmod{n}$

Therefore:
$$M^{ed} \equiv M \cdot 1^k \equiv M \pmod{n}$$

**Case 2**: $\gcd(M, n) \neq 1$

Since $n = pq$ and both are prime, either:
- $M \equiv 0 \pmod{p}$ and $\gcd(M, q) = 1$, or
- $M \equiv 0 \pmod{q}$ and $\gcd(M, p) = 1$

Assume $M \equiv 0 \pmod{p}$ and $\gcd(M, q) = 1$:

**Modulo $p$**:
$$M^{ed} \equiv 0^{ed} \equiv 0 \equiv M \pmod{p}$$

**Modulo $q$**:
Since $ed = k(p-1)(q-1) + 1$:
$$M^{ed} = M \cdot M^{k(p-1)(q-1)}$$

By Fermat's little theorem: $M^{q-1} \equiv 1 \pmod{q}$

Therefore:
$$M^{ed} \equiv M \cdot (M^{q-1})^{k(p-1)} \equiv M \cdot 1 \equiv M \pmod{q}$$

**By Chinese Remainder Theorem**:

Since $M^{ed} \equiv M \pmod{p}$ and $M^{ed} \equiv M \pmod{q}$, and $\gcd(p, q) = 1$:

$$M^{ed} \equiv M \pmod{pq} = M \pmod{n}$$

**Q.E.D.**

# Examples

## Example 1: Small RSA (Educational)

**Key Generation**:

1. Choose primes: $p = 61$, $q = 53$

2. Compute modulus: $n = 61 \times 53 = 3233$

3. Compute totient: $\phi(n) = (61-1)(53-1) = 60 \times 52 = 3120$

4. Choose public exponent: $e = 17$ (verify $\gcd(17, 3120) = 1$ ✓)

5. Find private exponent $d$ where $17d \equiv 1 \pmod{3120}$

**Extended Euclidean Algorithm**:

```
Step 1: Express gcd(3120, 17) as linear combination

3120 = 183 × 17 + 9
17 = 1 × 9 + 8
9 = 1 × 8 + 1
8 = 8 × 1 + 0

Backward substitution:
1 = 9 - 1 × 8
1 = 9 - 1 × (17 - 1 × 9) = 2 × 9 - 1 × 17
1 = 2 × (3120 - 183 × 17) - 1 × 17
1 = 2 × 3120 - 367 × 17

Therefore: -367 × 17 ≡ 1 (mod 3120)
d = -367 + 3120 = 2753
```

**Verification**: $17 \times 2753 = 46801 = 15 \times 3120 + 1$ ✓

**Keys**:
- Public key: $(e=17, n=3233)$
- Private key: $(d=2753, n=3233)$

**Encryption**: Message $M = 123$

$$C = 123^{17} \bmod 3233$$

Using ==fast modular exponentiation== (binary method):

$17 = 16 + 1 = 2^4 + 2^0 = (10001)_2$

```
123^1 ≡ 123 (mod 3233)
123^2 ≡ 15129 ≡ 1527 (mod 3233)
123^4 ≡ 1527^2 = 2331729 ≡ 2221 (mod 3233)
123^8 ≡ 2221^2 = 4932841 ≡ 2088 (mod 3233)
123^16 ≡ 2088^2 = 4359744 ≡ 2790 (mod 3233)

123^17 = 123^16 × 123^1
       ≡ 2790 × 123 (mod 3233)
       ≡ 343170 (mod 3233)
       ≡ 855 (mod 3233)
```

**Ciphertext**: $C = 855$

**Decryption**: $M = 855^{2753} \bmod 3233$

Using fast exponentiation (implementation shown later), we get: $M = 123$ ✓

## Example 2: Extended Euclidean Algorithm Implementation

**Problem**: Find $d$ such that $ed \equiv 1 \pmod{\phi(n)}$

**Algorithm**:

```
Extended_GCD(a, b):
    if b = 0:
        return (a, 1, 0)  // gcd, x, y where ax + by = gcd
    else:
        (g, x1, y1) = Extended_GCD(b, a mod b)
        x = y1
        y = x1 - (a div b) × y1
        return (g, x, y)
```

**Example**: Find $d$ where $65537d \equiv 1 \pmod{3120}$

```Python
def extended_gcd(a, b):
    if b == 0:
        return a, 1, 0
    gcd, x1, y1 = extended_gcd(b, a % b)
    x = y1
    y = x1 - (a // b) * y1
    return gcd, x, y

def mod_inverse(e, phi):
    gcd, x, y = extended_gcd(e, phi)
    if gcd != 1:
        raise ValueError("Modular inverse does not exist")
    return x % phi

e = 65537
phi = 3120
d = mod_inverse(e, phi)
print(f"d = {d}")
print(f"Verification: {(e * d) % phi}")  # Should be 1
```

Output:
```
d = 2753
Verification: 1
```

## Example 3: Realistic RSA (1024-bit)

**Key Generation** (conceptual - actual values are huge):

```
p = 135066410865995223349603216278805969938881475605667027524485143851526510604859
q = 135066410865995223349603216278805969938881475605667027524485143851526510604861

n = p × q
  = 18242887429038605015645980866370033476347956854571509789903683103556448481516769

φ(n) = (p-1)(q-1)
     = 18242887429038605015645980866370033476347956854571509789903683103556448481382850

e = 65537 (standard choice)

d = e^(-1) mod φ(n)
  = 10157478324572816115799264126992234278043932251372636490866740093956664069950673
```

**Message**: $M = 42$ (in practice, messages are padded)

**Encryption**:
$$C = 42^{65537} \bmod n$$

This computation requires ==modular exponentiation== algorithms for efficiency.

***

# Fast Modular Exponentiation

Computing $a^b \bmod n$ naively is computationally infeasible for large $b$. We use the ==binary exponentiation== method.

## Algorithm: Square-and-Multiply

**Principle**: Express exponent in binary and use:
$$a^{b_k2^k + b_{k-1}2^{k-1} + \cdots + b_12 + b_0} = \prod_{i=0}^{k} (a^{2^i})^{b_i}$$

**Steps**:
1. Express $b$ in binary: $b = (b_k b_{k-1} \cdots b_1 b_0)_2$
2. Compute $a^{2^i} \bmod n$ for each bit position
3. Multiply together where $b_i = 1$

**Python Implementation**:

```Python
def mod_exp(base, exponent, modulus):
    """Fast modular exponentiation: base^exponent mod modulus"""
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

# Example: 123^17 mod 3233
print(mod_exp(123, 17, 3233))  # Output: 855
```

**Complexity**: $O(\log b)$ multiplications instead of $O(b)$

## Example Trace

Compute $7^{13} \bmod 11$:

$13 = (1101)_2 = 8 + 4 + 1$

```
Iteration 1: exp=13 (odd)  → result = 1 × 7 = 7
             base = 7^2 = 49 ≡ 5 (mod 11), exp = 6

Iteration 2: exp=6 (even)
             base = 5^2 = 25 ≡ 3 (mod 11), exp = 3

Iteration 3: exp=3 (odd)   → result = 7 × 3 = 21 ≡ 10 (mod 11)
             base = 3^2 = 9 (mod 11), exp = 1

Iteration 4: exp=1 (odd)   → result = 10 × 9 = 90 ≡ 2 (mod 11)
             base = 9^2 = 81 ≡ 4 (mod 11), exp = 0

Result: 7^13 ≡ 2 (mod 11)
```

Verification: $7^{13} = 96889010407 = 8808091855 \times 11 + 2$ ✓

***

# Chinese Remainder Theorem Optimization

For RSA decryption, we can use ==CRT== to speed up computation by ~4x.

## Mathematical Foundation

**Chinese Remainder Theorem**: If $\gcd(p, q) = 1$, then solving:
$$x \equiv a \pmod{p}$$
$$x \equiv b \pmod{q}$$

Has unique solution modulo $pq$:
$$x = (a \cdot q \cdot (q^{-1} \bmod p) + b \cdot p \cdot (p^{-1} \bmod q)) \bmod pq$$

## RSA-CRT Decryption

Instead of computing $M = C^d \bmod n$, we compute:

**Step 1**: Compute exponents modulo $p-1$ and $q-1$:
$$d_p = d \bmod (p-1)$$
$$d_q = d \bmod (q-1)$$

**Step 2**: Compute modular inverses:
$$q_{\text{inv}} = q^{-1} \bmod p$$

**Step 3**: Compute partial results:
$$M_p = C^{d_p} \bmod p$$
$$M_q = C^{d_q} \bmod q$$

**Step 4**: Combine using CRT:
$$h = (M_p - M_q) \cdot q_{\text{inv}} \bmod p$$
$$M = M_q + h \cdot q$$

**Complexity Analysis**:
- Standard: One exponentiation with $n$-bit modulus and $n$-bit exponent
- CRT: Two exponentiations with $n/2$-bit moduli and $n/2$-bit exponents
- Speedup: $\approx 4\times$ (since complexity is $O((\log n)^3)$)

**Python Implementation**:

```Python
def rsa_crt_decrypt(ciphertext, d, p, q):
    """RSA decryption using Chinese Remainder Theorem"""
    # Precompute values (stored with private key)
    dp = d % (p - 1)
    dq = d % (q - 1)
    qinv = mod_inverse(q, p)

    # Compute partial results
    mp = mod_exp(ciphertext, dp, p)
    mq = mod_exp(ciphertext, dq, q)

    # Combine using CRT
    h = (qinv * (mp - mq)) % p
    plaintext = mq + h * q

    return plaintext

# Example with p=61, q=53, d=2753
p, q = 61, 53
d = 2753
ciphertext = 855

plaintext = rsa_crt_decrypt(ciphertext, d, p, q)
print(f"Decrypted: {plaintext}")  # Output: 123
```

***

# Mathematical Security Analysis

## The Factorization Problem

RSA security relies on the ==computational hardness of integer factorization==.

**Problem**: Given $n = pq$, find $p$ and $q$.

**Known Algorithms**:

| Algorithm | Complexity | Notes |
|-----------|-----------|-------|
| Trial Division | $O(\sqrt{n})$ | Impractical for large $n$ |
| Pollard's Rho | $O(n^{1/4})$ | Better for small factors |
| Quadratic Sieve | $O(e^{\sqrt{\ln n \ln \ln n}})$ | Efficient for 100-digit numbers |
| General Number Field Sieve (GNFS) | $O(e^{(\ln n)^{1/3}(\ln \ln n)^{2/3}})$ | Most efficient for large $n$ |

**Current Records** (as of 2025):
- 829-bit (250 decimal digits) factored using GNFS
- 1024-bit RSA considered ==vulnerable==
- 2048-bit minimum for new systems
- 3072-bit recommended for long-term security (beyond 2030)

## Mathematical Security Requirements

### 1. Prime Selection Requirements

**Requirement**: Primes $p$ and $q$ must satisfy:

1. **Sufficient Size**:
   - For 2048-bit RSA: $p, q \approx 1024$ bits each
   - For 3072-bit RSA: $p, q \approx 1536$ bits each

2. **Separation**: $|p - q|$ should be large
   - If $|p - q|$ is small, ==Fermat factorization== succeeds:
   $$n = pq = \left(\frac{p+q}{2}\right)^2 - \left(\frac{p-q}{2}\right)^2$$
   - Attack complexity: $O(|p-q|)$

3. **Strong Primes** (traditional, less critical with large keys):
   - $p - 1$ has large prime factor $r$
   - $r - 1$ has large prime factor
   - $p + 1$ has large prime factor
   - Protects against ==Pollard's p-1 algorithm==

**Example Attack**: Fermat Factorization

If $p = 1000003$ and $q = 1000033$ (difference = 30):

```Python
def fermat_factor(n):
    """Fermat's factorization method"""
    import math
    a = math.ceil(math.sqrt(n))
    b2 = a * a - n

    while not is_perfect_square(b2):
        a += 1
        b2 = a * a - n

    b = int(math.sqrt(b2))
    return a - b, a + b

def is_perfect_square(n):
    root = int(math.sqrt(n))
    return root * root == n

n = 1000003 * 1000033
p, q = fermat_factor(n)
print(f"Factors: {p}, {q}")  # Quickly finds factors!
```

### 2. Public Exponent Selection

**Small $e$ Vulnerabilities**:

**Case 1**: $e = 3$ with ==no padding==

If same message $M$ encrypted to three different recipients with coprime moduli $n_1, n_2, n_3$:
$$C_1 \equiv M^3 \pmod{n_1}$$
$$C_2 \equiv M^3 \pmod{n_2}$$
$$C_3 \equiv M^3 \pmod{n_3}$$

By CRT, attacker can compute $M^3 \pmod{n_1 n_2 n_3}$.

Since $M < n_i$, we have $M^3 < n_1 n_2 n_3$, so:
$$M = \sqrt[3]{M^3}$$ (integer cube root, no modular arithmetic needed!)

**Mitigation**: Always use ==proper padding== (OAEP)

**Case 2**: $e = 65537$ (recommended)

Optimal choice: $e = 2^{16} + 1 = 65537$
- Large enough to prevent low-exponent attacks
- Has only two 1-bits: fast exponentiation
- Standard in practice

### 3. Private Exponent Protection

**Small $d$ Vulnerability** (Wiener's Attack):

If $d < \frac{1}{3}n^{1/4}$, then $d$ can be recovered using ==continued fractions==.

**Theorem** (Wiener, 1990): If:
$$d < \frac{1}{3}n^{1/4} \text{ and } q < p < 2q$$

Then $d$ can be found in polynomial time.

**Attack Method**:
1. Compute continued fraction expansion of $\frac{e}{n}$
2. Each convergent $\frac{k}{d'}$ is tested
3. If $ed' \equiv 1 \pmod{k}$, then $d = d'$

**Example**:

```Python
def wiener_attack(e, n):
    """Wiener's attack for small d"""
    from fractions import Fraction

    convergents = continued_fraction_convergents(Fraction(e, n))

    for k, d in convergents:
        if k == 0:
            continue

        # Check if this d works
        phi = (e * d - 1) // k

        # Solve x^2 - (n - phi + 1)x + n = 0
        discriminant = (n - phi + 1) ** 2 - 4 * n

        if discriminant >= 0:
            sqrt_disc = int(discriminant ** 0.5)
            if sqrt_disc * sqrt_disc == discriminant:
                p = ((n - phi + 1) + sqrt_disc) // 2
                q = n // p
                if p * q == n:
                    return p, q

    return None

def continued_fraction_convergents(frac):
    """Generate convergents of continued fraction"""
    convergents = []
    n, d = frac.numerator, frac.denominator

    # Generate continued fraction coefficients
    cf = []
    while d != 0:
        q = n // d
        cf.append(q)
        n, d = d, n - q * d

    # Compute convergents
    h0, h1 = 0, 1
    k0, k1 = 1, 0

    for a in cf:
        h = a * h1 + h0
        k = a * k1 + k0
        convergents.append((k, h))
        h0, h1 = h1, h
        k0, k1 = k1, k

    return convergents
```

**Mitigation**: Ensure $d > n^{0.292}$ (modern RSA implementations do this)

## Padding Schemes and Semantic Security

**Problem**: Textbook RSA is ==deterministic== and ==malleable==.

- **Deterministic**: Same plaintext always produces same ciphertext
- **Malleable**: $E(m_1) \cdot E(m_2) = E(m_1 \cdot m_2)$

### PKCS#1 v1.5 Padding

**Format** (for encryption):
```
0x00 || 0x02 || PS || 0x00 || M

Where:
- 0x00: Leading byte
- 0x02: Block type for encryption
- PS: Padding string (random non-zero bytes)
- 0x00: Separator
- M: Message
```

**Length**: $|PS| \geq 8$ bytes, total length = key size

**Vulnerability**: ==Bleichenbacher's attack== (1998) - padding oracle attack

**Example**:

```Python
def pkcs1_v15_pad(message, key_size_bytes):
    """PKCS#1 v1.5 padding for encryption"""
    import os

    message_len = len(message)
    ps_len = key_size_bytes - message_len - 3

    if ps_len < 8:
        raise ValueError("Message too long for key size")

    # Generate random non-zero padding
    ps = bytearray()
    while len(ps) < ps_len:
        byte = os.urandom(1)
        if byte != b'\x00':
            ps.extend(byte)

    padded = b'\x00\x02' + bytes(ps) + b'\x00' + message
    return padded

# Example: Pad "HELLO" for 256-byte (2048-bit) RSA
message = b"HELLO"
padded = pkcs1_v15_pad(message, 256)
print(f"Padded length: {len(padded)} bytes")
print(f"First 20 bytes: {padded[:20].hex()}")
```

### OAEP (Optimal Asymmetric Encryption Padding)

**Standard**: PKCS#1 v2.0, RFC 8017

**Structure**:
```
0x00 || maskedSeed || maskedDB

Where:
- maskedSeed = seed ⊕ MGF(maskedDB)
- maskedDB = (Hash(L) || PS || 0x01 || M) ⊕ MGF(seed)
- MGF: Mask Generation Function (typically MGF1)
- L: Optional label (usually empty)
- PS: Padding string of zeros
```

**Security**: Provably secure under random oracle model against ==chosen ciphertext attacks== (CCA).

**Python Implementation**:

```Python
import hashlib
import os

def mgf1(seed, length, hash_func=hashlib.sha256):
    """Mask Generation Function 1"""
    hlen = hash_func().digest_size
    output = b''

    for counter in range((length + hlen - 1) // hlen):
        c = counter.to_bytes(4, byteorder='big')
        output += hash_func(seed + c).digest()

    return output[:length]

def oaep_pad(message, key_size_bytes, label=b'', hash_func=hashlib.sha256):
    """OAEP padding (RFC 8017)"""
    hlen = hash_func().digest_size

    # Check message length
    max_msg_len = key_size_bytes - 2 * hlen - 2
    if len(message) > max_msg_len:
        raise ValueError("Message too long")

    # Construct DB = Hash(L) || PS || 0x01 || M
    lhash = hash_func(label).digest()
    ps_len = key_size_bytes - len(message) - 2 * hlen - 2
    db = lhash + b'\x00' * ps_len + b'\x01' + message

    # Generate random seed
    seed = os.urandom(hlen)

    # Apply MGF
    db_mask = mgf1(seed, len(db), hash_func)
    masked_db = bytes(a ^ b for a, b in zip(db, db_mask))

    seed_mask = mgf1(masked_db, hlen, hash_func)
    masked_seed = bytes(a ^ b for a, b in zip(seed, seed_mask))

    # Construct padded message
    em = b'\x00' + masked_seed + masked_db

    return em

# Example usage
message = b"Attack at dawn"
padded = oaep_pad(message, 256)  # For 2048-bit RSA
print(f"OAEP padded length: {len(padded)} bytes")
```

**OAEP Decryption**:

```Python
def oaep_unpad(em, key_size_bytes, label=b'', hash_func=hashlib.sha256):
    """OAEP unpadding"""
    hlen = hash_func().digest_size

    # Split EM
    y = em[0]
    masked_seed = em[1:hlen+1]
    masked_db = em[hlen+1:]

    # Recover seed and DB
    seed_mask = mgf1(masked_db, hlen, hash_func)
    seed = bytes(a ^ b for a, b in zip(masked_seed, seed_mask))

    db_mask = mgf1(seed, len(masked_db), hash_func)
    db = bytes(a ^ b for a, b in zip(masked_db, db_mask))

    # Parse DB = lHash' || PS || 0x01 || M
    lhash = hash_func(label).digest()
    lhash_prime = db[:hlen]

    if lhash != lhash_prime:
        raise ValueError("OAEP decoding error")

    # Find 0x01 separator
    separator_index = db.find(b'\x01', hlen)
    if separator_index == -1:
        raise ValueError("OAEP decoding error")

    # Check padding is all zeros
    if db[hlen:separator_index] != b'\x00' * (separator_index - hlen):
        raise ValueError("OAEP decoding error")

    # Extract message
    message = db[separator_index+1:]
    return message
```

## Attack Vectors

### 1. Chosen Plaintext Attack (CPA)

**Attack**: Encrypt chosen messages and analyze ciphertexts.

**RSA Property**: Without padding, encryption is deterministic.

**Example**: Dictionary attack on small message space.

```Python
# Attacker builds dictionary
def dictionary_attack(ciphertext, public_key, message_space):
    """CPA attack on textbook RSA"""
    e, n = public_key

    # Build dictionary
    dictionary = {}
    for message in message_space:
        c = mod_exp(message, e, n)
        dictionary[c] = message

    # Lookup ciphertext
    if ciphertext in dictionary:
        return dictionary[ciphertext]
    return None

# Example: 8-bit message space
e, n = 17, 3233
ciphertext = 855

message_space = range(256)
plaintext = dictionary_attack(ciphertext, (e, n), message_space)
print(f"Cracked plaintext: {plaintext}")
```

**Mitigation**: Use OAEP padding (adds randomness).

### 2. Chosen Ciphertext Attack (CCA)

**Attack**: Submit chosen ciphertexts for decryption and analyze results.

**RSA Malleability**: Given $C = M^e \bmod n$, attacker can create:
$$C' = C \cdot s^e \bmod n = (M \cdot s)^e \bmod n$$

Decryption of $C'$ reveals $M \cdot s$, so $M = (M \cdot s) / s$.

**Example**:

```Python
def cca_attack_textbook_rsa(ciphertext, decryption_oracle, public_key):
    """CCA attack exploiting RSA malleability"""
    e, n = public_key

    # Choose blinding factor
    s = 2

    # Create modified ciphertext: C' = C × 2^e mod n
    c_prime = (ciphertext * mod_exp(s, e, n)) % n

    # Get decryption of C'
    m_s = decryption_oracle(c_prime)  # This is M × s mod n

    # Recover original message
    s_inv = mod_inverse(s, n)
    m = (m_s * s_inv) % n

    return m
```

**Mitigation**: Use OAEP (provides CCA security).

### 3. Timing Attacks

**Vulnerability**: Decryption time varies based on private key bits.

**Attack**: Measure time for many decryptions to extract $d$.

**Example Vulnerability** (naive implementation):

```Python
def vulnerable_decrypt(ciphertext, d, n):
    """Timing-vulnerable decryption"""
    result = 1
    base = ciphertext
    exp = d

    while exp > 0:
        if exp & 1:  # Bit is 1
            result = (result * base) % n  # EXTRA MULTIPLICATION
        base = (base * base) % n
        exp >>= 1

    return result
```

Branches based on secret bits leak information through timing!

**Mitigation**: ==Constant-time implementation==

```Python
def constant_time_decrypt(ciphertext, d, n):
    """Constant-time modular exponentiation"""
    result = 1
    base = ciphertext

    # Process all bits regardless of value
    for i in range(d.bit_length()):
        bit = (d >> i) & 1

        # Constant-time conditional: always multiply, conditionally use result
        temp = (result * base) % n
        result = (bit * temp + (1 - bit) * result) % n

        base = (base * base) % n

    return result
```

Better: Use ==Montgomery ladder== or ==blinding==:

```Python
def blinded_decrypt(ciphertext, d, n):
    """Blinding-based timing attack mitigation"""
    import os

    # Choose random blinding factor r
    r = int.from_bytes(os.urandom(n.bit_length() // 8), 'big') % n
    r_inv = mod_inverse(r, n)

    # Blind ciphertext: C' = C × r^e mod n
    e = 65537  # Public exponent
    blinded_c = (ciphertext * mod_exp(r, e, n)) % n

    # Decrypt blinded ciphertext
    blinded_m = mod_exp(blinded_c, d, n)

    # Unblind: M = M' × r^(-1) mod n
    message = (blinded_m * r_inv) % n

    return message
```

### 4. Side-Channel Attacks

**Vulnerabilities**:
- **Power Analysis**: Measure power consumption during decryption
- **Electromagnetic Analysis**: Measure EM emissions
- **Cache-Timing**: Exploit CPU cache behavior

**Mitigation**:
- Hardware countermeasures
- Algorithmic blinding
- Constant-time implementations

***

# Key Size Recommendations

| Key Size | Security Level | Quantum Security | Recommendation |
|----------|---------------|------------------|----------------|
| 1024 bits | ~80 bits | Broken | **Deprecated** - Do not use |
| 2048 bits | ~112 bits | Broken | Minimum for current use |
| 3072 bits | ~128 bits | Broken | Recommended for sensitive data |
| 4096 bits | ~140 bits | Broken | Maximum practical size |
| 7680 bits | ~192 bits | Broken | Future-proof (pre-quantum) |
| 15360 bits | ~256 bits | Broken | Impractical |

**Notes**:
- Quantum computers with Shor's algorithm break RSA in polynomial time
- Post-quantum alternatives: Lattice-based (NTRU, Kyber), Code-based (McEliece)
- Hybrid approach: RSA + post-quantum for transition period

**NIST Recommendations** (SP 800-57):
- 2048-bit RSA ≈ 112-bit security ≈ AES-128
- 3072-bit RSA ≈ 128-bit security ≈ AES-256
- Security level = effort to break (in bits)

**Key Size vs. Performance**:

| Operation | 2048-bit | 3072-bit | 4096-bit | Ratio |
|-----------|----------|----------|----------|-------|
| Key Gen | 1x | ~3x | ~5x | $O(n^2)$ to $O(n^3)$ |
| Encrypt | 1x | ~2x | ~4x | $O(n^2)$ |
| Decrypt | 1x | ~3x | ~5x | $O(n^3)$ |
| Decrypt (CRT) | 1x | ~2x | ~3x | $O(n^3)$ but smaller |

***

# Practical Implementations

## Python Implementation (Complete RSA)

```Python
import random
import math
import hashlib

class RSA:
    def __init__(self, key_size=2048):
        self.key_size = key_size
        self.e = 65537  # Standard public exponent
        self.n = None
        self.d = None
        self.p = None
        self.q = None

    def generate_keypair(self):
        """Generate RSA key pair"""
        # Generate two large primes
        self.p = self._generate_prime(self.key_size // 2)
        self.q = self._generate_prime(self.key_size // 2)

        # Ensure p != q
        while self.p == self.q:
            self.q = self._generate_prime(self.key_size // 2)

        # Compute n and φ(n)
        self.n = self.p * self.q
        phi = (self.p - 1) * (self.q - 1)

        # Verify e and φ(n) are coprime
        if math.gcd(self.e, phi) != 1:
            raise ValueError("e and φ(n) are not coprime")

        # Compute private exponent d
        self.d = self._mod_inverse(self.e, phi)

        return {
            'public': (self.e, self.n),
            'private': (self.d, self.n, self.p, self.q)
        }

    def encrypt(self, plaintext, public_key=None):
        """Encrypt with OAEP padding"""
        if public_key:
            e, n = public_key
        else:
            e, n = self.e, self.n

        # Apply OAEP padding
        key_size_bytes = (n.bit_length() + 7) // 8
        padded = self._oaep_pad(plaintext, key_size_bytes)

        # Convert to integer
        m = int.from_bytes(padded, byteorder='big')

        # Encrypt: C = M^e mod n
        c = pow(m, e, n)

        # Convert to bytes
        ciphertext = c.to_bytes(key_size_bytes, byteorder='big')
        return ciphertext

    def decrypt(self, ciphertext):
        """Decrypt with CRT optimization"""
        # Convert to integer
        c = int.from_bytes(ciphertext, byteorder='big')

        # Decrypt using CRT
        m = self._crt_decrypt(c)

        # Convert to bytes
        key_size_bytes = (self.n.bit_length() + 7) // 8
        padded = m.to_bytes(key_size_bytes, byteorder='big')

        # Remove OAEP padding
        plaintext = self._oaep_unpad(padded, key_size_bytes)
        return plaintext

    def _crt_decrypt(self, c):
        """Decrypt using Chinese Remainder Theorem"""
        # Compute exponents modulo p-1 and q-1
        dp = self.d % (self.p - 1)
        dq = self.d % (self.q - 1)
        qinv = self._mod_inverse(self.q, self.p)

        # Compute partial results
        mp = pow(c, dp, self.p)
        mq = pow(c, dq, self.q)

        # Combine using CRT
        h = (qinv * (mp - mq)) % self.p
        m = mq + h * self.q

        return m

    def _generate_prime(self, bits):
        """Generate a prime number of specified bit length"""
        while True:
            # Generate random odd number
            num = random.getrandbits(bits)
            num |= (1 << bits - 1) | 1  # Set MSB and LSB

            if self._is_prime(num):
                return num

    def _is_prime(self, n, rounds=40):
        """Miller-Rabin primality test"""
        if n < 2:
            return False
        if n == 2 or n == 3:
            return True
        if n % 2 == 0:
            return False

        # Write n-1 as 2^r × d
        r, d = 0, n - 1
        while d % 2 == 0:
            r += 1
            d //= 2

        # Witness loop
        for _ in range(rounds):
            a = random.randrange(2, n - 1)
            x = pow(a, d, n)

            if x == 1 or x == n - 1:
                continue

            for _ in range(r - 1):
                x = pow(x, 2, n)
                if x == n - 1:
                    break
            else:
                return False

        return True

    def _mod_inverse(self, a, m):
        """Extended Euclidean Algorithm for modular inverse"""
        def extended_gcd(a, b):
            if b == 0:
                return a, 1, 0
            gcd, x1, y1 = extended_gcd(b, a % b)
            x = y1
            y = x1 - (a // b) * y1
            return gcd, x, y

        gcd, x, _ = extended_gcd(a, m)
        if gcd != 1:
            raise ValueError("Modular inverse does not exist")
        return x % m

    def _oaep_pad(self, message, key_size_bytes):
        """OAEP padding (simplified)"""
        hash_func = hashlib.sha256
        hlen = hash_func().digest_size

        max_msg_len = key_size_bytes - 2 * hlen - 2
        if len(message) > max_msg_len:
            raise ValueError("Message too long")

        # Construct DB
        lhash = hash_func(b'').digest()
        ps_len = key_size_bytes - len(message) - 2 * hlen - 2
        db = lhash + b'\x00' * ps_len + b'\x01' + message

        # Generate seed and apply MGF
        seed = random.getrandbits(hlen * 8).to_bytes(hlen, 'big')
        db_mask = self._mgf1(seed, len(db), hash_func)
        masked_db = bytes(a ^ b for a, b in zip(db, db_mask))

        seed_mask = self._mgf1(masked_db, hlen, hash_func)
        masked_seed = bytes(a ^ b for a, b in zip(seed, seed_mask))

        return b'\x00' + masked_seed + masked_db

    def _oaep_unpad(self, em, key_size_bytes):
        """OAEP unpadding"""
        hash_func = hashlib.sha256
        hlen = hash_func().digest_size

        masked_seed = em[1:hlen+1]
        masked_db = em[hlen+1:]

        seed_mask = self._mgf1(masked_db, hlen, hash_func)
        seed = bytes(a ^ b for a, b in zip(masked_seed, seed_mask))

        db_mask = self._mgf1(seed, len(masked_db), hash_func)
        db = bytes(a ^ b for a, b in zip(masked_db, db_mask))

        lhash = hash_func(b'').digest()
        sep_index = db.find(b'\x01', hlen)

        if db[:hlen] != lhash or sep_index == -1:
            raise ValueError("OAEP decoding error")

        return db[sep_index+1:]

    def _mgf1(self, seed, length, hash_func):
        """Mask Generation Function 1"""
        hlen = hash_func().digest_size
        output = b''

        for i in range((length + hlen - 1) // hlen):
            output += hash_func(seed + i.to_bytes(4, 'big')).digest()

        return output[:length]

# Example usage
if __name__ == "__main__":
    # Generate 2048-bit RSA key
    print("Generating RSA-2048 key pair...")
    rsa = RSA(key_size=2048)
    keys = rsa.generate_keypair()

    print(f"Public key (e, n):")
    print(f"  e = {keys['public'][0]}")
    print(f"  n = {keys['public'][1]}")
    print(f"  n bit length: {keys['public'][1].bit_length()}")

    # Encrypt message
    message = b"Attack at dawn! This is a secret message."
    print(f"\nOriginal message: {message}")

    ciphertext = rsa.encrypt(message)
    print(f"Ciphertext (hex): {ciphertext.hex()[:64]}...")

    # Decrypt message
    decrypted = rsa.decrypt(ciphertext)
    print(f"Decrypted message: {decrypted}")

    # Verify
    assert message == decrypted
    print("\n✓ Encryption/Decryption successful!")
```

## Node.js Implementation

```JavaScript
const crypto = require('crypto');

class RSA {
    constructor(keySize = 2048) {
        this.keySize = keySize;
    }

    generateKeyPair() {
        // Generate RSA key pair using Node.js crypto
        const { publicKey, privateKey } = crypto.generateKeyPairSync('rsa', {
            modulusLength: this.keySize,
            publicKeyEncoding: {
                type: 'spki',
                format: 'pem'
            },
            privateKeyEncoding: {
                type: 'pkcs8',
                format: 'pem'
            }
        });

        this.publicKey = publicKey;
        this.privateKey = privateKey;

        return { publicKey, privateKey };
    }

    encrypt(message, publicKey = null) {
        const key = publicKey || this.publicKey;

        // Encrypt with OAEP padding
        const encrypted = crypto.publicEncrypt(
            {
                key: key,
                padding: crypto.constants.RSA_PKCS1_OAEP_PADDING,
                oaepHash: 'sha256'
            },
            Buffer.from(message)
        );

        return encrypted;
    }

    decrypt(ciphertext) {
        // Decrypt with OAEP padding
        const decrypted = crypto.privateDecrypt(
            {
                key: this.privateKey,
                padding: crypto.constants.RSA_PKCS1_OAEP_PADDING,
                oaepHash: 'sha256'
            },
            ciphertext
        );

        return decrypted.toString();
    }

    sign(message) {
        // Create digital signature using PSS padding
        const sign = crypto.createSign('SHA256');
        sign.update(message);
        sign.end();

        const signature = sign.sign({
            key: this.privateKey,
            padding: crypto.constants.RSA_PKCS1_PSS_PADDING,
            saltLength: crypto.constants.RSA_PSS_SALTLEN_DIGEST
        });

        return signature;
    }

    verify(message, signature, publicKey = null) {
        const key = publicKey || this.publicKey;

        const verify = crypto.createVerify('SHA256');
        verify.update(message);
        verify.end();

        return verify.verify(
            {
                key: key,
                padding: crypto.constants.RSA_PKCS1_PSS_PADDING,
                saltLength: crypto.constants.RSA_PSS_SALTLEN_DIGEST
            },
            signature
        );
    }
}

// Example usage
const rsa = new RSA(2048);

console.log('Generating RSA-2048 key pair...');
const { publicKey, privateKey } = rsa.generateKeyPair();

console.log('Public Key:', publicKey);

// Encrypt
const message = 'Attack at dawn! This is a secret message.';
console.log('\nOriginal message:', message);

const ciphertext = rsa.encrypt(message);
console.log('Ciphertext (hex):', ciphertext.toString('hex').substring(0, 64) + '...');

// Decrypt
const decrypted = rsa.decrypt(ciphertext);
console.log('Decrypted message:', decrypted);

// Digital signature
const signature = rsa.sign(message);
console.log('\nSignature (hex):', signature.toString('hex').substring(0, 64) + '...');

const isValid = rsa.verify(message, signature);
console.log('Signature valid:', isValid);
```

## Java Implementation

```Java
import java.security.*;
import java.security.spec.*;
import javax.crypto.Cipher;
import java.util.Base64;
import java.math.BigInteger;

public class RSAExample {
    private KeyPair keyPair;
    private int keySize;

    public RSAExample(int keySize) {
        this.keySize = keySize;
    }

    /**
     * Generate RSA key pair
     */
    public void generateKeyPair() throws NoSuchAlgorithmException {
        KeyPairGenerator keyGen = KeyPairGenerator.getInstance("RSA");
        keyGen.initialize(keySize, new SecureRandom());
        this.keyPair = keyGen.generateKeyPair();
    }

    /**
     * Encrypt with OAEP padding
     */
    public byte[] encrypt(String message) throws Exception {
        return encrypt(message, keyPair.getPublic());
    }

    public byte[] encrypt(String message, PublicKey publicKey) throws Exception {
        Cipher cipher = Cipher.getInstance("RSA/ECB/OAEPWithSHA-256AndMGF1Padding");
        cipher.init(Cipher.ENCRYPT_MODE, publicKey);
        return cipher.doFinal(message.getBytes("UTF-8"));
    }

    /**
     * Decrypt with OAEP padding
     */
    public String decrypt(byte[] ciphertext) throws Exception {
        Cipher cipher = Cipher.getInstance("RSA/ECB/OAEPWithSHA-256AndMGF1Padding");
        cipher.init(Cipher.DECRYPT_MODE, keyPair.getPrivate());
        byte[] decryptedBytes = cipher.doFinal(ciphertext);
        return new String(decryptedBytes, "UTF-8");
    }

    /**
     * Create digital signature using PSS
     */
    public byte[] sign(String message) throws Exception {
        Signature signature = Signature.getInstance("SHA256withRSA/PSS");
        signature.initSign(keyPair.getPrivate(), new SecureRandom());
        signature.update(message.getBytes("UTF-8"));
        return signature.sign();
    }

    /**
     * Verify digital signature
     */
    public boolean verify(String message, byte[] signatureBytes) throws Exception {
        return verify(message, signatureBytes, keyPair.getPublic());
    }

    public boolean verify(String message, byte[] signatureBytes, PublicKey publicKey)
            throws Exception {
        Signature signature = Signature.getInstance("SHA256withRSA/PSS");
        signature.initVerify(publicKey);
        signature.update(message.getBytes("UTF-8"));
        return signature.verify(signatureBytes);
    }

    /**
     * Get public key components
     */
    public void printKeyInfo() {
        RSAPublicKey pubKey = (RSAPublicKey) keyPair.getPublic();
        RSAPrivateKey privKey = (RSAPrivateKey) keyPair.getPrivate();

        System.out.println("Public Key:");
        System.out.println("  Modulus (n): " + pubKey.getModulus());
        System.out.println("  Exponent (e): " + pubKey.getPublicExponent());
        System.out.println("  Bit length: " + pubKey.getModulus().bitLength());

        System.out.println("\nPrivate Key:");
        System.out.println("  Exponent (d): " + privKey.getPrivateExponent());
    }

    /**
     * Example usage
     */
    public static void main(String[] args) {
        try {
            RSAExample rsa = new RSAExample(2048);

            System.out.println("Generating RSA-2048 key pair...");
            rsa.generateKeyPair();
            rsa.printKeyInfo();

            // Encrypt
            String message = "Attack at dawn! This is a secret message.";
            System.out.println("\nOriginal message: " + message);

            byte[] ciphertext = rsa.encrypt(message);
            System.out.println("Ciphertext (Base64): " +
                Base64.getEncoder().encodeToString(ciphertext).substring(0, 64) + "...");

            // Decrypt
            String decrypted = rsa.decrypt(ciphertext);
            System.out.println("Decrypted message: " + decrypted);

            // Digital signature
            byte[] signature = rsa.sign(message);
            System.out.println("\nSignature (Base64): " +
                Base64.getEncoder().encodeToString(signature).substring(0, 64) + "...");

            boolean isValid = rsa.verify(message, signature);
            System.out.println("Signature valid: " + isValid);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
```

***

# Digital Signatures with RSA

RSA can also be used for ==digital signatures== to provide authentication and non-repudiation.

## Signature Generation

**Process**:
1. Compute message digest: $h = H(M)$ using cryptographic hash (SHA-256)
2. Sign digest: $S = h^d \bmod n$ (encrypt with private key)

**With Padding** (PSS - Probabilistic Signature Scheme):
```
S = EMSA-PSS-ENCODE(M, n.bitLength() - 1)^d mod n
```

## Signature Verification

**Process**:
1. Decrypt signature: $h' = S^e \bmod n$ (decrypt with public key)
2. Compute message digest: $h = H(M)$
3. Verify: $h' \stackrel{?}{=} h$

**Example** (Textbook RSA signature):

```Python
def rsa_sign(message, d, n):
    """Sign message with RSA private key"""
    # Hash message
    h = hashlib.sha256(message.encode()).digest()
    h_int = int.from_bytes(h, byteorder='big')

    # Sign: S = h^d mod n
    signature = pow(h_int, d, n)

    return signature

def rsa_verify(message, signature, e, n):
    """Verify RSA signature"""
    # Hash message
    h = hashlib.sha256(message.encode()).digest()
    h_int = int.from_bytes(h, byteorder='big')

    # Recover hash: h' = S^e mod n
    h_prime = pow(signature, e, n)

    # Verify
    return h_int == h_prime

# Example
message = "I owe you $100"
p, q = 61, 53
n = 3233
e = 17
d = 2753

signature = rsa_sign(message, d, n)
print(f"Signature: {signature}")

is_valid = rsa_verify(message, signature, e, n)
print(f"Valid: {is_valid}")

# Tampering detection
tampered = "I owe you $1000"
is_valid_tampered = rsa_verify(tampered, signature, e, n)
print(f"Tampered valid: {is_valid_tampered}")  # False!
```

***

# Performance Considerations

## Computational Complexity

| Operation | Algorithm | Complexity |
|-----------|-----------|-----------|
| Primality Testing | Miller-Rabin | $O(k \log^3 n)$ where $k$ = rounds |
| Modular Exponentiation | Square-and-Multiply | $O(\log e \cdot \log^2 n)$ |
| Key Generation | Combined | $O(k \log^3 n)$ |
| Encryption | Modular Exp | $O(\log e \cdot \log^2 n)$ |
| Decryption | Modular Exp | $O(\log d \cdot \log^2 n)$ |
| Decryption (CRT) | Optimized | $O(\log d \cdot \log^2 (n/2))$ ≈ 4× faster |

## Benchmarks (Approximate, 2025 Hardware)

**RSA-2048** on modern CPU (Intel i7, single core):
- Key generation: ~50-100ms
- Encryption: ~0.1ms
- Decryption: ~2-3ms
- Decryption (CRT): ~0.7-1ms

**Comparison with Symmetric Crypto**:
- AES-256 encryption: ~0.001ms for same data
- RSA is **~100-1000× slower** than symmetric encryption
- This is why ==hybrid encryption== is used (RSA for key exchange, AES for data)

## Hybrid Encryption

**Standard Practice**: Combine RSA and AES

```Python
import os
from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes

def hybrid_encrypt(message, rsa_public_key):
    """Encrypt large message using RSA + AES"""
    # Generate random AES key
    aes_key = get_random_bytes(32)  # 256-bit AES key

    # Encrypt message with AES
    cipher_aes = AES.new(aes_key, AES.MODE_GCM)
    ciphertext, tag = cipher_aes.encrypt_and_digest(message)

    # Encrypt AES key with RSA
    e, n = rsa_public_key
    key_int = int.from_bytes(aes_key, byteorder='big')
    encrypted_key = pow(key_int, e, n)

    return {
        'encrypted_key': encrypted_key,
        'nonce': cipher_aes.nonce,
        'tag': tag,
        'ciphertext': ciphertext
    }

def hybrid_decrypt(encrypted_data, rsa_private_key):
    """Decrypt using RSA + AES"""
    d, n = rsa_private_key

    # Decrypt AES key with RSA
    key_int = pow(encrypted_data['encrypted_key'], d, n)
    aes_key = key_int.to_bytes(32, byteorder='big')

    # Decrypt message with AES
    cipher_aes = AES.new(aes_key, AES.MODE_GCM, nonce=encrypted_data['nonce'])
    message = cipher_aes.decrypt_and_verify(
        encrypted_data['ciphertext'],
        encrypted_data['tag']
    )

    return message
```

***

# Common Vulnerabilities and Mitigations

| Vulnerability | Attack Method | Mitigation |
|--------------|---------------|------------|
| Small message space | Dictionary attack | Use OAEP padding |
| Deterministic encryption | Ciphertext comparison | Use OAEP padding |
| Malleability | Ciphertext manipulation | Use OAEP padding |
| Low exponent (e=3) | Håstad's broadcast attack | Use e=65537 + OAEP |
| Small d | Wiener's attack | Ensure d > n^0.292 |
| Close p and q | Fermat factorization | Ensure \|p-q\| is large |
| Padding oracle | Bleichenbacher attack | Use OAEP, not PKCS#1 v1.5 |
| Timing attacks | Side-channel analysis | Constant-time implementation |
| Fault attacks | Induced computation errors | Verify intermediate results |

***

# References

1. **Original RSA Paper**
   - R. L. Rivest, A. Shamir, and L. Adleman, "A Method for Obtaining Digital Signatures and Public-Key Cryptosystems," *Communications of the ACM*, vol. 21, no. 2, pp. 120–126, 1978.
   - https://people.csail.mit.edu/rivest/Rsapaper.pdf

2. **RFC 8017** - PKCS #1: RSA Cryptography Specifications Version 2.2
   - https://www.rfc-editor.org/rfc/rfc8017.html
   - Defines RSA-OAEP, RSA-PSS, key formats

3. **Cryptography and Network Security** - William Stallings - 8th Edition - Pearson (2022)
   - Chapter 9: Public-Key Cryptography and RSA

4. **Introduction to Modern Cryptography** - Jonathan Katz and Yehuda Lindell - 3rd Edition - Chapman & Hall/CRC (2020)
   - Chapter 11: RSA and Factoring-Based Primitives
   - Mathematical proofs of security

5. **Handbook of Applied Cryptography** - Menezes, van Oorschot, and Vanstone - CRC Press (1996)
   - Chapter 8: Public-Key Encryption
   - http://cacr.uwaterloo.ca/hac/

6. **NIST Special Publication 800-57** - Recommendation for Key Management
   - https://csrc.nist.gov/publications/detail/sp/800-57-part-1/rev-5/final
   - Key size recommendations

7. **FIPS 186-4** - Digital Signature Standard (DSS)
   - https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.186-4.pdf

8. **Twenty Years of Attacks on the RSA Cryptosystem** - Dan Boneh - *Notices of the AMS* (1999)
   - http://www.ams.org/notices/199902/boneh.pdf
   - Comprehensive survey of RSA attacks

9. **Wiener's Attack on Short Secret Exponents** - Michael J. Wiener (1990)
   - "Cryptanalysis of Short RSA Secret Exponents," *IEEE Transactions on Information Theory*

10. **Bleichenbacher's Attack** - Daniel Bleichenbacher (1998)
    - "Chosen Ciphertext Attacks Against Protocols Based on the RSA Encryption Standard PKCS #1"
    - CRYPTO 1998

11. **Prime Number Theorem and Cryptography**
    - D. M. Burton, "Elementary Number Theory," 7th Edition, McGraw-Hill (2010)
    - Chapter 7: Prime number distribution

12. **OpenSSL RSA Documentation**
    - https://www.openssl.org/docs/man1.1.1/man1/openssl-rsa.html
    - Practical RSA implementation reference
