#cybersecurity #asymmetric-cipher  #cryptography #rsa  #number-theory 
- Backbone of asymmetric cryptography.
- Block cipher
- $n = 1024,2048,3072,4096$ depends on version.
# Principle
- Block size $i: 2^i<n \leq 2^{i+1}$ 
- $M^{ed} \equiv 1 (mod \space n) \Rightarrow ed \equiv 1 (mod \space \phi(n))$ 
- $(e,n)$ is chosen as public key, but $d$ is kept secret as ==private key==.
- That it is ==infeasible to factorize== a extremely large number underlies the strength of RSA algorithm.
# Algorithm
### Generate key pair ($K^+,K^-$) 
- Select two primes $p,q$ 
- $n=pq \Rightarrow \phi(n)=(p-1)(q-1)$ 
- Select $e: e < \phi(n) \land gcd(e,\phi(n))=1$ . $(e,n)$ is ==public key==.
- Find $d$ such that $d < \phi(n) \land de \equiv 1 (mod \space \phi(n))$ . $d$ is ==private key==.
### Encrypt
- $C=M^e mod \space n$
### Decrypt
- $M=C^d mod \space n = (M^e)^d mod \space n = M^{k\phi(n)+1} mod \space n = M$ 
# Application
- Encryption - decryption.
- Digital signature.
- Key exchange.
---
# References
1. Cryptography and Network Security Principles and Practice - William Stallings -  Global Edition Pearson (2022).
2. [[Public-key cryptosystem]]
