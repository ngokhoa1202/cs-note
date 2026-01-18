#set #matrix #array #leetcode #dynamic-programming #set
# Algorithm
- The requirement is to check the existence of a partition $P$ in the original array $A$ so that $$\sum_{a \in P} = \frac{S}{2}$$ where $S$ is the total sum of the array.
- If the total sum $S$ is odd, no equal partition exists since $\frac{S}{2}$ is not an integer.
- If $S$ is even, the problem reduces to finding if there exists a subset with sum equal to $\frac{S}{2}$.
## Variant of 0-1 Knapsack problem
- This problem is a variant of 0-1 Knapsack problem since it becomes checking if there exists a partition in the original set whose sum is equal to the half of total array sum.
- Let $K[i, s]$ denote the predicate indicating that there is a ==combination== of the first $i$ elements, whose sum is equal to $s$:
$$K[i, s] = \begin{cases}
\text{true} & \text{if } \exists \text{ subset of } \{a_1, a_2, \ldots, a_i\} \text{ with sum } s \\
\text{false} & \text{otherwise}
\end{cases}$$
- The optimal solution for $K[i, s]$ depends on whether element $a_i$ is included as part of the sum or not:
	- If element $a_i$ cannot be included: $K[i,s]=K[i-1,s]$. This occurs when $a_i > s$ (element is too large).
	- If element $a_i$ ==can be included==: $K[i,s]=K[i-1,s] \lor K[i-1, s-a_i]$. This occurs when $a_i \leq s$.
		- $K[i-1,s]$: subset without $a_i$
		- $K[i-1, s-a_i]$: subset including $a_i$
### Recurrence relation
$$K[i, s] = \begin{cases}
\text{true} & \text{if } i = 0 \text{ and } s = 0 \\
\text{false} & \text{if } i = 0 \text{ and } s > 0 \\
K[i-1, s] & \text{if } a_i > s \\
K[i-1, s] \lor K[i-1, s - a_i] & \text{if } a_i \leq s
\end{cases}$$
- ==Base cases==:
	- $K[0, 0] = \text{true}$: Empty subset has sum $0$
	- $K[0, s] = \text{false}$ for $s > 0$: Cannot achieve positive sum with empty set
### Correctness proof
- ==Claim==: $K[i, s]$ correctly determines if a subset of $\{a_1, \ldots, a_i\}$ sums to $s$.
- ==Proof by induction==:
	- ==Base case==: For $i = 0$:
		- $K[0, 0] = \text{true}$ is correct (empty subset sums to $0$)
		- $K[0, s] = \text{false}$ for $s > 0$ is correct (no elements available)
	- ==Inductive hypothesis==: Assume $K[j, t]$ is correct for all $j < i$ and all $t$.
	- ==Inductive step==: For $K[i, s]$, consider two cases:
		- ==Case 1==: $a_i > s$. Element $a_i$ cannot be included (too large).
			- Any subset summing to $s$ must come from $\{a_1, \ldots, a_{i-1}\}$.
			- By inductive hypothesis, $K[i-1, s]$ correctly determines this.
			- Therefore, $K[i, s] = K[i-1, s]$ is correct.
		- ==Case 2==: $a_i \leq s$. Element $a_i$ can potentially be included.
			- Either: subset without $a_i$ sums to $s$ (captured by $K[i-1, s]$)
			- Or: subset with $a_i$ sums to $s$, meaning remaining elements sum to $s - a_i$ (captured by $K[i-1, s - a_i]$)
			- By inductive hypothesis, both $K[i-1, s]$ and $K[i-1, s - a_i]$ are correct.
			- Therefore, $K[i, s] = K[i-1, s] \lor K[i-1, s - a_i]$ is correct.
## Example trace
- Input: `nums = [1, 5, 11, 5]`
- Total sum: $S = 1 + 5 + 11 + 5 = 22$
- Target sum: $\text{target} = \frac{22}{2} = 11$
- DP table $K[i, s]$ where $i \in [0, 4]$ and $s \in [0, 11]$:
### Initialization
- $K[0, 0] = \text{true}$ (empty subset sums to $0$)
- $K[0, s] = \text{false}$ for $s \in [1, 11]$
### Fill DP table
#### For $i = 1$ (element $a_1 = 1$):
- For $s = 0$: $K[1, 0] = K[0, 0] = \text{true}$
- For $s = 1$: $a_1 = 1 \leq 1$, so $K[1, 1] = K[0, 1] \lor K[0, 0] = \text{false} \lor \text{true} = \text{true}$
- For $s = 2$: $a_1 = 1 \leq 2$, so $K[1, 2] = K[0, 2] \lor K[0, 1] = \text{false} \lor \text{false} = \text{false}$
- For $s \in [3, 11]$: All $\text{false}$
#### For $i = 2$ (element $a_2 = 5$):
- For $s = 0$: $K[2, 0] = \text{true}$
- For $s = 1$: $a_2 = 5 > 1$, so $K[2, 1] = K[1, 1] = \text{true}$
- For $s = 5$: $a_2 = 5 \leq 5$, so $K[2, 5] = K[1, 5] \lor K[1, 0] = \text{false} \lor \text{true} = \text{true}$
- For $s = 6$: $a_2 = 5 \leq 6$, so $K[2, 6] = K[1, 6] \lor K[1, 1] = \text{false} \lor \text{true} = \text{true}$
#### For $i = 3$ (element $a_3 = 11$):
- For $s = 11$: $a_3 = 11 \leq 11$, so $K[3, 11] = K[2, 11] \lor K[2, 0] = \text{false} \lor \text{true} = \text{true}$
#### For $i = 4$ (element $a_4 = 5$):
- For $s = 11$: $a_4 = 5 \leq 11$, so $K[4, 11] = K[3, 11] \lor K[3, 6] = \text{true} \lor \text{true} = \text{true}$
### Complete DP table
|   | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 |
|---|---|---|---|---|---|---|---|---|---|---|----|-----|
| 0 | T | F | F | F | F | F | F | F | F | F | F  | F   |
| 1 | T | T | F | F | F | F | F | F | F | F | F  | F   |
| 2 | T | T | F | F | F | T | T | F | F | F | F  | F   |
| 3 | T | T | F | F | F | T | T | F | F | F | F  | T   |
| 4 | T | T | F | F | F | T | T | F | F | F | T  | T   |
- Result: $K[4, 11] = \text{true}$, so the answer is `true`.
- Explanation: The subset $\{1, 5, 5\}$ sums to $11$, and the remaining subset $\{11\}$ also sums to $11$.
## Example trace 2: False case
- Input: `nums = [1, 2, 5]`
- Total sum: $S = 1 + 2 + 5 = 8$
- Target sum: $\text{target} = \frac{8}{2} = 4$
### Complete DP table
|   | 0 | 1 | 2 | 3 | 4 |
|---|---|---|---|---|---|
| 0 | T | F | F | F | F |
| 1 | T | T | F | F | F |
| 2 | T | T | T | T | F |
| 3 | T | T | T | T | F |
- For $i = 1$ (element $a_1 = 1$): Can achieve sums $\{0, 1\}$
- For $i = 2$ (element $a_2 = 2$): Can achieve sums $\{0, 1, 2, 3\}$
	- $K[2, 3] = K[1, 3] \lor K[1, 1] = \text{false} \lor \text{true} = \text{true}$ (subset $\{1, 2\}$)
- For $i = 3$ (element $a_3 = 5$): Element $5 > 4$, so $K[3, 4] = K[2, 4] = \text{false}$
- Result: $K[3, 4] = \text{false}$, so the answer is `false`.
- Explanation: Cannot form a subset with sum $4$ from $\{1, 2, 5\}$.
# Implementation
## Go
```Go title='Problem 416 in Go: Variant of 0-1 Knapsack problem'
func canPartition(nums []int) bool {
  n, targetSum := len(nums), 0
  for _, val := range nums {
    targetSum += val
  }
  if targetSum % 2 == 1 {
    return false
  }
  targetSum /= 2

  k := make([][]bool, n + 1, n + 1);
  for i := 0; i <= n; i++ {
    k[i] = make([]bool, targetSum + 1, targetSum + 1)
  }

  k[0][0] = true

  for i := 1; i <= n; i++ {
    for j := 0; j <= targetSum; j++ {
      if j - nums[i - 1] >= 0 {
        k[i][j] = k[i - 1][j] || k[i - 1][j - nums[i - 1]]
      } else {
        k[i][j] = k[i - 1][j]
      }
    }
  }
  return k[n][targetSum]
}
```
# Complexity
- Let $n$ be the length of the original array and $m$ be the maximum value of elements in the array.
- The sum of all elements in the array is $$S=\sum_{i=1}^n a_i$$
## Expected value analysis
- The expected value of the sum of all elements in the array is:
$$E(S)=E\left( \sum_{i=1}^n a_i \right)=\sum_{i=1}^n E(a_i)$$
- For any single element $a_i$ uniformly distributed in the range $[1,m]$, its expected value is:
$$E(a_i)=\frac{1}{m}\sum_{j=1}^m j=\frac{1}{m} \cdot \frac{m(m+1)}{2}=\frac{m+1}{2}$$
- The expected value of the total sum is:
$$E(S)=nE(a_i)=n \times \frac{m+1}{2}$$
- The expected value of the half of the total sum is:
$$E\left(\frac{S}{2}\right)=\frac{E(S)}{2}=\frac{n(m+1)}{4}$$
### Proof of expected value
- For a uniform distribution over $[1, m]$, $E(X) = \frac{m+1}{2}$.
$$\begin{align}
E(X) &= \sum_{k=1}^m k \cdot P(X = k) \\
&= \sum_{k=1}^m k \cdot \frac{1}{m} \\
&= \frac{1}{m} \sum_{k=1}^m k \\
&= \frac{1}{m} \cdot \frac{m(m+1)}{2} \quad \text{(sum of first } m \text{ integers)} \\
&= \frac{m+1}{2}
\end{align}$$
## Time complexity
### Variant of 0-1 Knapsack problem
- The algorithm fills a DP table of size $(n+1) \times (\text{target}+1)$.
- Each cell requires $O(1)$ computation.
- In the worst case, $\text{target} = \frac{S}{2}$ where $S$ can be as large as $n \times m$.
- Expected target: $E\left(\frac{S}{2}\right) = \frac{n(m+1)}{4}$.
- Time complexity:
$$T(n,m)=O\left(n \times \frac{n(m+1)}{4}\right)=O(n^2m)$$
- In the worst case with maximum sum:
$$T_{\text{worst}}(n,m)=O(n \times nm)=O(n^2m)$$
### Example complexity calculation
- For `nums = [1, 5, 11, 5]`: $n = 4$, $\text{target} = 11$
- Table size: $(4+1) \times (11+1) = 5 \times 12 = 60$ cells
- Time: $O(n \times \text{target}) = O(4 \times 11) = O(44)$ operations
## Space complexity
- The DP table $K$ has dimensions $(n+1) \times (\text{target}+1)$.
- Space complexity:
$$S(n, m)=O\left((n+1) \times \left( \frac{n(m+1)}{4} + 1\right)\right)=O(n^2m)$$
- The auxiliary space is the same as the space complexity since the DP table dominates:
$$S_{\text{aux}}(n, m)=O(n^2m)$$
### Space optimization (not implemented)
- The recurrence $K[i, s]$ only depends on $K[i-1, \cdot]$.
- Space can be reduced to $O(\text{target})$ by using a 1D array and iterating backwards.
- Optimized space: $O\left(\frac{nm}{2}\right) = O(nm)$
***
# References
1. [Partition Equal Subset Sum](https://leetcode.com/problems/partition-equal-subset-sum/) for LeetCode problem
2. [[algorithm/algorithm/dynamic-programming/knapsack-problem/0-1 Knapsack problem]] for 0-1 Knapsack problem
3. Introduction to Algorithms - Thomas H.Cormen, Charles E.Leserson, Ronald L.Rivest, Clinfford Sten - The MIT Press - Third Edition 2009.
    1. Chapter 14: Dynamic Programming.