#recursion #algorithm-analysis 
# Substitution method
- The recurrence relation is represented in a recursive function $$C_{n}=f(C_{n-1})$$
- Substitute to make the complexity depend only on the input $$C_n=g(n)$$
- Use mathematical induction to prove the complexity.
## Example 1:
- $$
 \begin{cases}
 C_1=1 \\
 C_{n}=C_{\frac{n}{3}} + n^2
 \end{cases}$$
- Let $n=3^k$ $\Rightarrow$ $C_{3^k}=f(C_{3^{k-1}})$ 
# Master theorem
- Let $T(n)$ be the complexity of the problem on the non-negative integers. $$T(n)=aT\left(\frac{n}{b}\right)+f(n)$$ where $a \geq 1, b > 1$ are constants and $f(n)$ is a specific function.
>$\frac{n}{b}$ can be $\lfloor\frac{n}{b}\rfloor$ or $\lceil \frac{n}{b} \rceil$
- If $$f(n)=O(n^{\text{log}_b a - \epsilon})$$ for some constant $\epsilon > 0$, then $$T(n)=\Theta(n^{log_b a})$$. This results from the *domination of leaf cost*.
- If $$f(n)=\Theta(n^{\text{log}_b a})$$, then $$T(n)=\Theta(n^{\text{log}_b a}\text{log}n)$$. This results from that the work is evenly distributed at every level of the recursive tree.
- If $$f(n)=\Omega(n^{\text{log}_b a + \epsilon})$$ for some constant $\epsilon > 0$ and if $$af\left(\frac{n}{b}\right) \geq cf(n)$$ for some constant $c < 1$ and all sufficiently large $n$, then $$T(n)=\Theta(f(n))$$. This results from the domination of root cost.

***
# References
1. [[algorithm/complexity/Algorithm complexity|Algorithm complexity]]
2. 
 