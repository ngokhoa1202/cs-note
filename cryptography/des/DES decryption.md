#symmetric-cipher #des #cryptography #cybersecurity 

# Structure
- ![](Pasted%20image%2020240530091759.png)
- Similar to [Structure](DES%20encryption.md#Structure), but in ==reverse order==.

# Initial & Final Permutation
[Initial & Final permutation](DES%20encryption.md#Initial%20&%20Final%20permutation)
# Each round transformation
- Split ciphertext $Y$ into two 32-bit halves $L^d_0$ and $R^d_0$ . We have $$L^d_0 \cdot R^d_0=IP(Y)$$
-  For each round, split previous output into two halves $L_{i-1}$ and $R_{i-1}$, each halve has 32 bits.
- ==Transform== to produce two new halves $L_i$ and $R_i$, $$\begin{cases}L^d_i=R^d_{i-1} \\ R^d_i=L^d_{i-1} \oplus f(R^d_{i-1}, K^d_i) \end{cases}$$ where $f$ is round function.
## Round function $f$
[Round function $f$](DES%20encryption.md#Round%20function%20$f$)
# Key scheduling
- ![](Pasted%20image%2020240530093609.png)
-  Original ==64-bit key== $k$, but transformed to ==56-bit key== and then employs 16 ==subkey== $k_i$ for 16 round.
- $C_0=C_{16}, D_0=D_{16}$ ([Key scheduling](DES%20encryption.md#Key%20scheduling)), subkey $k_{16}$ $$k_{16}=PC-2(C_{16}, D_{16})=PC-2(C_0,D_0)=PC-2(PC-1(k))$$
- Split 56-bit key into two 28-bit halves $C_{i+1}$ and $D_{i+1}$ . Then each half is ==cyclically right shifted==:
	- In round $1$, do not rotate.
	- In round $2,9,16$, rotated right by one bit.
	- Other rounds, rotated right by two bits.
	- $C_{15}=RS(C_{16}) \land D_{15}=RS(D_{16})$ 
- Concat $C_{15} \cdot D_{15}$ and permutates with $PC-2$, producing 48-bit subkey $k_{15}=PC-2(C_{15} \cdot D_{15})$ . 
- Repeat from round 15 downto 1.
- $$\begin{cases} C_{16} \cdot D_{16} = C_{0} \cdot D_{0} = PC-1(k) \to 56 \space bit \\ C_i=RS(C_{i+1}), D_i=RS(D_{i+1}) \to 28 \space bit \\ k_i = PC-2(C_i \cdot P_i) \to 48 \space bit \end{cases}$$
# Proof 


# References
1. [DES encryption](DES%20encryption.md) for DES encryption and table.
2. Understand Cryptography for DES decryption proof. 
