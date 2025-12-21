#array #java #hash-table #set #leetcode #java8 #stream 
# Algorithm
## Hash table
- Allocates a hash table with the same size to store all elements in the original array.
- Filter all numbers in the range $[1,n]$ that does not belong to the hash table.
# Implementation
## Java
```Java title='Problem 448 in Java: Hash table solution'
class Solution {
  public List<Integer> findDisappearedNumbers(int[] nums) {
    Set<Integer> numbers = new HashSet<Integer>(nums.length);
    for (final var num: nums) {
      numbers.add(num);
    }
    return IntStream.rangeClosed(1, nums.length).boxed()
      .filter((number) -> !numbers.contains(number))
      .toList();
  }
}
```
# Complexity
## Time complexity
- $O(n)$
## Space complexity
- $\Theta(2n)=O(n)$.
- The auxiliary space is $\Theta(n)=O(n)$.
***
# References
1. https://leetcode.com/problems/find-all-numbers-disappeared-in-an-array/description/