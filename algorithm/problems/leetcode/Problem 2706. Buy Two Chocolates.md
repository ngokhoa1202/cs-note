#leetcode #sorting #array
# Algorithm
## Sort array
# Implementation
## Java
- `Arrays.sort` is used to sort the array before perform subtraction.
```Java title='Problem 2706 in Java: Sort array solution'
class Solution {
  public int buyChoco(int[] prices, int money) {
    Arrays.sort(prices);
    return money >= prices[0] + prices[1] ? money - prices[0] - prices[1] : money;
  }
}
```
# Complexity
## Time complexity
- $\Theta(n\text{log}n)$.
## Space complexity
- $\Theta(n)$.
- The auxiliary space is $\Theta(1)$.
***
# References
1. https://leetcode.com/problems/buy-two-chocolates/description/
2. 