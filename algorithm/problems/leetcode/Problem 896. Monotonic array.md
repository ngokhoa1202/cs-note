#leetcode #array 
# Algorithm
## Two consecutive monotonic checks
# Implementation
## Java
```Java title='Problem 896 in Java: Two consecutiv monotonic checks'
class Solution {
  public boolean isMonotonic(int[] nums) {
    if (nums.length == 1) return true;
    int i = 1;
    // monotonically decreasing
    while (i < nums.length && nums[i] <= nums[i-1]) i++;
    if (i == nums.length) return true;
    i = 1;
    // monotonically increasing
    while (i < nums.length && nums[i] >= nums[i-1]) i++;
    if (i == nums.length) return true;
    return false;
  }
}
```
***
# References
1. https://leetcode.com/problems/monotonic-array/description/
2. 