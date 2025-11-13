#leetcode #array #set #data-structure #associative-array 
# Algorithm
## Two maps to store character and their occurrences

# Implementation
## Java
```Java title='Problem 350 in Java: two maps solution'
class Solution {
  public int[] intersect(int[] nums1, int[] nums2) {
    Map<Integer, Integer> freq1 = new HashMap<>();
    for (final var num : nums1) {
      freq1.put(num, freq1.getOrDefault(num, 0) + 1);
    }
    Map<Integer, Integer> freq2 = new HashMap<>();
    for (final var num : nums2) {
      freq2.put(num, freq2.getOrDefault(num, 0) + 1);
    }
    List<Integer> intersection = new LinkedList<>();
    freq1.entrySet().forEach((entry) -> {
      if (freq2.containsKey(entry.getKey())) {
        int occurrence = Math.min(entry.getValue(), freq2.get(entry.getKey()));
        for (int j = 0; j < occurrence; ++j)
          intersection.add(entry.getKey());
      }
    });
    return Arrays.stream(intersection.toArray(new Integer[0])).mapToInt(Integer::intValue).toArray();
  }
}
```

***
# References
1. https://leetcode.com/problems/intersection-of-two-arrays-ii/description/
2. 