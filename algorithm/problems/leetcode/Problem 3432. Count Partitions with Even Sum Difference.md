#leetcode #array 
# Algorithm
## Mathematical formula
- Let $S$ be the sum of the whole array.
- Let $a_i$ and $b_i$ be respectively the sum of left partition and right partition at index $i$. As a result, $a_i+b_i=S$
- The difference between the two partitions is $$a_i-b_i=a_i-(S-a_i)=2a_i-S$$
- The value of $S$ is always fixed. Therefore, 
	- If $S$ is divisible by $2$, then $a_i-b_i$ is always divisible by $2$. The number of partitions whose even sum difference is the number of feasible partition in the array $n-1$.
	- If $S$ is not divisible by $2$, then $a_i-b_i$ is never divisible by $2$. The number of satisfied partitions become $0$.
# Implementation
## Java
```Java title='Problem 3432 in Java: Mathematical formula solution'
class Solution {
  public int countPartitions(int[] nums) {
    int sum = 0;
    for (final var num: nums)
      sum += num;
    return (sum % 2 == 0) ? nums.length - 1 : 0;
  }
}
```
# Complexity
## Time complexity
- $O(n)$
## Space complexity
- $O(n)$
- The auxiliary space complexity is $O(1)$.
***
# References
1. https://leetcode.com/problems/count-partitions-with-even-sum-difference/description/
2. 