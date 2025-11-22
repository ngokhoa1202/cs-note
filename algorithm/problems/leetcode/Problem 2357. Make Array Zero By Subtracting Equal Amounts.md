#leetcode #greedy-algorithm #set #sorting 
# Algorithm
## Greedy subtraction
- The subtract value is the *minimum element which is greater than zero* in the array for each operation.
- The elements with the same value in the array needs the same number of operations. Contrarily, different elements needs different number of operations. The number of subtraction operation, as a result, is the number of distinct elements in the original array. 
# Implementation
## Java
- A `HashSet` object is used to store the distinct elements greater than zero of the original array.
- The minimum number of operations is the size of that `HashSet` object.
```Java title='Problem 2357 in Java: Greedy subtraction solution'
class Solution {
  public int minimumOperations(int[] nums) {
    Set<Integer> distinctNums = Arrays.stream(nums).boxed().filter((num) -> num > 0)
      .collect(Collectors.toSet());
    return distinctNums.size();
  }
}
```
# Complexity
## Time complexity
- $O(n)$
## Space complexity
- $O(2n)=O(n)$
***
# References
1. https://leetcode.com/problems/make-array-zero-by-subtracting-equal-amounts/description/
2. 