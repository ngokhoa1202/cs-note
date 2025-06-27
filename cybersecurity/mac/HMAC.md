#cybersecurity #cryptography #ongoing #mac

- ==Hash-based== Message Authentication Code.
- Based on [MAC Concept](MAC%20Concept.md)
# Algorithm
- Hash function as black box (SHA-1, SHA-256, MD5,...).
- Message $M$ is divided into $Y_1, Y_2,...,Y_{L-1}$ blocks. Each block is of length $b$ bits.
- Secret key $K$, is padded with zero to the left to generate $K^+$ which has $b$ bits  (thêm 0 vào phía bên trái, đẩy K đi về bên phải.)
- Hash function output length $n$
- Initialization vector of hash function $IV$ 
- $ipad=0011 0110_2=36_{16}$ repeated $\frac{b}{8}$ times
- $opad=01011100_2={5C}_{16}$ repeated $\frac{b}{8}$ 
$$HMAC(K, M)=H[(K^+ \oplus ipad) || (K^+ \oplus opad) || M]$$

# Security of HMAC
- Compute ==compression function==.
	- Brute-force attack $\equiv$ hash function.
	- Choose $IV=$ initial vector => attack on key $\approx 2^n$ attacks. 
	- Or birthday attacks.
- Find ==collisions== in hash function.
	- Find $M' \neq M$ but $H(M)=H(M')$. 
	- MD5 is insecure:
		- know algorithm and $IV$.
		- But does not know $K$.
		- Strong bandwidth to listen messages with same key.
		- $\approx 2^{64}$.
- 

