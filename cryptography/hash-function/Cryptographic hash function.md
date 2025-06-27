#cybersecurity   #cryptography #rsa  #number-theory #digital-signature #hash 

# Definition
- Hash function $H$ accepts a variable-length block of data $M$ as input and produces a fixed-size hash value $h = H(M)$
- A *cryptographic hash function* is an hash function that is **one-way** and **collision-free**. Which means that function must make it computationally infeasible to find either:
	- a data object that maps to a pre-specified hash result (the one-way property) $\equiv$ Given hash value $h_0$ and hash function $H$, we cannot find message $m$ such that $H(m)=m_0$  
	- two data objects that map to the same hash result (the collision-free property) $\equiv$ Given hash function $H$, we cannot find two message $m_1$ and $m_2$ such that $m_1 \neq m_2$ and $H(m_1) = H(m_2)$
# Application
## Message authentication
- Before sending the message $m$ to Bob, Alice first computes the message digest $H(m)$ of message $m$, then concatenates them into $H(m) || m$. When receiving the concatenated message, Bob splits them, recalculates the message digest $H(m)$ from the input $m$, then compares it with the hash value received from the Internet to verify the authenticity of the message. ![[Pasted image 20250627144651.png]]
- However, the hash value must be encrypted to insulate it from being replaced by a man-in-the-middle attack. Without any encryption, Darth is able to intercepts the message $m$ sent from Alice, then replace both message and message digest by his prepared message and finally sends it to Bob. The authenticity and confidentiality of the message are both violated in this case.
- ![[Pasted image 20250627152439.png]]
### Encryption with symmetric cipher
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

---
# References
1.  Cryptography and Network Security Principles and Practice - William Stallings -  Global Edition Pearson (2022).
	1. Chapter 11. Cryptographic Hash Functions. 