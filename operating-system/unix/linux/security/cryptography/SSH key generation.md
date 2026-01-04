#ssh #computer-network #cybersecurity #cryptography #shell #protocol #transport-layer 
# Key management
- The key pair including private key and public key is first generated on the local environment.
- The public key  is given to the clients while the private key is kept secret.
# Generate key pair
## RSA algorithm
## ECDSA algorithm
```Bash title='Generate new ssh key pair using ECDSA algorithm'
# Generate both private and public keys with ssh-keygen and custom path/filename
ssh-keygen -t ecdsa -b 521 -f <filename> -C <comment>
```
- After having been executed, the command requires user to enter a passphrase for fingerprint to generate public key.
***
# References
1. [RSA](RSA.md)
2. 