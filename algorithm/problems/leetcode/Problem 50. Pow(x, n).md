#leetcode #recursion 
# Algorithm
## Recursion
- The function $p(x,n)$ is defined as: $$p(x,n)=\begin{cases}0 \text{ if } x=0 \\ 1 \text{ if } n=0 \\ x \text{ if } n=1 \\ \frac{1}{x} \text{ if } n=-1 \\ x\times (p(x,n \div 2))^2 \text{ if } n \mod 2 = 1\\(p(x,n \div 2))^2 \text{ if } n \mod 2 = 0\\ \frac{1}{x}\times (p(x,n \div 2))^2 \text{ if } n \mod 2 = 1 \end{cases}$$
# Implementation

# Complexity
## Time complexity
- The recurrence relation of time complexity is $$T_n=c+2T\left(\frac{n}{2}\right) \implies T_n=O(\text{log}(n))$$
## Space complexity
- $O(1)$
***
# References
1. https://leetcode.com/problems/powx-n/description/
2. 