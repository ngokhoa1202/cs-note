#cybersecurity   #cryptography #rsa  #number-theory #digital-signature #hash 

# Definition
- Hash function $H$ accepts a variable-length block of data $M$ as input and produces a fixed-size hash value $h = H(M)$
- A *cryptographic hash function* is an hash function that is **one-way** and **collision-free**. Which means that function must make it computationally infeasible to find either:
	- a data object that maps to a pre-specified hash result (the one-way property) $\equiv$ Given hash value $h_0$ and hash function $H$, we cannot find message $m$ such that $H(m)=m_0$  
	- two data objects that map to the same hash result (the collision-free property) $\equiv$ Given hash function $H$, we cannot find two message $m_1$ and $m_2$ such that $m_1 \neq m_2$ and $H(m_1) = H(m_2)$
# Application
## Message authentication
- Message authentication protects two parties who exchange messages **from any third party**.
- Before sending the message $m$ to Bob, Alice first computes the message digest $H(m)$ of message $m$, then concatenates them into $H(m) || m$. When receiving the concatenated message, Bob splits them, recalculates the message digest $H(m)$ from the input $m$, then compares it with the hash value received from the Internet to verify the authenticity of the message. ![[Pasted image 20250627144651.png]]
- However, the hash value must be encrypted to insulate it from being replaced by a man-in-the-middle attack. Without any encryption, Darth is able to intercepts the message $m$ sent from Alice, then replace both message and message digest by his prepared message and finally sends it to Bob. The authenticity and confidentiality of the message are both violated in this case.
- ![[Pasted image 20250627152439.png]]
### Encrypts the message and its digest
- The message plus concatenated hash code is encrypted using symmetric encryption. Because only A and B share the secret key, the message must have come from A and has not been altered:
	- A sends a message $m$
		- A computes the message digest $H(m)$.
		- The message $m$ and its message digest $H(m)$ is concatenated into $H(m) || m$
		- A encrypts the concatenated message with the secret key $K$, resulting $E(K, H(m) \space || \space m)$ and sends it.
	- B receives the whole encrypted message:
		- B decrypts the concatenated message with the secret key, producing the concatenated message $H(m) \space || \space m$.
		- B recalculates the message digest of message $m$, which is originally $H(m)$
		- B compares the re-calculated message digest and the received message digest to verify the authenticity.
- ![[Pasted image 20250627152756.png]]
- The **confidentiality** and **authenticity** of the message is ensured.
### Encrypts only the message digest
- Similarly to [[Cryptographic hash function#Encrypts the message and its digest with symmetric cipher]] but only the message digest is encrypted using symmetric encryption. 
	- A sends the message $m$:
		- A computes the message digest $H(m)$.
		- A encrypts the message digest with the secret key, producing $E(K, H(m))$.
		- The message $m$ and the encrypted digest are concatenated, resulting $m \space || \space E(K, H(m))$. This is sent to the Internet.
	- B receives the concatenated message:
		- B decrypts the encrypted message digest with the secret key, producing the original digest $H(m)$.
		- B re-calculates the message digest $H'(m)$.
		- B compares the original digest and the re-calculated digest to verify the authenticity.
- ![[Pasted image 20250627155232.png]]
- Only the **authenticity** is ensured because the message is readable over the Internet.
### Both sides share a secret value and digest is not encrypted
- The sender and the recipient must share a secret value $s$. Because the secret value itself is not sent, an opponent cannot modify an intercepted message and cannot generate a false message:
	- A sends the message $m$:
		- The message $m$ and the secret value is concatenated and then hashed, producing $H(m \space || \space s)$.
		- The hash value and the message $m$ is concatenated into $m \space || \space H(m \space || \space s)$, then sent over the Internet.
	- B receives the concatenated value:
		- B splits the concatenated message into the message $m$ and the hash value $H(m \space || \space s)$.
		- The message $m$ and the secret value is concatenated and then re-hashed by B, producing $H'(m \space || \space s)$.
		- B compares the received $H(m \space || \space s)$ and the re-calculated $H'(m \space || \space s)$ to verify the authenticity.
- ![[Pasted image 20250627160657.png]]
- Only the authenticity of the message is ensured.
### Both sides share a secret value and the concatenated message is encrypted
- Similarly to [[#Both sides share a secret value and digest is not encrypted]], but the whole concatenated message is encrypted:
	- A sends the message $m$:
		- The message $m$ and the secret value is concatenated and then hashed, producing $H(m \space || \space s)$.
		- The hash value and the message $m$ is concatenated into $m \space || \space H(m \space || \space s)$, then sent over the Internet.
		- The whole concatenated message is encrypted with the secret key $K$, resulting in $E(K, m \space || \space H(m \space || \space s))$
	- B receives the encrypted message:
		- B decrypted the message with the secret key, then splits it into the message $m$ and the original hash value $H(m \space || \space s)$
		- The message $m$ and the secret value $s$ are concatenated, the re-hashed, producing $H'(m \space || \space s)$
		-  B compares the received $H(m \space || \space s)$ and the re-calculated $H'(m \space || \space s)$ to verify the authenticity.
- ![[Pasted image 20250627161637.png]]
- Both the confidentiality and the authenticity of the message is ensured.
## Digital signatures
- Digital signature protects the two parties **against each other**.
- Cryptographic hash function is employed with [[Public-key cryptosystem#Encryption with private key - decryption with public key]] to generate and verify digital signatures.
### Encrypt only the message digest
- The sender employs his private key to encrypt the digest of the message so that it it verifiable that the message received on the recipient came only the from the sender.
- A sends the message $m$:
	- A generates the message digest $H(m)$, then encrypts it with his private key $K^-_A$, producing $C$.
	- The encrypted digest and the message is concatenated into $m \space || \space E(K^-_A, H(m))$, and sent over the Internet.
- B receives the concatenated message:
	- The concatenated message is split into the message $m$ and the encrypted digest $E(K^-_A, H(m))$.
	- B decrypts the encrypted digest with A's public key $K^+_A$, resulting the hash message $H(m)$
	- B re-calculates the digest of message $m$
	- B compares the original with the newly calculated hash message to verify the authenticity.
- Only the authenticity of the message is ensured because the original message is not encrypted before being sent over the Internet.
- ![[Pasted image 20250627164750.png]]
### Encrypt the message plus its digest
- Similarly to [[#Encrypt only the message digest]], but now the whole concatenated message is encrypted with a symmetric cipher before being sent over the Internet.
-  A sends the message $m$:
	- A generates the message digest $H(m)$, then encrypts it with his private key $K^-_A$, producing $C$.
	- The encrypted digest and the message is concatenated into $m \space || \space E(K^-_A, H(m))$, then encrypted with a secret key $K$, which produces $E'(K, m \space || \space E(K^-_A, H(m)))$, and finally sent over the Internet.
- B receives the encrypted message:
	- B decrypted the encrypted message with the secret key $K$, returning back to $m \space || \space E(K^-_A, H(m))$, then splits it into the message $m$ and the encrypted of the digest $E(K^-_A, H(m))$.
	- B decrypts the encrypted digest with A's public key $K^+_A$, resulting the hash message $H(m)$
	- B re-calculates the digest of message $m$
	- B compares the original with the newly calculated hash message to verify the authenticity.
- ![[Pasted image 20250628081015.png]]
- The authenticity and confidentiality of the message is ensured.
# References
1.  Cryptography and Network Security Principles and Practice - William Stallings -  Global Edition Pearson (2022).
	1. Chapter 11. Cryptographic Hash Functions.
2. [[Digital signature]]
3. 