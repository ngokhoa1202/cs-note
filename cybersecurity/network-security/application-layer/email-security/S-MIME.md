#cybersecurity #protocol #email #computer-network #application-layer #web #web-security 

- Stands for ==Secure Multipurpose Internet Mail Extension==.
- [MIME](MIME.md)
- Support ==canonical form==.
- Provide:
	- Authentication.
	- Digital signature.
	- Confidentiality.
	- Compression.
	- Email compatibility: encoding base64.
- ![](Pasted%20image%2020240514180231.png)
# Authentication
- [RSA](RSA.md).
- [Digital signature](Digital%20signature.md). 
# Confidentiality
- Symmetric encryption to encrypt content.
- RSA to encrypt secret key.
- [Email security scenario](Email%20security%20scenario.md) 
- => resolve session key distro to email application.
# Authentication and Confidentiality
- Sign, then encrypt.
![](Pasted%20image%2020240514181143.png)
![](Pasted%20image%2020240514182447.png)

# S/MIME Message Content Types
- **Data**: inner encoded content (`base64`).
- **SignedData**: digital signature of data.
	- Algorithm: MD5 or SHA-1.
	- Prepare *SignerInfo* block:
		- Signer's public key certificate.
		- Hash function's id.
		- Encryption algorithm's id.
- **EnvelopedData**: encrypted data.
	- Algorithm: RC40 or 3DES.
	- Principle: [Email security scenario](Email%20security%20scenario.md). 
	- Prepare *RecipientInfo* block:
		- Algorithm's id.
		- Encrypted session key.
		- Recipient's public key certificate id.
- **CompressedData**
- **Registration request**:
	- Request certificate from CA.

# S/MIME Certificate Processing


## User agent role
- Generate key (e.g: RSA key pair).
- Register with CA.
- Store and manage certificates.

# Enhanced S/MIME Security service
- **Signed receipts**: proof to CA and recipient that certificate has been delivered.
- **Security labels**: grant permisson for access control.
- **Secure mail list**: employs MLA <-> Mail List Agent.
- **Signing Certificate**: bind sender's certificate to signature.