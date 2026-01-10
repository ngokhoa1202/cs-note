#java #java8 #functional-programming #stream #api #pipeline
# Stream API
- The Stream API (introduced in Java 8) provides a functional approach to processing collections of objects. Streams support ==declarative, lazy, and potentially parallel== operations on sequences of elements.

# What is a Stream?
- A ==stream== is a sequence of elements supporting sequential and parallel aggregate operations. Streams do NOT store data; they convey elements from a ==source== (collection, array, I/O channel) through a ==pipeline== of operations.
## Characteristics
- **Not a data structure**: Streams don't store elements, they compute on demand
- **Functional in nature**: Operations produce results without modifying the source
- **Lazy evaluation**: Intermediate operations are lazy (executed only when terminal operation invoked)
- **Possibly unbounded**: Streams can be infinite (with `generate()`, `iterate()`)
- **Consumable**: Stream can only be used once; after terminal operation, stream is closed

```Java title='Stream basic concept'
List<String> names = Arrays.asList("Alice", "Bob", "Charlie", "David");

// Stream pipeline
List<String> result = names.stream()              // Source
    .filter(name -> name.length() > 4)            // Intermediate operation
    .map(String::toUpperCase)                     // Intermediate operation
    .sorted()                                     // Intermediate operation
    .collect(Collectors.toList());               // Terminal operation

System.out.println(result);  // [ALICE, CHARLIE, DAVID]

// Stream is consumed - cannot reuse
// result.stream()...  // Would need new stream
```

# Stream Creation

## From Collections
```Java title='Creating streams from collections'
// From List
List<String> list = Arrays.asList("A", "B", "C");
Stream<String> stream1 = list.stream();

// From Set
Set<Integer> set = new HashSet<>(Arrays.asList(1, 2, 3));
Stream<Integer> stream2 = set.stream();

// From Map (stream of entries)
Map<String, Integer> map = new HashMap<>();
map.put("A", 1);
map.put("B", 2);

Stream<Map.Entry<String, Integer>> stream3 = map.entrySet().stream();
Stream<String> keyStream = map.keySet().stream();
Stream<Integer> valueStream = map.values().stream();
```

## From Arrays
```Java title='Creating streams from arrays'
// Using Arrays.stream()
String[] array = {"Java", "Python", "JavaScript"};
Stream<String> stream1 = Arrays.stream(array);

// Using Stream.of()
Stream<String> stream2 = Stream.of("Java", "Python", "JavaScript");

// Primitive streams
int[] numbers = {1, 2, 3, 4, 5};
IntStream intStream = Arrays.stream(numbers);

// Range of integers
IntStream range = IntStream.range(1, 10);      // 1 to 9
IntStream rangeClosed = IntStream.rangeClosed(1, 10);  // 1 to 10
```

## Using Stream.of()
```Java title='Stream.of() for creating streams'
// From varargs
Stream<Integer> stream1 = Stream.of(1, 2, 3, 4, 5);

// Single element
Stream<String> stream2 = Stream.of("Single");

// Empty stream
Stream<String> emptyStream = Stream.empty();
```

## Using Stream.generate() and Stream.iterate()
```Java title='Infinite streams'
// Generate infinite stream with Supplier
Stream<Double> randomNumbers = Stream.generate(Math::random);
List<Double> tenRandom = randomNumbers.limit(10).collect(Collectors.toList());

// Generate with custom supplier
Stream<String> hellos = Stream.generate(() -> "Hello");
hellos.limit(5).forEach(System.out::println);  // Prints "Hello" 5 times

// Iterate - infinite sequence
Stream<Integer> numbers = Stream.iterate(0, n -> n + 1);  // 0, 1, 2, 3, ...
numbers.limit(10).forEach(System.out::println);

// Iterate with condition (Java 9+)
Stream<Integer> numbersUpTo20 = Stream.iterate(0, n -> n < 20, n -> n + 2);
numbersUpTo20.forEach(System.out::println);  // 0, 2, 4, ..., 18
```

## From Files
```Java title='Creating streams from files'
import java.nio.file.*;
import java.io.IOException;

// Lines from file
try (Stream<String> lines = Files.lines(Paths.get("data.txt"))) {
    lines.filter(line -> line.contains("error"))
         .forEach(System.out::println);
} catch (IOException e) {
    e.printStackTrace();
}

// List files in directory
try (Stream<Path> paths = Files.list(Paths.get("."))) {
    paths.filter(Files::isRegularFile)
         .forEach(System.out::println);
} catch (IOException e) {
    e.printStackTrace();
}
```

## Stream.Builder
```Java title='Using Stream.Builder'
Stream.Builder<String> builder = Stream.builder();
builder.add("A");
builder.add("B");
builder.add("C");

Stream<String> stream = builder.build();
stream.forEach(System.out::println);
```

# Intermediate Operations

==Intermediate operations== return a new stream and are ==lazy== (not executed until terminal operation).

## filter()
Filters elements based on a ==predicate==.

```Java title='filter() examples'
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

// Filter even numbers
List<Integer> evens = numbers.stream()
    .filter(n -> n % 2 == 0)
    .collect(Collectors.toList());
System.out.println(evens);  // [2, 4, 6, 8, 10]

// Multiple filters
List<Integer> filtered = numbers.stream()
    .filter(n -> n > 3)
    .filter(n -> n < 8)
    .filter(n -> n % 2 == 0)
    .collect(Collectors.toList());
System.out.println(filtered);  // [4, 6]

// Filter with complex predicate
List<String> words = Arrays.asList("Java", "Python", "JavaScript", "C++", "Go");
List<String> longWords = words.stream()
    .filter(word -> word.length() > 4 && word.contains("a"))
    .collect(Collectors.toList());
System.out.println(longWords);  // [JavaScript]
```

## map()
Transforms each element using a ==function==.

```Java title='map() examples'
List<String> names = Arrays.asList("alice", "bob", "charlie");

// Convert to uppercase
List<String> upperNames = names.stream()
    .map(String::toUpperCase)
    .collect(Collectors.toList());
System.out.println(upperNames);  // [ALICE, BOB, CHARLIE]

// Extract lengths
List<Integer> lengths = names.stream()
    .map(String::length)
    .collect(Collectors.toList());
System.out.println(lengths);  // [5, 3, 7]

// Transform objects
class Person {
    String name;
    int age;
    Person(String name, int age) {
        this.name = name;
        this.age = age;
    }
}

List<Person> people = Arrays.asList(
    new Person("Alice", 25),
    new Person("Bob", 30),
    new Person("Charlie", 35)
);

List<String> personNames = people.stream()
    .map(person -> person.name)
    .collect(Collectors.toList());
System.out.println(personNames);  // [Alice, Bob, Charlie]

// Chain transformations
List<Integer> squaredEvens = numbers.stream()
    .filter(n -> n % 2 == 0)
    .map(n -> n * n)
    .collect(Collectors.toList());
System.out.println(squaredEvens);  // [4, 16, 36, 64, 100]
```

## flatMap()
Flattens nested structures by mapping each element to a ==stream== and merging.

```Java title='flatMap() examples'
// Flatten list of lists
List<List<Integer>> nestedList = Arrays.asList(
    Arrays.asList(1, 2, 3),
    Arrays.asList(4, 5, 6),
    Arrays.asList(7, 8, 9)
);

List<Integer> flattened = nestedList.stream()
    .flatMap(list -> list.stream())
    .collect(Collectors.toList());
System.out.println(flattened);  // [1, 2, 3, 4, 5, 6, 7, 8, 9]

// Split strings into words
List<String> sentences = Arrays.asList(
    "Hello World",
    "Java Streams",
    "Functional Programming"
);

List<String> words = sentences.stream()
    .flatMap(sentence -> Arrays.stream(sentence.split(" ")))
    .collect(Collectors.toList());
System.out.println(words);  // [Hello, World, Java, Streams, Functional, Programming]

// Flatten optional values
List<Optional<String>> optionals = Arrays.asList(
    Optional.of("A"),
    Optional.empty(),
    Optional.of("B"),
    Optional.empty(),
    Optional.of("C")
);

List<String> values = optionals.stream()
    .flatMap(Optional::stream)  // Java 9+
    .collect(Collectors.toList());
System.out.println(values);  // [A, B, C]

// Complex flattening
class Department {
    String name;
    List<Person> employees;
    Department(String name, List<Person> employees) {
        this.name = name;
        this.employees = employees;
    }
}

List<Department> departments = Arrays.asList(
    new Department("IT", Arrays.asList(new Person("Alice", 25), new Person("Bob", 30))),
    new Department("HR", Arrays.asList(new Person("Charlie", 35)))
);

List<Person> allEmployees = departments.stream()
    .flatMap(dept -> dept.employees.stream())
    .collect(Collectors.toList());
```

## distinct()
Removes ==duplicate== elements (uses equals()).

```Java title='distinct() examples'
List<Integer> numbers = Arrays.asList(1, 2, 2, 3, 3, 3, 4, 4, 4, 4);

List<Integer> unique = numbers.stream()
    .distinct()
    .collect(Collectors.toList());
System.out.println(unique);  // [1, 2, 3, 4]

// With custom objects (requires proper equals/hashCode)
List<String> words = Arrays.asList("apple", "APPLE", "banana", "Apple");

List<String> uniqueCaseInsensitive = words.stream()
    .map(String::toLowerCase)
    .distinct()
    .collect(Collectors.toList());
System.out.println(uniqueCaseInsensitive);  // [apple, banana]
```

## sorted()
Sorts elements in ==natural order== or with a ==comparator==.

```Java title='sorted() examples'
List<Integer> numbers = Arrays.asList(5, 2, 8, 1, 9, 3);

// Natural order
List<Integer> sorted = numbers.stream()
    .sorted()
    .collect(Collectors.toList());
System.out.println(sorted);  // [1, 2, 3, 5, 8, 9]

// Reverse order
List<Integer> reversed = numbers.stream()
    .sorted(Comparator.reverseOrder())
    .collect(Collectors.toList());
System.out.println(reversed);  // [9, 8, 5, 3, 2, 1]

// Custom comparator
List<String> names = Arrays.asList("Alice", "Bob", "Charlie", "David");

List<String> byLength = names.stream()
    .sorted(Comparator.comparing(String::length))
    .collect(Collectors.toList());
System.out.println(byLength);  // [Bob, Alice, David, Charlie]

// Multiple comparators
List<Person> people = Arrays.asList(
    new Person("Alice", 30),
    new Person("Bob", 25),
    new Person("Alice", 25)
);

List<Person> sortedPeople = people.stream()
    .sorted(Comparator.comparing((Person p) -> p.name)
                      .thenComparing(p -> p.age))
    .collect(Collectors.toList());
```

## peek()
Performs an ==action== on each element without modifying stream (for debugging).

```Java title='peek() for debugging'
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);

List<Integer> result = numbers.stream()
    .peek(n -> System.out.println("Original: " + n))
    .filter(n -> n % 2 == 0)
    .peek(n -> System.out.println("After filter: " + n))
    .map(n -> n * n)
    .peek(n -> System.out.println("After map: " + n))
    .collect(Collectors.toList());

// Output:
// Original: 1
// Original: 2
// After filter: 2
// After map: 4
// Original: 3
// Original: 4
// After filter: 4
// After map: 16
// Original: 5
```

## limit()
Truncates stream to ==maximum size==.

```Java title='limit() examples'
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

List<Integer> firstFive = numbers.stream()
    .limit(5)
    .collect(Collectors.toList());
System.out.println(firstFive);  // [1, 2, 3, 4, 5]

// With infinite stream
List<Integer> first10Evens = Stream.iterate(0, n -> n + 2)
    .limit(10)
    .collect(Collectors.toList());
System.out.println(first10Evens);  // [0, 2, 4, 6, 8, 10, 12, 14, 16, 18]
```

## skip()
Skips the ==first n elements==.

```Java title='skip() examples'
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

List<Integer> afterSkip = numbers.stream()
    .skip(5)
    .collect(Collectors.toList());
System.out.println(afterSkip);  // [6, 7, 8, 9, 10]

// Pagination pattern
int pageSize = 3;
int page = 2;  // 0-indexed

List<Integer> pageData = numbers.stream()
    .skip(page * pageSize)
    .limit(pageSize)
    .collect(Collectors.toList());
System.out.println(pageData);  // [7, 8, 9]
```

## mapToInt(), mapToLong(), mapToDouble()
Convert to ==primitive streams== for better performance.

```Java title='Primitive stream mapping'
List<String> numbers = Arrays.asList("1", "2", "3", "4", "5");

// mapToInt
int sum = numbers.stream()
    .mapToInt(Integer::parseInt)
    .sum();
System.out.println(sum);  // 15

// mapToDouble
double average = numbers.stream()
    .mapToDouble(Double::parseDouble)
    .average()
    .orElse(0.0);
System.out.println(average);  // 3.0

// Statistics
IntSummaryStatistics stats = numbers.stream()
    .mapToInt(Integer::parseInt)
    .summaryStatistics();

System.out.println("Count: " + stats.getCount());
System.out.println("Sum: " + stats.getSum());
System.out.println("Min: " + stats.getMin());
System.out.println("Max: " + stats.getMax());
System.out.println("Average: " + stats.getAverage());
```

# Terminal Operations

==Terminal operations== produce a result or side-effect and ==close== the stream.

## forEach()
Performs an ==action== for each element.

```Java title='forEach() examples'
List<String> names = Arrays.asList("Alice", "Bob", "Charlie");

// Simple iteration
names.stream()
    .forEach(System.out::println);

// With operation
names.stream()
    .filter(name -> name.length() > 4)
    .forEach(name -> System.out.println("Long name: " + name));

// forEachOrdered (maintains order in parallel streams)
names.parallelStream()
    .forEachOrdered(System.out::println);  // Guaranteed order
```

## collect()
Accumulates elements into a ==collection or other result==.

```Java title='collect() with Collectors'
List<String> names = Arrays.asList("Alice", "Bob", "Charlie", "David");

// To List
List<String> list = names.stream()
    .filter(n -> n.length() > 4)
    .collect(Collectors.toList());

// To Set
Set<String> set = names.stream()
    .collect(Collectors.toSet());

// To Map
Map<String, Integer> nameToLength = names.stream()
    .collect(Collectors.toMap(
        name -> name,           // key
        name -> name.length()   // value
    ));

// Grouping
Map<Integer, List<String>> byLength = names.stream()
    .collect(Collectors.groupingBy(String::length));
System.out.println(byLength);  // {3=[Bob], 5=[Alice, David], 7=[Charlie]}

// Joining strings
String joined = names.stream()
    .collect(Collectors.joining(", "));
System.out.println(joined);  // Alice, Bob, Charlie, David

// With prefix and suffix
String formatted = names.stream()
    .collect(Collectors.joining(", ", "[", "]"));
System.out.println(formatted);  // [Alice, Bob, Charlie, David]
```

## reduce()
Reduces elements to a ==single value== using an associative accumulation function.

```Java title='reduce() examples'
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);

// Sum with identity value
int sum = numbers.stream()
    .reduce(0, (a, b) -> a + b);
System.out.println(sum);  // 15

// Using method reference
int product = numbers.stream()
    .reduce(1, (a, b) -> a * b);
System.out.println(product);  // 120

// Without identity (returns Optional)
Optional<Integer> max = numbers.stream()
    .reduce((a, b) -> a > b ? a : b);
max.ifPresent(System.out::println);  // 5

// Complex reduction
String concatenated = Arrays.asList("Java", "is", "awesome").stream()
    .reduce("", (acc, str) -> acc + " " + str);
System.out.println(concatenated.trim());  // Java is awesome

// Parallel reduce with combiner
int parallelSum = numbers.parallelStream()
    .reduce(0,
        (a, b) -> a + b,           // accumulator
        (a, b) -> a + b);          // combiner (for parallel)
```

## count()
Returns the ==count== of elements.

```Java title='count() examples'
List<String> words = Arrays.asList("Java", "Python", "JavaScript", "C++");

long count = words.stream()
    .filter(word -> word.length() > 4)
    .count();
System.out.println(count);  // 3

// Count distinct
long distinctCount = Arrays.asList(1, 2, 2, 3, 3, 3).stream()
    .distinct()
    .count();
System.out.println(distinctCount);  // 3
```

## min() and max()
Find ==minimum or maximum== element using a comparator.

```Java title='min() and max() examples'
List<Integer> numbers = Arrays.asList(5, 2, 8, 1, 9, 3);

Optional<Integer> min = numbers.stream()
    .min(Integer::compareTo);
min.ifPresent(System.out::println);  // 1

Optional<Integer> max = numbers.stream()
    .max(Integer::compareTo);
max.ifPresent(System.out::println);  // 9

// With custom comparator
List<String> words = Arrays.asList("Java", "C++", "Python", "Go");

Optional<String> shortest = words.stream()
    .min(Comparator.comparing(String::length));
shortest.ifPresent(System.out::println);  // Go

Optional<String> longest = words.stream()
    .max(Comparator.comparing(String::length));
longest.ifPresent(System.out::println);  // Python
```

## anyMatch(), allMatch(), noneMatch()
Check if elements ==match== a predicate.

```Java title='Matching operations'
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);

// anyMatch - at least one match
boolean hasEven = numbers.stream()
    .anyMatch(n -> n % 2 == 0);
System.out.println(hasEven);  // true

// allMatch - all elements match
boolean allPositive = numbers.stream()
    .allMatch(n -> n > 0);
System.out.println(allPositive);  // true

boolean allEven = numbers.stream()
    .allMatch(n -> n % 2 == 0);
System.out.println(allEven);  // false

// noneMatch - no elements match
boolean noNegative = numbers.stream()
    .noneMatch(n -> n < 0);
System.out.println(noNegative);  // true

// Short-circuiting behavior
boolean found = Stream.iterate(1, n -> n + 1)
    .peek(n -> System.out.println("Checking: " + n))
    .anyMatch(n -> n > 5);
// Only checks until 6 is found
```

## findFirst() and findAny()
Find an ==element== from the stream.

```Java title='Finding elements'
List<String> names = Arrays.asList("Alice", "Bob", "Charlie", "David");

// findFirst
Optional<String> first = names.stream()
    .filter(name -> name.startsWith("C"))
    .findFirst();
first.ifPresent(System.out::println);  // Charlie

// findAny (useful in parallel streams)
Optional<String> any = names.parallelStream()
    .filter(name -> name.length() > 4)
    .findAny();
any.ifPresent(System.out::println);  // Any matching name

// Empty Optional if no match
Optional<String> notFound = names.stream()
    .filter(name -> name.startsWith("Z"))
    .findFirst();
System.out.println(notFound.isPresent());  // false
```

## toArray()
Converts stream to an ==array==.

```Java title='toArray() examples'
List<String> names = Arrays.asList("Alice", "Bob", "Charlie");

// To Object[]
Object[] array1 = names.stream().toArray();

// To typed array
String[] array2 = names.stream().toArray(String[]::new);

// With transformation
Integer[] lengths = names.stream()
    .map(String::length)
    .toArray(Integer[]::new);
```

# Parallel Streams

==Parallel streams== divide work across multiple threads using the ==ForkJoinPool==.

```Java title='Parallel stream examples'
List<Integer> numbers = IntStream.rangeClosed(1, 1000)
    .boxed()
    .collect(Collectors.toList());

// Sequential
long startSeq = System.currentTimeMillis();
int sumSeq = numbers.stream()
    .map(n -> n * 2)
    .reduce(0, Integer::sum);
long endSeq = System.currentTimeMillis();
System.out.println("Sequential: " + (endSeq - startSeq) + "ms");

// Parallel
long startPar = System.currentTimeMillis();
int sumPar = numbers.parallelStream()
    .map(n -> n * 2)
    .reduce(0, Integer::sum);
long endPar = System.currentTimeMillis();
System.out.println("Parallel: " + (endPar - startPar) + "ms");

// Convert to parallel
Stream<Integer> parallelStream = numbers.stream().parallel();

// Convert back to sequential
Stream<Integer> sequentialStream = parallelStream.sequential();

// Check if parallel
boolean isParallel = numbers.parallelStream().isParallel();  // true
```

## When to Use Parallel Streams

```Java title='Parallel stream considerations'
// Good for parallel: Independent, CPU-intensive operations
List<Integer> largeList = IntStream.rangeClosed(1, 1_000_000)
    .boxed()
    .collect(Collectors.toList());

// Parallel beneficial
long count = largeList.parallelStream()
    .filter(n -> isPrime(n))  // CPU-intensive
    .count();

// Bad for parallel: Small datasets
List<Integer> smallList = Arrays.asList(1, 2, 3, 4, 5);
// Overhead of parallelization outweighs benefits

// Bad for parallel: Order-dependent operations
List<Integer> ordered = numbers.stream()
    .sorted()  // Order matters
    .collect(Collectors.toList());

// Bad for parallel: Shared mutable state
List<Integer> result = new ArrayList<>();  // NOT thread-safe
numbers.parallelStream()
    .forEach(result::add);  // WRONG: race condition

// Correct: Use collect
List<Integer> safeResult = numbers.parallelStream()
    .collect(Collectors.toList());  // Thread-safe

static boolean isPrime(int n) {
    if (n <= 1) return false;
    for (int i = 2; i <= Math.sqrt(n); i++) {
        if (n % i == 0) return false;
    }
    return true;
}
```

# Practical Examples

## Data Processing Pipeline
```Java title='Complete data processing example'
class Employee {
    String name;
    String department;
    double salary;
    int age;

    Employee(String name, String department, double salary, int age) {
        this.name = name;
        this.department = department;
        this.salary = salary;
        this.age = age;
    }

    @Override
    public String toString() {
        return String.format("Employee{name='%s', dept='%s', salary=%.2f, age=%d}",
                           name, department, salary, age);
    }
}

List<Employee> employees = Arrays.asList(
    new Employee("Alice", "IT", 75000, 30),
    new Employee("Bob", "HR", 60000, 35),
    new Employee("Charlie", "IT", 85000, 28),
    new Employee("David", "Finance", 70000, 40),
    new Employee("Eve", "IT", 90000, 32),
    new Employee("Frank", "HR", 55000, 29)
);

// Average salary by department
Map<String, Double> avgSalaryByDept = employees.stream()
    .collect(Collectors.groupingBy(
        e -> e.department,
        Collectors.averagingDouble(e -> e.salary)
    ));
System.out.println("Average salary by department: " + avgSalaryByDept);

// Top 3 earners
List<Employee> top3 = employees.stream()
    .sorted(Comparator.comparing((Employee e) -> e.salary).reversed())
    .limit(3)
    .collect(Collectors.toList());
System.out.println("Top 3 earners: " + top3);

// IT department employees with salary > 80000
List<String> highEarningIT = employees.stream()
    .filter(e -> e.department.equals("IT"))
    .filter(e -> e.salary > 80000)
    .map(e -> e.name)
    .collect(Collectors.toList());
System.out.println("High earning IT: " + highEarningIT);

// Total salary by department
Map<String, Double> totalSalary = employees.stream()
    .collect(Collectors.groupingBy(
        e -> e.department,
        Collectors.summingDouble(e -> e.salary)
    ));
System.out.println("Total salary by department: " + totalSalary);

// Partition by age
Map<Boolean, List<Employee>> partitioned = employees.stream()
    .collect(Collectors.partitioningBy(e -> e.age >= 30));
System.out.println("Under 30: " + partitioned.get(false));
System.out.println("30 and over: " + partitioned.get(true));
```

## File Processing
```Java title='Processing log files with streams'
try (Stream<String> lines = Files.lines(Paths.get("application.log"))) {
    // Count error lines
    long errorCount = lines
        .filter(line -> line.contains("ERROR"))
        .count();
    System.out.println("Error count: " + errorCount);
} catch (IOException e) {
    e.printStackTrace();
}

try (Stream<String> lines = Files.lines(Paths.get("access.log"))) {
    // Extract unique IP addresses
    Set<String> uniqueIPs = lines
        .map(line -> line.split(" ")[0])  // Assuming IP is first field
        .collect(Collectors.toSet());
    System.out.println("Unique IPs: " + uniqueIPs);
} catch (IOException e) {
    e.printStackTrace();
}

try (Stream<String> lines = Files.lines(Paths.get("data.csv"))) {
    // Parse CSV and aggregate
    Map<String, Long> categoryCounts = lines
        .skip(1)  // Skip header
        .map(line -> line.split(",")[2])  // Category column
        .collect(Collectors.groupingBy(
            category -> category,
            Collectors.counting()
        ));
    System.out.println(categoryCounts);
} catch (IOException e) {
    e.printStackTrace();
}
```

## Statistical Analysis
```Java title='Stream statistics'
List<Integer> scores = Arrays.asList(85, 92, 78, 95, 88, 76, 90, 84, 89, 93);

// Using primitive stream for statistics
IntSummaryStatistics stats = scores.stream()
    .mapToInt(Integer::intValue)
    .summaryStatistics();

System.out.println("Count: " + stats.getCount());
System.out.println("Sum: " + stats.getSum());
System.out.println("Min: " + stats.getMin());
System.out.println("Max: " + stats.getMax());
System.out.println("Average: " + stats.getAverage());

// Custom statistics
double median = scores.stream()
    .sorted()
    .skip(scores.size() / 2)
    .findFirst()
    .orElse(0);
System.out.println("Median: " + median);

// Standard deviation
double mean = stats.getAverage();
double variance = scores.stream()
    .mapToDouble(score -> Math.pow(score - mean, 2))
    .average()
    .orElse(0.0);
double stdDev = Math.sqrt(variance);
System.out.println("Standard deviation: " + stdDev);
```

# Best Practices

## Prefer Stream Operations Over Loops
```Java title='Stream vs traditional loop'
List<String> names = Arrays.asList("Alice", "Bob", "Charlie", "David");

// Traditional loop
List<String> filtered = new ArrayList<>();
for (String name : names) {
    if (name.length() > 4) {
        filtered.add(name.toUpperCase());
    }
}

// Stream (more readable)
List<String> streamFiltered = names.stream()
    .filter(name -> name.length() > 4)
    .map(String::toUpperCase)
    .collect(Collectors.toList());
```

## Use Method References When Possible
```Java title='Method references for clarity'
// Lambda
names.stream().map(name -> name.toUpperCase()).collect(Collectors.toList());

// Method reference (cleaner)
names.stream().map(String::toUpperCase).collect(Collectors.toList());

// Lambda
numbers.stream().forEach(n -> System.out.println(n));

// Method reference
numbers.stream().forEach(System.out::println);
```

## Avoid Side Effects in Stream Operations
```Java title='Avoiding side effects'
List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);

// Bad: Side effects (modifying external state)
List<Integer> result = new ArrayList<>();
numbers.stream()
    .filter(n -> n % 2 == 0)
    .forEach(n -> result.add(n * 2));  // Side effect

// Good: Use collect
List<Integer> goodResult = numbers.stream()
    .filter(n -> n % 2 == 0)
    .map(n -> n * 2)
    .collect(Collectors.toList());
```

## Use Appropriate Terminal Operations
```Java title='Choosing terminal operations'
// Use anyMatch instead of filter + isEmpty
boolean hasEven = numbers.stream().anyMatch(n -> n % 2 == 0);

// Instead of
boolean hasEvenBad = !numbers.stream()
    .filter(n -> n % 2 == 0)
    .collect(Collectors.toList())
    .isEmpty();

// Use findFirst/findAny for single element
Optional<Integer> first = numbers.stream()
    .filter(n -> n > 5)
    .findFirst();

// Instead of collecting all then getting first
Integer firstBad = numbers.stream()
    .filter(n -> n > 5)
    .collect(Collectors.toList())
    .get(0);  // May throw exception
```

## Be Careful with Parallel Streams
```Java title='Parallel stream cautions'
// Don't use parallel for small datasets
List<Integer> small = Arrays.asList(1, 2, 3);
// Overhead > benefit
small.parallelStream()...  // Not worth it

// Ensure thread safety
List<Integer> threadSafe = numbers.parallelStream()
    .collect(Collectors.toList());  // Thread-safe

// Avoid stateful lambda expressions
AtomicInteger counter = new AtomicInteger();
numbers.parallelStream()
    .forEach(n -> counter.incrementAndGet());  // Race condition possible
```

***
# References
1. Java 8 in Action: Lambdas, Streams, and functional-style programming - Raoul-Gabriel Urma, Mario Fusco, Alan Mycroft - Manning Publications
   1. Chapter 4: Introducing streams
   2. Chapter 5: Working with streams
   3. Chapter 6: Collecting data with streams
   4. Chapter 7: Parallel data processing and performance
2. Effective Java, 3rd Edition - Joshua Bloch
    1. Item 45: Use streams judiciously
    2. Item 46: Prefer side-effect-free functions in streams
    3. Item 47: Prefer Collection to Stream as a return type
    4. Item 48: Use caution when making streams parallel
3. https://docs.oracle.com/javase/8/docs/api/java/util/stream/Stream.html for Stream API documentation
4. https://docs.oracle.com/javase/8/docs/api/java/util/stream/Collectors.html for Collectors documentation
