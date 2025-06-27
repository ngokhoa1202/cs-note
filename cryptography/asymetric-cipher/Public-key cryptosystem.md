#asymmetric-cipher #cryptography #cybersecurity #openssl #ssh #digital-signature 

# Definition
- A public-key cryptosystem has three components:
	- Plaintext & ciphertext
	- Encryption algorithm & Decryption algorithm.
	- A key pair including a private key and a public key.
# Asymmetric keys
- A pair of key, a public key and a private key, that are used to perform <mark class="hltr-yellow">complementary</mark> operations, such as <mark class="hltr-yellow">encryption and decryption</mark> or <mark class="hltr-yellow">signature generation and signature verification</mark>.
## Encryption with public key - decryption with private key
- Encryption with public key is employed to **secure communications** between two sides.
- The recipient owns a private key and has his public key distributed to the sender. Each sender has his own public key ring containing all of the distributed public key.
- Whenever Bob sends a message to Alice, the plaintext is first encrypted using Alice's public key. When the ciphertext is received on Alice's side, it is decrypted using Alice's private key. The implication is that <mark class="hltr-yellow">no recipient except Alice</mark>, who owns the proper private key, <mark class="hltr-yellow">is able to decrypt the ciphertext</mark> which is encrypted with her public key. As a result, *confidentiality* is ensured. ![[Pasted image 20250627105521.png]]
- ![[Pasted image 20250627115211.png]]

## Encryption with private key - decryption with public key
- Encryption with private key is employed to **verify the authenticity and integrity** of messages.
- The sender has his own private key and shares his public key with the recipient. Each recipient has a ring of public keys shared by his senders.
- Whenever Bob sends a message to Alice, the plaintext is first encrypted using Bob's private key. When the ciphertext is received on Alice's side, it is decrypted with Bob's public key. The implication is that, when the private key is employed to encrypt a **digital signature**, every recipient can verify the sender's public key; but <mark class="hltr-yellow">only the sender</mark>, who owns the private key, <mark class="hltr-yellow">can prove that the message comes from him</mark>.  The *private key is the only input* that can generate a valid signature for that message.
- ![[Pasted image 20250627110325.png]]
- ![[Pasted image 20250627115238.png]]

- ![[Pasted image 20250627115352.png]]
# Application
- Encryption / decryption.
- Digital signature.
- Key exchange.
- ![[Pasted image 20250627120242.png]]
# Public-key certificate
- Public-key certificate is a digital document issued and digitally <mark class="hltr-yellow">signed by the private key of a Certification Authority</mark> that binds the name of a subscriber to a public key. The certificate indicates that the subscriber identified in the certificate has sole control and access to the corresponding private key.
# Public-key infrastructure
- Public-key infrastructure is a set of *policies, processes, server platforms, software and workstations* used for the purpose of <mark class="hltr-yellow">administering certificates</mark> and public-private key pairs, including the ability to issue, maintain, and revoke public key certificates.
---
# References
1.  Cryptography and Network Security Principles and Practice - William Stallings -  Global Edition-Pearson (2022).
	1. Chapter 9. Public-Key Cryptography and RSA.