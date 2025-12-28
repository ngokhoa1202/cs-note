#algorithm #binary-search #binary-tree #binary-search-tree #tree #array #list #java #go 
# Algorithm
## Array representation
- The array must be monotone, either monotonically increasing or decreasing.
- The search interval is initialized to the whole array $\left[0, n\right]$
- The search interval is repeatedly halved as follow:
	- If the search key is in the middle of the interval, it is immediately returned.
	- If the search key is less than the item in the middle of the interval, narrow the interval to the lower half; otherwise narrow it to the upper half.
# Implementation
## Java
### Inclusive right boundary
```Java title='Binary search in Java'
class BinarySearch {
  public static int search(int[] nums, int left, int right, int val) {
    int mid = 0;
    while (left <= right) {
      mid = (left + right) / 2;
      if (nums[mid] == val) return mid;
      else if (nums[mid] < val)
        left = mid + 1;
      else right = mid - 1; 
    }
    return -1;
  }
  
  public static void main(String[] args) {
    int[] nums = new int[]{12, 34, 45, 56, 89, 100};
    int val = 34;
    search(nums, 0, nums.length-1, val);
  }
}
```
### Exclusive right boundary
## Go
### Inclusive right boundary
# Complexity
## Time complexity
- $O(\text{log}(n))$
## Space complexity
- $O(n)$
***
# References
1. 