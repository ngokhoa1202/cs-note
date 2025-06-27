#cybersecurity  #cryptography #asymmetric-cipher  #discrete-logarithm
# Principle
- Alice generates public key $(q=prime, \alpha=primitive-root(q), Y_A=\alpha^{X_A} mod \space q)$ and private key $X_A$. (similar to [Diffie-Hellman key exchange.](Diffie-Hellman%20key%20exchange..md))
- Bob must uses Alice's public key to encrypt:
	- Bob generates random integer $0 \leq k \leq q-1$, caculates one-time key $K=Y_A^{k}$
	- Encrypts $k$ by $C_1=\alpha^k mod \space q$ => ==encrypt secret key==.
	- Encrypts $M$ by $C_2= KM (mod \space q)$ => ==encrypt message.==
- Alice decrypts messages from Bob:
	- $K=C_1^{X_A} = (\alpha^k)^{X_A}=(\alpha^{X_A})^k=Y_A^k (mod \space q)$ (qed)    
	-  $M=C_2K^{-1}=KMK^{-1}=M (mod \space q)=$ (qed)
- If message is long $\Rightarrow$ break into blocks: $M_1, M_2, ...$
# Security
- Difficult because it's hard to determine discrete logarithm.
	