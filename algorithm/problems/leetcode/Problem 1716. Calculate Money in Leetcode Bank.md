#leetcode #java 
# Algorithm
## Mathematical formula
- The total amount of money $S$ is $$S=\sum_{i=0}^{n}\left(\left\lfloor \frac{i}{7} \right\rfloor + 1 + i \bmod 7\right)$$
# Implementation
## Java
```Java title='Problem 1716 in Java: Mathematical solution'
class Solution {
  public int totalMoney(int n) {
    int total = 0;
    for (int i = 0; i < n; i++) {
      total += i / 7 + 1 + i % 7;
    }
    return total;
  }
}
```
# Complexity
## Time complexity
- $O(n)$
## Space complexity
- $O(1)$
***
# References
1. https://leetcode.com/problems/calculate-money-in-leetcode-bank/description/
2. 