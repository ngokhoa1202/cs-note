#java #object-oriented-programming #inheritance
# Inheritance
==Inheritance== is a fundamental OOP principle where a class (subclass/child) ==acquires properties and behaviors== from another class (superclass/parent), promoting code reuse and establishing an "is-a" relationship.

# Basic Inheritance

## extends Keyword
```Java title='Basic inheritance syntax'
// Parent class (superclass)
public class Animal {
    protected String name;
    protected int age;

    public Animal(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public void eat() {
        System.out.println(name + " is eating");
    }

    public void sleep() {
        System.out.println(name + " is sleeping");
    }
}

// Child class (subclass)
public class Dog extends Animal {
    private String breed;

    public Dog(String name, int age, String breed) {
        super(name, age);  // Call parent constructor
        this.breed = breed;
    }

    // Dog inherits eat() and sleep()
    // Dog adds its own method
    public void bark() {
        System.out.println(name + " is barking");
    }
}

// Usage
Dog dog = new Dog("Max", 3, "Golden Retriever");
dog.eat();    // Inherited from Animal
dog.sleep();  // Inherited from Animal
dog.bark();   // Dog's own method
```

## Inheritance Hierarchy
```Java title='Multi-level inheritance'
// Level 1: Base class
public class Vehicle {
    protected String brand;
    protected int year;

    public void start() {
        System.out.println("Vehicle starting");
    }
}

// Level 2: Intermediate class
public class Car extends Vehicle {
    protected int doors;

    public void drive() {
        System.out.println("Car driving");
    }
}

// Level 3: Leaf class
public class ElectricCar extends Car {
    private int batteryCapacity;

    public void charge() {
        System.out.println("Charging battery");
    }
}

// ElectricCar inherits from both Car and Vehicle
ElectricCar tesla = new ElectricCar();
tesla.start();   // From Vehicle
tesla.drive();   // From Car
tesla.charge();  // From ElectricCar
```

# The super Keyword

## Calling Parent Constructor
```Java title='super() for constructor chaining'
public class Employee {
    protected String name;
    protected double salary;

    public Employee(String name, double salary) {
        this.name = name;
        this.salary = salary;
        System.out.println("Employee constructor called");
    }
}

public class Manager extends Employee {
    private String department;

    public Manager(String name, double salary, String department) {
        super(name, salary);  // Must be first statement
        this.department = department;
        System.out.println("Manager constructor called");
    }

    // If super() not called explicitly, default constructor is called
    // public Manager() {
    //     super();  // Implicit call to Employee()
    // }
}
```

## Accessing Parent Members
```Java title='super for accessing parent methods and fields'
public class Animal {
    protected String type = "Animal";

    public void makeSound() {
        System.out.println("Some generic sound");
    }
}

public class Dog extends Animal {
    protected String type = "Dog";  // Shadows parent field

    @Override
    public void makeSound() {
        System.out.println("Woof woof");
    }

    public void displayInfo() {
        // Access child field
        System.out.println("This type: " + this.type);
        // Access parent field
        System.out.println("Super type: " + super.type);

        // Call child method
        this.makeSound();
        // Call parent method
        super.makeSound();
    }
}

// Usage
Dog dog = new Dog();
dog.displayInfo();
// Output:
// This type: Dog
// Super type: Animal
// Woof woof
// Some generic sound
```

# Method Overriding

==Method overriding== allows a subclass to provide a specific implementation of a method already defined in its parent class.

## Override Rules
```Java title='Method overriding rules'
public class Shape {
    protected String color;

    // Method to be overridden
    public double calculateArea() {
        return 0.0;
    }

    public void display() {
        System.out.println("This is a shape");
    }
}

public class Circle extends Shape {
    private double radius;

    public Circle(double radius) {
        this.radius = radius;
    }

    // Override with @Override annotation
    @Override
    public double calculateArea() {
        return Math.PI * radius * radius;
    }

    // Override display method
    @Override
    public void display() {
        super.display();  // Call parent implementation
        System.out.println("This is a circle with radius: " + radius);
    }
}
```

## Overriding Constraints
- Return type must be ==same or subtype== (covariant return)
- Access modifier must be ==same or more permissive==
- Cannot override ==final== methods
- Cannot override ==static== methods (hidden instead)
- Cannot override ==private== methods (not inherited)
- Can throw ==same, fewer, or narrower== checked exceptions

```Java title='Overriding constraints examples'
public class Parent {
    // Protected method
    protected Number getValue() {
        return 10;
    }

    public void process() throws IOException {
        // ...
    }
}

public class Child extends Parent {
    // Covariant return: Integer is subtype of Number
    @Override
    protected Integer getValue() {
        return 20;
    }

    // Can throw narrower exception
    @Override
    public void process() throws FileNotFoundException {
        // FileNotFoundException is subtype of IOException
    }

    // INVALID: Cannot reduce visibility
    // @Override
    // private void getValue() { }  // Compilation error

    // INVALID: Cannot throw broader exception
    // @Override
    // public void process() throws Exception { }  // Compilation error
}
```

## @Override Annotation
```Java title='@Override annotation usage'
public class Animal {
    public void makeSound() {
        System.out.println("Some sound");
    }
}

public class Dog extends Animal {
    // Good practice: use @Override
    @Override
    public void makeSound() {
        System.out.println("Bark");
    }

    // Compilation error: method signature doesn't match
    // @Override
    // public void makesound() {  // Typo in method name
    //     System.out.println("Bark");
    // }
}
```

# Constructor Chaining

## Constructor Execution Order
```Java title='Constructor chaining demonstration'
public class GrandParent {
    public GrandParent() {
        System.out.println("1. GrandParent constructor");
    }
}

public class Parent extends GrandParent {
    public Parent() {
        super();  // Implicit if not specified
        System.out.println("2. Parent constructor");
    }
}

public class Child extends Parent {
    public Child() {
        super();  // Implicit if not specified
        System.out.println("3. Child constructor");
    }
}

// Usage
Child child = new Child();
// Output:
// 1. GrandParent constructor
// 2. Parent constructor
// 3. Child constructor
```

## Explicit Constructor Selection
```Java title='Selecting specific parent constructor'
public class Person {
    protected String name;
    protected int age;

    public Person() {
        this.name = "Unknown";
        this.age = 0;
    }

    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }
}

public class Employee extends Person {
    private String employeeId;

    // Calls Person()
    public Employee(String employeeId) {
        super();  // Calls no-arg constructor
        this.employeeId = employeeId;
    }

    // Calls Person(String, int)
    public Employee(String name, int age, String employeeId) {
        super(name, age);  // Calls parameterized constructor
        this.employeeId = employeeId;
    }
}
```

# Access Modifiers and Inheritance

## protected Access
```Java title='protected members in inheritance'
package com.company;

public class Parent {
    public int publicField;       // Accessible everywhere
    protected int protectedField; // Accessible in subclasses
    int packageField;             // Accessible in same package
    private int privateField;     // NOT inherited/accessible

    protected void protectedMethod() {
        System.out.println("Protected method");
    }
}

package com.company.subpackage;
import com.company.Parent;

public class Child extends Parent {
    public void accessFields() {
        publicField = 1;      // OK
        protectedField = 2;   // OK - accessible in subclass
        // packageField = 3;  // Error - different package
        // privateField = 4;  // Error - private not inherited

        protectedMethod();    // OK - inherited protected method
    }
}
```

## Visibility Changes in Overriding
```Java title='Increasing visibility in override'
public class Parent {
    protected void method1() {
        System.out.println("Protected in parent");
    }

    public void method2() {
        System.out.println("Public in parent");
    }
}

public class Child extends Parent {
    // OK: Increase visibility from protected to public
    @Override
    public void method1() {
        System.out.println("Public in child");
    }

    // OK: Keep same visibility
    @Override
    public void method2() {
        System.out.println("Public in child");
    }

    // INVALID: Cannot decrease visibility
    // @Override
    // protected void method2() { }  // Compilation error
}
```

# final Keyword in Inheritance

## final Methods
==Cannot be overridden== by subclasses.

```Java title='final methods'
public class Parent {
    // final method - cannot override
    public final void immutableMethod() {
        System.out.println("This implementation is fixed");
    }

    public void normalMethod() {
        System.out.println("Can be overridden");
    }
}

public class Child extends Parent {
    // INVALID: Cannot override final method
    // @Override
    // public void immutableMethod() { }  // Compilation error

    // Valid: Can override non-final method
    @Override
    public void normalMethod() {
        System.out.println("Overridden implementation");
    }
}
```

## final Classes
==Cannot be extended==.

```Java title='final classes'
// final class - cannot be inherited
public final class ImmutableClass {
    private final String value;

    public ImmutableClass(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}

// INVALID: Cannot extend final class
// public class ExtendedClass extends ImmutableClass { }  // Compilation error

// Real-world examples of final classes
// public final class String { }
// public final class Integer { }
// public final class Math { }
```

# Object Class

All classes implicitly ==extend Object== class.

```Java title='Object class inheritance'
public class MyClass {
    // Implicitly: extends Object

    // Inherited methods from Object:
    // - toString()
    // - equals(Object obj)
    // - hashCode()
    // - getClass()
    // - clone()
    // - finalize()
    // - wait(), notify(), notifyAll()
}

// Override Object methods
public class Person {
    private String name;
    private int age;

    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }

    @Override
    public String toString() {
        return "Person{name='" + name + "', age=" + age + "}";
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Person person = (Person) obj;
        return age == person.age && Objects.equals(name, person.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(name, age);
    }
}
```

# Multiple Inheritance and Interfaces

Java does ==not support multiple inheritance== of classes but supports implementing multiple interfaces.

```Java title='Multiple inheritance with interfaces'
// Interfaces can have multiple inheritance
interface Flyable {
    void fly();
}

interface Swimmable {
    void swim();
}

// Class can implement multiple interfaces
public class Duck implements Flyable, Swimmable {
    @Override
    public void fly() {
        System.out.println("Duck flying");
    }

    @Override
    public void swim() {
        System.out.println("Duck swimming");
    }
}

// Class can extend one class AND implement multiple interfaces
public class Robot extends Machine implements Flyable, Swimmable {
    @Override
    public void fly() {
        System.out.println("Robot flying");
    }

    @Override
    public void swim() {
        System.out.println("Robot swimming");
    }
}
```

# Composition vs Inheritance

## When to Use Inheritance
- True "is-a" relationship
- Subclass is a specialized version of parent
- Need polymorphic behavior

```Java title='Appropriate inheritance usage'
// Dog IS-A Animal - good use of inheritance
public class Animal {
    public void breathe() {
        System.out.println("Breathing");
    }
}

public class Dog extends Animal {
    public void bark() {
        System.out.println("Barking");
    }
}
```

## When to Use Composition
- "has-a" relationship
- Need flexibility to change behavior at runtime
- Want to avoid deep inheritance hierarchies

```Java title='Composition over inheritance'
// Engine is NOT a Car, Car HAS-A Engine - use composition
public class Engine {
    public void start() {
        System.out.println("Engine starting");
    }
}

public class Car {
    private Engine engine;  // Composition

    public Car() {
        this.engine = new Engine();
    }

    public void start() {
        engine.start();
        System.out.println("Car starting");
    }
}

// Flexible: Can easily swap engine implementations
public class ElectricCar {
    private ElectricEngine engine;

    public void start() {
        engine.start();
    }
}
```

# Practical Examples

## Complete Employee Hierarchy
```Java title='Employee management system'
// Base class
public abstract class Employee {
    protected String id;
    protected String name;
    protected double baseSalary;

    public Employee(String id, String name, double baseSalary) {
        this.id = id;
        this.name = name;
        this.baseSalary = baseSalary;
    }

    // Abstract method - must be implemented by subclasses
    public abstract double calculateSalary();

    // Concrete method - inherited by all
    public void displayInfo() {
        System.out.println("ID: " + id);
        System.out.println("Name: " + name);
        System.out.println("Salary: $" + calculateSalary());
    }

    // Getters
    public String getId() { return id; }
    public String getName() { return name; }
}

// Regular employee
public class RegularEmployee extends Employee {
    private double bonus;

    public RegularEmployee(String id, String name, double baseSalary) {
        super(id, name, baseSalary);
        this.bonus = 0.0;
    }

    public void setBonus(double bonus) {
        this.bonus = bonus;
    }

    @Override
    public double calculateSalary() {
        return baseSalary + bonus;
    }
}

// Manager with additional responsibilities
public class Manager extends Employee {
    private double managementAllowance;
    private List<Employee> team;

    public Manager(String id, String name, double baseSalary, double allowance) {
        super(id, name, baseSalary);
        this.managementAllowance = allowance;
        this.team = new ArrayList<>();
    }

    public void addTeamMember(Employee employee) {
        team.add(employee);
    }

    @Override
    public double calculateSalary() {
        // Base salary + allowance + team bonus
        double teamBonus = team.size() * 500.0;
        return baseSalary + managementAllowance + teamBonus;
    }

    @Override
    public void displayInfo() {
        super.displayInfo();
        System.out.println("Team size: " + team.size());
    }
}

// Executive with stock options
public class Executive extends Manager {
    private double stockOptions;

    public Executive(String id, String name, double baseSalary,
                    double allowance, double stockOptions) {
        super(id, name, baseSalary, allowance);
        this.stockOptions = stockOptions;
    }

    @Override
    public double calculateSalary() {
        return super.calculateSalary() + stockOptions;
    }
}

// Usage
Employee emp1 = new RegularEmployee("E001", "John", 50000);
Manager mgr1 = new Manager("M001", "Alice", 70000, 5000);
Executive exec1 = new Executive("X001", "Bob", 100000, 10000, 20000);

mgr1.addTeamMember(emp1);

// Polymorphism in action
List<Employee> employees = Arrays.asList(emp1, mgr1, exec1);
for (Employee emp : employees) {
    emp.displayInfo();  // Calls appropriate version
    System.out.println();
}
```

***
# References
1. Effective Java, 3rd Edition - Joshua Bloch
   1. Item 18: Favor composition over inheritance
   2. Item 19: Design and document for inheritance or else prohibit it
   3. Item 20: Prefer interfaces to abstract classes
2. Head First Java, 3rd Edition - Kathy Sierra, Bert Bates, Trisha Gee
   1. Chapter 7: Inheritance and Polymorphism
3. https://docs.oracle.com/javase/tutorial/java/IandI/subclasses.html for inheritance tutorial
4. The Java Language Specification - Oracle
   1. Chapter 8.1.4: Superclasses and Subclasses
