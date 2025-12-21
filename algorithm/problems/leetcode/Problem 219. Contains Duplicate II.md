#leetcode #associative-array #java 
# Algorithm
## Associative array storing value to index
- Allocates an associative array $M: v \mapsto i$ storing the corresponding index $i$ for each element $e_i$ in the original array.
- Does a single linear scan to check whether the map has already contained the element $e_i$ and $|M(e_i)-i|\leq k$ or not; otherwise, puts the pair $(e_i, i)$ into the map.
# Implementation
## Java
```Java title='Problem 219 in Java: Associative array storing value to index solution'
class Solution {
  public boolean containsNearbyDuplicate(int[] nums, int k) {
    Map<Integer, Integer> valueToIndex = new HashMap<Integer, Integer>(nums.length);
    for (int i = 0; i < nums.length; ++i) {
      if (valueToIndex.containsKey(nums[i]) && Math.abs(valueToIndex.get(nums[i]) - i) <= k) {
        return true;
      } else {
        valueToIndex.put(nums[i], i);
      }
    }
    return false;
  }
}
```
# Complexity
## Time complexity
- $\Theta(n)=O(n)$.
## Space complexity
- $\Theta(2n)=O(n)$.
- The auxiliary space is $\Theta(n)=O(n)$.
***
# References
1. https://leetcode.com/problems/contains-duplicate-ii/description/
2. 