#algorithm #algorithm-analysis #calculus 
# Definition
- Algorithm complexity measures the <mark class="hltr-yellow">amount of resources</mark> such as time and space required to solve a problem.
- Mathematically represented as *asymptotic* notation when the inputs are considered very large, which expresses <mark class="hltr-yellow">bounds</mark> for best-case, worst-case, average-case complexity of an algorithm.
- $$n \geq n_0: g(n) \leq f(n) \leq h(n)$$
- ![](Pasted%20image%2020240519202543.png)

# Big Oh notation $O$ 
- Represented as $$f(n)=O(g(n))$$ means that $cg(n)$ is *upper bound* on $f(n)$ $\iff$ $\exists c:f(n) \leq c g(n)$ when $n$ is large enough. 
- Describes *worst-case* complexity.
# Big Omega notation $\Omega$ 
- Represented as $$f(n)=\Omega(g(n))$$means that  $cg(n)$ is *lower bound* on $f(n)$ $\iff$ $\exists c:f(n) \geq cg(n)$ if $n$ is large enough.
- Describes *best-case* complexity.
# Big Theta notation $\Theta$ 
- Represented as $$f(n)=\Theta(g(n))$$ means that if $c_1g(n)$ is lower bound on $f(n)$ and $c_2g(n)$ is upper bound on $f(n)$ $\iff \exists c_1,\exists c_2: f(n) \geq c_1g(n) \land f(n) \leq c_2g(n)$ when $n$ is large enough, then $g(n)$ is *tight bound* on $f(n)$
- Describes *equivalent* complexity. ![](Pasted%20image%2020240520102810.png)
# Growth rates
- ![](Pasted%20image%2020240519210128.png)
- Also called order of growth.
# Dominance rule
- Calculated from [[calculus/L_Hopital rule|L_Hopital rule]] $$n! >> a^n >> n^a >> nlogn >> n >> logn >> 1$$where $a \geq 2$ and n is very large.

- $$\Theta(f(n)+g(n))=\Theta(max\{f(n), g(n)\})$$
- $$\Theta(f(n) \times g(n))=\Theta(f(n)) \times \Theta(g(n))$$
- Big Oh is ==transitive== $$f(n)=O(g(n)) \land g(n) = O(h(n)) \Longrightarrow f(n)=O(h(n))$$
- General comparison of ==order of growth==: using limit $$L=\lim_{n \to \infty} {\frac{f(n)}{g(n)}}$$ $L=0 \iff$ $f(n)$ has smaller order of growth than $g(n)$ $\iff$ $f(n)=O(g(n))$.
  $L=c \iff f(n)$ has same order of growth as $g(n) \iff$ $f(n)=\Theta(g(n))$.
  $L=\infty \iff f(n)$ has greater order of growth  than $g(n) \iff$ $f(n)=\Omega(g(n))$ .
***
# References
1. The Algorithm Design Manual - Steven S. Skiena - Springer Publisher - 2nd edition
	1. Chapter 2. Algorithm Analysis.
2. [[calculus/L_Hopital rule|L_Hopital rule]] for calculating limits.
3. Introduction to Algorithms - Thomas H.Cormen, Charles E.Leserson, Ronald L.Rivest, Clinfford Sten - The MIT Press - Third Edition 2009.
	1. Chapter 4. Divide-and-Conquer.
		1. Section 4.5. The master method for solving recurrences.
4. [[algorithm/complexity/Recurrence relation|Recurrence relation]]
