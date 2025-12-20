#java #functional-programming #java8 #array #data-structure #set #stream
# Unordered Set - `HashSet`
```Java title='Convert a primitive array to Set in Java with Stream API and HashSet'
import java.util.Arrays;
import java.util.Set;
import java.util.stream.Collectors;

int[] primitives = {1, 2, 3, 2, 1};

Set<Integer> set = Arrays.stream(primitives)
                         .boxed() // Crucial: Converts int to Integer
                         .collect(Collectors.toSet());

System.out.println(set); // Output: [1, 2, 3] (order not guaranteed)
```
# Ordered Set - `TreeSet`
```Java title='Convert a primitive array to Set in Java with Stream API and TreeSet'
...
Set<Integer> sortedSet = Arrays.stream(primitives)
                               .boxed()
                               .collect(Collectors.toCollection(TreeSet::new));
...
```
***
# References
1. 