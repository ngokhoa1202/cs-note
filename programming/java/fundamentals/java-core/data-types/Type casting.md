#java #data-types #type-conversion
# Type Casting
==Type casting== is the process of converting a value from one data type to another in Java. There are two types: ==implicit casting== (widening) and ==explicit casting== (narrowing).

# Widening Conversion (Implicit Casting)

Automatic conversion from smaller to larger data type ==without data loss==.

## Widening Hierarchy
```
byte → short → int → long → float → double
       char → int
```

## Automatic Widening Examples
```Java title='Implicit widening conversion'
// Numeric widening
byte byteValue = 10;
short shortValue = byteValue;   // byte → short
int intValue = shortValue;      // short → int
long longValue = intValue;      // int → long
float floatValue = longValue;   // long → float
double doubleValue = floatValue; // float → double

// Character widening
char charValue = 'A';           // ASCII 65
int charToInt = charValue;      // char → int (65)
long charToLong = charValue;    // char → long (65)

// In expressions
int a = 10;
double b = 5.5;
double result = a + b;          // a promoted to double (15.5)

// Method parameter widening
public void printDouble(double value) {
    System.out.println(value);
}

int number = 42;
printDouble(number);            // int → double automatically
```

## Widening in Arithmetic Operations
```Java title='Type promotion in expressions'
byte b1 = 10;
byte b2 = 20;
int result = b1 + b2;           // Both promoted to int

short s = 100;
int multiplied = s * 2;         // short promoted to int

char c = 'A';
int charMath = c + 1;           // char promoted to int (66)

// Mixed type arithmetic
int i = 10;
long l = 20L;
long sum = i + l;               // int promoted to long

float f = 5.5f;
double d = 10.5;
double total = f + d;           // float promoted to double
```

# Narrowing Conversion (Explicit Casting)

Manual conversion from larger to smaller data type, ==may cause data loss==.

## Narrowing Hierarchy
```
double → float → long → int → short → byte
                              ↓
                            char
```

## Explicit Narrowing Examples
```Java title='Explicit narrowing conversion'
// Requires explicit cast
double doubleValue = 10.99;
float floatValue = (float) doubleValue;   // 10.99f
long longValue = (long) floatValue;       // 10L
int intValue = (int) longValue;           // 10
short shortValue = (short) intValue;      // 10
byte byteValue = (byte) shortValue;       // 10

// Direct narrowing
double price = 19.99;
int dollars = (int) price;                // 19 (decimal truncated)

long bigNumber = 1_000_000L;
int truncated = (int) bigNumber;          // 1000000 (fits)

// char narrowing
int asciiValue = 65;
char letter = (char) asciiValue;          // 'A'
```

## Data Loss in Narrowing
```Java title='Narrowing with data loss'
// Decimal truncation
double decimal = 9.99;
int truncated = (int) decimal;            // 9 (not rounded!)
System.out.println(truncated);

// Overflow in narrowing
int largeInt = 130;
byte overflowed = (byte) largeInt;        // -126 (wraps around)
System.out.println(overflowed);

// Explanation: 130 in binary = 0b10000010
// Interpreted as signed byte = -126 (two's complement)

long veryLarge = 10_000_000_000L;
int overflow = (int) veryLarge;           // 1410065408 (overflow)

// Character overflow
int codePoint = 70000;
char invalid = (char) codePoint;          // \u0001 (mod 65536)
```

## Safe Narrowing with Validation
```Java title='Validating before narrowing cast'
// Check range before casting
long value = 200L;
if (value >= Integer.MIN_VALUE && value <= Integer.MAX_VALUE) {
    int safeInt = (int) value;
    System.out.println("Safe: " + safeInt);
} else {
    System.out.println("Value out of int range");
}

// Using Math for rounding
double price = 19.99;
int rounded = (int) Math.round(price);    // 20 (rounded)
int floor = (int) Math.floor(price);      // 19 (floor)
int ceil = (int) Math.ceil(price);        // 20 (ceiling)

// Clamping values
public int safeCast(long value) {
    if (value > Integer.MAX_VALUE) {
        return Integer.MAX_VALUE;
    } else if (value < Integer.MIN_VALUE) {
        return Integer.MIN_VALUE;
    }
    return (int) value;
}
```

# Reference Type Casting

## Upcasting (Implicit)
Converting subclass reference to superclass reference is ==automatic and safe==.

```Java title='Upcasting examples'
class Animal {
    void eat() {
        System.out.println("Animal eating");
    }
}

class Dog extends Animal {
    void bark() {
        System.out.println("Dog barking");
    }
}

// Upcasting (implicit)
Dog dog = new Dog();
Animal animal = dog;            // Dog → Animal (automatic)

// Upcasting to interface
class ArrayList<E> implements List<E> { ... }

ArrayList<String> arrayList = new ArrayList<>();
List<String> list = arrayList;  // ArrayList → List (automatic)

// Method parameter upcasting
public void feedAnimal(Animal animal) {
    animal.eat();
}

Dog myDog = new Dog();
feedAnimal(myDog);              // Dog → Animal (automatic)
```

## Downcasting (Explicit)
Converting superclass reference back to subclass requires ==explicit cast and runtime check==.

```Java title='Downcasting with validation'
Animal animal = new Dog();      // Upcasting first

// Downcasting (explicit)
Dog dog = (Dog) animal;         // Animal → Dog (requires cast)
dog.bark();                     // Now can call Dog methods

// Unsafe downcasting (ClassCastException)
Animal cat = new Cat();
// Dog wrongCast = (Dog) cat;   // ClassCastException at runtime

// Safe downcasting with instanceof
Animal animal = getAnimal();
if (animal instanceof Dog) {
    Dog dog = (Dog) animal;     // Safe cast
    dog.bark();
} else {
    System.out.println("Not a dog");
}

// Pattern matching (Java 16+)
if (animal instanceof Dog dog) {
    dog.bark();                 // Automatically cast and assigned
}
```

## Casting with Interfaces
```Java title='Interface casting'
interface Flyable {
    void fly();
}

class Bird implements Flyable {
    public void fly() {
        System.out.println("Bird flying");
    }
    void chirp() {
        System.out.println("Bird chirping");
    }
}

// Upcasting to interface
Bird bird = new Bird();
Flyable flyable = bird;         // Bird → Flyable (automatic)
flyable.fly();                  // Can call interface methods
// flyable.chirp();             // Compilation error

// Downcasting from interface
if (flyable instanceof Bird) {
    Bird castedBird = (Bird) flyable;
    castedBird.chirp();         // Can call Bird methods
}
```

# Special Casting Scenarios

## String Conversion
```Java title='Converting to and from String'
// Primitive to String
int number = 42;
String str1 = String.valueOf(number);     // "42"
String str2 = Integer.toString(number);   // "42"
String str3 = "" + number;                // "42" (concatenation)

// String to primitive
String input = "123";
int parsed = Integer.parseInt(input);     // 123
double decimal = Double.parseDouble("19.99"); // 19.99
boolean flag = Boolean.parseBoolean("true");  // true

// Handling parse errors
try {
    int invalid = Integer.parseInt("abc");
} catch (NumberFormatException e) {
    System.out.println("Invalid number format");
}
```

## Array Casting
```Java title='Array type casting'
// Array covariance (compile-time allowed, runtime risky)
Object[] objects = new String[3];   // String[] → Object[]
objects[0] = "Hello";               // OK
// objects[1] = 123;                // ArrayStoreException at runtime

// Safe array operations
String[] strings = {"A", "B", "C"};
Object[] objects = strings;         // Covariant
Object first = objects[0];          // OK (upcasting element)
String str = (String) objects[0];   // OK (downcasting element)
```

## Wrapper Casting
```Java title='Wrapper class casting'
// Wrapper to primitive (unboxing)
Integer wrapped = 100;
int primitive = wrapped;            // Auto-unboxing
int explicit = (int) wrapped;       // Explicit unboxing

// Primitive to wrapper (boxing)
int value = 50;
Integer boxed = value;              // Auto-boxing
Integer explicit = (Integer) value; // Explicit boxing (unnecessary)

// Wrapper type casting (careful!)
Object obj = Integer.valueOf(42);
Integer num = (Integer) obj;        // OK
// Long wrong = (Long) obj;         // ClassCastException

// Number hierarchy casting
Number number = Integer.valueOf(100);
int intValue = number.intValue();   // Safe extraction
Integer casted = (Integer) number;  // Downcasting (risky if not Integer)
```

# instanceof Operator

The ==instanceof== operator tests whether an object is an instance of a specific class or interface.

```Java title='instanceof for safe casting'
Object obj = "Hello";

// Check before casting
if (obj instanceof String) {
    String str = (String) obj;      // Safe cast
    System.out.println(str.toUpperCase());
}

// With inheritance
Animal animal = new Dog();
if (animal instanceof Dog) {
    Dog dog = (Dog) animal;
    dog.bark();
}

if (animal instanceof Animal) {     // true
    System.out.println("Is an animal");
}

// Null safety
Object nullObj = null;
boolean result = nullObj instanceof String;  // false (not exception)

// Pattern matching (Java 16+)
if (obj instanceof String str) {
    System.out.println(str.toUpperCase());  // str already cast
}
```

# Casting Rules and Restrictions

## Compile-Time Rules
```Java title='Compile-time casting validation'
// Valid casts (compile-time check passes)
Number num = Integer.valueOf(10);
Integer i = (Integer) num;          // OK (Integer is Number)

// Invalid casts (compile-time error)
String str = "Hello";
// Integer invalid = (Integer) str; // Compilation error: incompatible types

int primitive = 10;
// String impossible = (String) primitive; // Compilation error
```

## Runtime Rules
```Java title='Runtime casting validation'
// Compile-time OK, runtime check needed
Object obj = "Hello";
Integer num = (Integer) obj;        // ClassCastException at runtime

// Safe with instanceof
if (obj instanceof Integer) {
    Integer num = (Integer) obj;    // Never throws exception
} else {
    System.out.println("Not an Integer");
}
```

## Primitive Casting Restrictions
```Java title='Primitive casting rules'
// Cannot cast boolean to/from numeric types
boolean flag = true;
// int value = (int) flag;          // Compilation error

// Cannot cast String to primitive directly
String str = "42";
// int value = (int) str;           // Compilation error
int value = Integer.parseInt(str);  // Correct approach

// Cannot cast object to primitive directly
Object obj = Integer.valueOf(42);
// int value = (int) obj;           // Compilation error
int value = (Integer) obj;          // Unbox after casting to Integer
```

# Performance Considerations

```Java title='Casting performance implications'
// Casting has minimal overhead for primitives
long start = System.nanoTime();
for (int i = 0; i < 1_000_000; i++) {
    double d = (double) i;          // Negligible cost
}
long end = System.nanoTime();

// Reference casting has instanceof check overhead
Animal animal = new Dog();
for (int i = 0; i < 1_000_000; i++) {
    if (animal instanceof Dog) {
        Dog dog = (Dog) animal;     // Runtime type check
    }
}

// Avoid repeated casting in loops
List<Object> objects = getObjects();

// Inefficient: cast inside loop
for (Object obj : objects) {
    if (obj instanceof String) {
        String str = (String) obj;
        process(str);
    }
}

// Better: filter and cast once
objects.stream()
    .filter(obj -> obj instanceof String)
    .map(obj -> (String) obj)
    .forEach(this::process);
```

# Best Practices

## Prefer Polymorphism Over Casting
```Java title='Avoid excessive downcasting'
// Bad: requires casting
public void process(Animal animal) {
    if (animal instanceof Dog) {
        Dog dog = (Dog) animal;
        dog.bark();
    } else if (animal instanceof Cat) {
        Cat cat = (Cat) animal;
        cat.meow();
    }
}

// Good: use polymorphism
abstract class Animal {
    abstract void makeSound();
}

class Dog extends Animal {
    void makeSound() {
        bark();
    }
}

public void process(Animal animal) {
    animal.makeSound();             // No casting needed
}
```

## Always Validate Before Casting
```Java title='Safe casting practices'
// Always use instanceof before downcasting
Object obj = getValue();
if (obj instanceof String) {
    String str = (String) obj;
    // Use str safely
}

// Or use pattern matching (Java 16+)
if (obj instanceof String str) {
    // str is automatically cast
}

// For numeric narrowing, check range
long value = getLongValue();
if (value >= Integer.MIN_VALUE && value <= Integer.MAX_VALUE) {
    int safeInt = (int) value;
}
```

## Use Appropriate Rounding
```Java title='Rounding during narrowing'
// Don't rely on truncation
double price = 19.99;
int wrong = (int) price;            // 19 (truncated)

// Use explicit rounding
int rounded = (int) Math.round(price);      // 20
int floor = (int) Math.floor(price);        // 19
int ceiling = (int) Math.ceil(price);       // 20

// For monetary values, use BigDecimal
BigDecimal amount = new BigDecimal("19.99");
int dollars = amount.setScale(0, RoundingMode.HALF_UP).intValue();
```

## Avoid Unnecessary Casting
```Java title='Eliminate redundant casts'
// Unnecessary casts
int value = 10;
long unnecessary = (long) (value + 20);     // Redundant outer cast

// Sufficient casting
long sufficient = (long) value + 20;        // value promoted to long

// Auto-casting in assignments
double d = 10;              // int → double (automatic)
Integer i = 42;             // int → Integer (autoboxing)
```

***
# References
1. The Java Language Specification - Oracle
   1. Chapter 5: Conversions and Contexts
   2. Section 5.1: Widening and Narrowing Primitive Conversions
   3. Section 5.5: Casting Contexts
2. Effective Java, 3rd Edition - Joshua Bloch
   1. Item 14: Consider implementing Comparable
3. https://docs.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html for type conversion basics
4. https://docs.oracle.com/javase/specs/jls/se17/html/jls-5.html for detailed conversion rules
