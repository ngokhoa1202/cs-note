#java #exception-handling #error-handling
# Exception Handling
==Exception handling== is a mechanism to handle runtime errors, maintaining the normal flow of program execution. Java provides a robust exception handling framework using ==try-catch-finally==, ==throw==, and ==throws== keywords.

# Exception Hierarchy

```
Throwable
├── Error (Unchecked - system errors)
│   ├── OutOfMemoryError
│   ├── StackOverflowError
│   └── VirtualMachineError
└── Exception
    ├── RuntimeException (Unchecked)
    │   ├── NullPointerException
    │   ├── ArrayIndexOutOfBoundsException
    │   ├── ArithmeticException
    │   ├── IllegalArgumentException
    │   ├── NumberFormatException
    │   └── ClassCastException
    └── Checked Exceptions
        ├── IOException
        │   ├── FileNotFoundException
        │   └── EOFException
        ├── SQLException
        ├── ClassNotFoundException
        └── InterruptedException
```

# Types of Exceptions

## Checked Exceptions
Exceptions that are ==checked at compile-time==. Must be handled or declared.

```Java title='Checked exceptions'
import java.io.*;

public class CheckedExceptionDemo {
    // Must declare throws or handle with try-catch
    public void readFile(String filename) throws IOException {
        FileReader file = new FileReader(filename);
        BufferedReader reader = new BufferedReader(file);
        String line = reader.readLine();
        reader.close();
    }

    // Or handle with try-catch
    public void readFileWithHandling(String filename) {
        try {
            FileReader file = new FileReader(filename);
            BufferedReader reader = new BufferedReader(file);
            String line = reader.readLine();
            reader.close();
        } catch (IOException e) {
            System.out.println("Error reading file: " + e.getMessage());
        }
    }
}
```

## Unchecked Exceptions (Runtime Exceptions)
Exceptions that occur at ==runtime==, not checked at compile-time.

```Java title='Unchecked exceptions'
public class UncheckedExceptionDemo {
    public void demonstrateUnchecked() {
        // NullPointerException
        String str = null;
        // System.out.println(str.length());  // Runtime error

        // ArrayIndexOutOfBoundsException
        int[] array = new int[5];
        // System.out.println(array[10]);     // Runtime error

        // ArithmeticException
        // int result = 10 / 0;                // Runtime error

        // NumberFormatException
        // int num = Integer.parseInt("abc");  // Runtime error

        // IllegalArgumentException
        // setAge(-5);                         // Runtime error
    }

    public void setAge(int age) {
        if (age < 0) {
            throw new IllegalArgumentException("Age cannot be negative");
        }
    }
}
```

## Errors
Serious problems that applications ==should not try to catch==. Indicate system-level issues.

```Java title='Errors - should not catch'
public class ErrorDemo {
    // StackOverflowError
    public void recursiveMethod() {
        recursiveMethod();  // Infinite recursion
    }

    // OutOfMemoryError
    public void consumeMemory() {
        List<byte[]> list = new ArrayList<>();
        while (true) {
            list.add(new byte[1024 * 1024]);  // Allocate 1MB repeatedly
        }
    }
}
```
# try-catch-finally
## Basic try-catch
```Java title='Basic exception handling'
public class TryCatchDemo {
    public void divide(int a, int b) {
        try {
            int result = a / b;
            System.out.println("Result: " + result);
        } catch (ArithmeticException e) {
            System.out.println("Cannot divide by zero");
        }
    }

    public void parseNumber(String input) {
        try {
            int number = Integer.parseInt(input);
            System.out.println("Number: " + number);
        } catch (NumberFormatException e) {
            System.out.println("Invalid number format: " + e.getMessage());
        }
    }
}
```

## Multiple catch Blocks
```Java title='Handling multiple exception types'
public class MultipleCatchDemo {
    public void processFile(String filename) {
        try {
            FileReader file = new FileReader(filename);
            BufferedReader reader = new BufferedReader(file);

            String line = reader.readLine();
            int number = Integer.parseInt(line);

            reader.close();

        } catch (FileNotFoundException e) {
            System.out.println("File not found: " + e.getMessage());
        } catch (IOException e) {
            System.out.println("IO error: " + e.getMessage());
        } catch (NumberFormatException e) {
            System.out.println("Invalid number format: " + e.getMessage());
        }
    }

    // Multi-catch (Java 7+) - when same handling for multiple exceptions
    public void processFileMultiCatch(String filename) {
        try {
            FileReader file = new FileReader(filename);
            BufferedReader reader = new BufferedReader(file);
            String line = reader.readLine();
            reader.close();
        } catch (FileNotFoundException | EOFException e) {
            System.out.println("File error: " + e.getMessage());
        } catch (IOException e) {
            System.out.println("IO error: " + e.getMessage());
        }
    }
}
```

## finally Block
The ==finally block always executes==, regardless of whether an exception occurs.

```Java title='finally block usage'
public class FinallyDemo {
    public void readFile(String filename) {
        FileReader file = null;
        BufferedReader reader = null;

        try {
            file = new FileReader(filename);
            reader = new BufferedReader(file);
            String line = reader.readLine();
            System.out.println(line);

        } catch (IOException e) {
            System.out.println("Error: " + e.getMessage());

        } finally {
            // Always executed - clean up resources
            try {
                if (reader != null) {
                    reader.close();
                }
                if (file != null) {
                    file.close();
                }
            } catch (IOException e) {
                System.out.println("Error closing resources");
            }
            System.out.println("Finally block executed");
        }
    }

    // finally executes even with return
    public int demonstrateFinallyWithReturn() {
        try {
            return 1;
        } finally {
            System.out.println("Finally executed before return");
        }
    }
}
```

## try-with-resources (Java 7+)
Automatically closes resources that implement ==AutoCloseable==.

```Java title='try-with-resources'
public class TryWithResourcesDemo {
    // Automatic resource management
    public void readFile(String filename) {
        try (FileReader file = new FileReader(filename);
             BufferedReader reader = new BufferedReader(file)) {

            String line = reader.readLine();
            System.out.println(line);

        } catch (IOException e) {
            System.out.println("Error: " + e.getMessage());
        }
        // Resources automatically closed here
    }

    // Multiple resources
    public void copyFile(String source, String dest) {
        try (FileInputStream in = new FileInputStream(source);
             FileOutputStream out = new FileOutputStream(dest)) {

            byte[] buffer = new byte[1024];
            int length;
            while ((length = in.read(buffer)) > 0) {
                out.write(buffer, 0, length);
            }

        } catch (IOException e) {
            System.out.println("Error copying file: " + e.getMessage());
        }
    }

    // Custom AutoCloseable resource
    static class DatabaseConnection implements AutoCloseable {
        public DatabaseConnection() {
            System.out.println("Opening database connection");
        }

        public void executeQuery(String query) {
            System.out.println("Executing: " + query);
        }

        @Override
        public void close() {
            System.out.println("Closing database connection");
        }
    }

    public void queryDatabase() {
        try (DatabaseConnection db = new DatabaseConnection()) {
            db.executeQuery("SELECT * FROM users");
        }  // Automatically closes connection
    }
}
```

# throw Keyword

==throw== is used to explicitly throw an exception.

```Java title='Throwing exceptions'
public class ThrowDemo {
    // Throw unchecked exception
    public void setAge(int age) {
        if (age < 0 || age > 150) {
            throw new IllegalArgumentException("Age must be between 0 and 150");
        }
        System.out.println("Age set to: " + age);
    }

    // Throw checked exception
    public void validateEmail(String email) throws IllegalArgumentException {
        if (email == null || !email.contains("@")) {
            throw new IllegalArgumentException("Invalid email format");
        }
        System.out.println("Valid email: " + email);
    }

    // Re-throwing exceptions
    public void processData(String data) throws IOException {
        try {
            // Some processing
            if (data == null) {
                throw new NullPointerException("Data is null");
            }
        } catch (NullPointerException e) {
            System.out.println("Caught: " + e.getMessage());
            // Re-throw as different exception
            throw new IOException("Data processing failed", e);
        }
    }
}
```

# throws Keyword

==throws== declares that a method ==may throw== specified checked exceptions.

```Java title='Declaring exceptions with throws'
public class ThrowsDemo {
    // Declare single exception
    public void readFile(String filename) throws IOException {
        FileReader file = new FileReader(filename);
        // Method may throw IOException
    }

    // Declare multiple exceptions
    public void processFile(String filename)
            throws IOException, NumberFormatException {
        FileReader file = new FileReader(filename);
        BufferedReader reader = new BufferedReader(file);
        String line = reader.readLine();
        int number = Integer.parseInt(line);
    }

    // Caller must handle or propagate
    public void caller() {
        try {
            readFile("data.txt");
        } catch (IOException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    // Or propagate further
    public void propagate() throws IOException {
        readFile("data.txt");  // Propagates IOException
    }
}
```

# Custom Exceptions

## Creating Custom Checked Exception
```Java title='Custom checked exception'
// Custom checked exception
public class InsufficientBalanceException extends Exception {
    private double balance;
    private double withdrawAmount;

    public InsufficientBalanceException(double balance, double withdrawAmount) {
        super("Insufficient balance. Available: " + balance +
              ", Requested: " + withdrawAmount);
        this.balance = balance;
        this.withdrawAmount = withdrawAmount;
    }

    public double getBalance() {
        return balance;
    }

    public double getWithdrawAmount() {
        return withdrawAmount;
    }
}

// Usage
public class BankAccount {
    private double balance;

    public void withdraw(double amount) throws InsufficientBalanceException {
        if (amount > balance) {
            throw new InsufficientBalanceException(balance, amount);
        }
        balance -= amount;
        System.out.println("Withdrawn: $" + amount);
    }
}

// Client code
try {
    account.withdraw(1000);
} catch (InsufficientBalanceException e) {
    System.out.println("Error: " + e.getMessage());
    System.out.println("Balance: $" + e.getBalance());
}
```

## Creating Custom Unchecked Exception
```Java title='Custom unchecked exception'
// Custom unchecked exception
public class InvalidUserInputException extends RuntimeException {
    private String inputField;
    private String invalidValue;

    public InvalidUserInputException(String inputField, String invalidValue) {
        super("Invalid input for field '" + inputField + "': " + invalidValue);
        this.inputField = inputField;
        this.invalidValue = invalidValue;
    }

    public InvalidUserInputException(String message, Throwable cause) {
        super(message, cause);
    }

    public String getInputField() {
        return inputField;
    }

    public String getInvalidValue() {
        return invalidValue;
    }
}

// Usage
public class UserValidator {
    public void validateUsername(String username) {
        if (username == null || username.length() < 3) {
            throw new InvalidUserInputException("username", username);
        }
    }

    public void validateAge(String ageStr) {
        try {
            int age = Integer.parseInt(ageStr);
            if (age < 0 || age > 150) {
                throw new InvalidUserInputException("age", ageStr);
            }
        } catch (NumberFormatException e) {
            throw new InvalidUserInputException(
                "age",
                ageStr
            );
        }
    }
}
```

# Exception Best Practices

## Catch Specific Exceptions
```Java title='Catch specific exceptions first'
// Good: Specific exceptions first
public void process(String filename) {
    try {
        FileReader file = new FileReader(filename);
        BufferedReader reader = new BufferedReader(file);
        String line = reader.readLine();
    } catch (FileNotFoundException e) {
        System.out.println("File not found: " + filename);
    } catch (IOException e) {
        System.out.println("IO error: " + e.getMessage());
    }
}

// Bad: Generic exception catches specific ones
// public void process(String filename) {
//     try {
//         // ...
//     } catch (Exception e) {  // Too broad
//         System.out.println("Error: " + e.getMessage());
//     }
// }
```

## Don't Swallow Exceptions
```Java title='Proper exception handling'
// Bad: Silent failure
public void badHandling() {
    try {
        riskyOperation();
    } catch (Exception e) {
        // Empty catch - exception swallowed
    }
}

// Good: Log or handle appropriately
public void goodHandling() {
    try {
        riskyOperation();
    } catch (Exception e) {
        // Log the exception
        logger.error("Error in riskyOperation", e);
        // Or rethrow
        throw new RuntimeException("Operation failed", e);
    }
}
```

## Use try-with-resources
```Java title='Prefer try-with-resources'
// Good: Automatic resource management
public void readFile(String filename) throws IOException {
    try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
        String line = reader.readLine();
    }
}

// Bad: Manual resource management
public void readFileManual(String filename) throws IOException {
    BufferedReader reader = null;
    try {
        reader = new BufferedReader(new FileReader(filename));
        String line = reader.readLine();
    } finally {
        if (reader != null) {
            try {
                reader.close();
            } catch (IOException e) {
                // Handle close exception
            }
        }
    }
}
```

## Provide Meaningful Messages
```Java title='Descriptive exception messages'
// Good: Informative messages
public void withdraw(double amount) throws InsufficientBalanceException {
    if (amount > balance) {
        throw new InsufficientBalanceException(
            String.format("Cannot withdraw $%.2f. Available balance: $%.2f",
                         amount, balance)
        );
    }
}

// Bad: Generic messages
public void withdrawBad(double amount) throws Exception {
    if (amount > balance) {
        throw new Exception("Error");  // Not helpful
    }
}
```

## Don't Use Exceptions for Control Flow
```Java title='Avoid exceptions for control flow'
// Bad: Using exceptions for normal logic
public boolean hasNextBad(Iterator<String> iterator) {
    try {
        String next = iterator.next();
        return true;
    } catch (NoSuchElementException e) {
        return false;
    }
}

// Good: Use proper methods
public boolean hasNextGood(Iterator<String> iterator) {
    return iterator.hasNext();
}
```

# Practical Example: Complete Exception Handling

```Java title='Comprehensive exception handling example'
import java.io.*;
import java.util.*;

// Custom exceptions
class DataValidationException extends Exception {
    public DataValidationException(String message) {
        super(message);
    }
}

class DataProcessingException extends RuntimeException {
    public DataProcessingException(String message, Throwable cause) {
        super(message, cause);
    }
}

// Service class with comprehensive exception handling
public class UserDataProcessor {
    private static final Logger logger = Logger.getLogger(UserDataProcessor.class.getName());

    // Process user data from file
    public List<User> processUserFile(String filename)
            throws IOException, DataValidationException {

        List<User> users = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {

            String line;
            int lineNumber = 0;

            while ((line = reader.readLine()) != null) {
                lineNumber++;

                try {
                    User user = parseUser(line);
                    validateUser(user);
                    users.add(user);

                } catch (DataValidationException e) {
                    logger.warning(String.format(
                        "Invalid data at line %d: %s", lineNumber, e.getMessage()
                    ));
                    // Continue processing other lines
                } catch (NumberFormatException e) {
                    logger.warning(String.format(
                        "Invalid number format at line %d: %s", lineNumber, line
                    ));
                }
            }

            if (users.isEmpty()) {
                throw new DataValidationException("No valid users found in file");
            }

        } catch (FileNotFoundException e) {
            throw new IOException("User data file not found: " + filename, e);
        }

        return users;
    }

    // Parse user from CSV line
    private User parseUser(String line) throws DataValidationException {
        String[] parts = line.split(",");

        if (parts.length != 3) {
            throw new DataValidationException(
                "Expected 3 fields, got " + parts.length
            );
        }

        try {
            String name = parts[0].trim();
            int age = Integer.parseInt(parts[1].trim());
            String email = parts[2].trim();

            return new User(name, age, email);

        } catch (NumberFormatException e) {
            throw new DataValidationException("Invalid age format: " + parts[1]);
        }
    }

    // Validate user data
    private void validateUser(User user) throws DataValidationException {
        if (user.getName() == null || user.getName().isEmpty()) {
            throw new DataValidationException("Name cannot be empty");
        }

        if (user.getAge() < 0 || user.getAge() > 150) {
            throw new DataValidationException(
                "Age must be between 0 and 150: " + user.getAge()
            );
        }

        if (!user.getEmail().matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            throw new DataValidationException("Invalid email: " + user.getEmail());
        }
    }

    // Save users to database with transaction
    public void saveUsers(List<User> users) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);

            for (User user : users) {
                insertUser(conn, user);
            }

            conn.commit();
            logger.info("Successfully saved " + users.size() + " users");

        } catch (SQLException e) {
            // Rollback on error
            if (conn != null) {
                try {
                    conn.rollback();
                    logger.severe("Transaction rolled back");
                } catch (SQLException ex) {
                    logger.severe("Error during rollback: " + ex.getMessage());
                }
            }
            throw new DataProcessingException("Failed to save users", e);

        } finally {
            // Always close connection
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    logger.warning("Error closing connection: " + e.getMessage());
                }
            }
        }
    }

    private void insertUser(Connection conn, User user) throws SQLException {
        String sql = "INSERT INTO users (name, age, email) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getName());
            stmt.setInt(2, user.getAge());
            stmt.setString(3, user.getEmail());
            stmt.executeUpdate();
        }
    }
}

// User class
class User {
    private String name;
    private int age;
    private String email;

    public User(String name, int age, String email) {
        this.name = name;
        this.age = age;
        this.email = email;
    }

    // Getters
    public String getName() { return name; }
    public int getAge() { return age; }
    public String getEmail() { return email; }
}

// Usage
public class Main {
    public static void main(String[] args) {
        UserDataProcessor processor = new UserDataProcessor();

        try {
            List<User> users = processor.processUserFile("users.csv");
            processor.saveUsers(users);

        } catch (IOException e) {
            System.err.println("File error: " + e.getMessage());
            e.printStackTrace();

        } catch (DataValidationException e) {
            System.err.println("Validation error: " + e.getMessage());

        } catch (DataProcessingException e) {
            System.err.println("Processing error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
```

***
# References
1. Effective Java, 3rd Edition - Joshua Bloch
   1. Item 69: Use exceptions only for exceptional conditions
   2. Item 70: Use checked exceptions for recoverable conditions and runtime exceptions for programming errors
   3. Item 72: Favor the use of standard exceptions
   4. Item 73: Throw exceptions appropriate to the abstraction
2. Java: The Complete Reference, 12th Edition - Herbert Schildt
   1. Chapter 10: Exception Handling
3. https://docs.oracle.com/javase/tutorial/essential/exceptions/ for Java exception handling tutorial
4. The Java Language Specification - Oracle
   1. Chapter 11: Exceptions
