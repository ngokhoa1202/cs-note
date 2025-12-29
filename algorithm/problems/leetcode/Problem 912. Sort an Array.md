#leetcode #algorithm #sorting #quicksort #java 
# Algorithm
## Quicksort
### Hoare's partition
- The Hoare's partition is significantly faster than the Lomuto's partition in large test cases.
### Lomuto's partition
- The quicksort with Lomuto's partition does not pass the time limit for this problem.
# Implementation
## Java
### Quicksort with Hoare's partition
```Java title='Problem 912 in Java: Quicksort with Hoare's partition'
public class Solution {
  public int[] sortArray(int[] nums) {
    this.sort(nums, 0, nums.length - 1);
    return nums;
  }

  private void sort(int[] nums, int low, int high) {
    if (low < high) {
      final var k = this.partition(nums, low, high);
      this.sort(nums, low, k);
      this.sort(nums, k + 1, high);
    }
  }

  private void swap(int[] nums, int i, int j) {
    final var tmp = nums[i];
    nums[i] = nums[j];
    nums[j] = tmp;
  }

  private int partition(int[] arr, int low, int high) {
    int pivot = arr[low]; // Choose first element as pivot
    int i = low - 1;
    int j = high + 1;

    while (true) {
      // Find element on left that should be on right
      do {
        i++;
      } while (arr[i] < pivot);

      // Find element on right that should be on left
      do {
        j--;
      } while (arr[j] > pivot);

      // If pointers crossed, partition is complete
      if (i >= j) {
        return j;
      }

      swap(arr, i, j);
    }
  }
}
```
# Testcases
- The Lomuto's partition fails if the array is already sorted and its size is large.
- The quicksort with Lomuto's partition does not pass the time limit if the array is already sorted and its size is large.
# Complexity
## Time complexity
- $\Theta(n\text{log}n)$
## Space complexity
- $\Theta(n)$
- The auxiliary space is $\Theta(1)$
***
# References
1. https://leetcode.com/problems/sort-an-array/description/
2. [[algorithm/algorithm/sorting/internal-sorting/Quick sort|Quick sort]]
3. 