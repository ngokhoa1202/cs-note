#leetcode #discrete-math #java 
# Algorithm
## Process simulation
### Recursive function
- Let $m$ be the original number of bottles, $n$ be the number of empty bottle used for 1 filled bottle exchange.
- An additional variable $p$ representing the number of empty bottles is used to exchange filled bottles whenever the number of filled bottles left is not enough to be exchanged.
- The maximum number of drinkable bottles is $f(m,n)$: $$f(m,n)=g(m,n,p=0)=\begin{cases}m \text{ when }\lfloor\frac{m+p}{n}\rfloor=0  \\ m + g(\lfloor\frac{m+p}{n}\rfloor, n, (m+p)\bmod n) \text{ when } \lfloor\frac{m}{n}\rfloor=0 \\ m+g(\lfloor\frac{m}{n}\rfloor, n, p+m\bmod n) \text{ otherwise} \end{cases}$$
### Iterative loop
## Mathematical formula
# Implementation
## Java
```Java title='Problem 1518 in Java: Process simulation with recursive function solution'
class Solution {
  public int numWaterBottles(int numBottles, int numExchange) {
    return this.numWaterBottlesHepler(numBottles, numExchange, 0);
  }

  private int numWaterBottlesHepler(int filledBottles, int numExchange, int emptyBottles) {
    if ((filledBottles + emptyBottles) / numExchange == 0) 
      return filledBottles;
    if (filledBottles / numExchange == 0)
      return filledBottles + this.numWaterBottlesHepler((filledBottles + emptyBottles) / numExchange, numExchange, (filledBottles + emptyBottles) % numExchange);
    return filledBottles + this.numWaterBottlesHepler(filledBottles / numExchange, numExchange, emptyBottles + filledBottles % numExchange);
  }
}
```
# Example

## Example 1
- 
# Complexity
## Time complexity

## Space complexity

***
# References
1. https://leetcode.com/problems/water-bottles/description/
2. 
