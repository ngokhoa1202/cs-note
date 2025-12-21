#leetcode #brute-force #java #geometry
# Algorithm
## Brute-force approach
- Use three-loop scan to find three points that satisfy *triangle inequality*.
# Implementation
## Java
```Java title='Problem 1037 in Java: Brute-force approach with Triangle inequality'
class Solution {
  public boolean isBoomerang(int[][] points) {
    double ij = 0, jk = 0, ki = 0;
    final double epsilon = 1e-5;
    for (int i = 0; i < points.length-2; i++) {
      for (int j = i+1; j < points.length-1; j++) {
        for (int k = j+1; k < points.length; k++) {
          ij = Math.sqrt( (double) (points[j][0] - points[i][0]) * (points[j][0] - points[i][0]) + (double) (points[j][1] - points[i][1]) * (points[j][1] - points[i][1]) );
          jk = Math.sqrt( (double) (points[k][0] - points[j][0]) * (points[k][0] - points[j][0]) + (double) (points[k][1] - points[j][1]) * (points[k][1] - points[j][1]) );
          ki = Math.sqrt( (double) (points[k][0] - points[i][0]) * (points[k][0] - points[i][0]) + (double) (points[k][1] - points[i][1]) * (points[k][1] - points[i][1]) );
          if (ij > 0 && jk > 0 && ki > 0 &&
            jk + ki - ij > epsilon && ki + ij - jk > epsilon && ij + jk - ki > epsilon
          ) {
            System.out.println(ij + " " + jk + " " + ki);
            return true;
          }
        }
      }
    }
    return false;
  }
}
```
# Complexity
- Let $n$ be the length of the original array.
## Time complexity
- The time complexity is $$T(n)=\Theta((n-2)(n-1)n)=O(n^3)$$
## Space complexity
- $O(n)$
- The auxiliary space is $O(1)$.
***
# References
1. https://leetcode.com/problems/valid-boomerang/description/
2. 