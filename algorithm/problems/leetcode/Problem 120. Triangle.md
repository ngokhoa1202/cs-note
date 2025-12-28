#leetcode #dynamic-programming #array #matrix #java #go 
# Algorithm
- Let $n$ be the number of row of the original matrix.
## Dynamic programming from bottom-up
- Creates a matrix $S_{i,j}$ storing the minimum sum calculated with the same row and column as that of the original matrix $M_{i,j}$.
- Initializes the matrix so that the final row is similar to  that of the original matrix. $$S_{n-1,j}=M_{n-1,j}$$
- The following rows of the matrix is calculated from bottom to up as follow. $$S_{i,j}=\min\{M_{i+1,j}, M_{i+1,j+1}\}+M_{i,j}$$
- The final minimum path sum is $S_{0,0}$.
## In-place matrix
- Rather than initializing a new matrix, the original matrix can be reused for the sum matrix.
# Implementation
## Java
```Java title='Problem 120 in Java. Dynamic programming from bottom-up with in-place matrix'
class Solution {
  public int minimumTotal(List<List<Integer>> triangle) {
    int row = triangle.size();
    for (int i = row-2; i > -1; --i) {
      for (int j = 0; j <= i; ++j) {
        int min = Math.min(triangle.get(i+1).get(j), triangle.get(i+1).get(j+1));
        triangle.get(i).set(j, min + triangle.get(i).get(j));
      }
    }
    return triangle.get(0).get(0);
  }
} 
```
## Go
```Go title='Problem 120 in Java. Dynamic programming from bottom-up with in-place matrix'
func minimumTotal(triangle [][]int) int {
  row := len(triangle)
  for i := row - 2; i > -1; i-- {
    for j := 0; j <= i; j++ {
      triangle[i][j] += min(triangle[i+1][j], triangle[i+1][j+1])
    }
  }
  return triangle[0][0]
}
```
# Complexity
- Let $n$ be the number of rows in the original matrix.
## Time complexity
### Dynamic programming from bottom-up
- The time complexity is $$T(n)=\Theta(n+(n-2)(n-1))=\Theta(n^2)=O(n^2)$$
#### In-place matrix
- The time complexity is $$T(n)=\Theta((n-2)(n-1))=\Theta(n^2)=O(n^2)$$
## Space complexity 

### Dynamic programming from bottom-up
#### In-place matrix
- The space complexity is $$\Theta(n(n-1))=O(n^2)$$
- The auxiliary space is $$\Theta(1)$$
#### New matrix
- The space complexity is $$\Theta(2n(n-1))=O(n^2)$$
- The auxiliary space is $$\Theta(n(n-1))=O(n^2)$$
***
# References
1. https://leetcode.com/problems/triangle/
2. 