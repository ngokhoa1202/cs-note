#leetcode #frequency-table 
# Algorithm
## Frequency table
# Implementation
## Java
```Java title='Problem 383 in Java: Frequency table solution'
class Solution {
  public boolean canConstruct(String ransomNote, String magazine) {
    int[] magazineLetterFreq = new int[26];
    magazine.chars().forEach((letter) -> {
      magazineLetterFreq[letter - 'a']++;
    });
    ransomNote.chars().forEach((letter) -> {
      magazineLetterFreq[letter - 'a']--;
    });

    for (final var freq: magazineLetterFreq) {
      if (freq < 0) return false;
    }
    return true;
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
1. https://leetcode.com/problems/ransom-note/description/
2. 