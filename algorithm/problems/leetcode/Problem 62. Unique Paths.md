#leetcode #dynamic-programming #recursion 
# Algorithm
## Recursion - Naive approach
- Let $u(m,n)$ is the number of unique paths for the robot to move from $(0,0)$ to $(m,n)$. The formula of $u$ is: $$u(m,n)=\begin{cases}0 \space\text{when}\space m<1 \lor n<1 \\1 \space \text{if}\space m=n=1\\ u(m-1,n)+u(m,n-1) \space\text{if}\space m>1 \land n>1\end{cases}$$
# Implementation
## Java
```Java title='Problem 62 in Java: Naive approach'
class Solution {
    public int uniquePaths(int m, int n) {
        if (m < 1 || n < 1) return 0;
        if (m == 1 && n == 1) return 1;
        int noOfPathsIfMoveDown = this.uniquePaths(m-1, n);
        int noOfPathsIfMoveRight = this.uniquePaths(m, n-1);
        return noOfPathsIfMoveDown + noOfPathsIfMoveRight;
    }
}
```
## TypeScript

## JavaScript

***
# References
1. https://leetcode.com/problems/unique-paths/