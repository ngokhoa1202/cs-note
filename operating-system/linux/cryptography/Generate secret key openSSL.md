#cli #rsa #cryptography #asymmetric-cipher #os #linux #ubuntu #fedora #computer-network #transport-layer #openssl

- Refers to [RSA](RSA.md)

# Generate key pair
## Generate private key
```bash title='openssl for generating private key'
openssl genpkey -algorithm <algorithm> -out <private-key.pem>
```
### RSA algorithm
```bash title='openssl for RSA'
openssl genrsa -out private-key.pem <length> # generate secret key

openssl rsa -in private-key.pem -out public-key.pem -outform PEM -pubout # generate public key
```
- Length can be either 1024, 2048, 3072 or 4096.
### ECDSA algorithm
```openssl for ECDSA
openssl ecparam -genkey -name <curve-name> -out private-key.pem
```
- `ecparam` specified the following parameters for the algorithm.
- `-name <curve-name>` specifies the curve name. There are some options:
	- `prime256v1`: NIST P-256 curve (recommended for general use)
    - `secp384r1`: NIST P-384 curve (higher security)
    - `secp521r1`: NIST P-521 curve (highest security)
    - `secp256k1`: The curve used by Bitcoin and many cryptocurrencies

## Generate public key from private key
```bash title='openssl for generating public key from private key'
openssl pkey -in <private-key.pem> -pubout -out <public-key.pem>
```

# List all algorithms
```bash title='openssl for listing algorithm'
openssl list --all-algorithms
```

# Generate certificate
- Generate private key:
```bash title='Generate certificate with openssl'
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
```bash title='Generate the certificate request'
openssl req -new -key <private_key.pem> -out cert.csr -config san.cnf
```

- Generate the certificate from its own request with a given duration and hash algorithm to ensure data integrity.
```bash title='Generate certificate.pem'
openssl x509 -req -in <cert.csr> -signkey <private_key.pem> -out <certificate.pem> -days <duration> -extensions v3_req -extfile san.cnf
```
---
# References
1. https://www.openssl.org/
2. [RSA](RSA.md)
3. [Hash-based Message Authentication Code](Hash-based%20Message%20Authentication%20Code.md)
4. [SSL-TLS](SSL-TLS.md)
5. [Transport layer overview](Transport%20layer%20overview.md)