#java #object-oriented-programming #object-class
# Object Class Methods
The ==Object class== is the root of the Java class hierarchy. Every class implicitly extends Object and inherits its methods. Understanding and properly overriding these methods is crucial for correct Java programming.

# Object Class Hierarchy

```
java.lang.Object
├── All classes inherit from Object
└── Provides fundamental methods:
    ├── equals(Object obj)
    ├── hashCode()
    ├── toString()
    ├── clone()
    ├── getClass()
    ├── finalize() [Deprecated]
    ├── wait(), notify(), notifyAll()
```

# equals() Method

The ==equals()== method determines if two objects are logically equal.

## Default Implementation
```Java title='Default equals() from Object class'
public class Object {
    public boolean equals(Object obj) {
        return (this == obj);  // Reference equality
    }
}

// Default behavior
String s1 = new String("hello");
String s2 = new String("hello");
System.out.println(s1 == s2);        // false (different references)
System.out.println(s1.equals(s2));   // true (String overrides equals())
```

## Proper equals() Implementation
```Java title='Implementing equals() correctly'
public class Person {
    private String name;
    private int age;
    private String email;

    public Person(String name, int age, String email) {
        this.name = name;
        this.age = age;
        this.email = email;
    }

    @Override
    public boolean equals(Object obj) {
        // 1. Check if same reference
        if (this == obj) {
            return true;
        }

        // 2. Check if obj is null or different class
        if (obj == null || getClass() != obj.getClass()) {
            return false;
        }

        // 3. Cast and compare fields
        Person person = (Person) obj;
        return age == person.age &&
               Objects.equals(name, person.name) &&
               Objects.equals(email, person.email);
    }

    // Getters omitted for brevity
}

// Usage
Person p1 = new Person("Alice", 25, "alice@email.com");
Person p2 = new Person("Alice", 25, "alice@email.com");
Person p3 = new Person("Bob", 30, "bob@email.com");

System.out.println(p1.equals(p2));  // true (same content)
System.out.println(p1.equals(p3));  // false (different content)
```

## equals() Contract
The equals() method must satisfy:

1. **Reflexive**: `x.equals(x)` must return true
2. **Symmetric**: If `x.equals(y)` is true, then `y.equals(x)` must be true
3. **Transitive**: If `x.equals(y)` and `y.equals(z)` are true, then `x.equals(z)` must be true
4. **Consistent**: Multiple invocations must consistently return same result
5. **Null handling**: `x.equals(null)` must return false

```Java title='Testing equals() contract'
Person p1 = new Person("Alice", 25, "alice@email.com");
Person p2 = new Person("Alice", 25, "alice@email.com");
Person p3 = new Person("Alice", 25, "alice@email.com");

// Reflexive
System.out.println(p1.equals(p1));  // true

// Symmetric
System.out.println(p1.equals(p2));  // true
System.out.println(p2.equals(p1));  // true

// Transitive
System.out.println(p1.equals(p2) && p2.equals(p3) && p1.equals(p3));  // true

// Consistent
System.out.println(p1.equals(p2));  // true
System.out.println(p1.equals(p2));  // true (same result)

// Null handling
System.out.println(p1.equals(null));  // false
```

# hashCode() Method

The ==hashCode()== method returns an ==integer hash code== for the object, used in hash-based collections.

## Default Implementation
```Java title='Default hashCode() from Object'
public class Object {
    public native int hashCode();  // Returns memory address (implementation-dependent)
}
```

## Proper hashCode() Implementation
```Java title='Implementing hashCode() correctly'
public class Person {
    private String name;
    private int age;
    private String email;

    // ... constructor ...

    @Override
    public int hashCode() {
        return Objects.hash(name, age, email);
    }

    // Manual implementation (equivalent)
    @Override
    public int hashCode() {
        int result = 17;  // Prime number
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + age;
        result = 31 * result + (email != null ? email.hashCode() : 0);
        return result;
    }
}
```

## hashCode() Contract
- If `x.equals(y)` is true, then `x.hashCode() == y.hashCode()` ==must== be true
- If `x.equals(y)` is false, `x.hashCode() == y.hashCode()` ==may or may not== be true
- Consistent: Multiple invocations must return same value (if object not modified)

```Java title='hashCode() contract demonstration'
Person p1 = new Person("Alice", 25, "alice@email.com");
Person p2 = new Person("Alice", 25, "alice@email.com");
Person p3 = new Person("Bob", 30, "bob@email.com");

System.out.println(p1.equals(p2));        // true
System.out.println(p1.hashCode() == p2.hashCode());  // true (must be equal)

System.out.println(p1.equals(p3));        // false
// p1.hashCode() == p3.hashCode() may be true or false (collision possible)
```

## hashCode() in Hash Collections
```Java title='Importance of hashCode() in HashMap'
public class Point {
    private int x;
    private int y;

    public Point(int x, int y) {
        this.x = x;
        this.y = y;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Point point = (Point) obj;
        return x == point.x && y == point.y;
    }

    @Override
    public int hashCode() {
        return Objects.hash(x, y);
    }
}

// Usage in HashMap
Map<Point, String> map = new HashMap<>();
Point p1 = new Point(1, 2);
Point p2 = new Point(1, 2);

map.put(p1, "Location A");
System.out.println(map.get(p2));  // "Location A" (works because of proper hashCode())

// Without hashCode(), p2 wouldn't find the entry
```

# toString() Method

The ==toString()== method returns a ==string representation== of the object.

## Default Implementation
```Java title='Default toString() from Object'
public class Object {
    public String toString() {
        return getClass().getName() + "@" + Integer.toHexString(hashCode());
    }
}

// Default behavior
Person person = new Person("Alice", 25, "alice@email.com");
System.out.println(person);  // Person@5c8da962 (class@hashcode)
```

## Proper toString() Implementation
```Java title='Overriding toString() for debugging'
public class Person {
    private String name;
    private int age;
    private String email;

    // ... constructor, equals, hashCode ...

    @Override
    public String toString() {
        return "Person{" +
               "name='" + name + '\'' +
               ", age=" + age +
               ", email='" + email + '\'' +
               '}';
    }

    // Alternative: Using String.format()
    @Override
    public String toString() {
        return String.format("Person{name='%s', age=%d, email='%s'}",
                           name, age, email);
    }
}

// Usage
Person person = new Person("Alice", 25, "alice@email.com");
System.out.println(person);
// Output: Person{name='Alice', age=25, email='alice@email.com'}

// Implicit toString() call
System.out.println("User: " + person);  // Automatically calls toString()
```

## toString() Best Practices
```Java title='toString() for complex objects'
public class Order {
    private String orderId;
    private Customer customer;
    private List<OrderItem> items;
    private double totalAmount;

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Order{");
        sb.append("orderId='").append(orderId).append('\'');
        sb.append(", customer=").append(customer);
        sb.append(", items=").append(items);
        sb.append(", totalAmount=").append(totalAmount);
        sb.append('}');
        return sb.toString();
    }

    // Or use StringJoiner (Java 8+)
    @Override
    public String toString() {
        StringJoiner joiner = new StringJoiner(", ", "Order{", "}");
        joiner.add("orderId='" + orderId + "'");
        joiner.add("customer=" + customer);
        joiner.add("items=" + items);
        joiner.add("totalAmount=" + totalAmount);
        return joiner.toString();
    }
}
```

# equals(), hashCode(), toString() Together

## Complete Implementation
```Java title='Complete Object methods implementation'
import java.util.Objects;

public class Employee {
    private final String employeeId;  // Immutable identifier
    private String name;
    private String department;
    private double salary;

    public Employee(String employeeId, String name, String department, double salary) {
        this.employeeId = employeeId;
        this.name = name;
        this.department = department;
        this.salary = salary;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;

        Employee employee = (Employee) obj;
        return Double.compare(employee.salary, salary) == 0 &&
               Objects.equals(employeeId, employee.employeeId) &&
               Objects.equals(name, employee.name) &&
               Objects.equals(department, employee.department);
    }

    @Override
    public int hashCode() {
        return Objects.hash(employeeId, name, department, salary);
    }

    @Override
    public String toString() {
        return String.format("Employee{id='%s', name='%s', dept='%s', salary=%.2f}",
                           employeeId, name, department, salary);
    }

    // Getters and setters
    public String getEmployeeId() { return employeeId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }
    public double getSalary() { return salary; }
    public void setSalary(double salary) { this.salary = salary; }
}

// Usage
Employee emp1 = new Employee("E001", "Alice", "Engineering", 75000);
Employee emp2 = new Employee("E001", "Alice", "Engineering", 75000);
Employee emp3 = new Employee("E002", "Bob", "Marketing", 65000);

// equals() test
System.out.println(emp1.equals(emp2));  // true
System.out.println(emp1.equals(emp3));  // false

// hashCode() test
System.out.println(emp1.hashCode() == emp2.hashCode());  // true

// toString() test
System.out.println(emp1);
// Employee{id='E001', name='Alice', dept='Engineering', salary=75000.00}

// Using in HashMap
Map<Employee, String> employeeMap = new HashMap<>();
employeeMap.put(emp1, "Office A");
System.out.println(employeeMap.get(emp2));  // "Office A" (works correctly)
```

# clone() Method

The ==clone()== method creates a ==copy== of the object. Requires implementing Cloneable interface.

## Shallow Copy
```Java title='Shallow cloning'
public class Person implements Cloneable {
    private String name;
    private int age;
    private Address address;  // Reference type

    public Person(String name, int age, Address address) {
        this.name = name;
        this.age = age;
        this.address = address;
    }

    @Override
    protected Object clone() throws CloneNotSupportedException {
        return super.clone();  // Shallow copy
    }

    // Getters and setters
}

class Address {
    private String city;
    private String street;

    public Address(String city, String street) {
        this.city = city;
        this.street = street;
    }

    // Getters and setters
}

// Problem with shallow copy
Address address = new Address("New York", "5th Avenue");
Person original = new Person("Alice", 25, address);

Person cloned = (Person) original.clone();
cloned.getAddress().setCity("Boston");  // Modifies original's address too!

System.out.println(original.getAddress().getCity());  // "Boston" (shared reference)
```

## Deep Copy
```Java title='Deep cloning'
public class Person implements Cloneable {
    private String name;
    private int age;
    private Address address;

    public Person(String name, int age, Address address) {
        this.name = name;
        this.age = age;
        this.address = address;
    }

    @Override
    protected Object clone() throws CloneNotSupportedException {
        Person cloned = (Person) super.clone();
        // Deep copy the address
        cloned.address = new Address(
            this.address.getCity(),
            this.address.getStreet()
        );
        return cloned;
    }
}

// Deep copy works correctly
Address address = new Address("New York", "5th Avenue");
Person original = new Person("Alice", 25, address);

Person cloned = (Person) original.clone();
cloned.getAddress().setCity("Boston");  // Only modifies cloned version

System.out.println(original.getAddress().getCity());  // "New York" (unchanged)
System.out.println(cloned.getAddress().getCity());    // "Boston"
```

## Alternative to clone(): Copy Constructor
```Java title='Copy constructor pattern'
public class Person {
    private String name;
    private int age;
    private Address address;

    // Regular constructor
    public Person(String name, int age, Address address) {
        this.name = name;
        this.age = age;
        this.address = address;
    }

    // Copy constructor
    public Person(Person other) {
        this.name = other.name;
        this.age = other.age;
        // Deep copy address
        this.address = new Address(other.address.getCity(), other.address.getStreet());
    }

    // Static factory method
    public static Person copyOf(Person person) {
        return new Person(person);
    }
}

// Usage - clearer than clone()
Person original = new Person("Alice", 25, new Address("New York", "5th Ave"));
Person copy = new Person(original);  // Copy constructor
Person copy2 = Person.copyOf(original);  // Factory method
```

# getClass() Method

Returns the ==runtime class== of the object.

```Java title='Using getClass()'
public class ClassDemo {
    public static void main(String[] args) {
        String str = "Hello";
        Integer num = 42;

        // Get class object
        Class<?> strClass = str.getClass();
        Class<?> numClass = num.getClass();

        System.out.println(strClass.getName());        // java.lang.String
        System.out.println(numClass.getName());        // java.lang.Integer
        System.out.println(strClass.getSimpleName());  // String

        // Check class type
        if (str.getClass() == String.class) {
            System.out.println("str is a String");
        }

        // Inheritance check
        Animal animal = new Dog();
        System.out.println(animal.getClass().getName());       // Dog
        System.out.println(animal.getClass().getSuperclass()); // Animal
    }
}
```

# Common Patterns

## Value Object Pattern
```Java title='Immutable value object'
public final class Money {
    private final double amount;
    private final String currency;

    public Money(double amount, String currency) {
        this.amount = amount;
        this.currency = currency;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Money money = (Money) obj;
        return Double.compare(money.amount, amount) == 0 &&
               Objects.equals(currency, money.currency);
    }

    @Override
    public int hashCode() {
        return Objects.hash(amount, currency);
    }

    @Override
    public String toString() {
        return String.format("%.2f %s", amount, currency);
    }

    // No setters - immutable
    public double getAmount() { return amount; }
    public String getCurrency() { return currency; }
}
```

## Entity Pattern (Database Entity)
```Java title='Entity with identity'
public class User {
    private final Long id;  // Unique identifier
    private String username;
    private String email;

    public User(Long id, String username, String email) {
        this.id = id;
        this.username = username;
        this.email = email;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        User user = (User) obj;
        // Only compare ID for entities
        return Objects.equals(id, user.id);
    }

    @Override
    public int hashCode() {
        // Only use ID for hashCode
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return String.format("User{id=%d, username='%s', email='%s'}",
                           id, username, email);
    }

    // Getters and setters
}
```

# Using IDE and Lombok

## IDE Generation
Most IDEs can generate equals(), hashCode(), toString().

```Java title='IntelliJ IDEA generated code'
// Right-click → Generate → equals() and hashCode()
// Right-click → Generate → toString()

public class Product {
    private String id;
    private String name;
    private double price;

    // Generated by IDE
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Product product = (Product) o;
        return Double.compare(product.price, price) == 0 &&
               Objects.equals(id, product.id) &&
               Objects.equals(name, product.name);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, name, price);
    }

    @Override
    public String toString() {
        return "Product{" +
               "id='" + id + '\'' +
               ", name='" + name + '\'' +
               ", price=" + price +
               '}';
    }
}
```

## Lombok Annotations
```Java title='Lombok for boilerplate reduction'
import lombok.*;

@Data  // Generates getters, setters, equals, hashCode, toString
public class Product {
    private String id;
    private String name;
    private double price;
}

@EqualsAndHashCode  // Only equals and hashCode
@ToString           // Only toString
@Getter @Setter     // Only getters and setters
public class Product {
    private String id;
    private String name;
    private double price;
}
```

***
# References
1. Effective Java, 3rd Edition - Joshua Bloch
   1. Item 10: Obey the general contract when overriding equals
   2. Item 11: Always override hashCode when you override equals
   3. Item 12: Always override toString
   4. Item 13: Override clone judiciously
2. Head First Java, 3rd Edition - Kathy Sierra, Bert Bates, Trisha Gee
   1. Chapter 9: Life and Death of an Object
3. https://docs.oracle.com/javase/8/docs/api/java/lang/Object.html for Object class documentation
4. The Java Language Specification - Oracle
   1. Chapter 4.3.2: The Class Object
