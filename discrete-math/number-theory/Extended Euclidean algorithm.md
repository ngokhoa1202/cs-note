#number-theory #cryptography #algorithm #asymmetric-cipher 
- Equivalent to [Diophantine equation](discrete-math/number-theory/Diophantine%20equation.md) 
# Input
- Given two huge positive integer $a,b>0$
$$as+bt=gcd(a,b)$$
# Output
- Find $s,t$ which are two coefficients and $gcd(a,b)$
# Method
- Initialization $$s_0=1, t_0=0$$ $$s_1=0, t_1=1$$ $$r_0=a,r_1=b$$
- Repeat calculation until $r_i = 0$ $$r_i=r_{i-2} \space mod \space r_{i-1}$$ $$q_{i-1}=\left\lfloor\frac{r_{i-2}-r_i}{r_{i-1}}\right\rfloor$$ $$\begin{cases} s_i=s_{i-2}-q_{i-1} \times s_{i-1} \\ t_i=t_{i-2}-q_{i-1} \times t_{i-1} \end{cases}$$
- If $r_i=0$ then $$gcd(a,b)=r_{i-1}$$ $$\begin{cases}s=s_i \\ t=t_i \end{cases}$$
***
# References
1. 

