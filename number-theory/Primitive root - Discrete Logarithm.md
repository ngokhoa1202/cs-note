#number-theory #cybersecurity #discrete-logarithm #cryptography #asymmetric-cipher 

- Modular operator has ==repetitive== patterns.
- Based on ==Euler's theorem==, if $p$ is prime, then $\phi(p)=p-1$
	$$
		a^{\phi(p)} = a^{p-1} \equiv 1 (mod \space p)
	$$
- If $\{a, a^2, a^3,...,a^p\}$ mod $p \mapsto \{1,2,3,...,p-1\}$, $a$ is ==primitive root== of $p$ $\iff$  $ord_n(a)=\phi(n)$ 
- Assume $a^i \equiv b (mod \space p)$, $i=0 \to p-1$:
	- $i$ is ==discrete algorithm== for the base $a$ modulo $p$. => $dlog_{a,p}(b)=i$ 
	- $i$ is also called ==index== $i=ind_{a}(b)$ 
 
# Order of modulo n
- Given $n>1, gcd(a,n)=1$, $k$ is smallest integer so that $a^k \equiv 1 (mod \space n) \iff ord_n(a)=k$ . $k$ is order of $a$ modulo $n$ => ==chu kỳ lặp lại của phép modulo== $n$ cho số $a$ bất kỳ.
- Primitive root <=> chu kỳ lặp lại của phép modulo là ==$\phi(n)$==. If n is prime, then  $ord_n(a)=\phi(n)=n-1$ .
***
# References
1. Elementary Number Theory - David M Burton - 7th edition - Mc-Graw Hill Publisher.
2. 