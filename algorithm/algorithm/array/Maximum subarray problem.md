#algorithm #array #java #two-pointer
# Problem
- Given an integer array $a$, find the *contiguous subarray* (containing at least one element) which has the **maximum possible sum**, and return that sum.
# Algorithm
## Naive approach
- Two loops are used iterate the array and find the maximum sum. Let $f(a)$ be the maximum value of contiguous array sum. Its mathematical formula is: $$f(a)=\text{max}_{1 \leq i \leq j \leq n}\left(\sum_{k=i}^j a_k\right)$$
## Kadane's algorithm
### Imperative approach
- <mark class="hltr-yellow">The prefix sum is removed whenever it is negative</mark>.
- Only one loop is used but the accumulative sum is reset to zero whenever the sum of itself and the current element is negative.
### Recursive approach
- Let $f(i)$ be the maximum sum of a contiguous subarray ending at index $i$. Its recurrence relation formula is $$f(i)=\begin{cases}a_0 \text{ when }i=0\\\max \{f(i-1)+a_i,a_i\} \text{ otherwise}\end{cases}$$
- Let $g(a)$ be the global maximum of the given array. Its mathematical formula is $$g(a)=\max_{0\leq i < n}f(i)$$
# Implementation
## Java
### Naive approach
```Java title='Maxium subarray problem in Java: naive approach'
class Solution {
  public int maxSubArray(int[] nums) {
    int maxSum = Integer.MIN_VALUE;
    for (int i = 0; i < nums.length; ++i) {
      int sum = 0;
      for (int j = i; j < nums.length; ++j) {
        sum += nums[j];
        maxSum = Math.max(maxSum, sum);
      }

    }
    return maxSum;
  }
}
```
### Kadane's algorithm
#### Imperative approach
```Java title='Maximum subarray problem in Java: Kadane algorithm with imperative approach' hl=5-6
class Solution {
  public int maxSubArray(int[] nums) {
    int sum = nums[0], max = nums[0];
    for (int i = 1; i < nums.length; ++i) {
      if (sum < 0)
        sum = 0;
      sum += nums[i];
      max = Math.max(max, sum);
    }
    return max;
  }
}
```
#### Recursive approach

# Complexity
## Time complexity
### Naive approach
- $O(n^2)$
### Kadane's algorithm
- $O(n)$
## Space complexity
### Naive approach
- $O(n)$
### Kadane's algorithm
- $O(n)$
***
# References
1. https://en.wikipedia.org/wiki/Maximum_subarray_problem
2. 