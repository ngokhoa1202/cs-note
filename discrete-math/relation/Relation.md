#discrete-math #relation 

# n-ary relations
>[!Info]
> Let $A_1 , A_2 , . . . , A_n$ be sets. An **n-ary relation** on these sets is a subset of $A_1 \times A_2 \times · · · \times A_n$ .
> The sets **$A_1 , A_2 , . . . , A_n$  are called the domains of the relation, and $n$ is called its degree.

# Properties of relation
## Relaxive
- A relation $R$ on a set $A$ is called reflexive if and only if ($a, a) \in R$ for every element $a \in A$.
## Symmetric
- A relation $R$ on a set $A$ is called symmetric if and only if $(b, a) ∈ R$ whenever $(a, b) ∈ R$, for all $a, b ∈ A$.
## Anti-symmetric
- A relation $R$ on a set $A$ such that for all $a, b ∈ A$, if $(a, b) ∈ R$ and $(b, a) ∈ R$, then $a = b$ is called anti-symmetric.
## Transitive
- A relation $R$ on a set A $is$ called transitive if whenever $(a, b) ∈ R$ and $(b, c) ∈ R$, then $(a, c) ∈ R$, for all $a, b, c ∈ R$.
# Orderings
## Partial ordering
- A relation $R$ on a set $S$ is called a partial ordering or partial order if it is <mark class="hltr-yellow">reflexive, anti-symmetric, and transitive</mark>. A set $S$ together with a partial ordering $R$ is called a partially ordered set, or poset, and is denoted by $(S, R)$. Members of $S$ are called elements of the poset.

- The elements $a$ and $b$ of a poset $(S, \preceq)$ are called comparable if either $a \preceq b$ or $b \preceq a$. When a and b are elements of S such that neither $a \preceq b$ nor $b \preceq a$, $a$ and $b$ are called incomparable.
## Total ordering
- If $(S, \preceq)$ is a poset and every two elements of $S$ are comparable, $S$ is called a <mark class="hltr-yellow">totally ordered </mark>or *linearly ordered set*, and  is called a total order or a linear order. A totally ordered set is also called a <mark class="hltr-yellow">chain</mark>.
---
# References
1. Discrete Mathematics and Its Applications - Kenneth Rosen - Mc Graw Hill Publisher - 7th edition