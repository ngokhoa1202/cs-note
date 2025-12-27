#email #application-layer #cybersecurity #computer-network #cryptography #asymmetric-cipher  #symmetric-cryptography #digital-signature #hmac #mac #session 

- Refer to [Email](Email.md)
- Secure mail access protocol:
	- [POP3](POP3.md)
	- [IMAP](IMAP.md)
- Depends on the scenario, all security protocols have to adhere to CIA triad.
- Apply to ==session-based security== protocols.
# Ensure confidentiality

- ![](Pasted%20image%2020240514162317.png)
## Context
- Alice and Bob share a session key (secret key $K_s$). 
- Bob must have public key $K^+_B$ , private key $K^-_B$ .
- Message $m$ .
- The general encryption function is $E(K, m)$
## Description
- Alice side:
	- Alice ==encrypts message using session key== $K_s$ , producing $E_1(K_s, m)$ 
	- Alice ==encrypts session key using Bob's public key== $K^+_B$, producing $E_2(K^+_B, K_s)$ .
	- The session key and the Bob's public key is concatenated into $E_1 || E_2$ and sends to Internet.
- Bob side:
	- The message concatenating the two keys are splitted.
	- Bob decrypts ciphertext $E_2(K^+_B, K_s)$ using his private key $K^-_B)$ , producing $K_s$
	- Bob uses this secret key $K_s$ , decrypts ciphertext $E_1(K^+_B, K_s)$, receives message $m$.
> [!Important]
>The implication of this mechanism is that only the client who owns his private key is able to decrypt the ciphertext sent from the server. The process of encryption, however, does not ensure the integrity of the message because there is no message digest comparison on the client side.

# Ensure integrity and authenticity
![](Pasted%20image%2020240514163449.png)
## Context
- Both side share a session key $K_S$ and hash function $H(m)$ 
- Alice must have private key $K^-_A$, public key $K^+_A$  
## Flow
- Alice side signs
	- Alice generates message digest $H(m)$
	- Alice ==encrypts message digest using her private key== $E(K^-_A, H(m))$ 
	- The message $m$ and its encrypted digest is concatenated into a new==digital signature== $E(K^-_A, H(m)) || m$ and sends to Internet.
- Bob side verifies:
	- The digital signature is split into message $m$ and message digest $E(K^-_A, H(m))$
	- Bob generates message digest $H_1(m)$ using message $m$
	- Bob decrypts $E(K^-_A, H(m))$ using Alice's public key $K^+_A$, producing $H_2(m)$ 
	- Bob verifies the integrity of the message $m$ by comparing two message digests $H1$ and $H_2$.
>[!Important]
>This mechanism provides no confidentiality of the message sent on the Internet but only its integrity and authenticity because only the server who owns his private key is able to encrypt the hash digest while its public keys are distributed among the clients to decrypts the encrypted hash digest.
>
>However, due to the lack of encryption by session key, who has the public key is able to read the message and thus the confidentiality is compromised.
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
			- Alice concatenates message digest $H(m)$ with message $m$, producing $E_1(K^-_A, H(m)) \space || \space m$ 
		- Alice encrypts $E_1 \| m$ using session key $K_S$, producing $E_2(K_S,E_1(K^-_A,H(m)) \space || \space m)$   
	- Alice concatenates $E_1$ and $E_2$ and sends the result $E_1(K^+_B, K_S) \space|| \space E_2(K_S,E_1(K^-_A,H(m)) \space || \space m)$ to Internet.
- Bob's side:
	- The message received on from the Internet is split into $E_1$ and $E_2$.
	- Bob decrypts $E_1(K^+_B, K_S)$ using his private key $K^-_B$ , receving session key $K_S$.
	- Bob decrypts and verifies:
		- Bob decrypts:
			- Bob decrypts $E_2(K_S,E_1(K^-_A,H(m)) \space || \space m)$ using session key $K_S$, thereby receiving $E_1(K^-_A, H(m) \space || \space m)$ .
			- Bob decrypts $E_1(K^-_A, H(m) \space || \space m)$ using Alice's public key, receiving $H(m) \space || \space m$
		- The message digest $H(m)$ and the message $m$ is split.
		- Bob verifies:
			- Bob generates message digest $H'(m)$ from the message$m$.
			- Bob verifies the integrity of message $m$ by comparing $H(m)$ and $H'(m)$
>[!Important]
>The mechanism ensures the confidentiality as well as the integrity and authenticity of the message. The encrypted message digest is private between the server and the client thanks to the encryption using shared session key.
***
# References
1. HCMUT computer network slides - Nguyễn Phương Duy
2. HCMUT cryptography and network security slides - Nguyễn Thành Đạt.
3. Cryptography and Network Security_ Principles and Practice - William Stallings -  Global Edition-Pearson (2022).
4. Computer Networking A Top-Down Approach, Global Edition, 8th Edition.
5. [Hash-based Message Authentication Code](Hash-based%20Message%20Authentication%20Code.md) for Hash-based MAC.
6. [Message Authentication Code](Message%20Authentication%20Code.md) for Message Authentication Code.