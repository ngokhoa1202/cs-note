#leetcode #array 
# Algorithm
## Two pointers

# Implementation
## Java
```Java title='Problem 485 in Java: Two pointers solution'
class Solution {
  public int findMaxConsecutiveOnes(int[] nums) {
    int counter = 0, i = 0, j = 0;
    while (i < nums.length) {
      while (i < nums.length && nums[i] == 0) i++;
      j = i;
      while (j < nums.length && nums[j] == 1) j++; 
      counter = Math.max(counter, j - i);
      i = j;
    }
    return counter;
  }
}
```
## JavaScript
```JavaScript title='Problem 485 in JavaScript: Two pointers solution'
const findMaxConsecutiveOnes = (nums) => {
  let counter = 0, i = 0, j = 0;
  while (i < nums.length) {
    while (i < nums.length && nums[i] == 0) i++; // first index of one
    j = i;
    while (j < nums.length && nums[j] != 0) j++; // first index of next 0
    counter = Math.max(counter, j - i);
    i = j;
  }
  return counter;
} 
```
## TypeScript
```TypeScript title='Problem 485 in TypeScript: Two pointers solution'
function findMaxConsecutiveOnes(nums: number[]): number {
    let counter = 0, i = 0, j = 0;
    while (i < nums.length) {
        while (i < nums.length && nums[i] == 0) i++; // first index of one
        j = i;
        while (j < nums.length && nums[i] != 0) j++; // first index of next 0
        counter = Math.max(counter, j - i);
        i = j;
    }
    return counter;
};
```
# Complexity
## Time complexity
- $O(n)$
## Space complexity
- $O(n)$

***
# References
1. https://leetcode.com/problems/max-consecutive-ones/description/
2. 