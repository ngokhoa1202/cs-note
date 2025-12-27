#leetcode #array #sorting #quicksort #java #go #javascript 
# Algorithm
## Sort, then transform the array
# Implementation
## Java
```Java title='Problem 977 in Java: Sort, then transform the array solution'
class Solution {
  public int[] sortedSquares(int[] nums) {
    for (int i = 0; i < nums.length; ++i) {
      nums[i] = nums[i] * nums[i];
    }
    this.sort(nums, 0, nums.length - 1);
    return nums;
  }

  private void swap(int nums[], int i, int j) {
    final var tmp = nums[i];
    nums[i] = nums[j];
    nums[j] = tmp;
  }

  private int partition(int[] nums, int low, int high) {
    final var pivot = nums[high];
    int i = low - 1;
    for (int j = low; j < high; ++j) {
      if (nums[j] <= pivot) {
        i++;
        this.swap(nums, i, j);
      }
    }
    this.swap(nums, i+1, high);
    return i+1;
  }

  private void sort(int[] nums, int low, int high) {
    if (low < high) {
      final var k = this.partition(nums, low, high);
      this.sort(nums, low, k - 1);
      this.sort(nums, k + 1, high);
    }
  }
}
```
## Go
```Go title='Problem 977 in Java: Sort, then transform the array solution'
func sortedSquares(nums []int) []int {
  for i := range nums {
    nums[i] = nums[i] * nums[i]
  }
  sort(nums, 0, len(nums) - 1)
  return nums
}

func sort(nums []int, low int, high int) {
  if (low < high) {
    var k int = partition(nums, low, high)
    sort(nums, low, k - 1)
    sort(nums, k + 1, high)
  }
}

func partition(nums []int, low int, high int) int {
  var pivot int = nums[high]
  i := low - 1
  for j := low; j < high; j++ {
    if nums[j] <= pivot {
      i++
      nums[i], nums[j] = nums[j], nums[i]
    }
  }
  nums[i+1], nums[high] = nums[high], nums[i+1]
  return i + 1
}
```
## JavaScript
```JavaScript title='Problem 977 in JavaScript: Sort, then transform the array solution'
/**
 * @param {number[]} nums
 * @return {number[]}
 */
const sortedSquares = function(nums) {
  return nums.map((num) => num * num).sort((a, b) => a - b);
};
```
# Complexity
- Let $n$ be the length of the original array.
## Time complexity
- The time complexity is $$T(n)=\Theta(n+n\text{log}(n))=\Theta(n\text{log}n)=O(\text{log}n)$$
## Space complexity
- $\Theta(n)=O(n)$.
- The auxiliary space is $\Theta(1)=O(1)$.
***
# References
1. https://leetcode.com/problems/squares-of-a-sorted-array/description/
2. [[algorithm/algorithm/sorting/internal-sorting/Quick sort|Quick sort]]
3. 