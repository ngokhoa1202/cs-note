#leetcode #string 
# Algorithm
## Frequency table
# Implementation
## Java
```Java title='Problem 242 in Java'
class Solution {
    public boolean isAnagram(String s, String t) {
        return Arrays.equals(this.getFrequency(s), this.getFrequency(t));
    }

    private int[] getFrequency(String s) {
        int[] freq = new int[26];
        s.chars().forEach((letter) -> {
            freq[letter - 'a']++;
        });
        return freq;
    }
};
```
# Complexity
- 
## Time complexity
- $O(n)$
## Space complexity
- $O(n)$
---
# References
1. https://leetcode.com/problems/valid-anagram/description/
2. [[Problem 49. Group anagrams]]