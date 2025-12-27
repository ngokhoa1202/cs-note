#mac #cybersecurity #asymmetric-cipher #hash 

# Definition
- A Message Authentication Code (MAC) is a <mark class="hltr-yellow">cryptographic checksum</mark> generated from a message and a secret key that provides both data integrity and authentication.
- MAC requires both sides share a ==secret key== $K_s$ $$\text{MAC} =f_{MAC}(K_s, M)$$
- MAC is based on the assumption that:
	- The message has not been altered before being sent to the receiver. If an attacker alters the message but does not alter the MAC, then the receiver’s calculation of the MAC will differ from the received MAC because he does not know the secret key $K_s$
	- The message must be sent from the alleged sender. Because no one else knows the secret key, no one else could prepare a message with a proper MAC.
# Characteristics
- Can be together with ==sequence number== to resolve replay attack.
- More ==lightweight== than encryption.
- Widespread used by [Json Web Token](cybersecurity/web-security/Json%20Web%20Token.md)
- Message authentication protects two parties who exchange messages *from any third party*. However, it <mark class="hltr-yellow">does not protect the two parties against each other</mark>.
# MAC Function
- MAC Function is  a ==many-to-one== function which accepts a variable-length message and generates a fixed-length authenticator called tag $T=MAC(K,M)$
## Requirement
- Cannot find $M' \neq M: MAC(K,M')=MAC(K,M)$ .
- If uniformly distributed:
	- $$Pr[MAC(K,M')=MAC(K,M)]=2^{-n}$$ 
# Attack
### Brute-force attacks on keys
- Suppose $k>n$ (key size > MAC size).
- Given $M_1, T_1=MAC(K, M_1)$ 
- Number of tags produced: $2^k$ (number of $T$ produced).
- Number of different tags produced $2^n$ (based on MAC size).
- Number of matches in first round: $\frac{2^k}{2^n}=2^{k-n}$ 
- Number of matches in second round: $2^{k-2n}$ 
- Number of matches in third round: $2^{k-3n}$ 
- Until: $k-\alpha \times n < 0$ => find key => Number of rounds: $\alpha = \frac{k}{n}$   

# Usage
## Generate MAC without encryption
- The MAC is generated and sent together with the message without any encryption. Because only A and B share the secret key, the message must have come from A and has not been altered.
- A sends the message $M$:
	- A calculates the message authenticate code $C(K_s,M)$
	- The authenticator is concatenated with the message, producing $M \space || \space C(K_s,M)$, and then sent over the Internet.
- B receives the concatenated message:
	- The concatenated message is split into the authenticator $C(K, M)$ and the original message.
	- B re-calculates the checksum using the secret key.
	- B compares the received checksum and the newly calculated checksum to verify the authenticity.
- ![[Pasted image 20250703074449.png]]
- Only the authenticity is ensured.
## Generate MAC, then encrypt the checksum
- The MAC is calculated on the plaintext message M using key $K_{s_1}$, then the message is encrypted separately using key $K_{s_2}$. The authenticate protects the plaintext.
- Only after the ciphertext has been decrypted then the MAC can be calculated to make further verification.
- A sends message $M$:
	- A calculates the message authenticate code $C(K_{s_1},M)$
	- The authenticator is concatenated with the message, producing $M \space || \space C(K_s,M)$, and then encrypted with $K_{s_2}$ , generating $E(K_{s_2}, M \space || \space C(K_{s_1}, M))$ and sent over Internet.
- B receives the encrypted message:
	- B decrypts the message with $K_{s_2}$, then splits it into the message $M$ and the checksum $C(K_1, M)$.
	- B re-calculates the checksum using the secret key $K_{s_1}$.
	- B compares the received checksum with the newly calculated checksum to verify the authenticity.
- ![[Pasted image 20250703081014.png]]
## Encrypt the message, then generate MAC
- The message is first encrypted with a secret key $K_{s_2}$, then the MAC is calculated on the resulting ciphertext using another secret key $K_{s_1}$  .  The MAC protects the ciphertext rather than the plaintext.
- The receiver can verify the MAC immediately upon receipt without decrypting.
- A sends the message:
	- A first encrypts the message with the secret key $K_{s_2}$, generating $E(K_{s_2}, M)$.
	- A then computes the checksum on the ciphertext $E$ with the secret key $K_{s_1}$ , generating $C(K_{s_1}, E(K_{s_2}, M))$
	- The ciphertext and its checksum are concatenated, producing $E(K_{s_2}, M) \space || \space C(K_{s_1}, E(K_{s_2}, M))$, and then sent over the Internet.
- B receives the message:
	- The whole message are split into the ciphertext and its checksum.
	- B re-computes the MAC on the ciphertext with the secret key $K_{s_2}$, producing $C^{'}(K_{s_1}, E(K_{s_2}, M))$
	- B compares the newly calculated checksum and the received checksum to verify the authenticity.
	- If the authenticity is successfully verified, the ciphertext is decrypted with the secret key $K_{s_2}$ , generating the original message $M$.
- ![[Pasted image 20250703202144.png]]
- The authenticity and the the confidentiality is ensured.
>[!Important]
>The encrypt-then-MAC approach (diagram c) provides superior security properties. It enables the receiver to detect tampering or invalid messages before attempting decryption, preventing various attacks including padding oracle attacks and chosen-ciphertext attacks. The receiver can reject malformed or tampered messages without expending computational resources on decryption.
>
>The MAC-then-encrypt approach (diagram b) requires decryption before authentication, potentially exposing the system to attacks where carefully crafted ciphertexts cause decryption errors that leak information. Additionally, this approach cannot detect modifications to the ciphertext until after decryption completes.
>
>Modern cryptographic protocols strongly favor encrypt-then-MAC for these security advantages.


# References
1. [Json Web Token](cybersecurity/web-security/Json%20Web%20Token.md) for HMAC application.
2. Cryptography and Network Security_ Principles and Practice - William Stallings -  Global Edition-Pearson (2022)
	1. Chapter 12. Message Authentication Codes.
3. [[HMAC]] 
