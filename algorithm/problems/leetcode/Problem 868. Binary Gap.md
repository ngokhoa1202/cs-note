#leetcode #bit-manipulation 
# Algorithm
## Convert to binary

# Implementation
## Java
```Java title='Problem 868 in Java: Convert to binary solution'
class Solution {
  public int binaryGap(int n) {
    StringBuilder builder = new StringBuilder();
    while (n > 0) {
      builder.insert(0, n % 2);
      n /= 2;
    }
    final var binary = builder.toString();
    int maxGap = 0, j = 0;
    for (int i = 0; i < binary.length(); ++i) {
      if (binary.charAt(i) == '1') {
        maxGap = Math.max(maxGap, i - j);
        j = i;
      }
    }
    return maxGap;
  }
}
```
# Complexity
## Time complexity
- $O(\text{log}n)$
## Space complexity
- $O(\text{log}n)$

***
# References
1. https://leetcode.com/problems/binary-gap/description/
2. 