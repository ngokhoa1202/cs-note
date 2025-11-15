#leetcode #set #array #javascript #typescript 
# Algorithm
## Set
# Implementation
## JavaScript
```Java title='Problem 575 in Java: Set solution'
/**
 * @param {number[]} candyType
 * @return {number}
 */
const distributeCandies = function(candyType) {
  const noOfTypes = new Set(candyType).size;
  return Math.min(noOfTypes, candyType.length / 2);
};
```
## TypeScript
```TypeScript title='Problem 575 in TypeScript: Set solution'
function distributeCandies(candyType: number[]): number {
  const noOfTypes = new Set(candyType).size;
  return Math.min(noOfTypes, candyType.length / 2);
};
```
# Complexity
## Time complexity
- $O(n)$
## Space complexity
- $O(n)$
***
# References
1. https://leetcode.com/problems/distribute-candies/
2. 