#cli #rsa #cryptography #asymmetric-cipher #os #linux #ubuntu #fedora

- Refers to [RSA](RSA.md)
# Generate key pair using RSA
```bash title='openssl for RSA'
openssl genrsa -out private-key.pem <length> # generate secret key

openssl rsa -in private-key.pem -out public-key.pem -outform PEM -pubout # generate public key
```
- Length can be either 1024, 2048, 3072 or 4096.
---
# References
1. https://www.openssl.org/
2. [RSA](RSA.md)