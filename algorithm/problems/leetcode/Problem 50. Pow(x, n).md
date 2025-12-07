#leetcode #recursion 
# Algorithm
## Recursion
- The function $p(x,n)$ is defined as: $$p(x,n)=\begin{cases}0 \text{ if } x=0 \\ 1 \text{ if } n=0 \\ x \text{ if } n=1 \\ \frac{1}{x} \text{ if } n=-1 \\ x\times (p(x,n \div 2))^2 \text{ if } n \mod 2 = 1\\(p(x,n \div 2))^2 \text{ if } n \mod 2 = 0\\ \frac{1}{x}\times (p(x,n \div 2))^2 \text{ if } n \mod 2 = 1 \end{cases}$$
# Implementation
## Java
```Java title='Problem 50 in Java: Recursion solution'
class Solution {
  public double myPow(double x, int n) {
    if (x == 0) return 0;
    if (n == 0) return 1;
    if (n == 1) return x;
    if (n == -1) return 1/x;
    final var y = this.myPow(x, n / 2);
    if (n < 0)
      return (n % 2 == 0) ? y * y : 1/x * y * y;
    return (n % 2 == 0) ? y * y : x * y * y;
  }
}
```
# Complexity
## Time complexity
- The recurrence relation of time complexity is $$T_n=c+2T\left(\frac{n}{2}\right) \implies T_n=\Theta(\text{log}(n))$$
## Space complexity
- $O(1)$
***
# References
1. https://leetcode.com/problems/powx-n/description/
2. 