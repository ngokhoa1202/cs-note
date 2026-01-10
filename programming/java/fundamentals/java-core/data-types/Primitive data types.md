#java #data-types #primitives
# Primitive Data Types
Java has ==8 primitive data types== that represent simple values and are not objects. Primitives are stored directly in memory, making them more efficient than object types.

# The Eight Primitive Types

## Integral Types

### byte
- **Size**: 8 bits (1 byte)
- **Range**: -128 to 127 ($-2^7$ to $2^7-1$)
- **Default**: 0
- **Usage**: Memory-sensitive operations, byte streams, binary data

```Java title='byte examples'
byte age = 25;
byte temperature = -10;
byte maxValue = 127;
byte minValue = -128;

// Common use case: reading binary files
byte[] fileData = new byte[1024];
```

### short
- **Size**: 16 bits (2 bytes)
- **Range**: -32,768 to 32,767 ($-2^{15}$ to $2^{15}-1$)
- **Default**: 0
- **Usage**: Memory optimization when int is too large

```Java title='short examples'
short year = 2024;
short portNumber = 8080;
short maxValue = 32767;
```

### int
- **Size**: 32 bits (4 bytes)
- **Range**: -2,147,483,648 to 2,147,483,647 ($-2^{31}$ to $2^{31}-1$)
- **Default**: 0
- **Usage**: Default choice for integer values, loop counters, array indices

```Java title='int examples'
int count = 1000;
int population = 1_000_000;  // underscores for readability
int hexValue = 0xFF;          // hexadecimal
int binaryValue = 0b1010;     // binary (Java 7+)
int octalValue = 077;         // octal

// Common use cases
for (int i = 0; i < 10; i++) {
    // loop counter
}

int[] array = new int[100];  // array size
```

### long
- **Size**: 64 bits (8 bytes)
- **Range**: $-2^{63}$ to $2^{63}-1$
- **Default**: 0L
- **Usage**: Large numbers, timestamps, file sizes, IDs

```Java title='long examples'
long worldPopulation = 8_000_000_000L;  // L suffix required
long timestamp = System.currentTimeMillis();
long fileSize = 5_000_000_000L;
long maxValue = Long.MAX_VALUE;

// Database IDs
long userId = 123456789L;
```

## Floating-Point Types

### float
- **Size**: 32 bits (4 bytes)
- **Precision**: ~6-7 decimal digits
- **Range**: $\pm 3.4 \times 10^{38}$
- **Default**: 0.0f
- **Usage**: Scientific calculations where precision is less critical, graphics, OpenGL

```Java title='float examples'
float price = 19.99f;         // f suffix required
float pi = 3.14159f;
float scientificNotation = 1.5e-10f;

// NOT suitable for monetary values
float money = 0.1f + 0.2f;    // 0.30000001 (precision loss)
```

### double
- **Size**: 64 bits (8 bytes)
- **Precision**: ~15-16 decimal digits
- **Range**: $\pm 1.7 \times 10^{308}$
- **Default**: 0.0d
- **Usage**: Default choice for floating-point values, scientific calculations

```Java title='double examples'
double distance = 384_400.0;  // km to moon
double pi = Math.PI;
double e = Math.E;
double result = 10.0 / 3.0;   // 3.3333333333333335

// Still NOT suitable for monetary values
// Use BigDecimal instead
```

## Character Type

### char
- **Size**: 16 bits (2 bytes)
- **Range**: 0 to 65,535 (unsigned)
- **Encoding**: UTF-16
- **Default**: '\u0000' (null character)
- **Usage**: Single Unicode characters

```Java title='char examples'
char letter = 'A';
char digit = '9';
char unicodeChar = '\u0041';  // 'A' in Unicode
char newline = '\n';
char tab = '\t';

// Special characters
char singleQuote = '\'';
char backslash = '\\';

// Unicode support
char euroSign = '€';
char emoji = '😀';  // requires surrogate pair in Java
```

## Boolean Type

### boolean
- **Size**: Not precisely defined (JVM dependent, typically 1 bit)
- **Values**: true or false
- **Default**: false
- **Usage**: Conditional logic, flags, state representation

```Java title='boolean examples'
boolean isActive = true;
boolean hasPermission = false;

// Conditional expressions
boolean isAdult = age >= 18;
boolean isValid = username != null && !username.isEmpty();

// Method returns
public boolean isEmpty() {
    return size == 0;
}

// Loop conditions
while (!isComplete) {
    // process
}
```

# Characteristics

## Memory Efficiency
- Primitives are stored on the ==stack== (when local variables)
- No object overhead (no object header, no garbage collection)
- Direct value access (no dereferencing)

```Java title='Memory comparison'
int primitiveInt = 42;        // 4 bytes on stack
Integer objectInt = 42;       // 16+ bytes on heap (object overhead)
```

## Performance
- Faster than wrapper classes
- No autoboxing/unboxing overhead
- Suitable for performance-critical code

## Default Values
- All primitives have default values when declared as instance variables
- Local variables must be explicitly initialized

```Java title='Default values demonstration'
public class DefaultValues {
    byte byteValue;       // 0
    short shortValue;     // 0
    int intValue;         // 0
    long longValue;       // 0L
    float floatValue;     // 0.0f
    double doubleValue;   // 0.0
    char charValue;       // '\u0000'
    boolean boolValue;    // false

    public void method() {
        int local;        // NOT initialized
        // System.out.println(local);  // Compilation error
    }
}
```

## Immutability
- Primitive values are ==immutable==
- Assignment creates a copy of the value

```Java title='Primitive value copying'
int a = 10;
int b = a;    // b gets a copy of a's value
b = 20;       // a remains 10
System.out.println(a);  // 10
System.out.println(b);  // 20
```

# Type Promotion

## Automatic Widening
Java automatically promotes smaller types to larger types in expressions.

```Java title='Automatic type promotion'
byte b = 10;
short s = 20;
int i = 30;
long l = 40L;

// All promoted to long in this expression
long result = b + s + i + l;

// Promotion in method calls
printDouble(10);  // int automatically promoted to double

void printDouble(double d) {
    System.out.println(d);
}
```

## Promotion Rules
- **byte, short, char** → promoted to **int** in expressions
- If one operand is **long** → other promoted to **long**
- If one operand is **float** → other promoted to **float**
- If one operand is **double** → other promoted to **double**

```Java title='Expression type promotion'
byte b1 = 10;
byte b2 = 20;
// byte result = b1 + b2;  // Compilation error: int cannot convert to byte
int result = b1 + b2;      // Correct: result is int

char c = 'A';
int asciiValue = c;        // 65 (automatic promotion)

short s = 10;
int i = s * 2;            // short promoted to int
```

# Common Pitfalls

## Integer Overflow
```Java title='Integer overflow example'
int max = Integer.MAX_VALUE;
int overflow = max + 1;      // -2147483648 (wraps around)
System.out.println(overflow);

// Solution: use long or check for overflow
long safeResult = (long) max + 1;
```

## Floating-Point Precision
```Java title='Floating-point precision issues'
double result = 0.1 + 0.2;
System.out.println(result);           // 0.30000000000000004

// Never use == for floating-point comparison
double a = 0.3;
double b = 0.1 + 0.2;
if (a == b) {  // false (precision issue)
    System.out.println("Equal");
}

// Correct approach: use epsilon comparison
double epsilon = 0.0001;
if (Math.abs(a - b) < epsilon) {
    System.out.println("Approximately equal");
}
```

## Division by Zero
```Java title='Division by zero behavior'
// Integer division by zero
int result = 10 / 0;  // ArithmeticException at runtime

// Floating-point division by zero
double infiniteResult = 10.0 / 0.0;    // Infinity
double negInfinite = -10.0 / 0.0;      // -Infinity
double notANumber = 0.0 / 0.0;         // NaN

System.out.println(Double.isInfinite(infiniteResult));  // true
System.out.println(Double.isNaN(notANumber));           // true
```

## Narrowing Conversion
```Java title='Narrowing conversion data loss'
int largeValue = 130;
byte narrowed = (byte) largeValue;  // -126 (data loss)

// Explanation: 130 > 127 (byte max), wraps around
// Binary: 130 = 0b10000010
// As byte: -126 (two's complement)

long bigNumber = 1_000_000_000_000L;
int truncated = (int) bigNumber;    // 1321730048 (overflow)
```

# Best Practices

## Choose Appropriate Type
- Use **int** for integer values by default
- Use **long** for timestamps, large IDs, file sizes
- Use **double** for floating-point by default
- Use **boolean** for flags, never int (0/1)
- Use **char** only for single characters

```Java title='Appropriate type selection'
// Good
int counter = 0;
long userId = 123456789L;
double price = 19.99;
boolean isValid = true;

// Bad
byte counter = 0;          // unnecessary restriction
int userId = 123456789;    // may overflow
float price = 19.99f;      // less precision
int isValid = 1;           // unclear semantics
```

## Avoid Unnecessary Casting
```Java title='Casting best practices'
// Bad: unnecessary cast
int result = (int) (10 + 20);

// Good: direct assignment
int result = 10 + 20;

// Necessary cast
double price = 19.99;
int dollars = (int) price;  // explicit truncation
```

## Use Underscores for Readability
```Java title='Numeric literal readability'
// Good
int million = 1_000_000;
long creditCard = 1234_5678_9012_3456L;
int binary = 0b1111_0000_1010_1100;

// Bad
int million = 1000000;
long creditCard = 1234567890123456L;
```

## Monetary Values
```Java title='Handling monetary values'
// NEVER use float or double for money
float price = 0.1f + 0.2f;  // 0.30000001 (WRONG)

// Use BigDecimal for monetary calculations
import java.math.BigDecimal;

BigDecimal price1 = new BigDecimal("0.1");
BigDecimal price2 = new BigDecimal("0.2");
BigDecimal total = price1.add(price2);  // 0.3 (CORRECT)

// Or use integer cents
int priceInCents = 1099;  // $10.99
```

***
# References
1. The Java Language Specification - Oracle
   1. Chapter 4: Types, Values, and Variables
2. Effective Java, 3rd Edition - Joshua Bloch
   1. Item 60: Avoid float and double if exact answers are required
3. https://docs.oracle.com/javase/tutorial/java/nutsandbolts/datatypes.html for Java primitive data types
