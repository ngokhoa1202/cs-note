#discrete-math #relation 

# n-ary relations
- Let $A_1 , A_2 , . . . , A_n$ be sets. An **n-ary relation** on these sets is a subset of $A_1 \times A_2 \times · · · \times A_n$ .
- The sets $A_1 , A_2 , . . . , A_n$  are called the domains of the relation, and $n$ is called its degree.
# Relation on a set
- A relation on a set $A$ is a relation from $A$ to $A$.
## Properties of relation
### Reflexive
- A relation $R$ on a set $A$ is called reflexive if and only if ($a, a) \in R$ for every element $a \in A$.
### Symmetric
- A relation $R$ on a set $A$ is called symmetric if and only if $(b, a) ∈ R$ whenever $(a, b) ∈ R$, for all $a, b ∈ A$.
### Anti-symmetric
- A relation $R$ on a set $A$ such that for all $a, b ∈ A$, if $(a, b) ∈ R$ and $(b, a) ∈ R$, then $a = b$ is called anti-symmetric.
### Transitive
- A relation $R$ on a set $A$ is called transitive if whenever $(a, b) ∈ R$ and $(b, c) ∈ R$, then $(a, c) ∈ R$, for all $a, b, c ∈ R$.
### Asymmetric
- A relation $R$ on a set $A$ is called asymmetric if $(a,b) \in R$, then $(b,a) \not\in R$.
## Closures
- The closure of a relation $R$ with respect to property $P$ is the relation obtained by adding the minimum number of ordered pairs to $R$ to obtain property $P$.
### Reflexive closure
- Let $\Delta=\{ (a,a) \mid a \in A\}$ be the <mark class="hltr-yellow">diagonal relation</mark> of $A$, the reflexive closure of $R$: $$r(R)=R \cup \Delta$$
### Symmetric closure
- Let $R^{-1}=\{(b,a) \mid (a, b) \in R \}$ be the inverse relation of $R$, the symmetric closure of $R$: $$s(R)=R^{-1}\cup R$$
### Transitive closure
- The connectivity relation, or the transitive closure of $R$ consists of the pairs $(a, b)$ such that there exists a path from $a$ to $b$ in $R$. $$R^*=\bigcup_{n=1}^{\infty} R^n$$
# Relation composite
- Let $R$ be a relation from $A$ to $B$ and $S$ a relation from $B$ to $C$. The composite  $S \circ R$ is the relation consisting of ordered pairs $(a, c)$, where $a ∈ A, c ∈ C$, and for which there exists an element $b ∈ B$ such that $(a, b) ∈$ R and $(b, c) ∈ S$.
- Let R be a relation on the set A. The powers $R^n, \space n = 1, 2, 3, . . .$, are defined recursively by $$R^n=\begin{cases}R \space\text{if } n = 1 \\ R^n \circ R \space\text{if }n>1\end{cases}$$
## Transitive
- The relation $R$ on a set $A$ is transitive if and only if $R^n ⊆ R$ for $n = 1, 2, 3,...$
# Orderings
## Partial ordering
- A relation $R$ on a set $S$ is called a partial ordering or partial order if it is <mark class="hltr-yellow">reflexive, anti-symmetric, and transitive</mark>. A set $S$ together with a partial ordering $R$ is called a partially ordered set, or <mark class="hltr-yellow">poset</mark>, and is denoted by $(S, R)$. Members of $S$ are called elements of the poset.

- The elements $a$ and $b$ of a poset $(S, \preceq)$ are called <mark class="hltr-yellow">comparable</mark> if either $a \preceq b$ or $b \preceq a$. When a and b are elements of S such that neither $a \preceq b$ nor $b \preceq a$, $a$ and $b$ are called incomparable.
## Total ordering
- If $(S, \preceq)$ is a poset and every two elements of $S$ are comparable, $S$ is called a <mark class="hltr-yellow">totally ordered </mark>or *linearly ordered set*, and  is called a total order or a linear order. A totally ordered set is also called a chain.
- 
# Example
## One-way hash function
- Given a hash function $H: X → Y$, a relation $R$ on the input domain $X$  is defined as:
$$(a, b) ∈ R \iff H(a) = H(b)$$
- $R$ is reflexive: $H(a) = H(a)$.
- $R$ is symmetric: $H(a)=H(b) \implies H(b)=H(a)$.
- $R$ is not anti-symmetric: $H(a)=H(b) \centernot\implies a = b$ because of the one-way characteristic.
- $R$ is transitive: $H(a)=H(b) \land H(b)=H(c) \implies H(a)=H(b)$
## Divides relation
- A relation $R$ on the positive integer domain $Z ^+$ is defined as:
$$(a,b) \in R \iff b \mid a$$
- $R$ is reflexive: $a \mid a$.
- $R$ is not symmetric: $b \mid a \centernot\implies a \mid b$. For example: $2 \mid 6$ but $6 \centernot \mid 2$
- $R$ is anti-symmetric: $b \mid a \land a \mid b \implies a = b$.
- $R$ is transitive: $b \mid a \land c \mid b \implies c \mid a$.
***
# References
1. Discrete Mathematics and Its Applications - Kenneth Rosen - Mc Graw Hill Publisher - 7th edition.
	1. Chapter 9. Relation.
2. https://cis.temple.edu/~latecki/Courses/CIS166-Spring06/Lectures/ch7.4.pdf
