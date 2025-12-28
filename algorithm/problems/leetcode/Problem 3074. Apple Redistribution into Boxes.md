#leetcode #array #sorting #greedy-algorithm #java #quicksort 
# Algorithm
## Sort and simulate
- Sort the `capacity` array in *descending order* to prioritize boxes with larger size, thereby minimizing the number of boxes that will be used.
- Simulate the distribution of apple. Whenever the left capacity of a box is deficient to hold, the box with largest capacity among the remainders is selected to hold  the apples.
# Implementation
## Java
### Sort and simulate
```Java title='Problem 3074 in Java: Sort and simulate solution'
class Solution {
  public int minimumBoxes(int[] apple, int[] capacity) {
    this.sort(capacity, 0, capacity.length - 1);
    int noOfBoxes = 0, capacityLeft = 0;
    // 1 3 2 : apple
    // 1 2 3 4 5
    for (final var a: apple) {
      while (capacityLeft < a) {
        capacityLeft += capacity[noOfBoxes];
        noOfBoxes++;
      }
      capacityLeft -= a;
    }
    return noOfBoxes;
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
      if (nums[j] > pivot) {
        i++;
        this.swap(nums, i, j);
      }
    }
    this.swap(nums, i + 1, high);
    return i + 1;
  }

  private void swap(int[] nums, int low, int high) {
    final var tmp = nums[low];
    nums[low] = nums[high];
    nums[high] = tmp;
  }
}
```
# Complexity
- Let $n$ and $m$ be the length of the `apple` array and `capacity` array respectively.
## Time complexity
- The time complexity is $$\Theta(m\text{logm}+n)=O(m\text{logm}+n)$$
## Space complexity
- $\Theta(n+m)$
- The auxiliary space is $\Theta(1)$
***
# References
1. https://leetcode.com/problems/apple-redistribution-into-boxes/description/
2. 