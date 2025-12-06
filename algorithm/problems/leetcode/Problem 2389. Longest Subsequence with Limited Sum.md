#leetcode #binary-search #array #greedy-algorithm #sorting #quicksort 
# Algorithm
## Sort array, calculate accumulative sum and binary search
- The elements are *sorted* to be greedily selected into the sub-sequence because the sub-sequence array must be maximized.
- An array is allocated to calculate the accumulative sum of the sorted array.
- For each element of array $\text{queries}$, a specific position is found in the array $\text{sum}$ so that $\text{sum}_\text{position}$ is maximum and $\text{sum}_\text{position} < \text{queries}_i$  with binary search because the sum array is already in ascending order.
# Implementation
## Java
```Java title='Problem 2389 in Java: Sort array, calculate accumulative sum and binary search solution'
class Solution {
  private int search(int[] nums, int left, int right, int val) {
    int mid = 0;
    while (left <= right) {
      mid = (left + right) / 2;
      if (nums[mid] == val) return mid;
      else if (nums[mid] < val)
        left = mid + 1;
      else right = mid - 1; 
    }
    return left;
  }

  public int[] answerQueries(int[] nums, int[] queries) {
    this.sort(nums, 0, nums.length - 1);
    int[] sums = new int[nums.length];
    int[] sizes = new int[queries.length];
  
    sums[0] = nums[0];
    for (int i = 1; i < sums.length; ++i)
      sums[i] = sums[i-1] + nums[i]; 
    for (int i = 0; i < queries.length; ++i) {
      int position = this.search(sums, 0, sums.length - 1, queries[i]);
      if (position < 0) sizes[i] = 0;
      else if (position >= sums.length) sizes[i] = sums.length;
      else if (sums[position] <= queries[i]) sizes[i] = position + 1;
      else sizes[i] = position;
    }
    return sizes;
  }

  public void sort(int[] nums, int low, int high) {
    if (low < high) {
      final int k = this.partition(nums, low, high);
      this.sort(nums, low, k - 1);
      this.sort(nums, k + 1, high);
    }
  }

  private int partition(int[] nums, int low, int high) {
    final int pivot = nums[high];
    int i = low - 1;
    for (int j = low; j < high; ++j)
      if (nums[j] <= pivot) {
        i++;
        this.swap(nums, i, j);
      }
    this.swap(nums, i+1, high);
    return i + 1;
  }

  private void swap(int[] nums, int i, int j) {
    final int tmp = nums[i];
    nums[i] = nums[j];
    nums[j] = tmp;
  }
}
```
# Complexity
## Time complexity
- $\Theta(n\text{log}n, m)$
## Space complexity
- $\Theta(n,m)$
***
# References
1. [[Quick sort]]
2. [[Binary search]]
