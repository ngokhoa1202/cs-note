#algorithm #algorithm-analysis

- Expresses ==bounds== for best-case, worst-case, average-case complexity of an algorithm.
- Also known as ==asymptotic== notation.
- Consider when input $n$ is ==very large==.
- When $n \geq n_0$ , $g(n) \leq f(n) \leq h(n)$ 
- ![](Pasted%20image%2020240519202543.png)

# Big Oh notation $\mathcal{O}$ 
- $$f(n)=O(g(n))$$ means that $cg(n)$ is ==upper bound== on $f(n)$ $\iff$ $f(n) \leq c g(n)$ when $n$ is large enough. 
- Worst-case complexity.
# Big Omega notation $\Omega$ 
- $$f(n)=\Omega(g(n))$$means that  $cg(n)$ is ==lower bound== on $f(n)$ $\iff$ $f(n) \geq cg(n)$ if $n$ is large enough.
- Best-case complexity.
# Big Theta notation $\Theta$ 
- $$f(n)=\Theta(g(n))$$ means that $c_1g(n)$ is lower bound on $f(n)$ and $c_2g(n)$ is ==upper bound== on $f(n)$ $\iff f(n) \geq c_1g(n) \land f(n) \leq c_2g(n)$ if $n$ is large enough. $g(n)$ is ==tight bound== on $f(n)$
- Equivalent complexity. ![800x400](Pasted%20image%2020240520102810.png)
# Growth rates
- ![](Pasted%20image%2020240519210128.png)
- Also called ==order of growth==
# Dominance rule
- Calculated from [L'Hopital rule](L'Hopital%20rule.md)
$$n! >> a^n >> n^a >> nlogn >> n >> logn >> 1$$
where $a \geq 2$ and n is very large.

- $$\Theta(f(n)+g(n))=\Theta(max\{f(n), g(n)\})$$
- $$\Theta(f(n) \times g(n))=\Theta(f(n)) \times \Theta(g(n))$$
- Big Oh is ==transitive== $$f(n)=O(g(n)) \land g(n) = O(h(n)) \Longrightarrow f(n)=O(h(n))$$
- General comparison of ==order of growth==: using limit $$L=\lim_{n \to \infty} {\frac{f(n)}{g(n)}}$$ $L=0 \iff$ $f(n)$ has smaller order of growth than $g(n)$ $\iff$ $f(n)=O(g(n))$.
  $L=c \iff f(n)$ has same order of growth as $g(n) \iff$ $f(n)=\Theta(g(n))$.
  $L=\infty \iff f(n)$ has greater order of growth  than $g(n) \iff$ $f(n)=\Omega(g(n))$ .
***
# References
1. The Algorithm Design Manual Chapter 2.
2. [L'Hopital rule](L'Hopital%20rule.md) for calculating limits.
3. 