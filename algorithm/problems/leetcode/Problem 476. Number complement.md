#leetcode #bit-manipulation 
# Algorithm
## Mathematical formula
- Given the number $n$, the binary complement $c$ of $n$ is represented in decimal as: $$c=2^k-n \geq 0 \implies k \geq \text{log}_2(n)$$ and $k$ needs to be minimum. 
- So, $k=\lfloor \text{log}_2(n) \rfloor + 1$
# Implementation
## Java
- The `int` data type can be overflowed when $n$ is large, so type casting should be used.
```Java title='Problem 476 in Java: mathematical formula solution'
class Solution {
  public int findComplement(int num) {
    int n = (int) (Math.log(num) / Math.log(2)) + 1;
    return (int) ((long) Math.pow(2, n) - 1 - num);
  }
}
```
## JavaScript

## TypeScript

***
# References
1. https://leetcode.com/problems/number-complement/description/
2. 