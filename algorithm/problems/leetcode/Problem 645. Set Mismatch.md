#leetcode #frequency-table #array #java #stream #java8 #sorting 
# Algorithm
## Frequency table
- A frequency table is used to store the number of occurrences of numbers.
- If the frequency of a number is 0, it is the missing number. If it is 2, it is the duplicate number.
# Implementation
## Java
```Java title='Problem 645 in Java: Frequency table approach'
class Solution {
  public int[] findErrorNums(int[] nums) {
    final var frequency = new HashMap<Integer, Integer>(nums.length);
    for (int i = 1; i <= nums.length; ++i) {
      frequency.put(i, 0);
    }
    for (final var num: nums) {
      frequency.put(num, frequency.get(num) + 1);
    }
    var missingStream = frequency.entrySet().stream()
      .filter((entry) -> entry.getValue() == 0)
      .map((entry) -> entry.getKey());
    var duplicateStream = frequency.entrySet().stream()
      .filter((entry) -> entry.getValue() == 2)
      .map((entry) -> entry.getKey());
    return IntStream.concat(
      duplicateStream.mapToInt(Integer::intValue),
      missingStream.mapToInt(Integer::intValue)
    ).toArray();
  }
}
```
# Complexity
## Time complexity

## Space complexity

***
# References
1. https://leetcode.com/problems/set-mismatch/description/
2. 
