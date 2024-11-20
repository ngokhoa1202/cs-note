#cryptography #cybersecurity #mac #algorithm 
- Known as ==Data Authentication Algorithm==.
# Principle
- Based on DES, CBC modes.
- Divide data into blocks (64 bits)
- Formula:
	- $O_1=E(K,D_1)$
	- $O_2=E(K,O_1 \oplus D_2)$ 
	- ...
	- $O_N = E(K, O_{N-1} \oplus D_N)$
- Insecure.