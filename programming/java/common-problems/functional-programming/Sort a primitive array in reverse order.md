#leetcode #java #java8 
# `{Java}Collections.reverseOrder()` flag
- `Collections.reverseOrder()` flag is passed as argument into `sorted()` method of `{Java}Stream`
```Java title='Reverse sort with Collections.reverseOrder() flag'
import java.util.Collections;
import java.util.stream.Collectors;
import java.util.stream.Stream;

String original = "abcde";

String reverseSorted = Stream.of(original.split(""))
                             .sorted(Collections.reverseOrder())
                             .collect(Collectors.joining());

System.out.println(reverseSorted); // Output: edcba
```
***
# References
1. 