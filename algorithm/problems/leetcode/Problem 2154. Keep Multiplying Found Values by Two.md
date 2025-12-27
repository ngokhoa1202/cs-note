#leetcode #hash #set #array #data-structure 
# Algorithm
## Hash table

# Implementation
## Java
```Java title='Problm 2154 in Java: Hash table solution'
class Solution {
  public int findFinalValue(int[] nums, int original) {
    Set<Integer> numbers = Arrays.stream(nums).boxed().collect(Collectors.toSet());
    while (numbers.contains(original)) {
      original *= 2;
    } 
    return original;
  }
}
```
# Complexity
## Time complexity
- $O(n)$
## Space complexity
- $O(n)$

***
# References
1. https://leetcode.com/problems/keep-multiplying-found-values-by-two/description/
2. [[programming/java/common-problems/functional-programming/Convert a primitive array to Set]]
3. 