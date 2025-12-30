#leetcode #array #java #go 
# Algorithm
## Linear scan
- Employ a linear scan to find the locally maximum number in the array.
# Implementation
- Boundary elements should be carefully checked.
## Java
### Linear scan
```Java title='Problem 162 in Java: Linear scan solution'
class Solution {
  public int findPeakElement(int[] nums) {
    if (nums.length == 1) return 0;
    for (int i = 0; i < nums.length; ++i) {
      if (i == 0 && nums[i] > nums[i+1]) {
        return i;
      }
      if (i == nums.length-1 && nums[i] > nums[i-1]) {
        return i;
      }
      if (i > 0 && i < nums.length-1 && nums[i] > nums[i-1] && nums[i] > nums[i+1]) {
        return i;
      }
    }
    return -1;
  }
}
```
## Go
```Go title='Problem 162 in Go: Linear scan solution'
func findPeakElement(nums []int) int {
  if len(nums) == 1 {
    return 0
  }

  for i, _ := range nums {
    if (i == 0 && nums[i] > nums[i+1]) {
      return i
    }
    if (i == len(nums) - 1 && nums[i] > nums[i-1]) {
      return i
    }
    if (i > 0 && i < len(nums)-1 && nums[i] > nums[i-1] && nums[i] > nums[i+1]) {
      return i
    }
  }
  return -1
}
```
# Complexity
## Time complexity
- $\Theta(n)$.
## Space complexity
- $\Theta(n)$.
- The auxiliary space is $\Theta(1)$.
***
# References
1. https://leetcode.com/problems/find-peak-element/description/
2. 