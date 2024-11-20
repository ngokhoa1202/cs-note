#jwt #asymmetric-cipher  #cybersecurity #authentication #authorization #computer-network #application-layer #hmac #mac 

# Scenario
- ![](Pasted%20image%2020240820140638.png)
- The rise of stateless architecture partially decentralizes server's load. However:
	- User verification.
# Json Web Token components
- Separated by the literal dot (.)
- Simplified form:
$$(Header).(Payload).(Signature)$$
- ![](Pasted%20image%2020240820150236.png)
## JWT Header
- The JWT headers from JWTs may look similar because they can employ the same encryption alogrithm.
```json
{
	"alg": "HS256",
	"typ": "JWT"
}
```
- `HS256` stands for HMAC with SHA-256 (Refers to [HMAC](HMAC.md)).
### Mandatory header
- `alg`: The main algorithm for signing and encrypting/decrypting JWT.
### Optional header
- `typ`: Media type of JWT (or just simply JWT itself).
- `cty`: Content type
## JWT Payload
- User-defined.
- Each pair of $(key, \space value)$ specifies a ==claim==.
```json
{
	"sub": "1234567890",
	"name": "John Doe",
	"admin": true
}
```
## Registered claims (popularly recognized)
- `iss`: issuer. A case-sensitive string or URI that ==uniquely indentifies the party== who issues the JWT:
	- No Certificate Authority manages `iss`.
	- Belongs to the organization itself.
- `sub`: subject. 
	- A case-sensitive string or URI that uniquely indetifies the ==subject== (the domain) which the party cares about.
	- Unique to the context of the current party.
- `aud`: audience. 
	- A single case-sensitive string or URI or array of these values.
	- Specifies who reads the data.
- `iat`: issued at time.
	- When the JWT were issued.
- `jti`: JWT ID
	- Distinguish between JWT if the content is the same.
	- Prevent replay attacks.
## Public & private claims
### Public claims
- Registered with https://www.iana.org/assignments/jwt/jwt.xhtml.
### Private claims
- Defined by the party.

## JWT Signatures
- Ensure data integrity  and authenticity.
- Employs [HMAC](HMAC.md) , [MAC Concept](MAC%20Concept.md)
- SHA-256 above is a rule of thumb.
### Recommended Hash algorithm
- `HS256`: ==HMAC using SHA-256==.
- `RS256`: RSASSA PKCS1 v1.5 using SHA-256. 
- `ES256`: ECDSA using P-256 and SHA-256.
---
# References
1. https://jwt.io/introduction for JWT Introduction.
2. https://jwt.io/ for JWT official documentation.
3. The JWT Handbook:
	1. Chapter 3 for JWT Header and Payload.
	2. Chapter 4 for JWT Signatures
4. https://www.iana.org/assignments/jwt/jwt.xhtml for IANA JWT Registry
5. [RSA](RSA.md) for RSA Algorithm
6. [MAC Concept](MAC%20Concept.md) for encryption and digital signature scenario.
7. 


