#abstract-algebra #cryptography #cybersecurity #number-theory 

# Definition
- Integer ring $Z_m$ satisfies:
	- $Z_m=\{0,1,2,...,m-1\}$.
	- Multiplication and Addition closure:
		1. $a+b \equiv c \in Z_m \space(mod \space m)$
		2. $a \times b \equiv c \in Z_m \space(mod \space m)$ 
# Characteristics
## Closure
- Above.
## Associativity
- $(a+b)+c=(a+c)+b$
- $(ab)c=a(bc)$.
## Neutral element
- Addition: $a+0=a$ 
- Multiplication: $a \times 1=a$
## Inverse
### Additive inverse
- Always exists.
$$a \in Z_m \Rightarrow \exists (-a) \in Z_m: a+(-a) \equiv 0 \space (mod \space m)$$ . For example $Z_7: 5 + 2 \equiv 0 \Rightarrow -5 = 2$
### Multiplicative inverse
- ==May exist or not==. $$a \in Z_m \land gcd(a,m)=1 \Longrightarrow \exists (a^{-1}) \in Z_m: a \times a^{-1} \equiv 1 \space (mod \space m)$$ For example: $Z_7: 5 \times 3 \equiv 1 \Rightarrow 5^{-1}=3$ 
- 