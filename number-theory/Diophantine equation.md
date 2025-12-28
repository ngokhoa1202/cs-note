#number-theory 

- Solution to small number.
- Equivalent to [Extended Euclidean algorithm](Extended%20Euclidean%20algorithm.md)
# Definition
- Given $a,b$ . Find all integer pair $(x,y)$ for the following equation
- $$ax+by=c$$
# Solution
- Has solution $\iff$ $d=gcd(a,b) | c$ 
- If $(x_0,y_0)$ is a specific solution, then general solution is $$\begin{cases} x=x_0+\frac{b}{d}t \\ y=y_0+\frac{a}{d}t \end{cases} \space \space \forall t \in Z$$
***
# References
1. 