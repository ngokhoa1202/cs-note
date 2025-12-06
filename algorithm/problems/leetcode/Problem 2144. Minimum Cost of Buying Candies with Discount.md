#leetcode #sorting #greedy-algorithm #java
# Algorithm
## Sort and calculate sum
### Mathematical analysis
- Let $S$ be the total cost of all elements in the array $\text{cost}$ $$S=\sum_i\text{cost}_i=c$$
- Let $C,F$ be the cost of bought candies and the cost of given candies from the shop. $$F=S-C$$
- The variable $C$ must be minimized, so the variable $F$ is <mark class="hltr-yellow">maximized</mark> because $S$ is a constant. For every two candies $c_i, c_j$, some specific candy $c_k$ must satisfy $$c_k \leq \min\{c_i, c_j\}$$ 
- Therefore, the algorithm is to <mark class="hltr-yellow">sort</mark> the array *in descending order* and calculate the total cost based the candies whose index divided by leaves a remainder of 2.
# Implementation
```Java title='Problem 2144 in Java: Sort and calculate sum solution'
class Solution {
  public int minimumCost(int[] cost) {
    this.sort(cost, 0, cost.length - 1);
    int totalCost = 0;
    for (int i = 0; i < cost.length; ++i)
      if (i % 3 != 2)
        totalCost += cost[i];
    return totalCost;
  }

  private void sort(int[] arr, int left, int right) {
    if (left < right) {
      final var k = this.partition(arr, left, right);
      this.sort(arr, left, k - 1);
      this.sort(arr, k + 1, right);
    }
  }

  private void swap(int[] arr, int i, int j) {
    final var tmp = arr[i];
    arr[i] = arr[j];
    arr[j] = tmp;
  }

  private int partition(int[] arr, int left, int right) {
    final var pivot = arr[right];
    int i = left - 1;
    for (int j = left; j < right; ++j) {
      if (arr[j] > pivot) {
        i++;
        System.out.println(i + " " + j);
        this.swap(arr, i, j);
      }
    }
    this.swap(arr, i + 1, right);
    return i + 1;
  }
}
```
# Complexity

***
# References
1. https://leetcode.com/problems/minimum-cost-of-buying-candies-with-discount/description/
2. 
