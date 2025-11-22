#java #java8 #functional-programming #list #data-structure 
# Reduce with initial value
- When the initial value is provided, the return value is of the boxed class.
```Java title='Find maximum element of a list: Reduce with identity approach'
import java.util.List;

List<Integer> numbers = List.of(5, 12, 3);

// Returns primitive int directly
int max = numbers.stream()
                 .reduce(Integer.MIN_VALUE, Math::max);

System.out.println(max); // Output: 12
```
# Reduce without initial value
- In case the initial is not provided, the return value is `{Java}Optional`.
```Java title='Find maximum element of a list: Reduce without initial value'
import java.util.List;
import java.util.Optional;

List<Integer> numbers = List.of(5, 12, 3, 9, 2);

// 1. Using Lambda
Optional<Integer> maxViaLambda = numbers.stream()
    .reduce((a, b) -> a > b ? a : b);

// 2. Using Method Reference (Cleaner)
Optional<Integer> maxViaMethodRef = numbers.stream()
    .reduce(Math::max);

// Handling the result
System.out.println(maxViaMethodRef.orElse(0)); // Output: 12
```
# `{Java}Stream.max` API
```Java title='Find maximum element of a list: Take advantage of Stream.max API'
import java.util.Comparator;

// Standard approach
Optional<Integer> max = numbers.stream()
                               .max(Comparator.naturalOrder());
                               // or .max(Integer::compareTo)
```
***
# References
1. 