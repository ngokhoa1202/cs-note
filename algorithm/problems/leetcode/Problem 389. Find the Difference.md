#leetcode #string #frequency-table 
# Algorithm
## Frequency table

# Implementation
## Java
```Java title='Problem 389 in Java: Frequency table'
class Solution {
  public char findTheDifference(String s, String t) {
    int[] freq = new int[26];
    s.chars().forEach((letter) -> {
      freq[letter - 'a']++;
    });
    t.chars().forEach((letter) -> {
      freq[letter - 'a']--;
    });
    int i = 0;
    while (freq[i] != -1)  i++;
    return (char) (i + 'a');
  }
}
```
***
# References
1. https://leetcode.com/problems/find-the-difference/description/
2. 