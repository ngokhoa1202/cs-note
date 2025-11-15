#leetcode #string #java 
# Algorithm

# Implementation
## Java
### Stream API
- An additional atomic variable is used to calculate the index of the current element in Java Stream API.
```Java title='Problem 824 in Java: Stream API'
class Solution {
  public String toGoatLatin(String sentence) {
    AtomicInteger idxCounter = new AtomicInteger(1);
    return Arrays.stream(sentence.split(" ")).map((word) -> {
      StringBuilder builder = new StringBuilder(word);
      if (List.of('a', 'e', 'o', 'u', 'i', 'A', 'E', 'O', 'U', 'I').contains(builder.charAt(0))) {
        builder.append("ma");
      } else {
        builder.append(builder.charAt(0)).append("ma").deleteCharAt(0);
      }
      int index = idxCounter.getAndIncrement();
      builder.append("a".repeat(index));
      return builder.toString();
    }).collect(Collectors.joining(" "));
  }
}
```
***
# References
1. https://leetcode.com/problems/goat-latin/description/
2. 