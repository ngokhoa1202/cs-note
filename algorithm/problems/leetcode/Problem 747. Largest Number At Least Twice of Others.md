#leetcode #array #go 
# Algorithm
## Linear search
- Do a linear search to find the index of maximum element in the array.
- Keep doing a linear search to check whether the maximum element is at least twice as much as other elements or not.
# Implementation
## Java
```Java title='Problem 747 in Java: Linear search solution'
class Solution {
  public int dominantIndex(int[] nums) {
    int maxIdx = 0;
    for (int i = 1; i < nums.length; ++i) {
      if (nums[i] > nums[maxIdx]) {
        maxIdx = i;
      }
    }
    boolean atLeastTwice = true;
    for (int i = 0; i < nums.length; ++i) {
      if (i != maxIdx && 2 * nums[i] > nums[maxIdx]) {
        return -1;
      }
    }
    return maxIdx;
  }
}
```
## Go
```Go title='Problem 747 in Go: Linear search solution'
func dominantIndex(nums []int) int {
  maxIdx := 0
  for i := 0; i < len(nums); i++ {
    if (nums[i] > nums[maxIdx]) {
      maxIdx = i;
    }
  }
  for i := 0; i < len(nums); i++ {
    if (i != maxIdx && 2 * nums[i] > nums[maxIdx]) {
      return -1;
    }
  }
  return maxIdx;
}
```
# Complexity
## Time complexity
- $\Theta(2n)=O(n)$
## Space complexity
- $\Theta(n)$
***
# References
1. https://leetcode.com/problems/largest-number-at-least-twice-of-others/description/
2. 