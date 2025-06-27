#cryptography  #cybersecurity #asymmetric-cipher   #discrete-logarithm #algorithm 
# Principle
- Based on [Primitive root - Discrete Logarithm](Primitive%20root%20-%20Discrete%20Logarithm.md)
- Algorithm:
	- Alice and Bob choose $(\alpha=primitive-root, q=prime)$ as global elements. 
	- Each side chooses $X_A < q$, $X_B < q$ as private key.
	- Calculate public key $Y_A=\alpha^{X_A} mod \space q$ ,   $Y_B=\alpha^{X_B} mod \space q$ and exchanges.
	- Each sides recalculates $K={Y_B}^{X_A}={Y_A}^{X_B} (\space mode \space q)$.
# Attacks
## Brute-force attack
- Attack on $X_B=dlog_{\alpha, q}(Y_B)$, then $K={Y_A}^{X_B}$ 
- Brute-force is hard because it's ==infeasible to calculate discrete logarithm== for large primes.
## Man-in-the-middle attack
- An adversary ==stays in the middle== of the communication and intercept exchange messages.
- Description:
	- Darth prepares $X_{D_1}, X_{D_2}$ => calculate $Y_{D_1}, Y_{D_2}$
	- Alice prepares $X_A$, calculate $Y_A$ and shares it.
	- But Darth intercepts and know $Y_A$, he send $Y_{D_2}$ as Bob's public key back to Alice. Also, he forwards $Y_{D_1}$ as Alice's public key to Bob.
	- Alice does not know. She receives $Y_{D_2}$, thinks it as Bob's public key and calculates $K_2=Y_{D_2}^{X_A} (mod \space q)$ . Darth and Alice now share $K_2$ 
	- On Bob's side, like Alice, he does not know, he still prepares $X_B$ for calculating $Y_B$ and sends it to Alice. He also calculate $K_1=Y_{D_1}^{X_B}$ 
	- Darth once intercepts Bob's message and knows $Y_B$. He calculates secret key $K_1=Y_B^{X_{D_1}} (mod \space q)$  . Now Darth and Bob shares $K_1$.

	
# Application
- Key exchange protocol [IKE](IKE.md).
- Central directory to ==store public key==.
- Any user granted permission can access directory to gain public key and generate his own private key.
- Does not support replay attacks.

---
# References
1. Cryptography and Network Security Principles and Practice - William Stallings -  Global Edition-Pearson (2022).