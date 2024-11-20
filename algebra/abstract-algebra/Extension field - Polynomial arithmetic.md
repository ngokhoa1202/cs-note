#abstract-algebra  #algebra #cryptography #symmetric-cryptography 

- Denoted by $GF(2^n)$.
- Represented by polynomial arithmetic with coefficient in $GF(2)$ 
- All operations are modulo with 2.
# Polynomial arithmetic
- $$A(x)=\sum_{i=1}^{n-1}{a_ix^i}, a_i \in \{ 0,1\}$$ where $x$ are called ==indeterminate==.
- $$A(x)-B(x) \equiv A(x)+B(x) \space mod \space n$$
- Multiplication: modulo with an ==irreducible polynomial== $P(x)$ $$C(x)\equiv A(x)B(x) \space mod \space P(x)$$
- Multiplicative inverse: using [Extended Euclidean algorithm](Extended%20Euclidean%20algorithm.md) $$A(x) \times A^{-1}(x) \equiv 1 \space (mod \space P(x))$$
- 