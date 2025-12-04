#array #greedy-algorithm #algorithm #leetcode #python #java
# Algorithm
## Naive approach
## Greedy algorithm
### Mathematical analysis
#### Global Feasibility Check
- A solution exists if and only if $$\sum_{i=0}^{n-1} \text{gas}[i] \geq \sum_{i=0}^{n-1} \text{cost}[i]$$
- If the circuit can be completed starting from some station $s$, then the total gas collected equals total gas consumed plus remaining gas. ($\implies$)
- If $\sum_{i=0}^{n-1} \text{gas}[i] \geq \sum_{i=0}^{n-1} \text{cost}[i]$, there exists a valid starting position [[#Greedy Choice Correctness]]
#### Greedy Choice Correctness
##### Theorem
- If a solution exists, the greedy algorithm finds it:
1. Start from station $0$
2. If we run out of gas at station $j$, the next candidate starting station is $j+1$
3. Any station in $[0,j]$ cannot be the valid starting position.
##### Proof
- Let $\text{net}[i]=\text{gas}[i]-\text{cost}[i]$ be the net gain at station $i$.
- Starting from station $s$, the cumulative gas at station $k$ is $$\text{tank}(s, k) = \sum_{i=s}^{k} \text{net}[i \bmod n]$$
- If station $j$ cannot be reached given the starting point is station $s$, which means $\text{tank}(s,j-1) < 0$, then *no station* in the range $[0,j-1]$ can reach $j$.
- Suppose that the gas is in short supply before reaching $j$, that is $$\text{tank}(s, j - 1) = \sum_{i=s}^{j-1} \text{net}[i] < 0$$
- Suppose there exists some station $t$ where $s<t<j$ can reach station $j$, which means $$\text{tank}(t, j - 1) = \sum_{i=t}^{j-1} \text{net}[i] \geq 0$$
- Decompose the travel from station $s$ to $j-1$ $$\text{tank}(s, j - 1) = \sum_{i=s}^{t-1} \text{net}[i] + \sum_{i=t}^{j-1} \text{net}[i] < 0$$
- As a result, $$\sum_{i=t}^{j-1} \text{net}[i] < 0$$
- But this means starting from $s$, the car ran out of gas before reach $t$, contradicting our assumption that station $j-1$ can be reached from $s$.
#### Solution uniqueness
##### Theorem
- If a solution exists, it is unique.
##### Proof
- Suppose there are two valid starting stations $s_1$ and $s_2$​ where $s_1 < s_2$​.
- From station $s_1$, the circuit can be completed, so $$\text{tank}(s_1,s_2-1) \geq 0$$
- The station $s_2$ can be reached from $s_1$, but s_2 cannot be a valid starting position because the greedy choice would have chosen $s_1$ $\implies$ contradicts with the initial assumption.
- As a result, the greedy choice results in only one unique solution. 
### Method
- Let $d_i = \text{gas}[i] - \text{cost}[i]$ represent the net gas gain at station $i$. 
1. Initialize $\text{total\_tank} = 0$, $\text{current\_tank} = 0$, and $\text{start} = 0$
2. For each station $i$ from $0$ to $n-1$:
   - Add $d_i$ to both $\text{total\_tank}$ and $\text{current\_tank}$
   - If $\text{current\_tank} < 0$:
     - The current station is definitely not a valid starting position. The next station is the following candidate.
     - Reset $\text{current\_tank} = 0$
3. Return $\text{start}$ if $\text{total\_tank} \geq 0$, otherwise return $-1$
# Implementation
## Java
```Java title='Problem 134 in Java: Greedy algorithm solution'
class Solution {
    public int canCompleteCircuit(int[] gas, int[] cost) {
        int totalTank = 0;
        int currentTank = 0;
        int startStation = 0;

        for (int i = 0; i < gas.length; i++) {
            int diff = gas[i] - cost[i];
            totalTank += diff;
            currentTank += diff;

            if (currentTank < 0) {
                startStation = i + 1;
                currentTank = 0;
            }
        }

        return totalTank >= 0 ? startStation : -1;
    }
}
```
## Python
```python
class Solution:
    def canCompleteCircuit(self, gas: List[int], cost: List[int]) -> int:
        total_tank = 0
        current_tank = 0
        start_station = 0

        for i in range(len(gas)):
            diff = gas[i] - cost[i]
            total_tank += diff
            current_tank += diff

            if current_tank < 0:
                start_station = i + 1
                current_tank = 0

        return start_station if total_tank >= 0 else -1
```

# Complexity
## Time complexity
- $O(n)$
## Space complexity
- $O(1)$
***
# References
1. [Gas Station - LeetCode](https://leetcode.com/problems/gas-station/description/)
2. [Prove the greedy algorithm for Gas Station is valid - Stack Overflow](https://stackoverflow.com/questions/69115349/prove-the-greedy-algorithm-for-gas-station-is-valid)
3. [Two Approaches for Gas Station Problem - Labuladong](https://labuladong.online/algo/en/frequency-interview/gas-station-greedy/)
4. [134. Gas Station - In-Depth Explanation](https://algo.monster/liteproblems/134)
