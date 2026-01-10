#java #control-flow #java8 #java17 #java21 
# Control Flow Statements
- Control flow statements determine the order in which statements are executed. Java provides decision-making statements, looping statements, and branching statements.
# Decision-Making Statements
## if Statement
- Executes code block if condition is true.
```Java title='if statement'
int age = 18;

if (age >= 18) {
    System.out.println("You are an adult");
}

// Single-line if (no braces needed)
if (age >= 18)
    System.out.println("Adult");

// Best practice: always use braces
if (age >= 18) {
    System.out.println("Adult");
}
```
## if-else Statement
```Java title='if-else statement'
int score = 75;

if (score >= 60) {
    System.out.println("Pass");
} else {
    System.out.println("Fail");
}

// Ternary operator alternative
String result = (score >= 60) ? "Pass" : "Fail";
System.out.println(result);
```
## if-else-if Ladder
```Java title='if-else-if chain'
int score = 85;

if (score >= 90) {
    System.out.println("Grade: A");
} else if (score >= 80) {
    System.out.println("Grade: B");
} else if (score >= 70) {
    System.out.println("Grade: C");
} else if (score >= 60) {
    System.out.println("Grade: D");
} else {
    System.out.println("Grade: F");
}
```
## Nested if Statements
```Java title='Nested if statements'
int age = 25;
boolean hasLicense = true;

if (age >= 18) {
    if (hasLicense) {
        System.out.println("You can drive");
    } else {
        System.out.println("You need a license");
    }
} else {
    System.out.println("You are too young to drive");
}

// Better: Use logical operators
if (age >= 18 && hasLicense) {
    System.out.println("You can drive");
} else if (age >= 18 && !hasLicense) {
    System.out.println("You need a license");
} else {
    System.out.println("You are too young to drive");
}
```
## switch Statement
- Evaluates an expression against multiple ==constant values==.
```Java title='switch statement'
int dayOfWeek = 3;

switch (dayOfWeek) {
    case 1:
        System.out.println("Monday");
        break;
    case 2:
        System.out.println("Tuesday");
        break;
    case 3:
        System.out.println("Wednesday");
        break;
    case 4:
        System.out.println("Thursday");
        break;
    case 5:
        System.out.println("Friday");
        break;
    case 6:
    case 7:  // Fall-through for multiple cases
        System.out.println("Weekend");
        break;
    default:
        System.out.println("Invalid day");
}
```
## switch with String (Java 7+)
```Java title='switch with String'
String day = "Monday";

switch (day) {
    case "Monday":
    case "Tuesday":
    case "Wednesday":
    case "Thursday":
    case "Friday":
        System.out.println("Weekday");
        break;
    case "Saturday":
    case "Sunday":
        System.out.println("Weekend");
        break;
    default:
        System.out.println("Invalid day");
}
```
## switch Expression (Java 14+)
```Java title='switch expression with yield'
String day = "Monday";

// Switch expression with arrow syntax
String dayType = switch (day) {
    case "Monday", "Tuesday", "Wednesday", "Thursday", "Friday" -> "Weekday";
    case "Saturday", "Sunday" -> "Weekend";
    default -> "Invalid";
};
System.out.println(dayType);

// With code blocks and yield
int numLetters = switch (day) {
    case "Monday", "Friday", "Sunday" -> 6;
    case "Tuesday" -> 7;
    case "Thursday", "Saturday" -> 8;
    case "Wednesday" -> {
        System.out.println("Middle of the week");
        yield 9;
    }
    default -> -1;
};
```
## Pattern Matching for switch (Java 17+ Preview)
```Java title='Pattern matching in switch'
Object obj = "Hello";

// Pattern matching switch
String result = switch (obj) {
    case Integer i -> String.format("Integer: %d", i);
    case Long l -> String.format("Long: %d", l);
    case Double d -> String.format("Double: %.2f", d);
    case String s -> String.format("String: %s", s);
    case null -> "null value";
    default -> "Unknown type";
};
System.out.println(result);

// With guards
String formatted = switch (obj) {
    case String s && s.length() > 5 -> "Long string: " + s;
    case String s -> "Short string: " + s;
    default -> "Not a string";
};
```
# Looping Statements
## for Loop
- Repeats code for a known number of iterations.
```Java title='for loop'
// Basic for loop
for (int i = 0; i < 5; i++) {
    System.out.println("Iteration: " + i);
}

// Multiple initialization and updates
for (int i = 0, j = 10; i < j; i++, j--) {
    System.out.println("i: " + i + ", j: " + j);
}

// Nested for loops
for (int i = 1; i <= 3; i++) {
    for (int j = 1; j <= 3; j++) {
        System.out.print(i * j + " ");
    }
    System.out.println();
}
// Output:
// 1 2 3
// 2 4 6
// 3 6 9

// Infinite loop (intentional)
// for (;;) {
//     System.out.println("Infinite loop");
// }
```
## Enhanced for Loop (for-each)
- Iterates over arrays and collections.
```Java title='Enhanced for loop'
// Array iteration
int[] numbers = {1, 2, 3, 4, 5};
for (int num : numbers) {
    System.out.println(num);
}

// Collection iteration
List<String> names = Arrays.asList("Alice", "Bob", "Charlie");
for (String name : names) {
    System.out.println(name);
}

// Cannot modify array/collection during iteration
int[] values = {1, 2, 3, 4, 5};
for (int val : values) {
    // val = val * 2;  // Doesn't modify original array
}

// Use traditional for loop to modify
for (int i = 0; i < values.length; i++) {
    values[i] = values[i] * 2;  // Modifies original array
}
```
## while Loop
- Repeats code while condition is true.
```Java title='while loop'
int count = 0;

while (count < 5) {
    System.out.println("Count: " + count);
    count++;
}

// Reading input until condition
Scanner scanner = new Scanner(System.in);
String input = "";

while (!input.equals("quit")) {
    System.out.print("Enter command (quit to exit): ");
    input = scanner.nextLine();
    System.out.println("You entered: " + input);
}

// Sentinel-controlled loop
int sum = 0;
int number = scanner.nextInt();

while (number != -1) {  // -1 is sentinel value
    sum += number;
    number = scanner.nextInt();
}
System.out.println("Sum: " + sum);
```
## do-while Loop
- Executes code block at least once, then repeats while condition is true.
```Java title='do-while loop'
int count = 0;

do {
    System.out.println("Count: " + count);
    count++;
} while (count < 5);

// Executes at least once even if condition is false
int num = 10;
do {
    System.out.println("This executes once");
} while (num < 5);  // false, but body executed once

// Input validation
Scanner scanner = new Scanner(System.in);
int age;

do {
    System.out.print("Enter your age (0-150): ");
    age = scanner.nextInt();
    if (age < 0 || age > 150) {
        System.out.println("Invalid age. Try again.");
    }
} while (age < 0 || age > 150);

System.out.println("Valid age: " + age);
```
# Branching Statements
## break Statement
- Terminates the loop or switch statement.
```Java title='break statement'
// Break in loop
for (int i = 0; i < 10; i++) {
    if (i == 5) {
        break;  // Exit loop when i is 5
    }
    System.out.println(i);
}
// Output: 0 1 2 3 4

// Break in switch
int day = 3;
switch (day) {
    case 1:
        System.out.println("Monday");
        break;  // Exit switch
    case 2:
        System.out.println("Tuesday");
        break;
    case 3:
        System.out.println("Wednesday");
        break;  // Without this, falls through to case 4
    default:
        System.out.println("Other day");
}

// Break in nested loops (exits inner loop only)
for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
        if (j == 1) {
            break;  // Exits inner loop
        }
        System.out.println("i: " + i + ", j: " + j);
    }
}
```
## Labeled break
- Breaks out of outer loops.
```Java title='Labeled break'
// Label for outer loop
outerLoop:
for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
        if (i == 1 && j == 1) {
            break outerLoop;  // Exits outer loop
        }
        System.out.println("i: " + i + ", j: " + j);
    }
}
System.out.println("After loops");

// Output:
// i: 0, j: 0
// i: 0, j: 1
// i: 0, j: 2
// i: 1, j: 0
// After loops

// Searching in 2D array
int[][] matrix = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
int target = 5;
boolean found = false;

search:
for (int i = 0; i < matrix.length; i++) {
    for (int j = 0; j < matrix[i].length; j++) {
        if (matrix[i][j] == target) {
            System.out.println("Found at [" + i + "][" + j + "]");
            found = true;
            break search;  // Exit both loops
        }
    }
}
```
## continue Statement
- Skips the current iteration and continues with the next.
```Java title='continue statement'
// Skip even numbers
for (int i = 0; i < 10; i++) {
    if (i % 2 == 0) {
        continue;  // Skip even numbers
    }
    System.out.println(i);
}
// Output: 1 3 5 7 9

// Continue in while loop
int count = 0;
while (count < 10) {
    count++;
    if (count % 3 == 0) {
        continue;  // Skip multiples of 3
    }
    System.out.println(count);
}

// Continue in nested loops
for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
        if (j == 1) {
            continue;  // Skip when j is 1
        }
        System.out.println("i: " + i + ", j: " + j);
    }
}
```
## Labeled continue
- Continues with the next iteration of labeled loop.
```Java title='Labeled continue'
outerLoop:
for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
        if (j == 1) {
            continue outerLoop;  // Continue outer loop
        }
        System.out.println("i: " + i + ", j: " + j);
    }
}

// Output:
// i: 0, j: 0
// i: 1, j: 0
// i: 2, j: 0
```
## return Statement
- Exits from the current method.
```Java title='return statement'
// Return value
public int add(int a, int b) {
    return a + b;  // Exit method and return value
}

// Early return for validation
public double divide(double a, double b) {
    if (b == 0) {
        System.out.println("Cannot divide by zero");
        return 0.0;  // Early exit
    }
    return a / b;
}

// Return in void method
public void processArray(int[] array) {
    if (array == null || array.length == 0) {
        return;  // Exit early
    }
    // Process array
    for (int num : array) {
        System.out.println(num);
    }
}

// Multiple return points
public String getGrade(int score) {
    if (score >= 90) return "A";
    if (score >= 80) return "B";
    if (score >= 70) return "C";
    if (score >= 60) return "D";
    return "F";
}
```
***
# References
1. Java: The Complete Reference, 12th Edition - Herbert Schildt
   1. Chapter 5: Control Statements
2. Head First Java, 3rd Edition - Kathy Sierra, Bert Bates, Trisha Gee
   1. Chapter 1: Breaking the Surface
3. https://docs.oracle.com/javase/tutorial/java/nutsandbolts/flow.html for control flow tutorial
4. The Java Language Specification - Oracle
   1. Chapter 14: Blocks and Statements
