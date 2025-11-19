#leetcode #bit-manipulation #array 
# Algorithm
## Recursive checking
- Let $f: (\text{bits}: \text{integer}[], i: \text{integer}) \mapsto \text{boolean}$ be the function that checks whether the last character is 1-bit or not. $$f(b,i)=\begin{cases}\text{false} \space \text{when} \space i \geq b.\text{length}\\ \text{true} \space \text{when} \space i=b.\text{length}-1 \land b_i=0 \\ f(b,i+1) \space\text{when } b_i=0 \\ f(b,i+2) \space\text{when } b_i=1 \end{cases}$$
# Implementation
## Java
```Java title='Problem 707 in Java: Recursive checking solution'
class Solution {
  public boolean isOneBitCharacter(int[] bits) {
    return this.isOneBitCharacterHelper(bits, 0);
  }

  private boolean isOneBitCharacterHelper(int[] bits, int index) {
    if (index >= bits.length) return false;
    if (index == bits.length - 1 && bits[index] == 0)
      return true;
    if (bits[index] == 0)
      return this.isOneBitCharacterHelper(bits, index + 1);
    return this.isOneBitCharacterHelper(bits, index + 2);
  }
}
```
# Complexity
## Time complexity

## Space complexity

***
# References
1. 