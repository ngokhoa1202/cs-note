#leetcode #binary-search 
# Algorithm
## Binary search
# Implementation
## Java
```Java title='Problem 374 in Java: Binary search'
/** 
 * Forward declaration of guess API.
 * @param  num   your guess
 * @return 	     -1 if num is higher than the picked number
 *			      1 if num is lower than the picked number
 *               otherwise return 0
 * int guess(int num);
 */

public class Solution extends GuessGame {
  public int guessNumber(int n) {
    int start = 1, end = n;
    while (start <= end) {
      int mid = start + (end-start)/2;
      if (this.guess(mid) == 0) return mid;
      if (this.guess(mid) == -1) {
        end = mid -1;
      } else {
        start = mid + 1;
      }
    }
    return start;
  }
}
```
# Complexity
## Time complexity
- $O(n\text{log}n)$
## Space complexity
- $O(1)$
***
# References
1. https://leetcode.com/problems/guess-number-higher-or-lower/description/
2. 