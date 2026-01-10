#java #object-oriented-programming #data-types
# Wrapper Classes
==Wrapper classes== provide an object representation of Java's primitive data types, allowing primitives to be used in contexts that require objects, such as collections, generics, and utility methods.

# The Eight Wrapper Classes

| Primitive | Wrapper Class | Package |
|-----------|---------------|---------|
| byte | Byte | java.lang |
| short | Short | java.lang |
| int | Integer | java.lang |
| long | Long | java.lang |
| float | Float | java.lang |
| double | Double | java.lang |
| char | Character | java.lang |
| boolean | Boolean | java.lang |

# Creating Wrapper Objects

## Constructor (Deprecated since Java 9)
```Java title='Constructor creation (deprecated)'
// Not recommended - deprecated in Java 9
Integer num1 = new Integer(10);
Double price = new Double(19.99);
```

## valueOf() Method (Preferred)
```Java title='Creating wrappers with valueOf()'
// Recommended approach - uses caching
Integer num = Integer.valueOf(10);
Double price = Double.valueOf(19.99);
Character letter = Character.valueOf('A');
Boolean flag = Boolean.valueOf(true);

// From String
Integer parsed = Integer.valueOf("123");
Double decimal = Double.valueOf("19.99");
```

## Autoboxing (Automatic)
```Java title='Autoboxing - automatic conversion'
// Compiler automatically converts primitive to wrapper
Integer num = 10;              // autoboxing
Double price = 19.99;          // autoboxing
Boolean flag = true;           // autoboxing

// In collections
List<Integer> numbers = new ArrayList<>();
numbers.add(5);                // autoboxing: int → Integer
```

# Extracting Primitive Values

## Unboxing Methods
```Java title='Unboxing - wrapper to primitive'
Integer wrapperInt = 100;
int primitiveInt = wrapperInt.intValue();

Double wrapperDouble = 19.99;
double primitiveDouble = wrapperDouble.doubleValue();

Boolean wrapperBool = true;
boolean primitiveBool = wrapperBool.booleanValue();

// Auto-unboxing (automatic)
Integer wrapped = 50;
int primitive = wrapped;       // auto-unboxing
int result = wrapped + 10;     // auto-unboxing in expression
```

# Autoboxing and Unboxing

## Autoboxing
==Automatic conversion of primitive to wrapper== object by the compiler.

```Java title='Autoboxing examples'
// Assignment
Integer i = 100;              // int → Integer

// Method parameters
public void process(Integer num) {
    System.out.println(num);
}

process(42);                  // int → Integer

// Collections
List<Integer> list = new ArrayList<>();
list.add(10);                 // int → Integer
list.add(20);
list.add(30);

// Return values
public Integer calculate() {
    return 100;               // int → Integer
}
```

## Unboxing
==Automatic conversion of wrapper to primitive== by the compiler.

```Java title='Unboxing examples'
// Assignment
Integer wrapped = 100;
int primitive = wrapped;      // Integer → int

// Arithmetic operations
Integer a = 10;
Integer b = 20;
int sum = a + b;             // Both unboxed for addition

// Comparisons
Integer x = 50;
if (x > 30) {                // Unboxed for comparison
    System.out.println("Greater");
}

// Method arguments
public void print(int value) {
    System.out.println(value);
}

Integer num = 42;
print(num);                  // Integer → int
```

## Autoboxing/Unboxing Performance Cost
```Java title='Performance implications'
// Inefficient: repeated autoboxing
Long sum = 0L;
for (int i = 0; i < 1_000_000; i++) {
    sum += i;  // creates 1 million Long objects!
}

// Efficient: use primitive
long sum = 0L;
for (int i = 0; i < 1_000_000; i++) {
    sum += i;  // no object creation
}
```

# Caching and Object Identity

## Integer Caching
Java caches Integer objects in the range **-128 to 127** by default.

```Java title='Integer caching demonstration'
// Cached integers (in range -128 to 127)
Integer a = 100;
Integer b = 100;
System.out.println(a == b);         // true (same object)
System.out.println(a.equals(b));    // true (same value)

// Non-cached integers (outside cache range)
Integer x = 200;
Integer y = 200;
System.out.println(x == y);         // false (different objects)
System.out.println(x.equals(y));    // true (same value)

// Explicitly created objects (no caching)
Integer m = new Integer(100);
Integer n = new Integer(100);
System.out.println(m == n);         // false (different objects)
System.out.println(m.equals(n));    // true (same value)
```

## Other Wrapper Caching
- **Byte**: All values cached (-128 to 127)
- **Short**: Values -128 to 127 cached
- **Long**: Values -128 to 127 cached
- **Character**: Values 0 to 127 cached
- **Boolean**: TRUE and FALSE constants cached

```Java title='Boolean caching'
Boolean b1 = true;
Boolean b2 = true;
System.out.println(b1 == b2);       // true (cached)

Boolean b3 = Boolean.valueOf(false);
Boolean b4 = Boolean.valueOf(false);
System.out.println(b3 == b4);       // true (cached)
```

# Null Values

Wrapper classes can be ==null==, unlike primitives.

```Java title='Null handling with wrappers'
Integer nullableInt = null;         // Valid
// int primitiveInt = null;         // Compilation error

// NullPointerException risk
Integer value = null;
// int result = value + 10;         // NullPointerException (unboxing null)

// Safe handling
Integer amount = getUserInput();    // may return null
if (amount != null) {
    int total = amount + 100;       // Safe unboxing
} else {
    // Handle null case
}

// Using Optional (Java 8+)
Optional<Integer> optAmount = Optional.ofNullable(getUserInput());
int total = optAmount.orElse(0) + 100;
```

# Utility Methods

## Parsing Strings
```Java title='String to primitive/wrapper conversion'
// parseInt() - returns primitive
int intValue = Integer.parseInt("123");
long longValue = Long.parseLong("9999999999");
double doubleValue = Double.parseDouble("19.99");
boolean boolValue = Boolean.parseBoolean("true");

// valueOf() - returns wrapper
Integer integer = Integer.valueOf("123");
Long longObj = Long.valueOf("9999999999");

// Different radix
int binary = Integer.parseInt("1010", 2);      // 10
int hex = Integer.parseInt("FF", 16);          // 255
int octal = Integer.parseInt("77", 8);         // 63

// NumberFormatException
try {
    int invalid = Integer.parseInt("abc");
} catch (NumberFormatException e) {
    System.out.println("Invalid number format");
}
```

## Converting to String
```Java title='Wrapper to String conversion'
Integer num = 123;
String str1 = num.toString();           // "123"
String str2 = String.valueOf(num);      // "123"
String str3 = Integer.toString(num);    // "123"

// With radix
String binary = Integer.toString(10, 2);   // "1010"
String hex = Integer.toString(255, 16);    // "ff"
String octal = Integer.toString(63, 8);    // "77"

// Formatting
String formatted = String.format("%05d", num);  // "00123"
```

## Comparison Methods
```Java title='Comparing wrapper values'
Integer a = 100;
Integer b = 200;

// compareTo() - returns int
int result = a.compareTo(b);
// result < 0 if a < b
// result == 0 if a == b
// result > 0 if a > b

System.out.println(a.compareTo(b));     // -1 (or negative)
System.out.println(b.compareTo(a));     // 1 (or positive)

// compare() - static method
int comparison = Integer.compare(100, 200);  // -1
int comparison2 = Double.compare(10.5, 10.5); // 0
```

## Constants
```Java title='Useful constants in wrapper classes'
// Integer constants
int maxInt = Integer.MAX_VALUE;         // 2147483647
int minInt = Integer.MIN_VALUE;         // -2147483648
int intSize = Integer.SIZE;             // 32 (bits)
int intBytes = Integer.BYTES;           // 4 (bytes)

// Double constants
double maxDouble = Double.MAX_VALUE;
double minDouble = Double.MIN_VALUE;
double posInfinity = Double.POSITIVE_INFINITY;
double negInfinity = Double.NEGATIVE_INFINITY;
double notANumber = Double.NaN;

// Boolean constants
Boolean trueObj = Boolean.TRUE;
Boolean falseObj = Boolean.FALSE;
```

## Bitwise and Mathematical Operations
```Java title='Integer utility methods'
// Bitwise operations
int bitCount = Integer.bitCount(15);        // 4 (number of 1s)
int highestBit = Integer.highestOneBit(10); // 8 (0b1000)
int lowestBit = Integer.lowestOneBit(10);   // 2 (0b0010)

// Rotation
int rotateLeft = Integer.rotateLeft(8, 1);  // 16
int rotateRight = Integer.rotateRight(8, 1); // 4

// Sign
int signum = Integer.signum(-42);           // -1

// Conversion
String binary = Integer.toBinaryString(10); // "1010"
String hex = Integer.toHexString(255);      // "ff"
String octal = Integer.toOctalString(63);   // "77"
```

## Character Utilities
```Java title='Character class utilities'
// Type checking
char ch = 'A';
boolean isLetter = Character.isLetter(ch);           // true
boolean isDigit = Character.isDigit('5');            // true
boolean isWhitespace = Character.isWhitespace(' ');  // true
boolean isUpperCase = Character.isUpperCase('A');    // true
boolean isLowerCase = Character.isLowerCase('a');    // true

// Case conversion
char upper = Character.toUpperCase('a');    // 'A'
char lower = Character.toLowerCase('A');    // 'a'

// Numeric value
int digitValue = Character.getNumericValue('5');  // 5
int hexValue = Character.getNumericValue('F');    // 15
```

# Use Cases

## Collections
Wrapper classes are ==required for collections== since collections cannot store primitives.

```Java title='Wrappers in collections'
// List of integers
List<Integer> numbers = new ArrayList<>();
numbers.add(10);           // autoboxing
numbers.add(20);
numbers.add(30);

// Map with primitive-like keys and values
Map<Integer, String> idToName = new HashMap<>();
idToName.put(1, "Alice");  // autoboxing key
idToName.put(2, "Bob");

// Set of unique numbers
Set<Long> userIds = new HashSet<>();
userIds.add(123456789L);
userIds.add(987654321L);
```

## Generics
```Java title='Wrappers with generics'
// Generic method requires wrapper class
public <T extends Number> double sum(List<T> numbers) {
    double total = 0;
    for (T num : numbers) {
        total += num.doubleValue();
    }
    return total;
}

// Usage
List<Integer> integers = Arrays.asList(1, 2, 3, 4, 5);
double result = sum(integers);

// Cannot use primitives with generics
// List<int> invalid;  // Compilation error
```

## Null Representation
```Java title='Using null with wrappers'
public Integer findUserAge(String username) {
    User user = database.findUser(username);
    if (user == null) {
        return null;  // Indicates "not found" or "unknown"
    }
    return user.getAge();
}

// Caller handles null
Integer age = findUserAge("john");
if (age != null) {
    System.out.println("Age: " + age);
} else {
    System.out.println("User not found");
}
```

## Utility Methods
```Java title='Using wrapper utility methods'
// Validation
public boolean isValidPort(String input) {
    try {
        int port = Integer.parseInt(input);
        return port >= 1 && port <= 65535;
    } catch (NumberFormatException e) {
        return false;
    }
}

// Comparison
public void sortDescending(List<Integer> numbers) {
    numbers.sort((a, b) -> b.compareTo(a));
}

// Min/Max finding
List<Integer> scores = Arrays.asList(85, 92, 78, 95, 88);
Integer maxScore = scores.stream()
    .max(Integer::compareTo)
    .orElse(0);
```

# Common Pitfalls

## NullPointerException with Auto-unboxing
```Java title='NullPointerException trap'
Integer count = null;
// int value = count;  // NullPointerException at runtime

// Safe approach
Integer count = getCount();
int value = (count != null) ? count : 0;

// Or use Optional
int value = Optional.ofNullable(count).orElse(0);
```

## Reference Comparison Instead of Value Comparison
```Java title='Comparison pitfalls'
Integer a = 200;
Integer b = 200;

// WRONG: compares references (outside cache range)
if (a == b) {  // false
    System.out.println("Equal");
}

// CORRECT: compares values
if (a.equals(b)) {  // true
    System.out.println("Equal");
}

// For primitives (after unboxing)
if (a.intValue() == b.intValue()) {  // true
    System.out.println("Equal");
}
```

## Performance Overhead
```Java title='Autoboxing performance cost'
// Inefficient: creates many wrapper objects
Integer sum = 0;
for (int i = 0; i < 1_000_000; i++) {
    sum += i;  // unbox, add, box (3 operations per iteration)
}

// Efficient: use primitive
int sum = 0;
for (int i = 0; i < 1_000_000; i++) {
    sum += i;  // direct addition
}
```

## Ternary Operator Type Mismatch
```Java title='Ternary operator unboxing trap'
Integer i = null;
// NullPointerException: unboxing null to meet int type
// int value = (true) ? i : 0;

// Solution 1: ensure both operands are same type
Integer value = (true) ? i : Integer.valueOf(0);

// Solution 2: null check
int value = (i != null) ? i : 0;
```

# Best Practices

## Prefer Primitives When Possible
```Java title='Choose primitives over wrappers'
// Good: performance-critical code
public long calculateSum(int[] numbers) {
    long sum = 0;
    for (int num : numbers) {
        sum += num;
    }
    return sum;
}

// Bad: unnecessary wrapper usage
public Long calculateSum(Integer[] numbers) {
    Long sum = 0L;
    for (Integer num : numbers) {
        sum += num;  // unbox + box overhead
    }
    return sum;
}
```

## Use valueOf() Instead of Constructors
```Java title='Prefer valueOf() for caching benefits'
// Good: benefits from caching
Integer cached = Integer.valueOf(100);

// Bad: always creates new object (deprecated)
Integer notCached = new Integer(100);
```

## Always Use equals() for Wrapper Comparison
```Java title='Safe wrapper comparison'
// Always use equals()
Integer a = 500;
Integer b = 500;

if (a.equals(b)) {  // Correct
    System.out.println("Equal");
}

// Null-safe comparison (Java 7+)
if (Objects.equals(a, b)) {
    System.out.println("Equal");
}
```

## Handle Null Appropriately
```Java title='Null safety with wrappers'
// Validate before unboxing
public int processValue(Integer value) {
    if (value == null) {
        throw new IllegalArgumentException("Value cannot be null");
    }
    return value * 2;  // Safe unboxing
}

// Use primitives in method signatures when null not needed
public void setAge(int age) {  // Better than Integer
    this.age = age;
}
```

***
# References
1. Effective Java, 3rd Edition - Joshua Bloch
   1. Item 6: Avoid creating unnecessary objects
   2. Item 61: Prefer primitive types to boxed primitives
2. The Java Language Specification - Oracle
   1. Chapter 5.1.7: Boxing Conversion
   2. Chapter 5.1.8: Unboxing Conversion
3. https://docs.oracle.com/javase/tutorial/java/data/autoboxing.html for autoboxing and unboxing
4. https://docs.oracle.com/javase/8/docs/api/java/lang/Integer.html for Integer class documentation
