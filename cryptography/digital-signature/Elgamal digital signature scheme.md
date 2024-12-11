#cybersecurity #cybersecurity #digital-signature #hash #ongoing 

- Based on [Elgamal cryptosystem](Elgamal%20cryptosystem.md)
# Algorithm
- Alice signs the message:
	- Generate prime $q$, primitive root of $q$ $\alpha$ => public key.
	- Generate random integer $1 < X_A < q-1$ => private key.
	- Compute $Y_A = \alpha ^ {X_A} (mod \space q)$ => public key.
	
	- $m=H(M): 0 \leq m \leq q-1$ 
	- Select $1 \leq K \leq q-1$ and $gcd(K,q-1)=1$ 
	- $S_1=\alpha ^ K mod \space q$  $\implies$ Encrypt $K$
	- $S_2=K^{-1}(m - X_A S_1) mod \space (q-1)$ 
	- $(S_1, S_2)$ => digital signature.
- Bob verifies message from Alice:
	- Compute $V_1=\alpha ^ {m} mod \space q$ 
	- Compute $V_2=Y_A^{S_1}S_1^{S_2} mod \space q$  
	- Compare $V_1$ , $V_2$ . if $=$, verified.
# Proof
- later
---
# References
1. Cryptography and Network Security Principles and Practice - William Stallings -  Global Edition-Pearson (2022).
2. 
