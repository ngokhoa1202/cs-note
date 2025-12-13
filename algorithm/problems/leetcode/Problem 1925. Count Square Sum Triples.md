#leetcode 
# Algorithm
## Optimized two loops
- For each triplet $a,b,c$ satisfying $a^2+b^2=c^2$, the position of $a$ and $b$ can be mutually exchanged. The number of iteration, as a result, can be reduced by increasing the counter by 2 for each satisfied condition.
# Implementation
## Java
```Java title='Problem 1925 in Java: Optimized two loops solution'
class Solution {
  public int countTriples(int n) {
    int counter = 0;
    for (int a = 1; a <=  n; a++) {
      for (int b = a + 1; b <= n; b++) {
        int sqrt = (int) Math.sqrt(a * a + b * b);
        if (sqrt <= n && sqrt * sqrt == a * a + b * b) counter += 2;
      }
    }
    return counter;
  }
}
```
# Complexity
## Time complexity
- $\Theta(n^2\text{log}n)$ because the algorithm complexity to calculate square root of a number is $\Theta(\text{log}n)$
## Space complexity
- $\Theta(1)$
***
# References
1. https://leetcode.com/problems/count-square-sum-triples/description/
2. 
