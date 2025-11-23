#leetcode #string #recursion 
# Algorithm
## Recursive palindrome check and modification
# Implementation
## Java
```Java title='Problem 2697 in Java: Recursive palindrome check and modification solution'
class Solution {
  public String makeSmallestPalindrome(String s) {
    return this.makeSmallestPalindromeHelper(s, 0);
  }

  private String makeSmallestPalindromeHelper(String s, int index) {
    if (index == s.length() / 2) return s;
    if (s.charAt(index) == s.charAt(s.length() - 1 - index))
      return this.makeSmallestPalindromeHelper(s, index + 1);
    final var strReplaced = (s.charAt(index) > s.charAt(s.length() - 1 - index)) ? s.substring(0, index) + String.valueOf(s.charAt(s.length() - 1 - index)) + s.substring(index + 1) : s.substring(0, s.length() - 1 - index) + String.valueOf(s.charAt(index)) + s.substring(s.length() - index);
    return this.makeSmallestPalindromeHelper(strReplaced, index + 1);
  }
}
```
# Complexity
## Time complexity
- $O(n)$
## Space complexity
- $O(n)$
***
# References
1. https://leetcode.com/problems/lexicographically-smallest-palindrome/description/
2. 
