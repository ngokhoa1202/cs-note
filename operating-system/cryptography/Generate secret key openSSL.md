#cli #rsa #cryptography #asymmetric-cipher #operating-system #linux #ubuntu #fedora #computer-network #transport-layer #openssl

- Refers to [RSA](RSA.md)
# Generate key pair using RSA
```Shell title='openssl for RSA'
openssl genrsa -out private-key.pem <length> # generate secret key

openssl rsa -in private-key.pem -out public-key.pem -outform PEM -pubout # generate public key
```
- Length can be either 1024, 2048, 3072 or 4096.
# Generate key pair
## Generate private key
```Shell title='openssl for generating private key'
openssl genpkey -algorithm <algorithm> -out <private-key.pem>
```

## Generate public key from private key
```Shell title='openssl for generating public key from private key'
openssl pkey -in <private-key.pem> -out <public-key.pem>
```

# List all algorithms
```Shell title='openssl for listing algorithm'
openssl list --all-algorithms
```

# Generate certificate
- Generate private key:
```Shell title='Generate certificate with openssl'
openssl genpkey -algorithm <algorithm> -out <private-key.pem>
```
- Create `.conf` configuration file:
```toml title='Create san.conf configuration file'
[ req ]
distinguished_name = req_distinguished_name
x509_extensions = v3_req
prompt = no

[ req_distinguished_name ]
CN = localhost

[ v3_req ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = localhost
```
- Request the certificate from the private key with the given configuration file.
```Shell title='Generate the certificate request'
openssl req -new -key <private_key.pem> -out cert.csr -config san.cnf
```

- Generate the certificate from its own request with a given duration and hash algorithm to ensure data integrity.
```Shell title='Generate certificate.pem'
openssl x509 -req -in <cert.csr> -signkey <private_key.pem> -out <certificate.pem> -days <duration> -extensions v3_req -extfile san.cnf
```
# References
1. https://www.openssl.org/
2. [RSA](RSA.md)
3. [HMAC](HMAC.md)
4. [Secure Socket Layer (SSL) - Transport Layer Security (TLS)](Secure%20Socket%20Layer%20(SSL)%20-%20Transport%20Layer%20Security%20(TLS).md)
5. [Transport layer overview](Transport%20layer%20overview.md)
6. [[Digital signature]]
7. 