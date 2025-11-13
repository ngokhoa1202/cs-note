#leetcode  #array 
# Algorithm
## In-place array - two pointers

## New array
# Implementation
## Java
```Java title='Problem 283 in Java: solution 1'
class Solution {
     public void moveZeroes(int[] nums) {
        int i = 0, j = 0;
        while (i < nums.length && j < nums.length) {
            while (i < nums.length && nums[i] != 0) i++; // first unordered zero
            j = i + 1;
            while (j < nums.length && nums[j] == 0) j++; // first unordered non zero after i
            if (i < nums.length && j < nums.length) {
                int tmp = nums[i];
                nums[i] = nums[j];
                nums[j] = tmp;
            }
        }
    }
}
```
## JavaScript
```JavaScript title='Problem 283 in JavaScript: Solution 2'
/**
 Do not return anything, modify nums in-place instead.
 */
function moveZeroes(nums: number[]): void {
    let i = 0, j = 0;
    while (i < nums.length && j < nums.length) {
        while (i < nums.length && nums[i] === 0) i++; // first unordered zero
        j = i + 1;
        while (j < nums.length && nums[j] !== 0) j++; // first unordered non zero after i
        if (i < nums.length && j < nums.length) [i, j] = [j, i];
    }
};
```
## TypeScript
```TypeScript title='Problm 283 in TypeScript: Solution 1'
/**
 Do not return anything, modify nums in-place instead.
 */
function moveZeroes(nums: number[]): void {
    let i = 0, j = 0;
    while (i < nums.length && j < nums.length) {
        while (i < nums.length && nums[i] === 0) i++; // first unordered zero
        j = i + 1;
        while (j < nums.length && nums[j] !== 0) j++; // first unordered non zero after i
        if (i < nums.length && j < nums.length) [i, j] = [j, i];
    }
};
```
# Complexity
## Time complexity
- $O(n)$
## Space complexity
- $O(n)$
---
# References
1. 