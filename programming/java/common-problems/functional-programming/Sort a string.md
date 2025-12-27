#java #stream #string #functional-programming #java8 #stream 
- `{Java}String` object is immutable in Java, so it cannot be directly sorted.
# Convert to char array and sort
```Java title='Sort a string: imperative solution'
import java.util.Arrays;

public class SortString {
    public static void main(String[] args) {
        String original = "edcba";

        // 1. Convert to char array
        char[] chars = original.toCharArray();

        // 2. Sort the array (Dual-Pivot Quicksort)
        Arrays.sort(chars);

        // 3. Convert back to String
        String sorted = new String(chars);

        System.out.println(sorted); // Output: abcde
    }
}
```
# `Stream` API
```Java title='Sort a string: Stream API solution in Java'
import java.util.stream.Collectors;
import java.util.stream.Stream;

String original = "edcba";

String sorted = Stream.of(original.split(""))
                      .sorted()
                      .collect(Collectors.joining());

System.out.println(sorted); // Output: abcde
```
***
# References
1. [[programming/java/common-problems/functional-programming/Sort a primitive array in reverse order]]