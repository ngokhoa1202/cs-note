#mac #cybersecurity #asymmetric-cipher #hash 

- Known as ==crytographic checksum.==
- Share a ==secret key== $K$
$$
MAC =f_{MAC}(K=secret-key, M=message)
	$$
- Check received MAC against recalculated MAC.
- Can be together with ==sequence number== to resolve replay attack.
- More ==lightweight== than encryption.
- Widespread used by [Json Web Token](cybersecurity/web-security/Json%20Web%20Token.md)
# MAC Function
- ==Many-to-one== function: many messages for one MAC values $\implies$ less vulnerable than encryption. $|Messages| >> |MAC-values|$ 
- Three scenarios:
	- ![](Pasted%20image%2020240511141058.png)
	- (a): Without encryption: $M$,$C_M$ are concatenated and sent to Internet.
	- (b): Encrypt MAC by $K_1$ , then concatenate with $M$ => encrypt by $K_2$ => Decrypt the whole block with $K_2$ first. Only $A$ can generate this plaintext. 
	- (c): Encrypt $M$ by $K_2$ first, then encrypt MAC with $K_1$ and concatenate. Decrypt $E$ by $K_2$ before calculating MAC again to check.
- Know as ==tag== $T=MAC(K,M)$
- HMAC [HMAC](HMAC.md) 
## Requirement
- Cannot find $M' \neq M: MAC(K,M')=MAC(K,M)$ .
- If uniformly distributed:
	- $$Pr[MAC(K,M')=MAC(K,M)]=2^{-n}$$ 
# Attack
### Brute-force attacks on keys
- Suppose $k>n$ (key size > MAC size).
- Given $M_1, T_1=MAC(K, M_1)$ 
- Number of tags produced: $2^k$ (number of $T$ produced).
- Number of different tags produced $2^n$ (based on MAC size).
- Number of matches in first round: $\frac{2^k}{2^n}=2^{k-n}$ 
- Number of matches in second round: $2^{k-2n}$ 
- Number of matches in third round: $2^{k-3n}$ 
- Until: $k-\alpha \times n < 0$ => find key => Number of rounds: $\alpha = \frac{k}{n}$   
# References
1. [Json Web Token](cybersecurity/web-security/Json%20Web%20Token.md) for HMAC application.
2. Cryptography and Network Security - William Stallings - MAC Section.


