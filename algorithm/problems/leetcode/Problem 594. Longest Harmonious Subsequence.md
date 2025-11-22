#leetcode #hash #associative-array 
# Algorithm
## Associative array - Map
- An map $M: e \mapsto f$ stores each distinct value of the original array and its occurrence.
- The longest length of harmonious subsequence is $$\max_{0 \leq i < n}(M(e_i)+M(e_i+1))$$, given that the element $e_i+1$ exists in the original array. 
  
# Implementation
## Java
- A `{Java}HashMap` object is used to store the occurrences of element in the array.
```Java title='Problem 594 in Java: Associative array solution'
class Solution {
  public int findLHS(int[] nums) {
    Map<Integer, Integer> occurences = new HashMap<Integer, Integer>();
    for (final var num: nums) {
      occurences.put(num, occurences.getOrDefault(num, 0) + 1);
    }
    int max = 0;
    for (final var entry: occurences.entrySet()) {
      int minOccur = entry.getValue();
      Integer maxOccur = occurences.get(entry.getKey() + 1);
      if (maxOccur != null)
        max = Math.max(max, minOccur + maxOccur.intValue());
    }
    return max;
  }
}
```
# Complexity
## Time complexity
- $O(n)$
## Space complexity
- $O(2n)=O(n)$
***
# References
1. https://leetcode.com/problems/longest-harmonious-subsequence/description/
2. 
