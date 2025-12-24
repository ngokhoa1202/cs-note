#java #functional-programming #java8 #array #data-structure #set 
- $T$ is a box type in Java including `{Java} Integer, String, Double, Float, Boolean,...`.
# `{Java}Stream<Integer>` to `{Java}IntStream`
- Use `{Java}mapToInt(Integer::intValue)`.
```Java title='Stream<Integer> to IntStream conversion' hl=17-18
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
***
# References
1. [[algorithm/problems/leetcode/Problem 645. Set Mismatch|Problem 645. Set Mismatch]]
2. 