#cybersecurity #web #web-security #transport-layer #protocol  #ssl-tls #computer-network 

# Core concepts
- ![](Pasted%20image%2020240513133801.png)
- ==TLS session==:
	- Session identifier.
	- Peer certificate: X509.v3 certificate.
	- Compression method.
	- CipherSpec: encryption algorithm (AES, null) and hash algorithm (MD5, SHA-1,...)
	- Master secret: 48-byte secret key.
	- Is resumable: start new session or not.
- ==TLS Connection==:
	- Server and client random: byte sequences.
	- Server write MAC secret.
		- secret key in server MAC.
	- Client write MAC secret.
		- secret key in client MAC.
	- Server write key:
		- Key encrypted by server
	- Client write key:
		- Key encrypted by client.
	- Initialization vectos: CBC Mode.
	- Sequence number:
		- When receive cipher spec message => set to 0.
		- $\leq 2^{64}-1$ 
# TLS Record Protocol
## Algorithm
- ![](Pasted%20image%2020240513200649.png)
1. **Fragmentation**:
	- Upper-layer message is divided into blocks $\leq 2^{14}$ bytes.
2. **Compression**
	- $Comp(B_1,B_2,...,B_N) \leq B_i.length + 1024$ bytes.
	- TLSv2 => no compression.
3. Generate **HMAC** and concat:
	- [Hash-based Message Authentication Code](Hash-based%20Message%20Authentication%20Code.md)
	- $$HMAC(MAC_{secret}, seqnum || Comp.type || Comp.version || Comp.length || Comp.fragment)$$
	- $HMAC || Comp$
4. **Encryption**
	- Symmetric encryption.
	- $E(K, HMAC || Comp) \leq Comp.length + 1024$ bytes.
	- Allowed algorithm:
	- ![](Pasted%20image%2020240513202625.png)
	- If employs block cipher, HMAC may be padded if necessary.
## Format 
- ![](Pasted%20image%2020240513203147.png)
- **Content-Type**: specify upper protocol: 2 bytes.
	- change_cipher_spec
	- alert
	- handshake
	- application_data.
- **TLS version**: TLS 1.2 : 2 bytes.
	- Major version 1
	- Minor version 2.
- **Compressed lengt**h: 2 bytes.

# Alert protocol
- Compressed and Encrypted.
- ![](Pasted%20image%2020240513203710.png)
- 2 bytes:
	- Level: 
		- Fatal => stops connection
		- Warning
	- Alert:
		- bad_record_mac. => fatal
		- handshake_failure. => fatal
		- unsupported_certificate. => warning.
# Handshake protocol
- Before application data transmission.
 ![](Pasted%20image%2020240513204038.png)
- Type:
	
	![](Pasted%20image%2020240513204243.png)
- Flowchart:
	 - ![](Pasted%20image%2020240514074746.png)
	 - **Phase 1: <mark style="background: #e4e62d;">Set up</mark> security capabilities:**
		 - Client sends ==client_hello packets==:
			 - *TLS version* (client's highest version).
			 - *Random*: 32-bit timestamp and 28 bytes generated as nonce => prevent relay attacks.
			 - *Session id*: $\neq 0$ => resume and update old session, $=0$ => new session.
			 - *CipherSuite*: list of encryption algorithm (high to low priority).
			 - *Compression method*.
		- Server responses with ==server_hello packets==:
			- *TLS version*: client's version and server's version.
			- *Random*: generated independently by server.
			- *Session id*: $=0$ => generate new id, $\neq 0$ reuse.
			- *===CipherSuite===*:
				- ==Key exchange method==:
					- *RSA*.
					- *Fixed Diffie-Hellman*: signed by CA <-> certificate authority.
					- *Ephemeral Diffie-Hellma*n: temporary secret key and Diffie Hellman exchange public key => most secure.
					- Anonymous Diffie-Hellman: Diffie-Hellman without authentication and certificate => vulnerable to man-in-the-middle attacks.
				- ==CipherSpec==:
    				- CipherAlgorithm: RC4, RC2, DES, 3DES, DES40, IDEA.
    				- MACAlgorithm: MD5, SHA-1.
    				- CipherType: Block or Stream.
    				- IsExportable
    				- HashSize: 0, 16 (MD5) or 20 (SHA-1) bytes
    				- Key Material: used to generate write keys.
    				- IV Size.
    - **Phase 2: <mark style="background: #e4e62d;">Server</mark> authentication and <mark style="background: #e4e62d;">key exchange</mark>**
	    - Server ==sends its certificate== except for anonymous Diffie-Hellman case.
	    - Server sends ==server_key_exchange message== in the case of:
		    - Anonymous Diffie-Hellman:
			    - [Diffie-Hellman key exchange.](Diffie-Hellman%20key%20exchange..md) 
			- Ephemeral Diffie-Hellman:
				- [Diffie-Hellman key exchange.](Diffie-Hellman%20key%20exchange..md) and a ==signature==.
			- RSA key exchange:
				- [RSA](RSA.md) 
				- Server generates its private key and public key. It sends public key $(e,n)$ and signature to client.
				- Client encrypts using server's public key.
				- Server uses its private key to decrypt.
		- If server is non anonymous (not using anonymous Diffie-Hellman), it sends ==certificate_request_message== to client:
			- Includes ==certificate_type== and ==certificate authorities==.
			- certificate_type:
				- RSA, signature only.
				- DSS, signature only.
				- RSA for fixed Difiie-Hellman, authentication only.
				- DSS for fixed Diffie-Hellman, authentication only.
		- Server sends ==server_hello_done== messsage.
	- **Phase 3: <mark style="background: #e4e62d;">Client</mark> authetication and <mark style="background: #e4e62d;">key exchange</mark>**
		- Client sends its ==certificate==. If none, send ==no_certificate== alert.
		- Client sends ==key_exchange_message==:
			- *RSA*: generate 48-byte pre-master secret and encrypt with server's public key.
			- Ephemeral/Anonymous Diffie-Hellman: [Diffie-Hellman key exchange.](Diffie-Hellman%20key%20exchange..md) 
			- Fixed Diffie-Hellman: null, sent in client's certificate already.
		- Client sends ==certificate_verify_message==: send hash code to verify its private key
			- CertificateVerify.signature.md5_hash <-> MD5(handshake_messages).
			- Certificate.signature.md5_hash <-> SHA(handshake_messages)
	- **Phase 4: Finish**: 
		- Client sends ==change_cipher_spec_message== containing CipherSpec.
		- Client sends ==finished_message== which has content:
		- $$PRF(master-secret, MD5(handshake-msg) || SHA-1(handshakr-msg))$$
# Heartbeat protocol

# SSL/TLS Attack
- Attack on handshake protocol.
- Attack on record protocol and application data protocol.
- Attack on PKI.
- DoS.
# References
1. Cryptography and Network security - William Stallings.