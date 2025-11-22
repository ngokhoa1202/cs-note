#leetcode #sorting #greedy-algorithm 
# Algorithm
## Sorting and greedily fill
- The original `amount` array is sorted in ascending order. 
- For every second, two types of cup *whose largest amount are greater than* 0 are selected to be filled. Then, the array is re-sorted.
- The process ends when the type of cup whose largest amount is zero.
# Implementation
## Java
```Java title='Problem 2335 in Java: Sorting and greedily fill solution'
class Solution {
  public int fillCups(int[] amount) {
    int seconds = 0;
    Arrays.sort(amount);
    while (amount[2] > 0) {
     
      if (amount[1] > 0 && amount[2] > 0) {
        amount[2]--;
        amount[1]--;
      } else if (amount[2] > 0) {
        amount[2]--;
      }
      seconds++;
      Arrays.sort(amount);
    }
    return seconds;
  }
}
```
# Complexity
- Let $m,n,p$ be respectively the amount of cold, warm and hot water cups.
## Time complexity
- $O(m+n+p)$
## Space complexity
- $O(1)$
***
# References
1. https://leetcode.com/problems/minimum-amount-of-time-to-fill-cups/description/
2. 