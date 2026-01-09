#symmetric-cryptography #classical-cipher #cryptography #number-theory 

# Definition
- Let $c,p,a,b \in Z_m$ 
- Encryption $$c=e(k, p) \equiv ap+b \space mod \space m$$
- Decryption $$p=d(k, c)=a^{-1}(c-b+m) \space mod \space m$$ using [Diophantine equation](discrete-math/number-theory/Diophantine%20equation.md) 
# Total cases
- The number of cases = The number of pairs $(a,b)$ so that $a$ has ==multiplicative inverse== $\iff gcd(a,m)=1$ .
- Total cases for $b$ is $m$.
- Total cases for $a$ is $\phi(m)$.
- Total cases = $m \times \phi(m)$.
