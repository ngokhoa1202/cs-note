#leetcode #string #go #java #array #matrix #brute-force 
# Algorithm
## Brute-force approach - two loops

# Implementation
## Java
```Java title='Problem 944 in Java: Brute-force approach'
class Solution {
  public int minDeletionSize(String[] strs) {
    int counter = 0, rows = strs.length, cols = strs[0].length();
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows-1; j++) {
        if (strs[j].charAt(i) > strs[j+1].charAt(i)) {
          counter++;
          break;
        }
      }
    }
    return counter;
  }
}
```
## Go
```Go title='Problem 944 in Go: Brute-force approach'
func minDeletionSize(strs []string) int {
  counter, rows, cols := 0, len(strs), len(strs[0])
  for i := 0; i < cols; i++ {
    for j := 0; j < rows - 1; j++ {
      if strs[j][i] > strs[j+1][i] {
        counter++
        break;
      }
    }
  }
  return counter;
}
```
# Complexity
- Let $n$ be the the length of string array and $\overline{m}$ be the average length of every string in the array.
## Time complexity
- $O(\overline{m}n)$
## Space complexity
- $O(\overline{m}n)$
***
# References
1. https://leetcode.com/problems/delete-columns-to-make-sorted/description/
2. 