#leetcode #matrix #binary-search #array #brute-force 
# Algorithm
## Brute-force approach
- For each row in the original matrix, find the first index of negative elements with linear scan.
- Because each row is already sorted in descending order, calculate the number of negative values based on those indexes.
## Binary search
- Because each row in the matrix is already sorted in descending order, perform binary search on each row to find the first index of negative elements.
- Because each row is already sorted in descending order, calculate the number of negative values based on those indexes.
# Implementation
## Java
### Brute-force approach
```Java title='Problem 1351 in Java: Brute-force approach'
class Solution {
  public int countNegatives(int[][] grid) {
    int counter = 0;
    for (final var nums: grid) {
      int idx = this.firstIndexOfNegative(nums, 0, nums.length-1);
      counter += (idx == -1) ? 0 : nums.length - idx;
    }
    return counter;
  }

  private int firstIndexOfNegative(int[] nums, int left, int right) {
    int mid = 0, firstNegative = -1;
    while (left <= right) {
      mid = (left + right) / 2;
      if (left == right) {
        if (nums[mid] < 0) return mid;
        else return firstNegative;
      }
      if (nums[mid] < 0) {
        firstNegative = mid;
        right = mid - 1;
      }
      else if (nums[mid] >= 0) {
        left = mid + 1;
      }
    }
    return firstNegative;
  }
}
```
### Binary search
```Java title='Problem 1351 in Java: Binary search solution'
class Solution {
  public int countNegatives(int[][] grid) {
    int counter = 0;
    for (final var nums: grid) {
      int idx = this.firstIndexOfNegative(nums, 0, nums.length-1);
      counter += (idx == -1) ? 0 : nums.length - idx;
    }
    return counter;
  }

  private int firstIndexOfNegative(int[] nums, int left, int right) {
    int mid = 0, firstNegative = -1;
    while (left <= right) {
      mid = (left + right) / 2;
      if (left == right) {
        if (nums[mid] < 0) return mid;
        else return firstNegative;
      }
      if (nums[mid] < 0) {
        firstNegative = mid;
        right = mid - 1;
      }
      else {
        left = mid + 1
      }
    }
    return firstNegative;
  }
}
```
## Go
### Binary search
```Go title='Problem 1351 in Go: Binary search solution'
func countNegatives(grid [][]int) int {
  counter := 0
  for _, row := range grid {
    index := firstIndexOfNegatives(row, 0, len(row) - 1)
    if index != -1 {
      counter += len(row) - index
    }
  }
  return counter
}

func firstIndexOfNegatives(nums []int, left int, right int) int {
  mid, firstNegative := 0, -1
  for left <= right {
    mid = (left + right) / 2
    if left == right {
      if nums[mid] < 0 {
        return mid
      } else {
        return firstNegative
      }
    }
    if nums[mid] < 0 {
      firstNegative = mid
      right = mid - 1
    } else {
      left = mid + 1
    }
  }
  return firstNegative
}

```
# Complexity
- Let $m$ and $n$ be the number of row and the number of column of the original matrix.
## Time complexity
### Brute-force approach
- The time complexity for searching the first index of negative elements in each row is $$\Theta(\frac{1}{n}\times\sum_{i=1}^n i)=\Theta(\frac{n+1}{2})=O(n)$$
- The final time complexity is $$T(m,n)=\Theta(m)\Theta(\frac{n+1}{2})=O(mn)$$
### Binary search solution
- The time complexity for searching the first index of negative elements in each row is $$\Theta(\text{log}n)$$
- The final time complexity is $$T(m,n)=\Theta(m)\Theta(\text{log}n)=\Theta(m\text{log}n)=O(m\text{log}n)$$
## Space complexity
- $\Theta(mn)=O(mn)$.
- The auxiliary space is $\Theta(1)=O(1)$.
***
# References
1. https://leetcode.com/problems/count-negative-numbers-in-a-sorted-matrix/description/
2. [[algorithm/algorithm/search/Binary search|Binary search]]
3. 