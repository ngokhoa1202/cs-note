#java #functional-programming #stream #collector
# Collector interface
- The `Java java.util.stream.Collector<T, A, R>` interface represents a ==mutable reduction operation== that accumulates input elements into a mutable result container, optionally transforming the accumulated result into a final representation.
- Type parameters:
	- `T`: the type of input elements to the reduction operation
	- `A`: the mutable accumulation type of the reduction operation (often hidden as an implementation detail)
	- `R`: the result type of the reduction operation
- The `Collector` interface defines five functions that work together to accumulate entries into a mutable result container and optionally perform a final transform on the result:
	- `Supplier<A> supplier()`: creates a new result container
	- `BiConsumer<A, T> accumulator()`: incorporates an element into a result container
	- `BinaryOperator<A> combiner()`: combines two result containers (for parallel processing)
	- `Function<A, R> finisher()`: performs the final transformation from intermediate accumulation type to final result type
	- `Set<Characteristics> characteristics()`: returns a set of characteristics describing the collector
# Collectors utility class
- The `Java java.util.stream.Collectors` class provides static factory methods for common collector implementations.
- The class includes collectors for basic operations like accumulating elements into collections, summarizing elements, grouping elements, and partitioning elements.
## Collection collectors
### toList()
- The `Java Collectors.toList()` method accumulates elements into a `Java List`.
```java
List<String> list = stream.collect(Collectors.toList());
```
### toSet()
- The `Java Collectors.toSet()` method accumulates elements into a `Java Set`, eliminating duplicates.
```java
Set<Integer> set = stream.collect(Collectors.toSet());
```
### toCollection()
- The `Java Collectors.toCollection(Supplier<C> collectionFactory)` method accumulates elements into a specific collection type.
```java
TreeSet<String> treeSet = stream.collect(Collectors.toCollection(TreeSet::new));
LinkedList<Integer> linkedList = stream.collect(Collectors.toCollection(LinkedList::new));
```
### toMap()
- The `Java Collectors.toMap(Function<? super T, ? extends K> keyMapper, Function<? super T, ? extends U> valueMapper)` method accumulates elements into a `Java Map` using the provided key and value mapping functions.
- If duplicate keys are encountered, an `Java IllegalStateException` is thrown.
```java
Map<Integer, String> map = persons.stream()
    .collect(Collectors.toMap(Person::getId, Person::getName));
```
- The `Java Collectors.toMap(Function keyMapper, Function valueMapper, BinaryOperator<U> mergeFunction)` method provides a merge function to handle duplicate keys.
```java
Map<String, Integer> map = persons.stream()
    .collect(Collectors.toMap(
        Person::getName,
        Person::getAge,
        (age1, age2) -> age1  // Keep first age if duplicate names
    ));
```
- The `Java Collectors.toMap(Function keyMapper, Function valueMapper, BinaryOperator<U> mergeFunction, Supplier<M> mapSupplier)` method allows specifying the map implementation.
```java
TreeMap<Integer, String> treeMap = persons.stream()
    .collect(Collectors.toMap(
        Person::getId,
        Person::getName,
        (n1, n2) -> n1,
        TreeMap::new
    ));
```
## String collectors
### joining()
- The `Java Collectors.joining()` method concatenates stream elements into a single `Java String`.
```java
String result = stream.collect(Collectors.joining());
// "abcdef"
```
- The `Java Collectors.joining(CharSequence delimiter)` method concatenates elements with a delimiter.
```java
String result = stream.collect(Collectors.joining(", "));
// "a, b, c, d, e, f"
```
- The `Java Collectors.joining(CharSequence delimiter, CharSequence prefix, CharSequence suffix)` method adds prefix and suffix to the result.
```java
String result = stream.collect(Collectors.joining(", ", "[", "]"));
// "[a, b, c, d, e, f]"
```
## Reduction collectors
### counting()
- The `Java Collectors.counting()` method counts the number of elements in the stream.
```java
Long count = stream.collect(Collectors.counting());
```
### summingInt(), summingLong(), summingDouble()
- The `Java Collectors.summingInt(ToIntFunction<? super T> mapper)` method sums the integer values extracted from elements.
```java
Integer totalAge = persons.stream()
    .collect(Collectors.summingInt(Person::getAge));
```
- Similar methods exist for `Java summingLong()` and `Java summingDouble()`.
### averagingInt(), averagingLong(), averagingDouble()
- The `Java Collectors.averagingInt(ToIntFunction<? super T> mapper)` method computes the arithmetic mean of integer values.
```java
Double averageAge = persons.stream()
    .collect(Collectors.averagingInt(Person::getAge));
```
### summarizingInt(), summarizingLong(), summarizingDouble()
- The `Java Collectors.summarizingInt(ToIntFunction<? super T> mapper)` method returns an `Java IntSummaryStatistics` object containing count, sum, min, average, and max.
```java
IntSummaryStatistics stats = persons.stream()
    .collect(Collectors.summarizingInt(Person::getAge));

long count = stats.getCount();
int sum = stats.getSum();
int min = stats.getMin();
double average = stats.getAverage();
int max = stats.getMax();
```
### reducing()
- The `Java Collectors.reducing(BinaryOperator<T> op)` method performs a reduction using the provided binary operator.
```java
Optional<Integer> sum = numbers.stream()
    .collect(Collectors.reducing(Integer::sum));
```
- The `Java Collectors.reducing(T identity, BinaryOperator<T> op)` method provides an identity value for the reduction.
```java
Integer sum = numbers.stream()
    .collect(Collectors.reducing(0, Integer::sum));
```
- The `Java Collectors.reducing(U identity, Function<? super T, ? extends U> mapper, BinaryOperator<U> op)` method maps elements before reduction.
```java
Integer totalAge = persons.stream()
    .collect(Collectors.reducing(0, Person::getAge, Integer::sum));
```
### maxBy(), minBy()
- The `Java Collectors.maxBy(Comparator<? super T> comparator)` method finds the maximum element according to the comparator.
```java
Optional<Person> oldest = persons.stream()
    .collect(Collectors.maxBy(Comparator.comparing(Person::getAge)));
```
- The `Java Collectors.minBy(Comparator<? super T> comparator)` method finds the minimum element.
```java
Optional<Person> youngest = persons.stream()
    .collect(Collectors.minBy(Comparator.comparing(Person::getAge)));
```
## Grouping collectors
### groupingBy()
- The `Java Collectors.groupingBy(Function<? super T, ? extends K> classifier)` method groups elements by a classification function into a `Java Map<K, List<T>>`.
```java
Map<String, List<Person>> byCity = persons.stream()
    .collect(Collectors.groupingBy(Person::getCity));
```
- The `Java Collectors.groupingBy(Function classifier, Collector downstream)` method applies a downstream collector to the grouped values.
```java
Map<String, Long> countByCity = persons.stream()
    .collect(Collectors.groupingBy(
        Person::getCity,
        Collectors.counting()
    ));

Map<String, Set<String>> namesByCity = persons.stream()
    .collect(Collectors.groupingBy(
        Person::getCity,
        Collectors.mapping(Person::getName, Collectors.toSet())
    ));
```
- The `Java Collectors.groupingBy(Function classifier, Supplier mapFactory, Collector downstream)` method specifies the map implementation.
```java
TreeMap<String, List<Person>> sortedByCity = persons.stream()
    .collect(Collectors.groupingBy(
        Person::getCity,
        TreeMap::new,
        Collectors.toList()
    ));
```
### groupingByConcurrent()
- The `Java Collectors.groupingByConcurrent()` variants perform concurrent grouping, returning a `Java ConcurrentMap`.
```java
ConcurrentMap<String, List<Person>> byCity = persons.parallelStream()
    .collect(Collectors.groupingByConcurrent(Person::getCity));
```
## Partitioning collectors
### partitioningBy()
- The `Java Collectors.partitioningBy(Predicate<? super T> predicate)` method partitions elements into two groups based on a predicate, returning a `Java Map<Boolean, List<T>>`.
```java
Map<Boolean, List<Person>> partitioned = persons.stream()
    .collect(Collectors.partitioningBy(p -> p.getAge() >= 18));

List<Person> adults = partitioned.get(true);
List<Person> minors = partitioned.get(false);
```
- The `Java Collectors.partitioningBy(Predicate predicate, Collector downstream)` method applies a downstream collector to each partition.
```java
Map<Boolean, Long> counts = persons.stream()
    .collect(Collectors.partitioningBy(
        p -> p.getAge() >= 18,
        Collectors.counting()
    ));
```
## Mapping collectors
### mapping()
- The `Java Collectors.mapping(Function<? super T, ? extends U> mapper, Collector<? super U, A, R> downstream)` method adapts a collector to accept elements of a different type by applying a mapping function before accumulation.
```java
List<String> names = persons.stream()
    .collect(Collectors.mapping(Person::getName, Collectors.toList()));

Map<String, Set<String>> namesByCity = persons.stream()
    .collect(Collectors.groupingBy(
        Person::getCity,
        Collectors.mapping(Person::getName, Collectors.toSet())
    ));
```
### flatMapping()
- The `Java Collectors.flatMapping(Function<? super T, ? extends Stream<? extends U>> mapper, Collector<? super U, A, R> downstream)` method adapts a collector by applying a flat-mapping function before accumulation.
```java
List<String> allHobbies = persons.stream()
    .collect(Collectors.flatMapping(
        p -> p.getHobbies().stream(),
        Collectors.toList()
    ));

Map<String, Set<String>> hobbiesByCity = persons.stream()
    .collect(Collectors.groupingBy(
        Person::getCity,
        Collectors.flatMapping(
            p -> p.getHobbies().stream(),
            Collectors.toSet()
        )
    ));
```
### filtering()
- The `Java Collectors.filtering(Predicate<? super T> predicate, Collector<? super T, A, R> downstream)` method adapts a collector to only accumulate elements matching the predicate.
```java
Map<String, List<Person>> adultsByCity = persons.stream()
    .collect(Collectors.groupingBy(
        Person::getCity,
        Collectors.filtering(
            p -> p.getAge() >= 18,
            Collectors.toList()
        )
    ));
```
## Collector composition
### collectingAndThen()
- The `Java Collectors.collectingAndThen(Collector<T, A, R> downstream, Function<R, RR> finisher)` method adapts a collector to perform an additional finishing transformation.
```java
List<String> unmodifiableList = stream
    .collect(Collectors.collectingAndThen(
        Collectors.toList(),
        Collections::unmodifiableList
    ));

int maxNameLength = persons.stream()
    .collect(Collectors.collectingAndThen(
        Collectors.maxBy(Comparator.comparing(p -> p.getName().length())),
        opt -> opt.map(p -> p.getName().length()).orElse(0)
    ));
```
### teeing()
- The `Java Collectors.teeing(Collector downstream1, Collector downstream2, BiFunction merger)` method applies two collectors to the same stream and merges their results.
```java
record MinMax(int min, int max) {}

MinMax minMax = numbers.stream()
    .collect(Collectors.teeing(
        Collectors.minBy(Integer::compareTo),
        Collectors.maxBy(Integer::compareTo),
        (min, max) -> new MinMax(
            min.orElse(0),
            max.orElse(0)
        )
    ));
```
# Collector characteristics
- The `Java Collector.Characteristics` enum defines properties of collectors that affect optimization.
## CONCURRENT
- The `Java CONCURRENT` characteristic indicates that the collector supports concurrent reduction when used with parallel streams.
- The result container can be shared across threads and accumulated to concurrently.
- Collectors with this characteristic typically produce `Java ConcurrentMap` or other thread-safe containers.
```java
// groupingByConcurrent has CONCURRENT characteristic
ConcurrentMap<String, List<Person>> map = persons.parallelStream()
    .collect(Collectors.groupingByConcurrent(Person::getCity));
```
## UNORDERED
- The `Java UNORDERED` characteristic indicates that the collection operation does not preserve encounter order.
- This allows for more efficient parallel processing when order is not important.
```java
// toSet() has UNORDERED characteristic
Set<String> set = stream.collect(Collectors.toSet());
```
## IDENTITY_FINISH
- The `Java IDENTITY_FINISH` characteristic indicates that the finisher function is the identity function and can be omitted.
- The accumulation type `A` is the same as the result type `R`.
- This optimization allows casting the intermediate result directly without calling the finisher.
```java
// toList() has IDENTITY_FINISH characteristic
// No finisher transformation needed
List<String> list = stream.collect(Collectors.toList());
```
# Custom collectors
- Custom collectors can be created by implementing the `Java Collector` interface or using the `Java Collector.of()` factory methods.
## Using Collector.of()
- The `Java Collector.of(Supplier supplier, BiConsumer accumulator, BinaryOperator combiner, Characteristics... characteristics)` method creates a collector with identity finish.
```java title='Custom collector that accumulates elements into a StringBuffer'
Collector<String, StringBuffer, StringBuffer> bufferCollector = Collector.of(
    StringBuffer::new,                          // supplier
    StringBuffer::append,                       // accumulator
    StringBuffer::append,                       // combiner
    Collector.Characteristics.IDENTITY_FINISH   // characteristics
);

StringBuffer result = stream.collect(bufferCollector);
```
- The `Java Collector.of(Supplier supplier, BiConsumer accumulator, BinaryOperator combiner, Function finisher, Characteristics... characteristics)` method creates a collector with a custom finisher.
```java title='Custom collector that counts elements with specific property'
Collector<Person, int[], Integer> adultCountCollector = Collector.of(
    () -> new int[1],                                    // supplier
    (acc, person) -> {                                   // accumulator
        if (person.getAge() >= 18) acc[0]++;
    },
    (acc1, acc2) -> {                                    // combiner
        acc1[0] += acc2[0];
        return acc1;
    },
    acc -> acc[0]                                        // finisher
);

Integer adultCount = persons.stream().collect(adultCountCollector);
```
## Implementing Collector interface
```java title='Custom immutable list collector'
public class ImmutableListCollector<T> implements Collector<T, List<T>, List<T>> {

    @Override
    public Supplier<List<T>> supplier() {
        return ArrayList::new;
    }

    @Override
    public BiConsumer<List<T>, T> accumulator() {
        return List::add;
    }

    @Override
    public BinaryOperator<List<T>> combiner() {
        return (list1, list2) -> {
            list1.addAll(list2);
            return list1;
        };
    }

    @Override
    public Function<List<T>, List<T>> finisher() {
        return Collections::unmodifiableList;
    }

    @Override
    public Set<Characteristics> characteristics() {
        return Collections.emptySet();
    }
}

// Usage
List<String> immutableList = stream.collect(new ImmutableListCollector<>());
```
# Practical examples
## Multi-level grouping
```java title='Group persons by city, then by age group'
Map<String, Map<String, List<Person>>> groupedByCity = persons.stream()
    .collect(Collectors.groupingBy(
        Person::getCity,
        Collectors.groupingBy(person -> {
            int age = person.getAge();
            if (age < 18) return "Minor";
            else if (age < 65) return "Adult";
            else return "Senior";
        })
    ));
```
## Complex aggregations
```java title='Compute statistics per group'
Map<String, IntSummaryStatistics> ageStatsByCity = persons.stream()
    .collect(Collectors.groupingBy(
        Person::getCity,
        Collectors.summarizingInt(Person::getAge)
    ));

ageStatsByCity.forEach((city, stats) -> {
    System.out.println(city + ": avg=" + stats.getAverage() +
                       ", max=" + stats.getMax());
});
```
## Collecting to custom objects
```java title='Create a summary object from stream'
record Summary(long count, double average, String allNames) {}

Summary summary = persons.stream()
    .collect(Collectors.teeing(
        Collectors.counting(),
        Collectors.teeing(
            Collectors.averagingInt(Person::getAge),
            Collectors.mapping(Person::getName, Collectors.joining(", ")),
            (avg, names) -> new Object[]{avg, names}
        ),
        (count, arr) -> new Summary(count, (Double) arr[0], (String) arr[1])
    ));
```
## Downstream collector chains
```java title='Complex downstream collectors'
Map<String, Optional<Person>> oldestByCity = persons.stream()
    .collect(Collectors.groupingBy(
        Person::getCity,
        Collectors.collectingAndThen(
            Collectors.maxBy(Comparator.comparing(Person::getAge)),
            Optional::of
        )
    ));

Map<String, String> oldestNamesByCity = persons.stream()
    .collect(Collectors.groupingBy(
        Person::getCity,
        Collectors.collectingAndThen(
            Collectors.maxBy(Comparator.comparing(Person::getAge)),
            opt -> opt.map(Person::getName).orElse("Unknown")
        )
    ));
```
***
# References
1. Oracle Java Documentation - Collector Interface: https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/stream/Collector.html
2. Oracle Java Documentation - Collectors Class: https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/util/stream/Collectors.html
3. Urma, Raoul-Gabriel, Mario Fusco, and Alan Mycroft. "Modern Java in Action: Lambdas, streams, functional and reactive programming." Manning Publications, 2018. Chapter 6: Collecting data with streams.
