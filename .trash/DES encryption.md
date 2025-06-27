#symmetric-cipher #cryptography #cybersecurity #algorithm #bit-manipulation #des 

# Structure
- ![](Pasted%20image%2020240530091845.png)
- Block cipher $Plaintext=64 bits \to Ciphetext=64bits$ using key $K=56 bits$ 
- ==Iterative transformation== for both key and ciphertext in 16 rounds.
- Permutates both before and after encryption phase.
- Key scheduling is an ==independent== flow.
# Initial & Final permutation
- Maps a bit to its new position in a new permutation $\Rightarrow$ one-to-one mapping.
- Final permutation ${IP}^{-1}$ are inverse of initial permutation $IP$.
- ![](Pasted%20image%2020240526114837.png)
- ![](Pasted%20image%2020240526114858.png)
- ==No security== in this step.

# Each round transformation
- After initial permutation, we have 64-bit $IP(M)$ . Split into two 32-bit halves $L_0$ and $R_0$  
- For each round, split previous output into two halves $L_{i-1}$ and $R_{i-1}$, each halve has 32 bits.
- ==Transform== to produce two new halves $L_i$ and $R_i$, $$\begin{cases}L_i=R_{i-1} \\ R_i=L_{i-1} \oplus f(R_{i-1}, K_i) \end{cases}$$ where $f$ is round function.
## Round function $f$ 
- ==Many-to-one== function.
- ![](Pasted%20image%2020240526115630.png)
- Expands $R_{i-1}$ to 48 bits using ==E-Box== (Extension Box), then Xor with 48-bit subkey $k_i$, producing $$E(R_{i-1}) \oplus k_i$$
- Each 6-bit block $B_i$ of 48-bit $E(R_{i-1}) \oplus k_i$ undergoes ==S-box==  $i$(Substitution Box), producing 4-bit block.  $$S_i(B_i)$$.Then concat them producing 32-bit S-box output.
 $$S(E(R_{i-1}) \oplus k_i)$$
- Then ==permutated== with $P$ $$f(R_{i-1}, K_i)=P(S(E_{i-1} \oplus k_i))$$ 
### Extension box (E-box)
- ==Many-to-on==e function.
- Divides 32-bit $R_{i-1}$ into 8 blocks. Expands each 4-bit block to ==6-bit block== to generate 48-bit $E(R_{i-1})$.
- ![](Pasted%20image%2020240526120646.png)
- ![](Pasted%20image%2020240526120942.png)
- Increases ==diffusion==.

### Substitution box (S-box)
- Consists of 8 independent S-boxes $S_0, S_1,...,S_8$.
- Each S-box contains $2^6=64$ entries, represented by $4 \times 16$ table, which map 6-bit input to 4-bit output.
- How to map: for each 6-bit $b_i$:
	- Two outer bits ($MSB$ and $LSB$) identify row.
	- Four inner bits identify column.
- Example: $b_i={100101}_2 \Rightarrow row={11}_2=3 \land col={0010}_2=2$. In $S_1$ , $S_1(b_i)=S[3,2]=8$  
- ![](Pasted%20image%2020240527091548.png)
- ![](Pasted%20image%2020240527091937.png)
- 
- Provides ==non linearity and confusion==. $$S(a \oplus b) \neq S(a) \oplus S(b)$$
### Permutation function $P$
- Similar to Initial permutation step.
- Provides ==avalance effect==: one minor bit change causes another major change of many bits.
- ![500x](Pasted%20image%2020240527092736.png)
- Produces $P(S(E(R_{i-1} \oplus K_1)))$
# Key scheduling
- Original ==64-bit key== $k$, but transformed to ==56-bit key== and then employs 16 ==subkey== $k_i$ for 16 round.
- ![](Pasted%20image%2020240527133246.png)
- Every ==8th bit== in 64-bit original key $k$ is parity bit and ==stripped out== in $PC-1$ (Permutated Choice $1$).
- ![](Pasted%20image%2020240527093918.png)
- $PC-1$ is just ==permutation function== producing 56-bit key.
- ![](Pasted%20image%2020240527094026.png)
- ==Splits== 56-bit key into two 28-bit halves $C_0$ and $D_0$. Then each half is ==cyclically shifted==:
	- In round $1,2,9,16$, rotated left by one bit.
	- Other rounds, rotated left by two bits.
	- $\implies$ After 16 rounds, first bit position $4 \times 1 + 12 \times 2=28 \space mod \space 28=0 \implies C_0=C_{16} \land D_0 = D_{16}$  
	- $C_1=LS(C_0) \land D_1=LS(D_0)$
- Concats $C_1 \cdot D_1$ and permutates with $PC-2$, producing ==48-bit subkey== $k_1=PC-2(C_1 \cdot D_1)$ (==ignore 8 bits==).
- From round 2 to round 16, repeat above steps to product subkey $k_i$ 
- $$\begin{cases} C_0 \cdot D_0 = PC-1(k) \to 56 \space bit \\ C_i=LS(C_{i-1}), D_i=LS(D_{i-1}) \to 28 \space bit \\ k_i = PC-2(C_i \cdot P_i) \to 48 \space bit \end{cases}$$
- ![](Pasted%20image%2020240527101336.png)
