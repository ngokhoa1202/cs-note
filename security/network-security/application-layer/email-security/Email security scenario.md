#email #application-layer #cybersecurity #computer-network #cryptography #asymmetric-cipher  #symmetric-cryptography #digital-signature #hmac #mac #session 

- Refer to [Email](Email.md)
- Secure mail access protocol:
	- [POP3](POP3.md)
	- [IMAP](IMAP.md)
- Depends on the scnario, all security protocols have to adhere to CIA triad.
- Apply to ==session-based security== protocols.
# Ensure confidentiality

- ![](Pasted%20image%2020240514162317.png)
## Context
- Alice and Bob share a session key (secret key $K_s$) 
- Bob must have public key $K^+_B$ , private key $K^-_B$ 
- Message $m$ 
## Description
- Alice side:
	- Alice ==encrypts message using session key== $K_s$ , producing $E_1(K_s, m)$ 
	- Alice ==encrypts session key using Bob's public key== $K^+_B$, producing $E_2(K^+_B, K_s)$ .
	- Concats and sends to Internet.
- Bob side:
	- Split.
	- Bob decrypts ciphertext $E_2(K^+_B, K_s)$ using his private key $K^-_B)$ , producing $K_s$
	- Bob uses this secret key $K_s$ , decrypts ciphertext $E_1(K^+_B, K_s)$, receives message $m$.
# Ensure integrity and authenticity
![](Pasted%20image%2020240514163449.png)
## Context
- Both side share a session key $K_S$ and hash function $H(m)$ 
- Alice must have private key $K^-_A$, public key $K^+_A$  
## Flow
- Alice side signs
	- Alice generates message digest $H(m)$
	- Alice ==encrypts message digest using her private key== $E(K^-_A, H(m))$ 
	- Concat with message $m$ generating ==digital signature== and sends to Internet.
- Bob side verifies:
	- Split.
	- Bob generates message digest $H(m)$ using message $m$
	- Bob decrypts $E(K^-_A, H(m))$ using Alice's public key $K^+_A$, producing $H(m)$ 
	- Bob verifies by comparing two message digests.
# Ensure confidentiality, integrity and authenticity

- ![](Pasted%20image%2020240515135326.png)
- Context:
	- Both side must share a session key $K_S$.
	- Alice must have private key $K^-_A$ and public key $K^+_A$ for ==digital signature's confidentiality==.
	- Bob must have private key $K^-_B$ and public key $K^+_B$ for session key 's confidentiality.
- Alice's side:
	- Alice ==encrypts session key== $K_S$ using Bob's public key $K^+_B$ , producing $E_1(K^+_B, K_S)$.
	- Alice signs and encrypts
		- Alice signs:
			- Alice generates message digest $H(m)$ .
			- Alice encrypts $H(m)$ using her private key $K^-_A$, producing $E_1(K^-_A, H(m))$ 
			- Concat with message $m$, producing $E_1(K^-_A, H(m)) \space || \space m$ 
		- Alice encrypts $E_1 \| m$ using session key $K_S$, producing $E_2(K_S,E_1(K^-_A,H(m)) \space || \space m)$   
	- Concats and sends $E_1(K^+_B, K_S) \space|| \space E_2(K_S,E_1(K^-_A,H(m)) \space || \space m)$ to Internet.
- Bob's side:
	- Splits.
	- Bob decrypts $E_1(K^+_B, K_S)$ using his private key $K^-_B$ , receving session key $K_S$.
	- Bob decrypts and verifies:
		- Bob decrypts:
			- Bob decrypts $E_2(K_S,E_1(K^-_A,H(m)) \space || \space m)$ using session key $K_S$, receiving $E_1(K^-_A, H(m) \space || \space m)$ .
			- Bob decrypts $E_1(K^-_A, H(m) \space || \space m)$ using Alice's public key, receiving $H(m) \space || \space m$
		- Splits.
		- Bob verifies:
			- Bob generates message digest $H(m)$ from $m$.
			- Compares to $H(m)$.

---
# References
1. HCMUT's computer network inforgraphics
2. HCMUT's cryptography and network security infographics.
3. Cryptography and Network Security_ Principles and Practice - William Stallings -  Global Edition-Pearson (2022).
4. Computer Networking_ A Top-Down Approach, Global Edition, 8th Edition.
5. <mark style="background: #ADCCFFA6;">Khoa Ngo study and summarize</mark> .
6. [HMAC](HMAC.md) for Hash-based MAC.
7. [MAC Concept](MAC%20Concept.md) for Message Authentication Code.