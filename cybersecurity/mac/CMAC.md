#symmetric-cryptography #cryptography  #algorithm  #mac #cybersecurity #computer-network 

- Cipher-Based Message Authentication Code (CMAC).
- Block-cipher based MAC.
- Can use DES, AES, 3ES but must obey length.
# Algorithm
- Padd $M$ with 100...0 to the right (LSB) so that length = $b$ (algorithm requres).
- Divide message $M$ into $n$ blocks $M_1, M_2,...,M_n$ .
	- $C_1=E(K, M_1)$
	- $C_2=E(K, M_2)$ 
	- ...
	- $C_n=E(K, M_n \oplus C_{n-1} \oplus K_1)$ 
	- $T=MSB_{T-length}(C_n)$
	- 