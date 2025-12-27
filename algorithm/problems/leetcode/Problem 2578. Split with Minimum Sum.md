#leetcode #greedy-algorithm 
# Algorithm
## Sort, split and assign digits alternatively
- The original number digits are sorted into ascending order because the large digits should be placed in most significant positions.
- The digits are alternatively assigned to $\text{num}_1$ and $\text{num}_2$ for sum calculation.
# Implementation
## Java
```Java title='Problem 2578 in Java: sort, split and assign digits alternatively solution'
class Solution {
  public int splitNum(int num) {
    String originalNumber = String.valueOf(num);
    char[] numbers = originalNumber.toCharArray();
    Arrays.sort(numbers);
    String sortedNumber = new String(numbers);
    final var builder1 = new StringBuilder("");
    final var builder2 = new StringBuilder("");
    for (int i = 0; i < sortedNumber.length(); ++i) {
      if (i % 2 == 0)
        builder1.append(sortedNumber.charAt(i));
      else builder2.append(sortedNumber.charAt(i));
    }
    return Integer.valueOf(builder1.toString()) + Integer.valueOf(builder2.toString());
  }
}
```
# Complexity

***
# References
1. https://leetcode.com/problems/split-with-minimum-sum/description/
2. [[programming/java/common-problems/functional-programming/Sort a string]] for String sort in Java.
3. 