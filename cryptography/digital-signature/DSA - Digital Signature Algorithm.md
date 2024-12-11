#digital-signature #asymmetric-cipher  #cryptography #cybersecurity #hash #algorithm 

- Known as ==Digital Signature Algorithm==.
# Algorithm
## Generate public-key elements
- prime $p: 2^{L-1} < p < 2^L$ where $512 \leq L \leq 1024 \land 64|L$ 
- prime $q: q|(p-1) \land 2^{N-1} < q < 2^N$ where $N$ is bit length of hash function out (e.g: SHA-1 -> $N=160$) 
- $g=h^{\frac{p-1}{q}}$ where $1<h<p-1: h^{{\frac{p-1}{q}}} mod \space p > 1$ 
## Generate private key
$0 < x < q$ 
## Generate public key (encrypt $x$)
$y=g^x mod \space p$
## Generate per-message number
$0 < k < q$ 

### Calculate hash value
$H(M)$ (SHA-1, SHA-256,...)
### Sign
$r = (g^k mod \space p) mod \space q$ 
$s=[k^{-1}(H(M) + xr)] mod \space q$ 
$(s,r)$ is Alice's signature.

### Verify
$s', r', M'$ are received value of $s,r,M$. We have to verify them.
$$
w=(s')^{-1} mod \space q
$$
$$u_1=H(M') \times w \space mod \space q$$
$$u_2=(r') \times w mod \space q$$
$$v = [(g^{u_1}y^{u_2}) \space mod \space p] \space mod \space q$$  Check if $r'=v$ . If $=$, verified.

# Advantage 
- More lightweight than RSA.
- Less computational overhead.

---
# References
1. Cryptography and Network Security Principles and Practice - William Stallings -  Global Edition-Pearson (2022).