#leetcode #hash-table #set #java 
# Algorithm
## Hash table
# Implementation
## Java
```Java title='Problem 771 in Java: Hash table solution'
class Solution {
  public int numJewelsInStones(String jewels, String stones) {
    Set<Character> jewelStones = new HashSet<Character>(jewels.length());
    for (final var jewel: jewels.toCharArray()) {
      jewelStones.add(jewel);
    }
    int counter = 0;
    for (final var stone: stones.toCharArray()) {
      if (jewelStones.contains(stone)) {
        counter++;
      }
    }
    return counter;
  }
}
```
# Complexity
## Time complexity
- $O(n)$
## Space complexity
- $\Theta(2n)=O(n)$
- The auxiliary space is $O(n)$.
***
# References
1. https://leetcode.com/problems/jewels-and-stones/description/
2. 