#string #frequency-table #leetcode 
# Algorithm
## Letter frequency table
# Implementation
## Java
```Java title='Problem 387 in Java: Letter frequency table'
class Solution {
  public int firstUniqChar(String s) {
    int[] freq = new int[26];
    s.chars().forEach((letter) -> {
      freq[letter - 'a']++;
    });
    for (int i = 0; i < s.length(); ++i) {
      if (freq[s.charAt(i) - 'a'] == 1) return i;
    }
    return -1;
  }
}
```
***
# References
1. https://leetcode.com/problems/first-unique-character-in-a-string/description/
2. 