#java #object-oriented-programming #class
# Classes and Objects
A ==class== is a blueprint or template that defines the structure and behavior of objects. An ==object== is an instance of a class, representing a concrete entity with state and behavior.

# Class Definition

## Basic Class Structure
```Java title='Basic class definition'
public class Car {
    // Instance variables (state)
    private String brand;
    private String model;
    private int year;
    private double mileage;

    // Constructor
    public Car(String brand, String model, int year) {
        this.brand = brand;
        this.model = model;
        this.year = year;
        this.mileage = 0.0;
    }

    // Methods (behavior)
    public void drive(double distance) {
        mileage += distance;
        System.out.println("Drove " + distance + " km");
    }

    public void displayInfo() {
        System.out.println(year + " " + brand + " " + model);
        System.out.println("Mileage: " + mileage + " km");
    }

    // Getters and setters
    public String getBrand() {
        return brand;
    }

    public double getMileage() {
        return mileage;
    }
}
```

## Class Components

### Fields (Instance Variables)
Variables that hold the ==state== of an object.

```Java title='Instance variables'
public class BankAccount {
    // Instance variables
    private String accountNumber;
    private String owner;
    private double balance;
    private boolean isActive;

    // Each object has its own copy of these variables
}
```

### Methods (Instance Methods)
Functions that define the ==behavior== of an object.

```Java title='Instance methods'
public class BankAccount {
    private double balance;

    // Instance method - operates on object state
    public void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
            System.out.println("Deposited: $" + amount);
        }
    }

    public boolean withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            System.out.println("Withdrawn: $" + amount);
            return true;
        }
        return false;
    }

    public double getBalance() {
        return balance;
    }
}
```

### Constructors
Special methods that ==initialize new objects==.

```Java title='Multiple constructors'
public class Person {
    private String name;
    private int age;
    private String email;

    // Default constructor
    public Person() {
        this.name = "Unknown";
        this.age = 0;
        this.email = "";
    }

    // Parameterized constructor
    public Person(String name, int age) {
        this.name = name;
        this.age = age;
        this.email = "";
    }

    // Full constructor
    public Person(String name, int age, String email) {
        this.name = name;
        this.age = age;
        this.email = email;
    }
}
```

# Object Creation

## Using new Keyword
```Java title='Creating objects with new'
// Create objects using constructors
Car myCar = new Car("Toyota", "Camry", 2022);
Car secondCar = new Car("Honda", "Civic", 2023);

// Each object has independent state
myCar.drive(100);
secondCar.drive(50);

System.out.println(myCar.getMileage());    // 100.0
System.out.println(secondCar.getMileage()); // 50.0
```

## Object References
```Java title='Understanding object references'
// Reference points to object in heap
Car car1 = new Car("BMW", "X5", 2023);
Car car2 = car1;  // car2 references the same object

car2.drive(100);
System.out.println(car1.getMileage());  // 100.0 (same object)

// Creating new object
car2 = new Car("Audi", "A4", 2023);
System.out.println(car1.getMileage());  // 100.0 (different objects now)
System.out.println(car2.getMileage());  // 0.0
```

## null References
```Java title='Handling null references'
Car car = null;  // Reference exists but points to nothing

// NullPointerException if accessing null reference
// car.drive(10);  // Runtime error

// Safe null checking
if (car != null) {
    car.drive(10);
} else {
    System.out.println("Car is null");
}

// Modern null handling (Java 8+)
Optional<Car> optionalCar = Optional.ofNullable(car);
optionalCar.ifPresent(c -> c.drive(10));
```

# The `this` Keyword

## Referencing Current Object
```Java title='this keyword usage'
public class Person {
    private String name;
    private int age;

    // Distinguish parameter from field
    public Person(String name, int age) {
        this.name = name;  // this.name is the field
        this.age = age;    // name is the parameter
    }

    // Returning current object for method chaining
    public Person setName(String name) {
        this.name = name;
        return this;       // Return current object
    }

    public Person setAge(int age) {
        this.age = age;
        return this;
    }

    // Method chaining usage
    public static void main(String[] args) {
        Person person = new Person("", 0)
            .setName("John")
            .setAge(25);
    }
}
```

## Calling Other Constructors
```Java title='Constructor chaining with this()'
public class Employee {
    private String name;
    private String department;
    private double salary;

    // Primary constructor
    public Employee(String name, String department, double salary) {
        this.name = name;
        this.department = department;
        this.salary = salary;
    }

    // Constructor delegates to primary constructor
    public Employee(String name, String department) {
        this(name, department, 50000.0);  // Call other constructor
    }

    // Constructor with default department
    public Employee(String name) {
        this(name, "General", 50000.0);
    }
}
```

# Instance vs Static Members

## Instance Members
Belong to ==individual objects==, each object has its own copy.

```Java title='Instance members'
public class Counter {
    // Instance variable - each object has its own
    private int count;

    // Instance method - operates on specific object
    public void increment() {
        count++;
    }

    public int getCount() {
        return count;
    }
}

// Usage
Counter counter1 = new Counter();
Counter counter2 = new Counter();

counter1.increment();
counter1.increment();
counter2.increment();

System.out.println(counter1.getCount());  // 2
System.out.println(counter2.getCount());  // 1
```

## Static Members
Belong to the ==class itself==, shared by all objects.

```Java title='Static members'
public class Counter {
    // Static variable - shared by all objects
    private static int totalCount = 0;

    // Instance variable - each object has its own
    private int count = 0;

    public void increment() {
        count++;
        totalCount++;  // Increment shared counter
    }

    public int getCount() {
        return count;
    }

    // Static method - belongs to class
    public static int getTotalCount() {
        return totalCount;
    }
}

// Usage
Counter counter1 = new Counter();
Counter counter2 = new Counter();

counter1.increment();
counter1.increment();
counter2.increment();

System.out.println(counter1.getCount());        // 2
System.out.println(counter2.getCount());        // 1
System.out.println(Counter.getTotalCount());    // 3 (shared)
```

# Access Modifiers

## private
Accessible only ==within the same class==.

```Java title='private access modifier'
public class Person {
    private String ssn;  // Sensitive data

    private void validateSSN() {
        // Internal validation logic
    }

    public void setSSN(String ssn) {
        validateSSN();  // Can access private method
        this.ssn = ssn;
    }
}

// Usage
Person person = new Person();
// person.ssn = "123-45-6789";  // Compilation error
// person.validateSSN();        // Compilation error
person.setSSN("123-45-6789");   // OK - public method
```

## public
Accessible from ==anywhere==.

```Java title='public access modifier'
public class MathUtils {
    // Public constant
    public static final double PI = 3.14159;

    // Public method
    public static double calculateCircleArea(double radius) {
        return PI * radius * radius;
    }
}

// Usage from anywhere
double area = MathUtils.calculateCircleArea(5.0);
double pi = MathUtils.PI;
```

## protected
Accessible within the ==same package and subclasses==.

```Java title='protected access modifier'
public class Animal {
    protected String species;  // Accessible to subclasses

    protected void makeSound() {
        System.out.println("Some sound");
    }
}

public class Dog extends Animal {
    public void bark() {
        species = "Canine";     // Can access protected field
        makeSound();            // Can access protected method
    }
}
```

## package-private (default)
Accessible only within the ==same package== when no modifier is specified.

```Java title='Package-private access'
class InternalHelper {  // No modifier = package-private
    int value;          // Package-private field

    void process() {    // Package-private method
        System.out.println("Processing");
    }
}

// Accessible only within same package
public class MyClass {
    void useHelper() {
        InternalHelper helper = new InternalHelper();
        helper.process();  // OK - same package
    }
}
```

# Encapsulation

Bundling data and methods that operate on that data, ==restricting direct access== to object internals.

```Java title='Encapsulation example'
public class BankAccount {
    // Private fields - hidden from outside
    private String accountNumber;
    private double balance;
    private List<String> transactionHistory;

    public BankAccount(String accountNumber) {
        this.accountNumber = accountNumber;
        this.balance = 0.0;
        this.transactionHistory = new ArrayList<>();
    }

    // Controlled access through public methods
    public void deposit(double amount) {
        if (amount > 0) {
            balance += amount;
            transactionHistory.add("Deposit: $" + amount);
        } else {
            throw new IllegalArgumentException("Amount must be positive");
        }
    }

    public boolean withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
            transactionHistory.add("Withdrawal: $" + amount);
            return true;
        }
        return false;
    }

    // Read-only access to balance
    public double getBalance() {
        return balance;
    }

    // Return defensive copy to prevent external modification
    public List<String> getTransactionHistory() {
        return new ArrayList<>(transactionHistory);
    }

    // No setter for balance - can only change through deposit/withdraw
}
```

## Benefits of Encapsulation
- **Data validation**: Control what values are allowed
- **Flexibility**: Change internal implementation without affecting users
- **Security**: Hide sensitive data and implementation details
- **Maintainability**: Reduce dependencies between classes

```Java title='Encapsulation benefits'
public class Temperature {
    private double celsius;

    // Validation in setter
    public void setCelsius(double celsius) {
        if (celsius < -273.15) {
            throw new IllegalArgumentException("Below absolute zero");
        }
        this.celsius = celsius;
    }

    public double getCelsius() {
        return celsius;
    }

    // Derived properties - can change calculation without affecting users
    public double getFahrenheit() {
        return celsius * 9.0 / 5.0 + 32;
    }

    public double getKelvin() {
        return celsius + 273.15;
    }
}
```

# Object Lifecycle

## Creation
Object is created with ==new== keyword and constructor is called.

```Java title='Object creation lifecycle'
public class User {
    private String username;

    // Constructor called during object creation
    public User(String username) {
        this.username = username;
        System.out.println("User created: " + username);
    }
}

// Object creation
User user = new User("john_doe");  // "User created: john_doe"
```

## Usage
Object is used through its reference variable.

```Java title='Object usage phase'
user.setEmail("john@example.com");
String name = user.getUsername();
user.updateProfile();
```

## Destruction
Object becomes eligible for ==garbage collection== when no references point to it.

```Java title='Object eligible for garbage collection'
User user = new User("john");
user = null;  // Original object now eligible for GC

User user1 = new User("alice");
User user2 = user1;
user1 = null;  // Object NOT eligible - user2 still references it
user2 = null;  // NOW eligible for GC
```

## finalize() Method (Deprecated)
```Java title='finalize() - deprecated and unreliable'
public class Resource {
    // NOT recommended - use try-with-resources instead
    @Override
    protected void finalize() throws Throwable {
        try {
            // Cleanup code (unreliable timing)
            System.out.println("Finalizing resource");
        } finally {
            super.finalize();
        }
    }
}

// Modern approach: implement AutoCloseable
public class Resource implements AutoCloseable {
    @Override
    public void close() {
        // Cleanup code (reliable)
        System.out.println("Closing resource");
    }
}

// Usage with try-with-resources
try (Resource resource = new Resource()) {
    // Use resource
}  // close() automatically called
```

# Nested and Inner Classes

## Inner Class
Non-static nested class that has ==access to outer class members==.

```Java title='Inner class example'
public class OuterClass {
    private String outerField = "Outer";

    // Inner class
    public class InnerClass {
        private String innerField = "Inner";

        public void display() {
            // Can access outer class members
            System.out.println(outerField);
            System.out.println(innerField);
        }
    }

    public void createInner() {
        InnerClass inner = new InnerClass();
        inner.display();
    }
}

// Usage
OuterClass outer = new OuterClass();
OuterClass.InnerClass inner = outer.new InnerClass();
inner.display();
```

## Static Nested Class
Static nested class that ==cannot access outer class instance members==.

```Java title='Static nested class'
public class OuterClass {
    private static String staticField = "Static";
    private String instanceField = "Instance";

    // Static nested class
    public static class StaticNestedClass {
        public void display() {
            System.out.println(staticField);     // OK - static
            // System.out.println(instanceField); // Error - needs instance
        }
    }
}

// Usage - no outer instance needed
OuterClass.StaticNestedClass nested = new OuterClass.StaticNestedClass();
nested.display();
```

# Practical Examples

## Complete Banking System
```Java title='Comprehensive banking example'
public class BankAccount {
    // Constants
    private static final double MIN_BALANCE = 100.0;
    private static int nextAccountNumber = 1000;

    // Instance variables
    private final String accountNumber;
    private final String owner;
    private double balance;
    private final List<Transaction> transactions;

    // Constructor
    public BankAccount(String owner, double initialDeposit) {
        if (initialDeposit < MIN_BALANCE) {
            throw new IllegalArgumentException(
                "Initial deposit must be at least $" + MIN_BALANCE
            );
        }
        this.accountNumber = "ACC" + (nextAccountNumber++);
        this.owner = owner;
        this.balance = initialDeposit;
        this.transactions = new ArrayList<>();
        recordTransaction("Initial deposit", initialDeposit);
    }

    // Public methods
    public boolean deposit(double amount) {
        if (amount <= 0) {
            return false;
        }
        balance += amount;
        recordTransaction("Deposit", amount);
        return true;
    }

    public boolean withdraw(double amount) {
        if (amount <= 0 || balance - amount < MIN_BALANCE) {
            return false;
        }
        balance -= amount;
        recordTransaction("Withdrawal", -amount);
        return true;
    }

    public boolean transfer(BankAccount toAccount, double amount) {
        if (withdraw(amount)) {
            toAccount.deposit(amount);
            recordTransaction("Transfer to " + toAccount.accountNumber, -amount);
            toAccount.recordTransaction("Transfer from " + this.accountNumber, amount);
            return true;
        }
        return false;
    }

    // Private helper method
    private void recordTransaction(String type, double amount) {
        transactions.add(new Transaction(type, amount, LocalDateTime.now()));
    }

    // Getters
    public String getAccountNumber() {
        return accountNumber;
    }

    public String getOwner() {
        return owner;
    }

    public double getBalance() {
        return balance;
    }

    public List<Transaction> getTransactions() {
        return new ArrayList<>(transactions);  // Defensive copy
    }

    // Inner class for transactions
    private static class Transaction {
        private final String type;
        private final double amount;
        private final LocalDateTime timestamp;

        public Transaction(String type, double amount, LocalDateTime timestamp) {
            this.type = type;
            this.amount = amount;
            this.timestamp = timestamp;
        }

        @Override
        public String toString() {
            return String.format("%s: $%.2f on %s", type, amount, timestamp);
        }
    }
}

// Usage
BankAccount account1 = new BankAccount("Alice", 1000.0);
BankAccount account2 = new BankAccount("Bob", 500.0);

account1.deposit(200.0);
account1.withdraw(100.0);
account1.transfer(account2, 50.0);

System.out.println("Balance: $" + account1.getBalance());
account1.getTransactions().forEach(System.out::println);
```

***
# References
1. Effective Java, 3rd Edition - Joshua Bloch
   1. Item 15: Minimize the accessibility of classes and members
   2. Item 16: In public classes, use accessor methods, not public fields
   3. Item 17: Minimize mutability
2. Head First Java, 3rd Edition - Kathy Sierra, Bert Bates, Trisha Gee
   1. Chapter 2: Classes and Objects
3. https://docs.oracle.com/javase/tutorial/java/javaOO/index.html for Java OOP tutorial
4. The Java Language Specification - Oracle
   1. Chapter 8: Classes
