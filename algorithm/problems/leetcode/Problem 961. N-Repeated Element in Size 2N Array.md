#leetcode #frequency-table #array #associative-array #java 
# Algorithm
## Frequency table
- Employ an associative array to store the value as key and its number of occurrences as value.
- The element with maximum  number of occurrences is the element repeated $N+1$ times. 
# Implementation
## Java
### Frequency table
```Java title='Problem 961 in Java: Frequency table'
class Solution {
  public int repeatedNTimes(int[] nums) {
    final Map<Integer, Integer> valueToFrequency = new HashMap<Integer, Integer>();
    for (final var num: nums) {
      valueToFrequency.put(num, valueToFrequency.getOrDefault(num, 0) + 1);
    }
    int value = 0, max = 0;
    for (final var entry: valueToFrequency.entrySet()) {
      if (max < entry.getValue()) {
        max = entry.getValue();
        value = entry.getKey();
      }
    }
    return value;
  }
}
```
## Go
### Frequency table
```Go title='Problem 961 in Go: Frequency table'
func repeatedNTimes(nums []int) int {
  valueToFrequency := make(map[int]int)
  for _, num := range nums {
    freq, existed := valueToFrequency[num]
    if existed {
      valueToFrequency[num] = freq + 1
    } else {
      valueToFrequency[num] = 1
    }
  }
  num := nums[0]
  for val, freq := range valueToFrequency {
    if valueToFrequency[num] < freq {
      num = val
    }
  }
  return num
}
```
# Complexity
## Time complexity
- The time complexity is $$\Theta(2n)=O(n)$$
## Space complexity
- $\Theta(2n)=O(n)$.
- The auxiliary space is $\Theta(n)=O(n)$.
***
# References
1. https://leetcode.com/problems/n-repeated-element-in-size-2n-array/description/
2. 