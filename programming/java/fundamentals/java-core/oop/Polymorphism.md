#java #object-oriented-programming #polymorphism
# Polymorphism
==Polymorphism== (from Greek: "many forms") is the ability of an object to take many forms. In Java, it allows ==one interface to be used for a general class of actions==, with specific behavior determined at runtime or compile-time.

# Types of Polymorphism

## Compile-Time Polymorphism (Static Binding)
Resolved during ==compilation==. Achieved through ==method overloading== and ==operator overloading== (not supported in Java).

## Runtime Polymorphism (Dynamic Binding)
Resolved during ==runtime==. Achieved through ==method overriding== and ==inheritance==.

# Method Overloading (Compile-Time Polymorphism)

==Method overloading== allows multiple methods with the ==same name but different parameters== in the same class.

## Overloading Rules
```Java title='Method overloading examples'
public class Calculator {
    // Overloaded add methods

    // Different number of parameters
    public int add(int a, int b) {
        return a + b;
    }

    public int add(int a, int b, int c) {
        return a + b + c;
    }

    // Different parameter types
    public double add(double a, double b) {
        return a + b;
    }

    // Different parameter order
    public String add(String a, int b) {
        return a + b;
    }

    public String add(int a, String b) {
        return a + b;
    }

    // INVALID: Return type alone is not sufficient
    // public double add(int a, int b) { }  // Compilation error
}

// Usage
Calculator calc = new Calculator();
System.out.println(calc.add(5, 3));          // 8 (int, int)
System.out.println(calc.add(5, 3, 2));       // 10 (int, int, int)
System.out.println(calc.add(5.5, 3.2));      // 8.7 (double, double)
System.out.println(calc.add("Result: ", 5)); // "Result: 5"
```

## Constructor Overloading
```Java title='Constructor overloading'
public class Person {
    private String name;
    private int age;
    private String email;

    // No-arg constructor
    public Person() {
        this.name = "Unknown";
        this.age = 0;
        this.email = "";
    }

    // Constructor with name
    public Person(String name) {
        this.name = name;
        this.age = 0;
        this.email = "";
    }

    // Constructor with name and age
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

// Usage - different constructors called based on arguments
Person p1 = new Person();
Person p2 = new Person("Alice");
Person p3 = new Person("Bob", 25);
Person p4 = new Person("Charlie", 30, "charlie@email.com");
```

## Varargs and Overloading
```Java title='Varargs in overloading'
public class Printer {
    // Fixed parameters
    public void print(String message) {
        System.out.println("Single: " + message);
    }

    // Varargs
    public void print(String... messages) {
        System.out.println("Multiple: " + String.join(", ", messages));
    }

    // Ambiguity: fixed parameter preferred over varargs
    public static void main(String[] args) {
        Printer p = new Printer();
        p.print("Hello");                // Calls print(String)
        p.print("A", "B", "C");         // Calls print(String...)
    }
}
```

## Type Promotion in Overloading
```Java title='Automatic type promotion'
public class TypePromotion {
    public void method(int a) {
        System.out.println("int: " + a);
    }

    public void method(long a) {
        System.out.println("long: " + a);
    }

    public void method(double a) {
        System.out.println("double: " + a);
    }

    public static void main(String[] args) {
        TypePromotion obj = new TypePromotion();

        byte b = 10;
        short s = 20;
        obj.method(b);    // byte → int
        obj.method(s);    // short → int
        obj.method(30);   // int
        obj.method(40L);  // long
        obj.method(50.5); // double
        obj.method(60.5f);// float → double
    }
}
```

# Method Overriding (Runtime Polymorphism)

==Method overriding== allows a subclass to provide a ==specific implementation== of a method already defined in its parent class.

## Basic Overriding
```Java title='Method overriding example'
public class Animal {
    public void makeSound() {
        System.out.println("Animal makes a sound");
    }

    public void eat() {
        System.out.println("Animal is eating");
    }
}

public class Dog extends Animal {
    @Override
    public void makeSound() {
        System.out.println("Dog barks: Woof woof!");
    }

    @Override
    public void eat() {
        System.out.println("Dog is eating bones");
    }
}

public class Cat extends Animal {
    @Override
    public void makeSound() {
        System.out.println("Cat meows: Meow meow!");
    }

    @Override
    public void eat() {
        System.out.println("Cat is eating fish");
    }
}

// Runtime polymorphism in action
Animal animal1 = new Dog();
Animal animal2 = new Cat();

animal1.makeSound();  // "Dog barks: Woof woof!" (Dog's implementation)
animal2.makeSound();  // "Cat meows: Meow meow!" (Cat's implementation)
```

## Dynamic Method Dispatch
The JVM determines which method to call based on the ==actual object type at runtime==, not the reference type.

```Java title='Dynamic method dispatch'
public class Shape {
    public void draw() {
        System.out.println("Drawing a shape");
    }

    public double area() {
        return 0.0;
    }
}

public class Circle extends Shape {
    private double radius;

    public Circle(double radius) {
        this.radius = radius;
    }

    @Override
    public void draw() {
        System.out.println("Drawing a circle");
    }

    @Override
    public double area() {
        return Math.PI * radius * radius;
    }
}

public class Rectangle extends Shape {
    private double width;
    private double height;

    public Rectangle(double width, double height) {
        this.width = width;
        this.height = height;
    }

    @Override
    public void draw() {
        System.out.println("Drawing a rectangle");
    }

    @Override
    public double area() {
        return width * height;
    }
}

// Polymorphic behavior
Shape[] shapes = new Shape[3];
shapes[0] = new Circle(5.0);
shapes[1] = new Rectangle(4.0, 6.0);
shapes[2] = new Shape();

for (Shape shape : shapes) {
    shape.draw();              // Calls appropriate draw() method
    System.out.println("Area: " + shape.area());
}

// Output:
// Drawing a circle
// Area: 78.53981633974483
// Drawing a rectangle
// Area: 24.0
// Drawing a shape
// Area: 0.0
```

# Reference Type vs Object Type

## Compile-Time vs Runtime Type
```Java title='Understanding type resolution'
public class Animal {
    public void makeSound() {
        System.out.println("Animal sound");
    }

    public void eat() {
        System.out.println("Animal eating");
    }
}

public class Dog extends Animal {
    @Override
    public void makeSound() {
        System.out.println("Bark");
    }

    // Dog-specific method
    public void fetch() {
        System.out.println("Fetching ball");
    }
}

// Reference type: Animal, Object type: Dog
Animal animal = new Dog();

// Resolved at runtime - calls Dog's version
animal.makeSound();  // "Bark"

// Resolved at runtime - calls Animal's version (inherited)
animal.eat();        // "Animal eating"

// Compilation error - fetch() not in Animal
// animal.fetch();   // Compiler doesn't know about Dog's methods

// Solution: casting
if (animal instanceof Dog) {
    Dog dog = (Dog) animal;
    dog.fetch();      // Now accessible
}

// Or pattern matching (Java 16+)
if (animal instanceof Dog dog) {
    dog.fetch();      // Automatically cast
}
```

## Method Binding
```Java title='Static vs dynamic binding'
public class Parent {
    // Instance method - dynamic binding
    public void instanceMethod() {
        System.out.println("Parent instance method");
    }

    // Static method - static binding
    public static void staticMethod() {
        System.out.println("Parent static method");
    }

    // final method - static binding
    public final void finalMethod() {
        System.out.println("Parent final method");
    }

    // private method - static binding
    private void privateMethod() {
        System.out.println("Parent private method");
    }
}

public class Child extends Parent {
    @Override
    public void instanceMethod() {
        System.out.println("Child instance method");
    }

    // Not overriding - hiding (static binding)
    public static void staticMethod() {
        System.out.println("Child static method");
    }

    // Cannot override final method
    // public void finalMethod() { }  // Compilation error

    // Not overriding - private not inherited
    private void privateMethod() {
        System.out.println("Child private method");
    }
}

// Testing
Parent parent = new Child();

parent.instanceMethod();  // "Child instance method" (dynamic dispatch)
parent.staticMethod();    // "Parent static method" (static binding)
parent.finalMethod();     // "Parent final method" (static binding)
```

# Polymorphism with Interfaces

Interfaces enable polymorphism by defining a ==contract== that multiple classes can implement differently.

```Java title='Interface-based polymorphism'
interface Payment {
    boolean processPayment(double amount);
    String getPaymentMethod();
}

class CreditCardPayment implements Payment {
    private String cardNumber;

    public CreditCardPayment(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    @Override
    public boolean processPayment(double amount) {
        System.out.println("Processing $" + amount + " via Credit Card: " + cardNumber);
        // Payment processing logic
        return true;
    }

    @Override
    public String getPaymentMethod() {
        return "Credit Card";
    }
}

class PayPalPayment implements Payment {
    private String email;

    public PayPalPayment(String email) {
        this.email = email;
    }

    @Override
    public boolean processPayment(double amount) {
        System.out.println("Processing $" + amount + " via PayPal: " + email);
        // Payment processing logic
        return true;
    }

    @Override
    public String getPaymentMethod() {
        return "PayPal";
    }
}

class CryptoPayment implements Payment {
    private String walletAddress;

    public CryptoPayment(String walletAddress) {
        this.walletAddress = walletAddress;
    }

    @Override
    public boolean processPayment(double amount) {
        System.out.println("Processing $" + amount + " via Crypto: " + walletAddress);
        // Payment processing logic
        return true;
    }

    @Override
    public String getPaymentMethod() {
        return "Cryptocurrency";
    }
}

// Polymorphic usage
public class PaymentProcessor {
    public void executePayment(Payment payment, double amount) {
        System.out.println("Payment method: " + payment.getPaymentMethod());
        boolean success = payment.processPayment(amount);
        if (success) {
            System.out.println("Payment successful!");
        }
    }

    public static void main(String[] args) {
        PaymentProcessor processor = new PaymentProcessor();

        Payment payment1 = new CreditCardPayment("1234-5678-9012-3456");
        Payment payment2 = new PayPalPayment("user@email.com");
        Payment payment3 = new CryptoPayment("1A2B3C4D5E6F7G8H9I");

        processor.executePayment(payment1, 100.00);
        processor.executePayment(payment2, 50.00);
        processor.executePayment(payment3, 200.00);
    }
}
```

# Abstract Classes and Polymorphism

==Abstract classes== provide a middle ground between interfaces and concrete classes.

```Java title='Abstract class polymorphism'
public abstract class Employee {
    protected String name;
    protected String id;
    protected double baseSalary;

    public Employee(String name, String id, double baseSalary) {
        this.name = name;
        this.id = id;
        this.baseSalary = baseSalary;
    }

    // Abstract method - must be implemented
    public abstract double calculateSalary();

    // Abstract method for bonus
    public abstract double calculateBonus();

    // Concrete method - can be inherited as-is
    public void displayInfo() {
        System.out.println("Name: " + name);
        System.out.println("ID: " + id);
        System.out.println("Salary: $" + calculateSalary());
        System.out.println("Bonus: $" + calculateBonus());
    }

    // Getters
    public String getName() { return name; }
    public String getId() { return id; }
}

public class FullTimeEmployee extends Employee {
    private double benefits;

    public FullTimeEmployee(String name, String id, double baseSalary, double benefits) {
        super(name, id, baseSalary);
        this.benefits = benefits;
    }

    @Override
    public double calculateSalary() {
        return baseSalary + benefits;
    }

    @Override
    public double calculateBonus() {
        return baseSalary * 0.10;  // 10% bonus
    }
}

public class ContractEmployee extends Employee {
    private int hoursWorked;
    private double hourlyRate;

    public ContractEmployee(String name, String id, int hoursWorked, double hourlyRate) {
        super(name, id, 0);  // No base salary
        this.hoursWorked = hoursWorked;
        this.hourlyRate = hourlyRate;
    }

    @Override
    public double calculateSalary() {
        return hoursWorked * hourlyRate;
    }

    @Override
    public double calculateBonus() {
        return 0;  // No bonus for contractors
    }
}

// Polymorphic processing
List<Employee> employees = new ArrayList<>();
employees.add(new FullTimeEmployee("Alice", "E001", 60000, 5000));
employees.add(new ContractEmployee("Bob", "C001", 160, 50));
employees.add(new FullTimeEmployee("Charlie", "E002", 70000, 6000));

double totalSalary = 0;
double totalBonus = 0;

for (Employee emp : employees) {
    emp.displayInfo();
    totalSalary += emp.calculateSalary();
    totalBonus += emp.calculateBonus();
    System.out.println();
}

System.out.println("Total Salary: $" + totalSalary);
System.out.println("Total Bonus: $" + totalBonus);
```

# Covariant Return Types

==Covariant return types== allow an overriding method to return a ==subtype== of the type returned by the overridden method.

```Java title='Covariant return types'
public class Animal {
    public Animal reproduce() {
        return new Animal();
    }
}

public class Dog extends Animal {
    // Covariant return: Dog is subtype of Animal
    @Override
    public Dog reproduce() {
        return new Dog();
    }
}

public class Cat extends Animal {
    @Override
    public Cat reproduce() {
        return new Cat();
    }
}

// Usage
Animal animal = new Dog();
Animal offspring = animal.reproduce();  // Returns Dog but typed as Animal

Dog dog = new Dog();
Dog puppy = dog.reproduce();            // Returns Dog typed as Dog
```

# Practical Examples

## Strategy Pattern Using Polymorphism
```Java title='Strategy pattern with polymorphism'
// Strategy interface
interface SortingStrategy {
    void sort(int[] array);
}

// Concrete strategies
class BubbleSort implements SortingStrategy {
    @Override
    public void sort(int[] array) {
        System.out.println("Sorting using Bubble Sort");
        // Bubble sort implementation
        for (int i = 0; i < array.length - 1; i++) {
            for (int j = 0; j < array.length - i - 1; j++) {
                if (array[j] > array[j + 1]) {
                    int temp = array[j];
                    array[j] = array[j + 1];
                    array[j + 1] = temp;
                }
            }
        }
    }
}

class QuickSort implements SortingStrategy {
    @Override
    public void sort(int[] array) {
        System.out.println("Sorting using Quick Sort");
        quickSort(array, 0, array.length - 1);
    }

    private void quickSort(int[] arr, int low, int high) {
        if (low < high) {
            int pi = partition(arr, low, high);
            quickSort(arr, low, pi - 1);
            quickSort(arr, pi + 1, high);
        }
    }

    private int partition(int[] arr, int low, int high) {
        int pivot = arr[high];
        int i = low - 1;
        for (int j = low; j < high; j++) {
            if (arr[j] < pivot) {
                i++;
                int temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
            }
        }
        int temp = arr[i + 1];
        arr[i + 1] = arr[high];
        arr[high] = temp;
        return i + 1;
    }
}

class MergeSort implements SortingStrategy {
    @Override
    public void sort(int[] array) {
        System.out.println("Sorting using Merge Sort");
        mergeSort(array, 0, array.length - 1);
    }

    private void mergeSort(int[] arr, int left, int right) {
        if (left < right) {
            int mid = (left + right) / 2;
            mergeSort(arr, left, mid);
            mergeSort(arr, mid + 1, right);
            merge(arr, left, mid, right);
        }
    }

    private void merge(int[] arr, int left, int mid, int right) {
        // Merge implementation
        int n1 = mid - left + 1;
        int n2 = right - mid;
        int[] L = new int[n1];
        int[] R = new int[n2];

        System.arraycopy(arr, left, L, 0, n1);
        System.arraycopy(arr, mid + 1, R, 0, n2);

        int i = 0, j = 0, k = left;
        while (i < n1 && j < n2) {
            if (L[i] <= R[j]) {
                arr[k++] = L[i++];
            } else {
                arr[k++] = R[j++];
            }
        }

        while (i < n1) arr[k++] = L[i++];
        while (j < n2) arr[k++] = R[j++];
    }
}

// Context class
class Sorter {
    private SortingStrategy strategy;

    public void setStrategy(SortingStrategy strategy) {
        this.strategy = strategy;
    }

    public void performSort(int[] array) {
        if (strategy == null) {
            throw new IllegalStateException("Strategy not set");
        }
        strategy.sort(array);
    }
}

// Usage - polymorphic behavior through strategy
public class StrategyDemo {
    public static void main(String[] args) {
        int[] data = {64, 34, 25, 12, 22, 11, 90};
        Sorter sorter = new Sorter();

        // Use different strategies polymorphically
        sorter.setStrategy(new BubbleSort());
        sorter.performSort(data.clone());

        sorter.setStrategy(new QuickSort());
        sorter.performSort(data.clone());

        sorter.setStrategy(new MergeSort());
        sorter.performSort(data.clone());
    }
}
```

## Factory Pattern with Polymorphism
```Java title='Factory pattern using polymorphism'
// Product interface
interface Vehicle {
    void start();
    void stop();
    String getType();
}

// Concrete products
class Car implements Vehicle {
    @Override
    public void start() {
        System.out.println("Car engine starting...");
    }

    @Override
    public void stop() {
        System.out.println("Car engine stopping...");
    }

    @Override
    public String getType() {
        return "Car";
    }
}

class Motorcycle implements Vehicle {
    @Override
    public void start() {
        System.out.println("Motorcycle engine starting...");
    }

    @Override
    public void stop() {
        System.out.println("Motorcycle engine stopping...");
    }

    @Override
    public String getType() {
        return "Motorcycle";
    }
}

class Truck implements Vehicle {
    @Override
    public void start() {
        System.out.println("Truck diesel engine starting...");
    }

    @Override
    public void stop() {
        System.out.println("Truck diesel engine stopping...");
    }

    @Override
    public String getType() {
        return "Truck";
    }
}

// Factory class
class VehicleFactory {
    public static Vehicle createVehicle(String type) {
        return switch (type.toLowerCase()) {
            case "car" -> new Car();
            case "motorcycle" -> new Motorcycle();
            case "truck" -> new Truck();
            default -> throw new IllegalArgumentException("Unknown vehicle type: " + type);
        };
    }
}

// Client code - works with Vehicle interface polymorphically
public class FactoryDemo {
    public static void main(String[] args) {
        String[] vehicleTypes = {"car", "motorcycle", "truck"};

        for (String type : vehicleTypes) {
            Vehicle vehicle = VehicleFactory.createVehicle(type);
            System.out.println("\n--- " + vehicle.getType() + " ---");
            vehicle.start();
            // Do something with vehicle
            vehicle.stop();
        }
    }
}
```

# Benefits of Polymorphism

- **Flexibility**: Easy to add new implementations without changing existing code
- **Maintainability**: Changes localized to specific implementations
- **Extensibility**: New types can be added with minimal impact
- **Code Reusability**: Generic code works with many types
- **Loose Coupling**: Code depends on abstractions, not concrete types

***
# References
1. Effective Java, 3rd Edition - Joshua Bloch
   1. Item 20: Prefer interfaces to abstract classes
   2. Item 52: Use overloading judiciously
2. Head First Java, 3rd Edition - Kathy Sierra, Bert Bates, Trisha Gee
   1. Chapter 7: Inheritance and Polymorphism
   2. Chapter 8: Interfaces and Abstract Classes
3. Design Patterns: Elements of Reusable Object-Oriented Software - Gang of Four
   1. Strategy Pattern
   2. Factory Pattern
4. https://docs.oracle.com/javase/tutorial/java/IandI/polymorphism.html for polymorphism tutorial
