#leetcode #array #sorting #quicksort 
# Algorithm
## Quick sort, then linear scan
- Allocate the new array with the same content as the `heights` array.
- Perform quick sort on the new array.
- Do a linear scan to find the number of different values. 
# Implementation
```Java title='Problem 1051 in Java: Quick sort, then linear scan'
class Solution {
  public int heightChecker(int[] heights) {
    int[] sortedHeights = Arrays.copyOf(heights, heights.length);
    this.sort(sortedHeights, 0, heights.length-1);
    int counter = 0;
    for (int i = 0; i < heights.length; ++i) {
      if (heights[i] != sortedHeights[i]) {
        counter++;
      }
    }
    return counter;
  }

  private void sort(int[] nums, int low, int high) {
    if (low < high) {
      final var k = this.partition(nums, low, high);
      this.sort(nums, low, k - 1);
      this.sort(nums, k + 1, high);
    }
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
    this.swap(nums, i + 1, high);
    return i + 1;
  }

  private void swap(int[] nums, int i, int j) {
    final var tmp = nums[i];
    nums[i] = nums[j];
    nums[j] = tmp;
  }
}
```
## Go
```Go title='Problem 1051 in Go: Quick sort, then linear scan'
func heightChecker(heights []int) int {
  sortedHeights := make([]int, len(heights))
  copy(sortedHeights, heights)
  Sort(heights, 0, len(heights)-1)
  counter := 0
  for i := 0; i < len(heights); i++ {
    if (sortedHeights[i] != heights[i]) {
      counter++
    }
  }
  return counter
}

func Sort(nums []int, low int, high int) {
  if (low < high) {
    k := Partition(nums, low, high)
    Sort(nums, low, k - 1)
    Sort(nums, k + 1, high)
  }
}

func Partition(nums []int, low int, high int) int {
  pivot := nums[high]
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
# Complexity
## Time complexity
- $\Theta(n\text{log}(n) + n)=\Theta(n)=O(n)$
## Space complexity
- $\Theta(2n)=\Theta(n)=O(n)$
- The auxiliary space is $\Theta(n)$
***
# References
1. https://leetcode.com/problems/height-checker/description/\
2. 