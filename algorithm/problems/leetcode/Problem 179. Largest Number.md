#leetcode #greedy-algorithm #sorting 
# Algorithm
## Greedily choose maximum string number
### Mathematical analysis
- Let $n_i$ be the given numbers as string.
- The element should be greedily selected to form the maximum number, so the comparator should be $$\forall n_i, n_j, \space i \neq j: (n_i || n_j) \gt (n_j || n_i)$$
- The largest number will be the concatenation of the sorted string array.
### Method
- Convert all the elements of the array into strings.
- Sort the string array with the given predicate in descending order.
- Concatenate the string array to form the largest number.
# Implementation
## Java
- Use the instance method `compareTo` of `{Java}String` class to compare two elements
```Java title='Problem 179 in Java'
class Solution {
  public String largestNumber(int[] nums) {
    String[] numbers = new String[nums.length];
    for (int i = 0; i < nums.length; ++i)
      numbers[i] = String.valueOf(nums[i]);
    this.quickSort(numbers, 0, numbers.length - 1);
    final var builder = new StringBuilder();
    for (final var number: numbers)
      builder.append(number);
    String number = builder.toString();
    while (number.length() > 1 && number.startsWith("0"))
      number = number.substring(1);
    return number;
  }

  private void quickSort(String[] numbers, int low, int high) {
    if (low < high) {
      final var k = this.partition(numbers, low, high);
      this.quickSort(numbers, low, k - 1);
      this.quickSort(numbers, k + 1, high);
    }
  }

  private int partition(String[] numbers, int low, int high) {
    final var pivot = numbers[high];
    int i = low - 1;
    for (int j = low; j < high; ++j)
      if (this.isGreaterThan(numbers[j], pivot)) {
        i++;
        this.swap(numbers, i, j);
      }
    this.swap(numbers, i + 1, high);
    return i + 1;
  }

  private void swap(String[] numbers, int i, int j) {
    final var tmp = numbers[i];
    numbers[i] = numbers[j];
    numbers[j] = tmp;
  }

  private boolean isGreaterThan(String a, String b) {
    return (a + b).compareTo(b + a) > 0;
  }
}
```
# Complexity
## Time complexity
- $\Theta(n\text{log}n)$
## Space complexity
- $\Theta(n)$
***
# References
1. https://leetcode.com/problems/largest-number/description/
2. 