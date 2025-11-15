#string #leetcode 
# Algorithm
## String representation
# Implementation
## Java
```Java title='Problem 415 in Java: String representation solution'
class Solution {
  public String addStrings(String num1, String num2) {
    while (num1.length() < num2.length()) num1 = "0" + num1;
    while (num2.length() < num1.length()) num2 = "0" + num2;
    StringBuilder builder = new StringBuilder();
    int carrier = 0, sum = 0;
    for (int i = num1.length() - 1; i > -1; i--) {
      sum = (num1.charAt(i) - '0') + (num2.charAt(i) - '0') + carrier;
      builder.insert(0, sum % 10);
      carrier = sum / 10;
    }
    if (carrier != 0) builder.insert(0, 1);
    return builder.toString();
  }
}
```
# Complexity
- Let $n_1$ and $n_2$ is the integer value of the two numbers.
## Time complexity
- $O(\text{log}(\text{max}(n_1, n_2)))$
## Space complexity
- $O(\text{log}n_1 + \text{log}n_2)$
***
# References
1. https://leetcode.com/problems/add-strings/description/
2. 